Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285ACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104B4206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFLOCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:02:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59631 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726085AbgFLOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:02:12 -0400
Received: (qmail 13466 invoked by uid 1000); 12 Jun 2020 10:02:11 -0400
Date:   Fri, 12 Jun 2020 10:02:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jim Lin <jilin@nvidia.com>,
        Siqi Lin <siqilin@google.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH] usb: replace hardcoded maximum usb string length by
 definition
Message-ID: <20200612140211.GA12639@rowland.harvard.edu>
References: <y>
 <1591939967-29943-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591939967-29943-1-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 01:32:47PM +0800, Macpaul Lin wrote:
> Replace hardcoded maximum usb string length (126 bytes) by definition
> "MAX_USB_STRING_LEN".
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

...

> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 9f3c721..df4a9cb 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1815,6 +1815,8 @@ static inline int usb_get_ptm_status(struct usb_device *dev, void *data)
>  		0, data);
>  }
>  
> +/* USB String descriptors can contain at most 126 characters. */
> +#define MAX_USB_STRING_LEN	126

This definition belongs in include/uapi/linux/usb/ch9.h (near the 
definition of struct usb_string_descriptor) because it is part of the USB 
standard rather than specific to the Linux USB stack.

Alan Stern
