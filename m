Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E5DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAC1214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dJRG8Qmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIJTQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbgIJPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:54:36 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB7EC061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:54:35 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id u20so6135729ilk.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OZHxSy9GxPtwL4FPXTEL4wHPxBFDa6n0iEKloHdc+dY=;
        b=dJRG8Qmps859QERXNYLJxi55QI15qf+NmhuQCnsZM3tzSEE4XDm6akhiZPmfFP2D5L
         noKfGQmOG//ogqGq6MHNPrBzfyTsSRYDDvmU4HpGKt2M3+VX34Rn11vzjMP7dWCeXtL7
         peTBqP2XxuoNfSrqxocG1z0zzHqFPkd4E6mCLjflVUpkyfeWBoxTosdtHT8O3weuXwoU
         tQ9lPzZrLFElRA5AiEu/B7dHsjPFnIljwQ7uqXHEHqGd8+4jBMrrg/VTkfD3IGCBJS5B
         tsG5z+xzaGHBSxD5B1GWK+wIELg2uX73o8AHY/LKWaXB7jjiscV+sTvRU/rMsZateAut
         mn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZHxSy9GxPtwL4FPXTEL4wHPxBFDa6n0iEKloHdc+dY=;
        b=WHybdPpEYDuv6ML0Xo+QCCvK7Ss6kPO23j9t3o9BiTYZjk94W93eb9ny5SnrEGsblR
         k6++HOAVU2E0aDJiByF8yCUkxAsEanpqySrjQ7olzqxrB6Ebuub9/B/GH7o2EpPcCxKl
         ECU+YZsADiBy9w/J9NdIgTtsuA4QhYD4r0BAHv1PjlC77GKn4Ox6G8G5nK2w3AnU1gQ6
         ZR4KfxcolLDIctBwdtr+gat55A8XAW8OVBPtB1z8u6cB9Zif1jVVYye/UXgYtKl9Zjpr
         puauBpit8Eog9UNdL+Vo+jJS7UnxcUJa3bH3PGQwc5ip2HQIx++wcwcNWVAgcqTqhuYX
         8c3w==
X-Gm-Message-State: AOAM530tFKKy7JbNbEgQljX+F8B8mLbwZbImPDh08mFZUC7bdAst9viI
        VfAKnbQaqybRiXHaX6Lb/M4aNA==
X-Google-Smtp-Source: ABdhPJxHvxNIiZ7YNxR9PEQ5wMasrzeeVlpwNZVmQsRSVIQZmYnp6kGKrBV3BTGdMbs3dPcZtBZnXQ==
X-Received: by 2002:a92:b309:: with SMTP id p9mr6758105ilh.125.1599753274952;
        Thu, 10 Sep 2020 08:54:34 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z15sm3315413ilb.73.2020.09.10.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:54:34 -0700 (PDT)
Subject: Re: rework check_disk_change() v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200908145347.2992670-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5e51c24-b9a6-979f-8fe0-f762f113bba3@kernel.dk>
Date:   Thu, 10 Sep 2020 09:54:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908145347.2992670-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 8:53 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series replaced the not very nice check_disk_change() function with
> a new bdev_media_changed that avoids having the ->revalidate_disk call
> at its end.  As a result ->revalidate_disk can be removed from a lot of
> drivers.

Applied, thanks.

-- 
Jens Axboe

