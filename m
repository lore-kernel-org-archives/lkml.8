Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7164C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C682073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgCZLdd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:33:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36238 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgCZLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:33:32 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jHQlP-0001Ef-Ao
        for linux-kernel@vger.kernel.org; Thu, 26 Mar 2020 11:33:31 +0000
Received: by mail-pf1-f199.google.com with SMTP id h24so4868652pfn.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 04:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G+QwyOSfehj0haKhfhlIVYmqRcVCM5uC0FJcjI7cTRY=;
        b=s1frU1fTX5stUOjpLkTu/k5vrdb2pao/XpodQ/ssFAkoWcdlOsoYvgfU5Psv6koEIO
         Ct1f+pdxSyahDzgszywSrngqRLqUFXpcxduBXYCv/EekgMs/79/+1xVG99ip9mbuT6YO
         0BEj/yyh4WTbwDzG/DskiH+fLZWfE+Pw+ABzug17c92cejAwiqXA682MJzTjOva4QUW4
         EXluH7Of1QNQrm5tnjba+F15otMjBnn0nC30oSZBpHLYjgbpPv6BhdSnn7AO8HERjYEJ
         m+7r+t7GGzflS8Prl4il8JBMpRvugqa4utBBbkLImgRrL1Ie23gZn06lJEKv9mutJtch
         qBcg==
X-Gm-Message-State: ANhLgQ2BTRheOCxkUzJe/SLiEZj3UI02LWA8ZvTW1TmDJn8QcOVNFBs6
        +l3GuE4pAi2fD7rkizSww9nhvzg+JeKMMMC5bGjuurzHWPSCSl7VpGjcsctGiitjIVFQr2V0Vkh
        trpwafNjEVxDoMPDojXZIOVhARWDcxZBT2uZUSEwDWQ==
X-Received: by 2002:a17:90b:46d0:: with SMTP id jx16mr2598851pjb.155.1585222409866;
        Thu, 26 Mar 2020 04:33:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuUF7fZ8cLQXk/E8Fjz7a3uP4QpVjOkMylBN5KEJwNfoB/LjAMeMUPYZ/BXBETvh8LztOA/Bg==
X-Received: by 2002:a17:90b:46d0:: with SMTP id jx16mr2598815pjb.155.1585222409533;
        Thu, 26 Mar 2020 04:33:29 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a15sm1474595pfg.77.2020.03.26.04.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 04:33:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] xhci: Set port link to RxDetect if port is not enabled
 after resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200311040456.25851-1-kai.heng.feng@canonical.com>
Date:   Thu, 26 Mar 2020 19:33:26 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B4E44BDC-5AFE-4F8A-8498-0EEE9CDAC0E1@canonical.com>
References: <20200311040456.25851-1-kai.heng.feng@canonical.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

> On Mar 11, 2020, at 12:04, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
> then connects to ASMedia xHCI's root hub:
> 
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
> 
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
> Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
> 
> The port is disabled after resume:
> xhci_hcd 0000:3f:00.0: Get port status 4-1 read: 0x280, return 0x280
> 
> According to xHCI 4.19.1.2.1, we should set link to RxDetect to transit
> it from disabled state to disconnected state, which allows the port to
> be set to U0 and completes the resume process.
> 
> My own test shows port can still resume when it's not enabled, as long
> as its link is in U states. So constrain the new logic only when link is
> not in any U state.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Do you think this is a proper fix?

Kai-Heng

> ---
> drivers/usb/host/xhci-hub.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index a9c87eb8951e..263f9a9237a1 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1776,6 +1776,14 @@ int xhci_bus_resume(struct usb_hcd *hcd)
> 			clear_bit(port_index, &bus_state->bus_suspended);
> 			continue;
> 		}
> +
> +		/* 4.19.1.2.1 */
> +		if (!(portsc & PORT_PE) && (portsc & PORT_PLS_MASK) > XDEV_U3) {
> +			portsc = xhci_port_state_to_neutral(portsc);
> +			portsc &= ~PORT_PLS_MASK;
> +			portsc |= PORT_LINK_STROBE | XDEV_RXDETECT;
> +		}
> +
> 		/* resume if we suspended the link, and it is still suspended */
> 		if (test_bit(port_index, &bus_state->bus_suspended))
> 			switch (portsc & PORT_PLS_MASK) {
> -- 
> 2.17.1
> 

