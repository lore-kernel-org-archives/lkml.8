Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75B7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7685C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFzrLGU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHSI04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHSI0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:26:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E68C061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:26:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so20594287wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CdkoMChO912JQmLhb7omaniX8p32GEvBGErJ8gXOLRg=;
        b=sFzrLGU65rf8DFZg2uvUEgMwfgjPybFD8cCiaE2mOD9MXsJM/0njzIT3xxKhck2hYh
         pz9Evstvu4iFgv8fa+Cy65LOxNOmyztkdeNTDQKW/A3bvcmwJso8NgArYKy6opyxEk7s
         VYqnXK+ctloGIdOFNsddcJc0nbE+XRm7iiAwtAy98oSFuEOnpFdSugdsu/DSQryJ0wv9
         aUA+0OwL1QvKiIp4rInw5B5TMHlke6LHtFXVuCiW5Uh0Sb9Rf4htdTAzG6Og5S40Iz/M
         ATDiNOC3tWI8zDAVN9KHxag/lclY43fulorfJ9IBYCf49tXaOUzie7APIIaimONjNF+f
         hK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CdkoMChO912JQmLhb7omaniX8p32GEvBGErJ8gXOLRg=;
        b=crJHQ9+lgkRxlqVX53xzW85Vsr5gWKWZWLh8jZ8AfSvqTk+75OxJhD1kbjlUI4HBbQ
         aXzEVutWbseOXG7acS6XqsrC8zn30oum31YUJCm6G/YBQmP3QZI7+TLqbGqPFqjiYF+s
         Rxng01R2Ois+ML9Zdp/pIAtxFP7hLhtoq1cUVnEXrZqrtQVpFotF9hs/YAT68Kv0OymI
         2o0Cf1bqmM0irBujxvSjLnC4BJBki5+H95tWRoqaSBYcLDymZxouyGzxzJrCgbC9CEy6
         8g/DjscTm0KXjK45DUWD6y0bj71lV7tofO/5MfXLZq40Br7cxybwlxbjDz0e5586vjkA
         JpaQ==
X-Gm-Message-State: AOAM532AAr2zyeFH2xac1vunIc5Mm9x7z30Rt3x8705g5wL6pdjly0G4
        1z4WLp0VlKusholoVAO0UcT4UvLFY94i4Q==
X-Google-Smtp-Source: ABdhPJyUz4Kr7JEIg/EMaMtfaJe8FayYqmyFRW2Id1ELkkC2PPV5GqBDMaR1JFlG7kJepDsZ3X30Gg==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr2866442wrq.327.1597825612812;
        Wed, 19 Aug 2020 01:26:52 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id p25sm4091249wma.39.2020.08.19.01.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 01:26:52 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:26:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Fix handle of OF disabled MFD cells
Message-ID: <20200819082650.GC4354@dell>
References: <20200801070130.3323112-1-icenowy@aosc.io>
 <20200819081122.GB4354@dell>
 <3b0ba1c95efa2ac465d9b6312b8e0e2c8fb461b5.camel@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b0ba1c95efa2ac465d9b6312b8e0e2c8fb461b5.camel@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020, Icenowy Zheng wrote:

> 在 2020-08-19星期三的 09:11 +0100，Lee Jones写道：
> > On Sat, 01 Aug 2020, Icenowy Zheng wrote:
> > 
> > > When rewriting the OF match code of MFD core, addition of cells
> > > disabled
> > > in OF will result in a failure with error -ENODEV. This is an
> > > unexpected
> > > behavior, as the previous behavior is silently ignore the cell. On
> > > SBCs with AXP20x PMICs, this leads to boot failure if AXP20x PMIC
> > > support is built-in and some cells (especially power supply ones)
> > > are
> > > disabled.
> > 
> > Thanks for reporting this.
> > 
> > Do you mind if I fix this another way?  I plan to reinstate the old
> > code that was removed as part of the offending patch.  I will of
> > course add your Reported-by tag.
> 
> I think it's okay.
> 
> I will test it once it's out.

That would be great.  Then I can add your Tested-by also.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
