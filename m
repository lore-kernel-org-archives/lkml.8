Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD21C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2992063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWcqyEBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHQJM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgHQJM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:12:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC84C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:12:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f18so12799178wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TAk1CNB68uzgdZHQjUzoVKE5R4ThxDVFJ+Vz/1cgb+I=;
        b=VWcqyEBKXQbKiMZsXmRyusrwFWvJBgHoensvI90QD+n8ep0Txg5x3aUmA60AU70XN2
         g6QXXH2GPhF42s4Goj+EZnN6K9Fl4J/Q8UBDzQiIjP5b1y7viW0Hid2hb2GI6911ohan
         VulPHyiC0YTr4JBWGx0A0RbyDU/d+8iqUeBKRKrmv6U+JonPAloMBpwPa9654kHaZDpW
         hT8mREVT5DktElD+1m0KRtJ5xzsZuGMyNwNur/GmiBzL36HQQecnseBarYckX65U3LD0
         EX2juwO3EYnedw+eJZmHCK+b7BkwNMElfxrsIAnWkcXBCIobUlf7LtpZI9nDNsGqE5lt
         w6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TAk1CNB68uzgdZHQjUzoVKE5R4ThxDVFJ+Vz/1cgb+I=;
        b=k7NUKVZp4+NSAu/rMNqZASBiazFmtos83dPDHBYMdSk5fk5eIrLZVIbZDXRy3l4CeL
         q2s4bDTHn2fEazlEeh6A5cmlHi7P5Lsq8UYzSfsrSpg9s3iCHDmp9m0jFKMzH1QRRzCZ
         ofH3sSmz6Kje803f9MxBUNHuxtla2Ooqoplg534qA6BrIswQL2tSXm5tzF2zU0iG5c/x
         4dOCyNJvAYlzDSe6zzxCFz9Ccz3kjyRCn+92wPXgIPbNAAOFrFijSi002BXN2BP9WzLe
         01stqt4WMpVHZlYaCTD1MhQkMVLPR55sOTD+VEAFs9D1o7WdutQ+zs3gxFmy/N5I7TiP
         N0ag==
X-Gm-Message-State: AOAM5318yE6fsxYL0Q1Hpwp+aNSLTeB4wcVGSgfxQh7qFZsy4F2i6OXi
        bqYpg+OhEtQRdppMpVO4pUESJA==
X-Google-Smtp-Source: ABdhPJyOTFlAWBDZIYUZfML6pdmbAFDZ2dwR9Y9BvYix6RSJO8bJcfOG8uwIN4GMVQvYfWNL4O+UAQ==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr13316971wmb.157.1597655574497;
        Mon, 17 Aug 2020 02:12:54 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y145sm30720826wmd.48.2020.08.17.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:12:53 -0700 (PDT)
Date:   Mon, 17 Aug 2020 10:12:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Message-ID: <20200817091252.GV4354@dell>
References: <1596614456-20182-1-git-send-email-yilun.xu@intel.com>
 <20200817082410.GB19661@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200817082410.GB19661@yilunxu-OptiPlex-7050>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020, Xu Yilun wrote:

> Hi Brown & jones:
> 
> I tried to refacor the regmap code and add comments in this patchset. I
> made big changes to the rx flow and remove some tricky parts in it.
> 
> Would it be more understandable than last version? I'm expecting your
> comments on it when you have time, thanks in advance.

Just resubmit please.  We can review the code itself.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
