Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57956206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IROJTaKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404128AbgFXPBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404107AbgFXPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:01:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17872C061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a45so2371544pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2Wt5QedxvLGXCfHxOenkohT0DiZJGHo6D4kFEJ4uE8=;
        b=IROJTaKwsSOIpl0WW4Gu8mPbIi0eaibrEp+f3DVWW4zt3amjINeZfRPvIwLOalIy8e
         7/XPatvV30fEzPY0uKnRbynudIVhi6EssJ1mMT8B0TpQ+xVtlNJaRmhqmbE5EsBsogHQ
         GLEFs2DhZ7YwDKffHihrNoQ1dDx5eYIzFeiuTHCZj3zodndYdrl1fLKXzPBNaUzA7o91
         53gctfr2I7K6XZakW8edfoI4f2Jrfi5hIjR+g+50Do4ywZoOQSBko7nkRRaC/tKXERdn
         ep6h0uze29S8PrWVjY8q8UiafF0Ba0EyrQW9/ORpTST41Pj5CDvvpAGBdLbMdY/8gWpg
         584A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2Wt5QedxvLGXCfHxOenkohT0DiZJGHo6D4kFEJ4uE8=;
        b=QrFBNEtQuRyL0DIALoiVHpCVTZAy7oE66Cl7GbhdhjFSQ0HWsY3aLfLYE9CJkt4rkL
         ty6KY4Xh5+TMoohOoW6km+6H4v9Rf78D/xneez2Ne00eYrW5vTLCcDFL01JbHq1gg2D9
         0FU/RA8aOGEUIiW4pDIK1QD2emqmmpA0VojuFxUMRech3hn3jVqLOwyV4jUurMbtwen5
         rDw3tk6RFaffQEf9eI1VVoK17ypJoLSEx7WFi/UA0mv2lSRmW4A4ThfglLEi7iYTJUR1
         hR7/DMDUqiCN60thBcugeNAgQ5hWBVHT3xM7GKsUg8ZSIe4e4APjHUYDpJtV8m+l4HS8
         Hy6Q==
X-Gm-Message-State: AOAM532DUus5sRZzurcIhKXpfRo7KaGi8nt5LgzRsIdGqgMt7ChbElo9
        Yz8Yx6KJ6tZBjRpv3wMrLvF3Ug==
X-Google-Smtp-Source: ABdhPJwdFv++0X60Vw2UpSgX2H9PZx08FyjXGhCZ+1Q4IXV3Ir3kUVavKO4Ae3tjd6c7WpUnLLyOGw==
X-Received: by 2002:a17:90a:d485:: with SMTP id s5mr27344721pju.61.1593010894581;
        Wed, 24 Jun 2020 08:01:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p30sm21012287pfq.59.2020.06.24.08.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:01:33 -0700 (PDT)
Subject: Re: [PATCH 05/15] mm: allow read-ahead with IOCB_NOWAIT set
To:     Dave Chinner <david@fromorbit.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20200618144355.17324-1-axboe@kernel.dk>
 <20200618144355.17324-6-axboe@kernel.dk>
 <20200624043814.GC5369@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8248e187-1b4a-83c8-0ba8-afc253ed69da@kernel.dk>
Date:   Wed, 24 Jun 2020 09:01:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624043814.GC5369@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 10:38 PM, Dave Chinner wrote:
> On Thu, Jun 18, 2020 at 08:43:45AM -0600, Jens Axboe wrote:
>> The read-ahead shouldn't block, so allow it to be done even if
>> IOCB_NOWAIT is set in the kiocb.
>>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> BTW, Jens, in case nobody had mentioned it, the Reply-To field for
> the patches in this patchset is screwed up:
> 
> | Reply-To: Add@vger.kernel.org, support@vger.kernel.org, for@vger.kernel.org,
> |         async@vger.kernel.org, buffered@vger.kernel.org,
> | 	        reads@vger.kernel.org

Yeah, I pasted the subject line into the wrong spot for git send-email,
hence the reply-to is boogered, and the subject line was empty for the
cover letter...

-- 
Jens Axboe

