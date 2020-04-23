Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF56CC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A02320736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg9MY5If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgDWSD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgDWSD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:03:26 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3FC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:03:26 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 72so7698304otu.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2/La/wL+coGvWMbmb0Ahh27fgATuogd6ONJOHlv/dXo=;
        b=Tg9MY5IfCmtOyZv1E5YaI5u48Aa0GMq/n5vgn6qgR8RcoRuTAN1Qo1NsHyK/nMM3Gy
         qMdC3Bhh6992NB/VIAeWF7jbJu0LzSYmftkF1HfzL9aJ+waynEJ9J2rNGG0E0TMIrCqj
         0AzADq5Sj6hhv/qw2Bl/rUgD/qXP34J3I9S0FfmYz2+oQrXX+KZ6Gk7mMjzkalhLh5f1
         zo4Jx7tsl8G9t9Gq5EPJQq73lyDrZXMHDPiontp3cJTfRD0GmPz9IV62njpsNqQstTnn
         G/M7E+Q7xyhDE1qHGtBGMLzOZzqfPg09sCNweKst45W1nP7dmbNwsPa1R1eKARjN04K5
         pxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2/La/wL+coGvWMbmb0Ahh27fgATuogd6ONJOHlv/dXo=;
        b=ECVOwceSYa8cez6DIWj67URVma4p4j/x3q8pigg5V5DbcAgOf4u6fyWER9vVFVHnDz
         nmxuS7/ieXtNEUh+wKZ29PrLDVLCJlh9SJ1WRKjP2MgsR5kWKFnPwhgH87EgMV0f8f57
         r2TG376zA3d3p+rQEqnTccdTB1tcOIcBVnBuMFopCmMgZLdhV/KSMJqCbtw5xIHIlDMw
         u/0tAgiKc/GSFu3eLcjGyVm9hZHfaFs7E6i3WL1WhZ2S8WXJU77upSf7DxmsQIAAMPds
         512Ev6wZJOKorF7NhN2W38bL9qYkrbwnZwgf50/NszrnaYZ4CJXfaEqJ/Vb+1lT7qwSp
         yfYg==
X-Gm-Message-State: AGi0Pub6QRaIwx9lNcFAQqtl2lA9hfKwDYmujGYDBRaWRxYbawmp3nbS
        USZO/wSY/LEOkAQWZXJUqW+9NfuNl6E=
X-Google-Smtp-Source: APiQypJlwGEDo4ccJA0eOVTEQHvZXXtJkUFC/LyKTI7ERYuXNAKD6DnV8AQGRPy0ysr79IcclNc3pw==
X-Received: by 2002:aca:2b0a:: with SMTP id i10mr4075605oik.22.1587665005382;
        Thu, 23 Apr 2020 11:03:25 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g13sm767144otk.62.2020.04.23.11.03.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 11:03:24 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:03:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soundwire: intel: Make sdw_intel_init static
Message-ID: <20200423180323.GA18440@ubuntu-s3-xlarge-x86>
References: <20200410115708.27708-1-yuehaibing@huawei.com>
 <20200420071212.GV72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420071212.GV72691@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:42:12PM +0530, Vinod Koul wrote:
> On 10-04-20, 19:57, YueHaibing wrote:
> > Fix sparse warning:
> > 
> > drivers/soundwire/intel_init.c:193:6: warning:
> >  symbol 'sdw_intel_init' was not declared. Should it be static?
> 
> Applied, thanks
> 
> -- 
> ~Vinod

Why was this applied? It replaces one warning with another (that is
actually visible during a normal kernel build):

$ make -j$(nproc) -s allyesconfig drivers/soundwire/intel_init.o
drivers/soundwire/intel_init.c:193:14: warning: ‘sdw_intel_init’ defined
but not used [-Wunused-function]
 static void *sdw_intel_init(acpi_handle *parent_handle,
               ^~~~~~~~~~~~~~

Cheers,
Nathan
