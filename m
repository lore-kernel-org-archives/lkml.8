Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8746C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF1022B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnhVEzGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgH0G4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0G4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:56:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC689C061264
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:56:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x9so4109262wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3ayGOk+/JeyND85yxkj/Uc7Hasftwa3oWJIsR7xqt2A=;
        b=PnhVEzGxDTQFTvuXit58KCH5pHeByiCiMtsaEd7SQWtAlnH1E1dEt0zc7ya5r5hehe
         n7h2/Z95m162pbqJOIYAiujp+NQLMbeqGEeFlsPv0+gBkg+N7yiBv8fFtXQGld4aulWb
         I9VNTfCHqwGxYIsWJDK83a88n25cTAZwfU8uRjCwEIstEbPZOzqB+70m8KaRcAIoE06H
         fdFlHI8a91hJoyxF106tGoFF2152jNwVjK5PRfyD4I33bOMKTPvdvADWIKSk0PuVDOqs
         BuaUE6WAw8S5VJ/ZtJVvKUSgjTznNSg20LOcgEiv1g+XUWQK/4q9qH+T2f0yL3pF/Ku+
         UcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3ayGOk+/JeyND85yxkj/Uc7Hasftwa3oWJIsR7xqt2A=;
        b=VhHVchdfbkqyuJ/mKghkeBFT+T6ItDsjM9hy1chl7ggz5C8CpUlSFq+i/cTlLWAiv7
         w85L5uiqha87796Le/RqvuW0ZEY9O42jYZ8iqI7B1tyRvzLCDMz9KJrBG9RLL/LpCF/G
         OE4uiRQc0VdGpC3pRW+t2sN59T0Q4PWEP4FkMQ/Nivt/BXbtH9LNrk8q58lk/+7HwuX1
         LjPXTWDDVFQqtbdiIuT6PtmyhuO6xnMfvW7+LZpDFWQjBONqnYdEh8MWhadrWsty2uok
         2z/ilwIhc9mQamPQFiS4uj4AdlcPXKLmHiG30ivUjSQv14jaDpWAoSuH++fTaG9i/m+Z
         dRJA==
X-Gm-Message-State: AOAM533Yp7fVHDtM9BHvwEsEn+8mFUnaC1P+JtOAoL9Ut6Z+WHeVnhZh
        5/DXrl1nVqI8x6E69i2On0UxZA==
X-Google-Smtp-Source: ABdhPJylJz+xCjJvYyR6cHS82cUS96H4jeycbPF9Jp3y8JG4trgkt/CYwZ7N79D5ftT4IFWH9/RC9w==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr9954278wmb.57.1598511409365;
        Wed, 26 Aug 2020 23:56:49 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id g14sm2871587wmk.37.2020.08.26.23.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 23:56:48 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:56:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        hao.wu@intel.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com, trix@redhat.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH v4 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Message-ID: <20200827065647.GQ3248864@dell>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <159846941049.39902.15220563960562003689.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159846941049.39902.15220563960562003689.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020, Mark Brown wrote:

> On Wed, 19 Aug 2020 15:34:55 +0800, Xu Yilun wrote:
> > This patchset adds the regmap-spi-avmm to support the Intel SPI Slave to
> > AVMM Bus Bridge (spi-avmm) IP block. It also implements the usercase - the
> > driver of Intel Max10 BMC chip which integrates this IP block.
> > 
> > Patch #1 implements the regmap-spi-avmm.
> > Patch #2 implements the mfd driver of Intel Max10 BMC chip.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
> 
> Thanks!
> 
> [1/2] regmap: add Intel SPI Slave to AVMM Bus Bridge support
>       commit: 7f9fb67358a2bcaacbdfeee12e0f19e98c8bdf55

> [2/2] mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC
>       commit: 53be8bbc2f4058d4a6bfff3dadf34164bcaafa87

Que?  This is yet to be reviewed.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
