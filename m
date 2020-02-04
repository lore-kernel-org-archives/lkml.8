Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C994CC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A45320732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cPhAokTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBDA2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:28:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45631 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgBDA2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:28:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so8475782pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vAhBNULLMh9XOTvTdD4G3os1qV1uXBckyQ+ldlyDpfU=;
        b=cPhAokTZ9kQlxDMTNKVdWb25SdZQI8UBNjRVl3ZSbzLxuAeFM6nmq3+LvH5C//TF72
         KnmhtKKTDOHe+qmvVNbgnDAq2Img5xAMjhjYPLWv+sLiUToMmBjdRXFhceXTZHrF2ZbY
         QAgYwXicceFkzvpgstFkXqu24LkxVf4tauXIa/0VhQSciw8bdJEQn5AkAx2RfGETBATL
         sTUJK4WpvdJJ+lHg8NEvi1TaCek47dl7BprkR5UbBzvJ0SEB9KQamt7iu86LmxJXmwnt
         /6C7kujevhxm1/7+UJB4473pqpmOeMG8UwOChUsbyZ0K12JZ/+PasYw2ROZpLYfmIVgv
         Wfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vAhBNULLMh9XOTvTdD4G3os1qV1uXBckyQ+ldlyDpfU=;
        b=gNNbR+LAXCH7ZeNXPg12fso519pezBYL6gNQjPTYhVpEJ2xMMKhk+eznZpHkOyrXXh
         AaFBRlEwdiEr3pYU+5VTLYiJRT/V+4O31Ud286xtKscA+EVWvbTnE2nw3CWa9mKK6Iyd
         /dqsroQOukn+wwTm+qZkluYGijsuyfEUEF+6ipGlkgCKCTLx7+f5dAyCCygPnV1NR/sD
         JqCtySRqChUQ4SJ5shYbnH/q+sFPmepY2doYRC88au+RURrSpH/+RPxQs/DCwWCTWr53
         5FJf4D5iF8q9Hvu5hf+1fFu9PW+Prj6IRsNLHLSVwsXL4oFzropklQZfQ1U0XAUcs3pG
         Hqcw==
X-Gm-Message-State: APjAAAUbkBq0yx+xCczLYrf1rcDlubsYsUZ1XgfD3ohRTygrt+8uXXVJ
        NBZNcSCN3u+dGuPj40yDIi4jD9+Xsjs=
X-Google-Smtp-Source: APXvYqwUc9cZI7DMbGryZAH6VeR/EOia6vpZadPgVDPS+m5PjCNf3yY9tmflych0xth95EjpIgFBDg==
X-Received: by 2002:aa7:864b:: with SMTP id a11mr27630304pfo.175.1580776117631;
        Mon, 03 Feb 2020 16:28:37 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g13sm17438595pfo.169.2020.02.03.16.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 16:28:37 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200204112555.0f1b1490@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eaad4710-872e-a0fd-33df-747d16c8c293@kernel.dk>
Date:   Mon, 3 Feb 2020 17:28:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204112555.0f1b1490@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/20 5:25 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:

[snip]

Thanks, apparently we needed two includes... I've folded in your
fix.

-- 
Jens Axboe

