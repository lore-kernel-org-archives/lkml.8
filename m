Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362A7C28CBC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9FC2071C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgEACmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 22:42:07 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51521 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728107AbgEACmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 22:42:07 -0400
Received: (qmail 21059 invoked by uid 500); 30 Apr 2020 22:42:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Apr 2020 22:42:05 -0400
Date:   Thu, 30 Apr 2020 22:42:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Arnd Bergmann <arnd@arndb.de>
cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 08/15] usb: ehci: avoid gcc-10 zero-length-bounds warning
In-Reply-To: <20200430213101.135134-9-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.2004302231290.19755-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, Arnd Bergmann wrote:

> Building ehci drivers with gcc-10 results in a number of warnings like
> when an zero-length array is accessed:
> 
> drivers/usb/host/ehci-hub.c: In function 'ehci_bus_suspend':
> drivers/usb/host/ehci-hub.c:320:30: error: array subscript 14 is outside the bounds of an interior zero-length array 'u32[0]' {aka 'unsigned int[0]'} [-Werror=zero-length-bounds]
>   320 |    u32 __iomem *hostpc_reg = &ehci->regs->hostpc[port];
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/usb/host/ehci.h:273,
>                  from drivers/usb/host/ehci-hcd.c:96:
> include/linux/usb/ehci_def.h:186:7: note: while referencing 'hostpc'
>   186 |  u32  hostpc[0]; /* HOSTPC extension */
>       |       ^~~~~~
> In file included from drivers/usb/host/ehci-hcd.c:305:
> drivers/usb/host/ehci-hub.c: In function 'ehci_hub_control':
> drivers/usb/host/ehci-hub.c:892:15: error: array subscript 256 is outside the bounds of an interior zero-length array 'u32[0]' {aka 'unsigned int[0]'} [-Werror=zero-length-bounds]
>   892 |  hostpc_reg = &ehci->regs->hostpc[temp];
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/usb/host/ehci.h:273,
>                  from drivers/usb/host/ehci-hcd.c:96:
> include/linux/usb/ehci_def.h:186:7: note: while referencing 'hostpc'
>   186 |  u32  hostpc[0]; /* HOSTPC extension */
>       |       ^~~~~~
> 
> All these fields are colocated with reserved fields that I guess
> refer to the correct field length.

No, they don't.

> Change the two struct definition to use an unnamed union to define
> both of these fields at the same location as the corresponding
> reserved fields.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/usb/ehci_def.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
> index 78e006355557..8777d8e56ef2 100644
> --- a/include/linux/usb/ehci_def.h
> +++ b/include/linux/usb/ehci_def.h
> @@ -127,7 +127,8 @@ struct ehci_regs {
>  #define FLAG_CF		(1<<0)		/* true: we'll support "high speed" */
>  
>  	/* PORTSC: offset 0x44 */
> -	u32		port_status[0];	/* up to N_PORTS */
> +	union {
> +		u32		port_status[9];	/* up to N_PORTS */

This array can have up to 15 elements, meaning that it can extend out
to offset 0x80.

>  /* EHCI 1.1 addendum */
>  #define PORTSC_SUSPEND_STS_ACK 0
>  #define PORTSC_SUSPEND_STS_NYET 1
> @@ -165,7 +166,8 @@ struct ehci_regs {
>  #define PORT_CONNECT	(1<<0)		/* device connected */
>  #define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
>  
> -	u32		reserved3[9];
> +		u32		reserved3[9];
> +	};
>  
>  	/* USBMODE: offset 0x68 */
>  	u32		usbmode;	/* USB Device mode */

As you see, this next field actually lies inside the preceding array.  
It's not a real conflict; any hardware which supports the usbmode field 
uses only the first element of the port_status array.

I don't know how you want to handle this.  Doing

#define usbmode port_status[9]

doesn't seem like a very good approach, but I can't think of anything 
better at the moment.  Maybe just set the array size to 9, as you did, 
but with a comment explaining what's really going on.

> @@ -181,11 +183,13 @@ struct ehci_regs {
>   * PORTSCx
>   */
>  	/* HOSTPC: offset 0x84 */
> -	u32		hostpc[0];	/* HOSTPC extension */
> +	union {
> +		u32		hostpc[17];	/* HOSTPC extension */

Likewise, this array can have up to 15 elements.  In fact, it's the 
same size as the port_status array.

>  #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
>  #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
>  
> -	u32		reserved5[17];
> +		u32		reserved5[17];
> +	};
>  
>  	/* USBMODE_EX: offset 0xc8 */
>  	u32		usbmode_ex;	/* USB Device mode extension */

Alan Stern

