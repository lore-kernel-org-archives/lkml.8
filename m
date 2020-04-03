Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49C82073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403898AbgDCOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:39:34 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51653 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728066AbgDCOje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:39:34 -0400
Received: (qmail 8390 invoked by uid 500); 3 Apr 2020 10:39:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Apr 2020 10:39:33 -0400
Date:   Fri, 3 Apr 2020 10:39:33 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
cc:     gregkh@linuxfoundation.org, <hariprasad.kelam@gmail.com>,
        <colin.king@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ldv-project@linuxtesting.org>,
        <andrianov@ispras.ru>
Subject: Re: [PATCH] usb: host: u132-hcd: Remove u132_static_list
In-Reply-To: <20200402232228.22395-1-madhuparnabhowmik10@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2004031038200.7035-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 madhuparnabhowmik10@gmail.com wrote:

> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> u132_static_list is a global list protected by u132_module_lock.
> It is read in the u132_hcd_exit() function without holding the lock
> thus may lead to data race.
> However, it turns out that this list isn't used for anything useful
> and thus it is okay to get rid of it.
> Thus, remove the u132_static_list from u132-hcd module.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  drivers/usb/host/u132-hcd.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
> index e9209e3e6248..52f70cf063ea 100644
> --- a/drivers/usb/host/u132-hcd.c
> +++ b/drivers/usb/host/u132-hcd.c
> @@ -81,7 +81,6 @@ static DECLARE_WAIT_QUEUE_HEAD(u132_hcd_wait);
>  static struct mutex u132_module_lock;
>  static int u132_exiting;
>  static int u132_instances;
> -static struct list_head u132_static_list;
>  /*
>  * end of the global variables protected by u132_module_lock
>  */

You forgot to remove the u132_list member from struct u132.

Alan Stern

