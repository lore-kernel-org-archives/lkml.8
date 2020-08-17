Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62326C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA97204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lD+saaoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgHQUEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgHQUEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:04:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78FEC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 13:04:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so14279356wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 13:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tAXPgym6FtqBq+nYKNWr3Je81ziv8aLTZG6/euLwZtw=;
        b=lD+saaoAIHgBU7RNtXaTp9L/JEsVjNP4FXN5Pvcjq2x8zuVx2+jQJtXzC2uXKUdbsq
         qcIqAdbFScLdkdQRA+iVFhyMdANTntX7Gjcz+naJGav/gfCcGnbaiGtKKC10yBuxOoSd
         IsosM0HXin+2Un3HW/CZ9vGmdJ0Y3jhlqQ3ogW/uxyqlboRFubaV+MmmAF6h3hK+m9dd
         +uvMzwHLGF4JDHJ6JmgpmNC4M4X0tOVCFYO7jxvqvv71CgAhpqqEdsh7/BBcmE853Lae
         2Duqa2kQQMzU7TtEYUNwNRtsTsc7x7WWBET0PVbEA01Gwv9K7MK0HOuRiW5QdtlLdgrj
         ZwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tAXPgym6FtqBq+nYKNWr3Je81ziv8aLTZG6/euLwZtw=;
        b=kaCESUv2tu2jkcVrht6yqBr3MlHArkzZ6cZWUjxp1s85b5DL7weuE2m+kA0EX+57BE
         6Jr1RJL98F/zw2Vt1yzlbHNAIMW+hnp/fnh0qeKDXcMhj7XaCA+42HRXJF5RhAzDeVpi
         LMNHCuFylPA4rf0infSLwVAO6fwMNUy/Kt+7rpFFg8+gVdfUv5SN8Bfd/24m3bpEc62a
         wDkw/ISNeU6je1Ag4DvWMla5UfZRJlYbY1XjbAPqogh5t09cwlw4kfGcQ6iqiPekPswh
         0/dkSiaMKTNZ+h1VWzhiSLTugeEWtbuJiN3Hc+fuozUgU3J6m5Mm1u8fXxlDm07KLlEy
         ez2w==
X-Gm-Message-State: AOAM5332GooKd9/3qRvZ/RKDU6eL1IBdcG67SzKhwfR73SubmnP3Bn/8
        kcRe7LXH8BFsBs4BlL4OC2eB5A==
X-Google-Smtp-Source: ABdhPJx9jpCPFTLhiIHqL/NbBIE6T9LQfyDvbVE3f4JwbB5VFQtldiBaW4XWMqL+hgencFjPhE0YIQ==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr15440235wmc.97.1597694675470;
        Mon, 17 Aug 2020 13:04:35 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id m14sm32070420wrx.76.2020.08.17.13.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 13:04:34 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:04:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Reed <breed@users.sourceforge.net>,
        Javier Achirica <achirica@users.sourceforge.net>,
        Jean Tourrilhes <jt@hpl.hp.com>,
        Fabrice Bellet <fabrice@bellet.info>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH 12/30] net: wireless: cisco: airo: Fix a myriad of coding
 style issues
Message-ID: <20200817200432.GY4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814113933.1903438-13-lee.jones@linaro.org>
 <87r1s9l0mc.fsf@codeaurora.org>
 <20200814163831.GN4354@dell>
 <87a6ytmmhm.fsf@codeaurora.org>
 <20200817112706.000000f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200817112706.000000f2@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020, Jesse Brandeburg wrote:

> On Mon, 17 Aug 2020 16:27:01 +0300
> Kalle Valo <kvalo@codeaurora.org> wrote:
> 
> > I was surprised to see that someone was using this driver in 2015, so
> > I'm not sure anymore what to do. Of course we could still just remove
> > it and later revert if someone steps up and claims the driver is still
> > usable. Hmm. Does anyone any users of this driver?
> 
> What about moving the driver over into staging, which is generally the
> way I understood to move a driver slowly out of the kernel?

I always thought Staging was used for *incoming* drivers?

Either way, Staging is on my hit list.  It's actually next after Net.

Is there a Kconfig symbol that can be used to not include it in the
standard builds?  I'm aware of BROKEN.  Is there anything more
suitable for a deprecated driver (I don't see a DEPRECATED symbol).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
