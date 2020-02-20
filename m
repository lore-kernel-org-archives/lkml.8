Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4109C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B316F207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgBTPeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:34:37 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59448 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728351AbgBTPeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:34:37 -0500
Received: (qmail 1597 invoked by uid 2102); 20 Feb 2020 10:34:36 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2020 10:34:36 -0500
Date:   Thu, 20 Feb 2020 10:34:36 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kees Cook <keescook@chromium.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: net2280: Distribute switch variables for
 initialization
In-Reply-To: <20200220062315.69253-1-keescook@chromium.org>
Message-ID: <Pine.LNX.4.44L0.2002201028070.1453-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020, Kees Cook wrote:

> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> drivers/usb/gadget/udc/net2280.c: In function ‘handle_stat0_irqs_superspeed’:
> drivers/usb/gadget/udc/net2280.c:2871:22: warning: statement will never be executed [-Wswitch-unreachable]
>  2871 |   struct net2280_ep *e;
>       |                      ^
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/usb/gadget/udc/net2280.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
> index 1fd1b9186e46..cc5869363298 100644
> --- a/drivers/usb/gadget/udc/net2280.c
> +++ b/drivers/usb/gadget/udc/net2280.c
> @@ -2861,6 +2861,7 @@ static void ep_clear_seqnum(struct net2280_ep *ep)
>  static void handle_stat0_irqs_superspeed(struct net2280 *dev,
>  		struct net2280_ep *ep, struct usb_ctrlrequest r)
>  {
> +	struct net2280_ep *e;
>  	int tmp = 0;
>  
>  #define	w_value		le16_to_cpu(r.wValue)
> @@ -2868,14 +2869,13 @@ static void handle_stat0_irqs_superspeed(struct net2280 *dev,
>  #define	w_length	le16_to_cpu(r.wLength)
>  
>  	switch (r.bRequest) {
> -		struct net2280_ep *e;
> -		u16 status;
> -
>  	case USB_REQ_SET_CONFIGURATION:
>  		dev->addressed_state = !w_value;
>  		goto usb3_delegate;
>  
> -	case USB_REQ_GET_STATUS:
> +	case USB_REQ_GET_STATUS: {
> +		u16 status;
> +
>  		switch (r.bRequestType) {
>  		case (USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE):
>  			status = dev->wakeup_enable ? 0x02 : 0x00;
> @@ -2905,7 +2905,7 @@ static void handle_stat0_irqs_superspeed(struct net2280 *dev,
>  			goto usb3_delegate;
>  		}
>  		break;
> -
> +	}

This is an unusual use of nested blocks (i.e., a block immediately 
following a "case" label, and it throws the indentation off -- there 
will now be two nested closing braces at the same indentation level: 
this one and the one preceding do_stall3:.

Just define status at the function level, along with e, and don't 
worry about it.

Alan Stern

>  	case USB_REQ_CLEAR_FEATURE:
>  		switch (r.bRequestType) {
>  		case (USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE):
> 
> 
> 

