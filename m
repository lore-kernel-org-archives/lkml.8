Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C29FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC50207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnwOR0/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbgIHQ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbgIHQWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:22:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2113AC061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 04:56:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so18768039wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tp70PkVNXkSrNE2j0x4hwAD20KzB67jv0ioCblAxIfE=;
        b=HnwOR0/hgZ+Lk2Ef1r50CTfWhlvEWHToNkXE65iDT3clvw0a8Go+T4AbKoW15rXUbi
         gGkTvB1bmDZN8E7oHAlh9ewgXEXVU2K3uXg3/eDktJTlRUbEjEAXBn9jPvqHeFs5zAeK
         HnkZeFBMdbHwJJhN1a9nM8+3t4We1WH2Yei8R3/+MN94v4dk/n2RUIyzRV+fCobrtr/h
         9zGhfhYUUrGdNgxHEqUWkpmrpUPZZbPvdx1IGz40eCoZFv10ogBtjvTdCI4XkawmDiE8
         6iTKPLI/MFrnaBiFNX3Aao2tL7p7Rp1/0joq3/AXU01u6NB6THr6IkTvYA54sC9faqds
         pnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tp70PkVNXkSrNE2j0x4hwAD20KzB67jv0ioCblAxIfE=;
        b=TV+PcQ1gCeMzXvWyINuLufNwEZOhBQXPmRTzstjK4Ja1C7JLjGN1HCFVoSdJ7ppIFs
         QGlixIzUMV+/mxJ4GGGas2B/S/CCZvKxq6jR6bQ1gwAwHVX0Us2/R8X67YVLsc3Ttp86
         7PQJ81nObGIF12sUVPkqM8IEKbcJDdduusEE8vC1AhA53d9+qjE1Z4mEpZ1kXzJiGe1e
         okfyftm+JYYjFyCQXUQm6ZH+RBDFdDdCuvlnYUK6LjQsGUOOgNWfx+JQZWjiKEQYkJ07
         Z2bvFbKw8CsIkS64AgnawkyPgwp3sd6zaQsl2RyPNnDbf46Yx0w2G31aqVquAHWHvLhZ
         Y4Ug==
X-Gm-Message-State: AOAM5307dtmXHhIc2VmU3bCY8JMSVpFQ/efeJ7PjdKzc6wGSvhHzu+gC
        vbcvLH7d+xpRHTjrec8XAxzW2g==
X-Google-Smtp-Source: ABdhPJzaY79n3svROxhhavD7molBVjp0Fw3QrK2h3PmIxnn1uL3sT3TfTjMuqb3dOVp64JTckRQigQ==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr26752210wre.361.1599566187763;
        Tue, 08 Sep 2020 04:56:27 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id 71sm34589177wrm.23.2020.09.08.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 04:56:27 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:56:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support
 for Intel FPGA PAC
Message-ID: <20200908115625.GP4400@dell>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
 <20200828100236.GF1826686@dell>
 <de14ce03-2d42-74d1-3801-2dd2b09a448e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de14ce03-2d42-74d1-3801-2dd2b09a448e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020, Tom Rix wrote:

> 
> >> +
> >> +static int check_m10bmc_version(struct intel_m10bmc *m10bmc)
> >> +{
> >> +	unsigned int v;
> >> +
> >> +	if (m10bmc_raw_read(m10bmc, M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
> >> +			    &v))
> >> +		return -ENODEV;
> > Please break functions out of if statements.
> >
> > Does m10bmc_raw_read() return 0 on success?
> >
> > Seems odd for a read function.
> >
> >> +	if (v != 0xffffffff) {
> >> +		dev_err(m10bmc->dev, "bad version M10BMC detected\n");
> >> +		return -ENODEV;
> >> +	}
> > The only acceptable version is -1?
> 
> I ran into this in testing.  This is a check if the board is using a
> very old legacy bmc version. The M10BMC_LEGACY_SYS_BASE is the
> offset to this old block of mmio regs.  On the old boards, v would
> have not been f's, on the current boards it is f's. The check is
> necessary because future calls use the M10BMC_SYS_BASE offset which
> was not valid on the old boards.

This should be made more clear.  Either as a comment or as a define.

Preferably both!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
