Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800B0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F384206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V9IvKWCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgHSMxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgHSMxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:53:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A677EC061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:53:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y10so9214728plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJN7mPc4emxLWdlN8p4SOLwoWeu8g9Q4yzK4x1mAeUc=;
        b=V9IvKWCIvVv6RHOH9FmZD2dEZhykl4heM9C4QqgM6ZX/rhStZvwtXIE6311sDZIgTj
         zav4sMApHPARygYP7q+vkk8tA5Nsk/+wApyQCU8PKpYZ1SyE7u9hbKCWX1ncaP4ethsk
         OqjveJ/lTH797kTI0bHbD9wUwhYg2MgwUnfbwkYeXwbmQVjmNXrOTqeEB0TD5yG0qcZi
         LxyCmJhx0B1ACnnnFNq50/aA9+nsUNlpkzcazjwVKtQpzVNRistFgmBf1wL2QnL1wFH9
         fSQyrI1vQC4ZcGXtF2ZMPIIDmb/BkFXVAMrqn3hSlEf/3z7e4A3Ww4Tf6l4a4bKVfkHI
         Gd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJN7mPc4emxLWdlN8p4SOLwoWeu8g9Q4yzK4x1mAeUc=;
        b=dvmNtCGyMRyv6bTnOxlvZiAA2sH1rIBDXKJwl4Pwk2p+NSNauROacNcnrrFaQsJhdY
         SPHKpxICD27xUZPM6ydg3F6gYgtZ4Fmyc0qbscglD21JYClCoZYu/yqpvzX4dRsWNNdd
         J8k7/l6Y0IvvQjxBmXl6QraqpbmN63YRNc/u+LFPE/mg2ehtE4UWVSW5mFKXOCaVWMm5
         YoM2qDI657qAEPScnBg45AMb6feyxw0ApiQQ++2wRIKIRkHVZbvkCFUuJRddNPZrm0Ag
         WTB5gvm0SIoUppaYhhVRIv35aVuO5oQr8RA2q5NHM7TuIgjA7wYgTz3/Vi7nsaOzmEQM
         2Faw==
X-Gm-Message-State: AOAM53024+oR7yA/5Lpb1sTRapLhrUBtW2XclcMqvQE15aZiohhhZ3GE
        Zdg/62hCwR6yNYxxeHFfRXu11UddNSBsDBK/
X-Google-Smtp-Source: ABdhPJwWxtJ56gpX/eys9lAeJkNGXd7Lh/mpNFyHUZnF8rMPQuRnhrAZSY17fn+dbhx0FWeDG4KhvA==
X-Received: by 2002:a17:90a:ea13:: with SMTP id w19mr4215260pjy.18.1597841599971;
        Wed, 19 Aug 2020 05:53:19 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z3sm23839823pgk.49.2020.08.19.05.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:53:19 -0700 (PDT)
Subject: Re: [PATCH] raw: deprecate the raw driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200819073533.1808361-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2b65ace-be51-6094-f9a6-5d72677c2b64@kernel.dk>
Date:   Wed, 19 Aug 2020 06:53:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819073533.1808361-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 12:35 AM, Christoph Hellwig wrote:
> The raw driver has been replaced by O_DIRECT support on the block device
> in 2002.  Deprecate it to prepare for removal in a few kernel releases.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Jens, I wonder if we can sneak this into 5.9 to have a longer deprecation
> period?

Wow, hadn't thought about this one in forever. Yeah let's see if we can
get this into 5.9. I can't imagine anyone using this thing, well, ever.

-- 
Jens Axboe

