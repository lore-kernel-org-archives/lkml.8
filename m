Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9565C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F58220728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gDBM/cKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbgCCRzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:55:11 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39906 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbgCCRzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:55:07 -0500
Received: by mail-il1-f194.google.com with SMTP id w69so3550949ilk.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ayIxKKAwCnNFCQ+lZzklsRs5rXYB11mGFHyYGI5wUqQ=;
        b=gDBM/cKDaAMh9NyfxfoObozsG9BZGD80+G1UGm/xV8TRxMqdcxd3lkS7Tjc2EZIK5k
         O23wx5QTaZLVh2TUQMR/TRMtGrzlj3bIrack/HPTGO10ixgYa7tKMJ096FUlVlKSpVlk
         4T4h8gnuTVFX1A/hBPx1SunMMPdgrCbXi4uVHq95icV0U4T5UQyhYuUIg4plkkEWhLtK
         iY/tQv5MsboKHbHaXcPeN6P1iYXGkLhHrJcXbFJGYOaBrXt/zh7Z9xLjhLQSofkYiJbd
         L7hD+kdiIc4k3EkxMC+O1Z2XYNe5g1WwxJxZxyKY6/WHpQcxhJwpXpYZ9S8bMjc/4KH3
         aUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ayIxKKAwCnNFCQ+lZzklsRs5rXYB11mGFHyYGI5wUqQ=;
        b=VsXf3hSeLNPd0Jr7nkPEBN11iMpwXKRmdnCLD6K9XO5iQ0mlLkYqMnaeXBW68gIjjy
         A4Z8rLYTyqpi6V250M2u0TZI0oD3qVpKskADsgppU+i+dBQxeahjsZ0rrGn9aPjLCtgD
         VZ9qXbb73PKZr93mtjzisnmsLEm6YRSDzC2KpbLqfd7dW+A+pa/OX+kPr7M7qbD7eJBd
         aGpkkth/NxlX+yhEdxqHRO+cWBKX18NYIwI4wIDn4WsDNautfxXPuV6y+9TG0h4p6r8z
         4iRzVJ3pJauukjX9NKQ8AzqmaFFp784lQ2IbivOjyzc2O7BAqFOefulgvVEH8EWHdeql
         vDcg==
X-Gm-Message-State: ANhLgQ0Geu+08JTZmS8fASmEVYVM97jXEoHYXZyCf+2bLTQ8gllHxBvS
        web7fp/EkNX9Jlv1DY1M/9RuLw==
X-Google-Smtp-Source: ADFU+vswN1+JEsE23FDapwuSVGGnBVQIgUF2nTXa5raP7vGWLMOlfTYLzjaimZzTkgwmW/1PXcHyyw==
X-Received: by 2002:a92:8f46:: with SMTP id j67mr5772317ild.125.1583258106150;
        Tue, 03 Mar 2020 09:55:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h14sm1061362iow.23.2020.03.03.09.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 09:55:05 -0800 (PST)
Subject: Re: [PATCH 5.4 062/152] bcache: ignore pending signals when creating
 gc and allocator thread
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Sasha Levin <sashal@kernel.org>
References: <20200303174302.523080016@linuxfoundation.org>
 <20200303174309.501274295@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db776832-64ff-6757-de09-ced1ea8b368f@kernel.dk>
Date:   Tue, 3 Mar 2020 10:55:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174309.501274295@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 10:42 AM, Greg Kroah-Hartman wrote:
> From: Coly Li <colyli@suse.de>
> 
> [ Upstream commit 0b96da639a4874311e9b5156405f69ef9fc3bef8 ]
> 
> When run a cache set, all the bcache btree node of this cache set will
> be checked by bch_btree_check(). If the bcache btree is very large,
> iterating all the btree nodes will occupy too much system memory and
> the bcache registering process might be selected and killed by system
> OOM killer. kthread_run() will fail if current process has pending
> signal, therefore the kthread creating in run_cache_set() for gc and
> allocator kernel threads are very probably failed for a very large
> bcache btree.
> 
> Indeed such OOM is safe and the registering process will exit after
> the registration done. Therefore this patch flushes pending signals
> during the cache set start up, specificly in bch_cache_allocator_start()
> and bch_gc_thread_start(), to make sure run_cache_set() won't fail for
> large cahced data set.

Please drop this one, it's being reverted in mainline.

-- 
Jens Axboe

