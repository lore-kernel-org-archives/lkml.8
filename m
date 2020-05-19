Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFBF207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgESRLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:11:02 -0400
Received: from mailrelay4.webfaction.com ([185.20.51.6]:57804 "EHLO
        mailrelay4.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:11:01 -0400
Received: from mailrelay3.webfaction.com (mailrelay3.webfaction.com [207.38.93.110])
        by mailrelay4.webfaction.com (Postfix) with ESMTPS id AA711A6D79;
        Tue, 19 May 2020 17:10:54 +0000 (UTC)
Received: from mailrelay1.webfaction.com (mailrelay1.webfaction.com [207.38.86.46])
        by mailrelay3.webfaction.com (Postfix) with ESMTPS id DEEE32A5088;
        Tue, 19 May 2020 17:10:52 +0000 (UTC)
Received: from smtp.webfaction.com (mail6.webfaction.com [31.170.123.134])
        by mailrelay1.webfaction.com (Postfix) with ESMTPS id EA76E1A0E3D;
        Tue, 19 May 2020 17:10:51 +0000 (UTC)
Received: from jeremy.localnet (host-37-191-188-128.lynet.no [37.191.188.128])
        by smtp.webfaction.com (Postfix) with ESMTPSA id 810DA60038E8E;
        Tue, 19 May 2020 17:11:01 +0000 (UTC)
From:   Paul Boddie <paul@boddie.org.uk>
To:     dri-devel@lists.freedesktop.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>, od@zcrc.me,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 11/12] gpu/drm: Ingenic: Add support for the IPU
Date:   Tue, 19 May 2020 19:10:32 +0200
Message-ID: <3220152.ycyENPvHUQ@jeremy>
User-Agent: KMail/4.14.1 (Linux/3.16.0-10-586; KDE/4.14.2; i686; ; )
In-Reply-To: <YGYIAQ.7N9YGTBML0143@crapouillou.net>
References: <20200516215057.392609-1-paul@crapouillou.net> <CACvgo50q=qJXk3nFSCm+S6JHBMxpY0C_HwH8KGB2EAcKwgL0oQ@mail.gmail.com> <YGYIAQ.7N9YGTBML0143@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18. May 2020 13.26.58 Paul Cercueil wrote:
> >>  
> >>  @@ -186,13 +186,16 @@ static void
> >> 
> >> ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
> >> 
> >>          regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
> >>                             JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16,
> >>                             JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16);
> >>  
> >>  +
> >>  +       regmap_write(priv->map, JZ_REG_LCD_IPUR, JZ_LCD_IPUR_IPUREN
> >>  +                    (ht * vpe / 3) << JZ_LCD_IPUR_IPUR_LSB);
> > 
> > This hunk also indicates that it may be better to merge the IPU within
> > the existing driver.
> 
> This writes the IPUR register of the CRTC, nothing wrong here.

Since I noticed it in the above patch details, I think the mask when updating 
the burst setting in the LCD_CTRL register should - in general - involve 
multiple bits, since the BST field is 3 bits wide on the JZ4780 and 2 bits 
wide on earlier products. Just setting BURST_16 (0b10) could potentially 
enable BURST_32 (0b11) or other field values that are not explicitly defined.

Hope this is useful!

Paul
