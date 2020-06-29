Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98E8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B8D206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eupvc9s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbgF2VSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B79C030F17
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:25:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so4763497pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6u7fsXOnpntiVLfxhPmOks2Cw5x4MKBv8gUIWlulmZQ=;
        b=eupvc9s7oTUWLWpef4QipcnGJua7jXAWsjt7JWwV+gxzv4gQvuOPABkzbJGCpMX50M
         7VDeXpYwQcWLIN68hFKi8495Lt2hq++eSMC1HOfPA6BUcZVKNQF+H4xJ6jCh+IW8CeN+
         4CwNQUXtRuVU8dez4qk1ww+if1571lMT89enUcZs2tPLFV3e/mhS8MOytKxOKQuK9SVl
         aIeYvgHRCgpLzJWvq8THmowVyVy/j8A81XaQJ3ee62M3KBOCO1NjsRJhYZs45Tj9Xkfq
         mBk2ULY8qHLgKoDJikvetY1Ir/z/EC/porLZF97jSoXEMMIyP/USaoF6yQvRrEtYzCbs
         ZBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6u7fsXOnpntiVLfxhPmOks2Cw5x4MKBv8gUIWlulmZQ=;
        b=ZUak3eRqJ44tFU5BogqqWWPyaY6LdGjvT3uDcSNjSvcfMZWBKbEtax2YB4BoXFHVMo
         3e+8z2TCjcsNo/TDoS7o3ShetQfhONl1rnBxDa53B7HxUyKdsUQCZTYN9G7BjtvZY3v7
         7GqRLotIE6T7uuVltVh46eDvVU300f4pNdu+rNHGA4WDzmF742rJVqxHPm8ktEj6o81/
         yxSyCFVmb/M7/Dwbh9bLGnR5/Q0fsUoIZ71zufk7nTrmA1Avm+aJXDyHF5djA2jC7VBM
         BUaM9AIPcynOsMRyBTPZiteEhOMQpwdW8y925fprN74jMWMC4vU9wKHDF5eTaoJzJzGD
         c78Q==
X-Gm-Message-State: AOAM533hkMexAFvOeYoTYHxEcJl2TbZKqFdb7+V6jcw32fU1hrhc3/HO
        u8EMtk3shhD0Mp/y8tozRZAfg5v3tdGp/g==
X-Google-Smtp-Source: ABdhPJwoJE3KK2/ckFz3jcZ/3sSQF+7WycuVQNd3KJFtZYhYYhEPn0QeeddqpPWDR/3UlOahPZTYeA==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10mr14216607pls.34.1593447903575;
        Mon, 29 Jun 2020 09:25:03 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id z25sm194632pfg.140.2020.06.29.09.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 09:25:03 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200629080533.5f44d445@canb.auug.org.au>
 <3949fc27-da62-6e26-cf07-59d3c78e2b64@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa5b0279-32a6-f9c6-f325-cedc2786b74a@kernel.dk>
Date:   Mon, 29 Jun 2020 10:25:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3949fc27-da62-6e26-cf07-59d3c78e2b64@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/20 10:21 AM, Pavel Begunkov wrote:
> On 29/06/2020 01:05, Stephen Rothwell wrote:
>> Hi all,
>>
>> In commit
>>
>>   8c9cb6cd9a46 ("io_uring: fix refs underflow in io_iopoll_queue()")
>>
>> Fixes tag
>>
>>   Fixes: a1d7c393c47 ("io_uring: enable READ/WRITE to use deferred completions")
> 
> Jens, could you please fix this up after me?
> full hash: a1d7c393c4711a9ce6c239c3ab053a50dc96505a

I don't think that's a grave enough concern to rebase, it's just "missing" a
single digit of the sha.

-- 
Jens Axboe

