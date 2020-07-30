Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBE0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B37C2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y1dQnjMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgG3RqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgG3RqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:46:11 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B915C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:46:11 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j9so19801980ilc.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+f4IFhG2djRuvcFmGTRHAajQFcXsrndVO/SZzro2eAA=;
        b=y1dQnjMrml1hBY4Kv3uFmAwTo87V4ZcHn7dGg1OGK83xtxFt2KkcP6mlMLQ8SqKdm3
         Uy+vNaCc2F6aq2ziGAGvrCIL38jCyTF5E7QRWj30Eo9JNTxRO8Wv7FgO/VMUsMg0rN1K
         0v9ZqseDGo/crxXVGgsHrJGVIYJGie74DTWp5eUJOzJrwqESXPX4yMReRjcGXXMp/2q2
         Wrt66jiTAGXKPBxeWiZoDAgp9LoHMTkHFJIEl8GCUHP3xRZJOHKhKmg/xuM2LE7b4HPq
         ru0GKZrbq03aG96IhLOLVHTwzwO0w8limcZgHGwRtEmGRWUShqF7O9DxinDxI7eqqGX5
         8pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+f4IFhG2djRuvcFmGTRHAajQFcXsrndVO/SZzro2eAA=;
        b=cvzJqNKMatsxhGz1TTW5f+OyUVXDaKjuYsCBuRLHSLa2lvvWqcNk7Gvg2GdaejfJgd
         oytfix0y56bAEnUsCQFc6icnwuqNkNoooljq5F/ceytlCx4zKhTq/Erc50QHCzq7st7f
         vbROKl7jdyS/jyd4zyJ5FVY6E7uyVbSbEVflIIIvMGEyYZuiSD5OGaxgQZI0fEHHmOZH
         eyI5FaHr6bvuG267kYTWhVmeKsmyz6PnjrQKOXz9L1Oal+NDRQB/cX0xBKbw0mhgaB8f
         Af5/+5f+j8Ceew/z1vK6FQOtesgXQpgP7vTQgca54r2Do9kVbIaQvrthWgZgFJrtYH36
         t4lg==
X-Gm-Message-State: AOAM531Ytr8FBCHJtPxWUct5AjZjw5NmXKZCl7MpaArL1c7ARw+Jk1Bl
        iND6BiATIqoKBUinln4XAXRo0jrZBIo=
X-Google-Smtp-Source: ABdhPJxDuoNCh35y3vT7UN88lZ2Q+eWloT15kJ9Q0oWYn8dsptnKDYt5tUny0O6nQHJcdf21BQxyvw==
X-Received: by 2002:a92:6008:: with SMTP id u8mr40065711ilb.196.1596131170673;
        Thu, 30 Jul 2020 10:46:10 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s8sm3058335iow.11.2020.07.30.10.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 10:46:10 -0700 (PDT)
Subject: Re: [PATCH] iocost_monitor: start from the oldest usage index
To:     Chengming Zhou <zhouchengming@bytedance.com>, tj@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200730123104.27023-1-zhouchengming@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c68a4aa-c301-feba-8ded-62e6de81db4b@kernel.dk>
Date:   Thu, 30 Jul 2020 11:46:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730123104.27023-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 6:31 AM, Chengming Zhou wrote:
> iocg usage_idx is the latest usage index, we should start from the
> oldest usage index to show the consecutive NR_USAGE_SLOTS usages.

Applied, thanks.

-- 
Jens Axboe

