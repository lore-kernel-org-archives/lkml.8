Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBDEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E33922CAE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8UTjeOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgH0Msu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgH0M1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:27:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B5BC061232
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:27:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so4942383wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1BFNwvu8rBwN9stUjG3d5lzv7XiXDcsYMpVKhxq+mug=;
        b=V8UTjeOO7pt4cwjykrFJxMqmeekLT8aWiye+vmiOZVahIZF9KN0OKSV85fVs2AEaEG
         +zsmm3OyV6PIEDOoGA3vwhNZIW1Uqk5dFSxhOVqZO0odMq53qQeuKXRcXhuSL7jndXcH
         ArlgSRf8BnVoKQ8gMQN7yfSPNUEjPlAc4Cjwop15/3gMjDG3sgBmr/mxyP2XZdsL1/VW
         d4p5CHmDQPa0ibo7mER4eW+AcH/qw8YdaMagTV7NHGqBervzjJIhf9UYit9hUazLgwtd
         xBr+c9hU8tAKa7b9ZUcPeKd7OWA1p0waqTH04NAGKFeB0SfRO+5W0sBKXysRkh8TEpIv
         7izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1BFNwvu8rBwN9stUjG3d5lzv7XiXDcsYMpVKhxq+mug=;
        b=oKbP47LM9X3CBC+MsZeUbaLvJMUQ/6bXHJTdbcxQWcnD52DMw3rBrYy0PV2s1hh2p7
         IhTtkP0D31KrR5qKjRHn4bFTogaaad+WmUhSSLVhnb+5k5TSXS7k7lt3VP947hP1lk8l
         GgqV8TkhmlAyUAZmDdK9RRvI6q67iPXXczt7eLdTGxl8nJM4asCCnmmmG1BtE2UxnD2k
         wPcVLq79CegfhmeatPDZ/m+xE62as4ZIS1Yr4Q43tanaS5riP9WIv+Y02RFBH1i8cbm6
         ZxtZtHb3cZudvogeLL1+b7tII7wT0Pro17gv0iRdBPu3tYqPGc6KfqL5Q3E6n53wL9Y0
         XDew==
X-Gm-Message-State: AOAM533iBqWAaW9n9Pjw7rk0t1drvWjEpI2eZwOoTqY156wYg+wly/Jz
        rw6v2JtVJO/LNaLjNwgIwtz3Ig==
X-Google-Smtp-Source: ABdhPJwvpTWcMGLE3zucq/3pV3891tweVjmimX9yI3nUKK4pyaTJ+vc6Q4F0Sf6zd7TJj06U8785eA==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr12068616wmi.151.1598531244671;
        Thu, 27 Aug 2020 05:27:24 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id h5sm5660395wrt.31.2020.08.27.05.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:27:23 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:27:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        hao.wu@intel.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com, trix@redhat.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH v4 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Message-ID: <20200827122722.GG1627017@dell>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <159846941049.39902.15220563960562003689.b4-ty@kernel.org>
 <20200827065647.GQ3248864@dell>
 <20200827122013.GB4674@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200827122013.GB4674@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020, Mark Brown wrote:

> On Thu, Aug 27, 2020 at 07:56:47AM +0100, Lee Jones wrote:
> > On Wed, 26 Aug 2020, Mark Brown wrote:
> 
> > > [2/2] mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC
> > >       commit: 53be8bbc2f4058d4a6bfff3dadf34164bcaafa87
> 
> > Que?  This is yet to be reviewed.
> 
> Sorry, meant to only fetch the first patch.  Dropped now.

Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
