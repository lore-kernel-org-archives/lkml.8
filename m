Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D04821919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISIjZ5JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgIIQ4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbgIIPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:52:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE0C061372
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:17:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so3117989wrl.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YTINV8fXf0M3n9PBAJO84TZ3ZWqVa/k8IvPy7N9wgi4=;
        b=ISIjZ5JQj4TVnnSGapFb7wbJQYYctJNyBV/BPiddD36GRemkQ2jjGJozi7ZZ/kNFgX
         L+a9BRRcxvMgswArV5WD4NYsCit9c2oH3aiX4oPX4bd3Jz2GsnLqByOiF29v5yx3b5iD
         uDbebTiq0Z5y1HyVnJZ+YOiaS2S0q+WjKtZ6Tef9eHw7YRu85EZSVkNInnykwrXTIC+n
         P5rhgZr4VBrBEVyX5ti/2W5iurPZAztgCxVQu0luBxCahAI/N4dSAyW9VNbxVRuO4gwp
         I7Snb8LSDhaMGjreOX/81es+gdR7Eb9OtmYjiXDDWcimTmOxMQjfw/bK/6V7yYEScTk0
         wy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YTINV8fXf0M3n9PBAJO84TZ3ZWqVa/k8IvPy7N9wgi4=;
        b=PWFDkiv85K1UX/tznXp8gE69wD+s914QnexKMrhdQ73X+HuRxkAd8oYXTABSKDisTc
         WSgWBloBfHbbABbRm/qqSEawJzgXLefyXRipEY5Kfsw0NiNxePyC+WdtU8jF00EDLcsT
         ykdzy45OiOApjZ4iiWq6TrnOLGPij6pLh4minJDa3osPVxY9fqaxuZhOzRMQlFqwuvd+
         mRK7UgbouDtmq6rOPth6tl+gIL8s1aiDiDjmiOsfnN51VX2DmaZ3ItWk1NHvsYuBSCZk
         uHwK/BEXthavHsIQ9Kg5CJlEYS65skGwG4TqyfxMP19NllUa45hJcj7Sk0rdSFD1F+V0
         /AUA==
X-Gm-Message-State: AOAM531Fh+moLse1U2pM4fSIPyzlek+nh7tb/Q37/dnl57zT/8/FKI/P
        73M2O0YYDyIC5ajTLAmuAtGcwQ==
X-Google-Smtp-Source: ABdhPJyylZV7lGE0N2Ov626dsFCzQyMBnovybUKfA++XerEYgGcuyp66iCHpW/4W3EGC5UFcCO7ASQ==
X-Received: by 2002:adf:82d5:: with SMTP id 79mr4682690wrc.60.1599661042100;
        Wed, 09 Sep 2020 07:17:22 -0700 (PDT)
Received: from dell ([91.110.221.208])
        by smtp.gmail.com with ESMTPSA id m3sm2774942wrs.83.2020.09.09.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:17:21 -0700 (PDT)
Date:   Wed, 9 Sep 2020 15:17:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Subject: Re: [PATCH 01/32] wireless: marvell: mwifiex: sdio: Move 'static
 const struct's into their own header file
Message-ID: <20200909141719.GD218742@dell>
References: <20200821071644.109970-2-lee.jones@linaro.org>
 <20200901091541.3974FC433C6@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200901091541.3974FC433C6@smtp.codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Sep 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Only include these tables in the 1 source file they are used.
> > 
> > Fixes hundreds of W=1 warnings!
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  In file included from drivers/net/wireless/marvell/mwifiex/main.h:59,
> >  from drivers/net/wireless/marvell/mwifiex/main.c:22:
> >  drivers/net/wireless/marvell/mwifiex/sdio.h:705:41: warning: ‘mwifiex_sdio_sd8801’ defined but not used [-Wunused-const-variable=]
> >  705 | static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
> >  | ^~~~~~~~~~~~~~~~~~~
> > 
> >  NB: There were 100's of these - snipped for brevity.
> > 
> > Cc: Amitkumar Karwar <amitkarwar@gmail.com>
> > Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> > Cc: Xinming Hu <huxinming820@gmail.com>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I don't think static const variables should be in a .h file. Wouldn't
> sdio.c be the right place for these? At least from a quick look I got
> that impression.

That's a bone of contention.  I personally do not like to see C-files
overwhelmed by a sea of structs/tables and tend to ferry them off into
*-tables.h header files instead.

As the gate-keeper, what you say goes.  So if you insist we move these
450 lines of tables into the source file which references them, I will
of course do as you ask.

> Patch set to Changes Requested.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
