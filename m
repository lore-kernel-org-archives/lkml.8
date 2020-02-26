Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF5AC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FB820801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sqv2FNlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgBZKcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:32:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33842 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:32:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so2337615wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=otmCATSRYiYfcNTEa190T1n7T2AvRdBbV2LD1HclObE=;
        b=Sqv2FNlb4QYJOkmyUbBO7bwbAk95t9jcY7coAj0MhyHXegl3TMNKJvFObYocSZ8TVH
         fE16W1DoLXT2oQPG/aNmFqpU6ZXv3Ia55o9FGPlbjEq8vpybtd+abBUXZVhOSKEpNjj6
         MDiWtFeX7Itw4oL4mpZqPk/hWLVmWyFG595B76ymrD5Fd18ftU0ZtOZ0h9SRD74mazRg
         AGTWF7uuOz055tKJIP7rP0cibf1q5bxSR7w1i3dg2H4+FZv5x1xnhGMqY7WfFjZQYn2x
         oukn8WVJ99SDK9yTpv0KGZos2yGWAezAuGyKQ7jXQFDUrMRykdQj5x8pATXsYMqlvgzl
         TEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=otmCATSRYiYfcNTEa190T1n7T2AvRdBbV2LD1HclObE=;
        b=X8CZ8Qte6nut0/A2IZm3DhFV3l2rDAi6qJ1EOCIeGdb+KkKZH9wcJAtQzapY9bSxYS
         bhbSiKGrMJzhuMwC03bn0O2oESIesAZOIt8ClCMBWYTXh8a5TFTKeVD0Py1oiRlnR5vd
         zajNp2/4LRdsaxzLjvdrROPBFt+SZC15rbo+lPdldAzVvqzKRRIiBsM1rSmUJN9S3BPD
         q/0ZSTL3iZUm9Ik+6Fny1c7T9oJZ1ocFYTGwiG1eioy7pCYw7w/MUdV0/guk8BjAFdXX
         mI+jlB9OLNrDgA264ijIV6xKFX6zSyHccHanwmy9icOXDeCVJ1GomZ2lJv6vY2B2ejr/
         SO1Q==
X-Gm-Message-State: APjAAAWQuJpf0ocujdVPUdqQY/9vhwwj7zucKN0H6qNqDhqQpGEVAnwx
        OZWoenLplTv0/3NJpLUaHJH8gcoNKC4=
X-Google-Smtp-Source: APXvYqxJ0189fHCzXgNjZsRc+7OHH4aLOzN4lIHEZg0t6OgJRwoj3QJCIAmzJd350lmE/9RTYJ4FIA==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr4546464wrl.320.1582713133328;
        Wed, 26 Feb 2020 02:32:13 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id t131sm2460789wmb.13.2020.02.26.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 02:32:12 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:32:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: Re: [PATCH v2 3/5] mfd: rk808: Stop using syscore ops
Message-ID: <20200226103245.GG3494@dell>
References: <cover.1578789410.git.robin.murphy@arm.com>
 <7fdcdb900c7dc4fba38266e1db637131c3090a67.1578789410.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fdcdb900c7dc4fba38266e1db637131c3090a67.1578789410.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Robin Murphy wrote:

> Setting the SLEEP pin to its shutdown function for appropriate PMICs
> doesn't need to happen in single-CPU context, so there's really no point
> involving the syscore machinery. Hook it up to the standard driver model
> shutdown method instead. This also obviates the issue that the syscore
> ops weren't being unregistered on probe failure or module removal.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/mfd/rk808.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
