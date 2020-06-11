Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2DDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC658206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IxsUmGCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgFKPQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgFKPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:16:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBFDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:16:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so415447pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TkYB8W4nXJPMmHfuB6tFy5NdErLfDGBuYJ9xHGiV3Nw=;
        b=IxsUmGCg9xCXJcVSJEYQFLPgY7kLMYX6eJTZ1z72m7zhsWvBgGBTX1x9lqgj6B5tOT
         0JV1l9UwolLKFpZ+dc0h9IG52uKi/3HwzBecVu2ISiciuwjDkNwQDqxJ8pSRleEOLs16
         VFbz2jwDyq0e1XWubhCpl43Z+a4oN/kGns7Rb0CMTTTxdcKH3VMMDqHtWsUZ/WwwRmsN
         lFfH5s/ClyskThKq1PGT/qcruHKyTDqkC9SRfwVzNQteR5/qd0Rg2SeXhNdTG5CzIq18
         SUi/kGzp0xGjNTBmuYLJg83r7DJqjaqz0MOtt4HqyIiLBHzjA3zqWE063MibbNxbdrbC
         OdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TkYB8W4nXJPMmHfuB6tFy5NdErLfDGBuYJ9xHGiV3Nw=;
        b=It8YCD7AWL/wk6FvPhHFC2DdAEA8bVvnscq9lZ9mDzbR+YM6iPjB9MRULAZtbMd/d/
         bmdWoLzHWbKm+61KVt42UEgQbfLCtL4o+MfhEiSihAIaia/KPWwH2ztBfXgUKVTx7O2f
         ClL3LW2M0o2mKwGb42hipcA18fIFZ8A+jmUa6YInLBrqJ/c1zzMe4Zsp6V/XVYP6kadg
         W821Na3XrNoGKyNHQ4G0R4rVA7zSgKWmWbDYCgUVq8R2qGBssdDmAdneUIc/KW8TwK8Y
         aSdjYOx5KE1pT8Q0TvtSD3mZIprDdu+QOI1IiBg3SRCnbIE6fwZ4z/ukKxH4QbJ59uHG
         PCAg==
X-Gm-Message-State: AOAM531Kkyx20aW5+kTLNyauLnKyga1HQ2DaxKNEohPOX8M0+vfsP/bB
        NbH3LnR6/4rPS2gBknTlSb4rJ851edu4zA==
X-Google-Smtp-Source: ABdhPJyBU4PaWFmugtp0SghM7ORFmRKLbhu67wIySCFY+UnIRRr2o7E5ktqM4TOai7STPK8vvP0Ytg==
X-Received: by 2002:a62:834c:: with SMTP id h73mr737262pfe.221.1591888565047;
        Thu, 11 Jun 2020 08:16:05 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u5sm2975735pjv.54.2020.06.11.08.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 08:16:04 -0700 (PDT)
Subject: Re: [PATCH] pktcdvd: remove redundant initialization of variable ret
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200611143014.925317-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <70a77fb7-ccfa-2843-c30b-beb5ba493856@kernel.dk>
Date:   Thu, 11 Jun 2020 09:16:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611143014.925317-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 8:30 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

