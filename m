Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E0C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBCC2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="dkPv3tWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgD2PMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgD2PMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:12:16 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03069C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:12:16 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j26so1988747ots.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Dw9z3skpovx5U+Kokok0Gl+LhbKi7TC3S8cZHyqEUI=;
        b=dkPv3tWoN9rA8+Bpd+XhqvQdAVTKC5limvdKzHBCx1BarPDm57/tI78fBE7uL+DU13
         O+AdIpD3a43by+BV6dogoQY6jcRVPQzgoHMQ2/ZyLQ89a8AqDasMiHo+R7jnddEjMysW
         weDMB8rrapD3D21eqEKS/uTdXAsIUn3UizXUdAER0MkK+RQUQbyR0rmkcFB3iXfF5JjO
         V4aIZK19mtcUR+rO0sv76y5Tch4CtoYxls2o2TsK222FmVZ4jIxFjdOotGiM8ByBi9XE
         /HIbF/OzTvGtilnlXBZAlg9tzAenf1Iy9nSCfhDsZztkn6+d0LG5oWPsr4xbTHLYq7Ki
         Be1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Dw9z3skpovx5U+Kokok0Gl+LhbKi7TC3S8cZHyqEUI=;
        b=UYxjnTqWQnFKcGQ5D1kSMyTOJRDkfL/XCqDpbkkJTKM5y3qn83VGWAKJn2PahYnLrx
         wDwkOh/zTxDLqMJk0+UFxl/330woRZf+aqmKJVbEO7xuWVgMXzl57HQ7/SBa+lqtZS2D
         mNAbShOsj37O+FfPttpZLy1v978MQghvobszYAPigWh5Mkm1BcZDIx5B1XnZFvVOASlP
         rCMaSYgIhbJ13hC23ZNaTt/SotMUlMv1Q4yfhfixNtNa7hECXLQXDnGTCOOciro4kkoz
         n5Mi6HYcc4NgF1h68yszJi02ziPQyLvzM6hs9XLr/W6ERFF30ONdrLo2mGRAnaPbISUP
         zpkQ==
X-Gm-Message-State: AGi0PubN61A+87IQrF5qR0ip3ShOc10x77NhWvZMiPAw7H4PZdBF/JCo
        0cDkVjllEG2VL1kpTeqWu9uZN9x579WxcvOC++nImg==
X-Google-Smtp-Source: APiQypKIJWHbxA5JB3lkWleLMMBByUMCEMnUlnt76a3lN0G0WNuQD4Dk7h+dye5tgPuRW+q4nMRv5v6zQwQumku/iX8=
X-Received: by 2002:a9d:7dd8:: with SMTP id k24mr26893979otn.33.1588173135382;
 Wed, 29 Apr 2020 08:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <1587748215-9587-1-git-send-email-tharvey@gateworks.com> <20200429033740.GP32592@dragon>
In-Reply-To: <20200429033740.GP32592@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 29 Apr 2020 08:12:04 -0700
Message-ID: <CAJ+vNU23EFFjxC4gATy1d1CU7GQQZ8+p+9eiQkF_r4vhR-p+ng@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: gw552x: add USB OTG support
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 8:37 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Apr 24, 2020 at 10:10:15AM -0700, Tim Harvey wrote:
> > The GW552x-B board revision adds USB OTG support.
> >
> > Enable the device-tree node and configure the OTG_ID pin.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> > index dc646b7..133a1e3 100644
> > --- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> > @@ -12,8 +12,6 @@
> >               led1 = &led1;
> >               led2 = &led2;
> >               nand = &gpmi;
> > -             usb0 = &usbh1;
> > -             usb1 = &usbotg;
>
> Have some comments about this change in the commit log?
>

Shawn,

I shouldn't have removed those... will submit a v2. Thank you for catching this!

Tim
