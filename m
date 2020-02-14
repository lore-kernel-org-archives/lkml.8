Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E07FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E697222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skgxbxei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbgBNJMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:12:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42063 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgBNJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:12:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id e8so3496369plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 01:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YfJq7nGAaU/CodvzuiTJ0GQLAtFhs3FPkxECGfNM5Pk=;
        b=skgxbxeiNa+Kmpjh9vLwPapqQrJp9JKrLs/9W/qHBwR6Neg8PoxyDtvOfJ9BGdvPw8
         vlsZYJHhoLlKi+I29cceyqZtl6ZomshnBbwrzUsQVe9Dqk/RCLs3vUWRn833SQ13C5wW
         WHdHlUdCXtIWwNAYmJhmFxjW6E0C97lciVBPEyEWJ0eeJy68Iu+w/hc1s1kPCdL7OSwV
         10hiDLOlHcvE5WnwCT962Ps9V5jxs24KxUmL+fMS9fcBGp/kBm96KK1AbeFpGO6IqZ2u
         NHnY20Wy7Zfsm4j9SZg7Wkqo9fZuYxRgqfDLej9UYcy4rQ19diMRPP+RqWu4CpmWPZtj
         5Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YfJq7nGAaU/CodvzuiTJ0GQLAtFhs3FPkxECGfNM5Pk=;
        b=B5tmW0PqTgE30jijhmy41bNbClJmCTp8uLAao45161FkVmM19Va33521BY1coaaIJx
         tIB0mUM4LGoWNjVs4QokQ7Vub14bzxpCQJ7TPQTzmBnnvQ1e5cFG+0LbcaMqf3wnZNSM
         WoqdKVPlAJxv84OUWlVWdxGnWeCITcsGBF4Po5ZCFL0+EGGtk8BcIgTS7q/yxcwp3pRb
         HEdg+EMevwE5YlRAGjAl9x2tqK0+EbU4LlNn8tl/LBfBsyS7YEltapEzxEb0raYtYl4P
         /We9El13L5FPbuRCwKe3DpJT4ehuo2RDEtPWAUCV45ARrVHmveDp49XcB0IZpXYBMddh
         XJSg==
X-Gm-Message-State: APjAAAXrU7sOdZ8jgfA1TPLNEiNHu/nXYRHD5dbMzbhIPV1xEfR+8oZw
        yfa0fsOmEwkFmw/4q6RYYMxo
X-Google-Smtp-Source: APXvYqx/MMNoIJVibPFhFnas2INFpCv10w8uMgU8O4GTtPE02KyIEeH+TPNtT3kU+aNaUucvmHNR3g==
X-Received: by 2002:a17:902:d216:: with SMTP id t22mr2361037ply.150.1581671524205;
        Fri, 14 Feb 2020 01:12:04 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:482:690f:50bb:adfb:86f:a4bf])
        by smtp.gmail.com with ESMTPSA id z27sm6081643pfj.107.2020.02.14.01.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 01:12:03 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:41:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     David Miller <davem@davemloft.net>
Cc:     dcbw@redhat.com, kuba@kernel.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Migrate QRTR Nameservice to Kernel
Message-ID: <20200214091156.GD6419@Mani-XPS-13-9360>
References: <20200213091427.13435-1-manivannan.sadhasivam@linaro.org>
 <34daecbeb05d31e30ef11574f873553290c29d16.camel@redhat.com>
 <20200213153007.GA26254@mani>
 <20200213.074755.849728173103010425.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213.074755.849728173103010425.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Thu, Feb 13, 2020 at 07:47:55AM -0800, David Miller wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Date: Thu, 13 Feb 2020 21:00:08 +0530
> 
> > The primary motivation is to eliminate the need for installing and starting
> > a userspace tool for the basic WiFi usage. This will be critical for the
> > Qualcomm WLAN devices deployed in x86 laptops.
> 
> I can't even remember it ever being the case that wifi would come up without
> the help of a userspace component of some sort to initiate the scan and choose
> and AP to associate with.
> 
> And from that perspective your argument doesn't seem valid at all.

For the WiFi yes, but I should have added that this QRTR nameservice is being
used by modems, DSPs and some other co-processors for some offloading tasks.
So currently, they all depend on userspace ns tool for working. So migrating
it to kernel can benefit them all.

Sorry that I should've made it clear in the commit message.

Thanks,
Mani
