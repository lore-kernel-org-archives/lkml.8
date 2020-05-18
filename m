Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1095BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA28320657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vtm64xWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgERJsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:48:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327EBC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:48:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci21so1528279pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qhhn0VwMxiaOVltVT+JHeQEc8jO/6BKzGmuLUsypl40=;
        b=Vtm64xWVmyDtHmUUR2p2lWsliT1zLS+ji2PmXEo5AOaXRctjr5RrzuG299MOHoi7/Y
         Ncm/X1K8fJeljEh9G/Yy/juSpQ53ipBA5Ci7CD1lrGqQ4OGu8f6prCRYyfFqBAzUa3vj
         gaXfaNxWAPiCxTePAtxez4Pa6OeA77UMa3xmTE62nFHvGbxAvo6ZXGVJRO5Nd+sTkqMn
         uLy6McZZOcWvLEXkoV6L85FjQ9Af5BdIBg/VyZhQjNDkabQtauIcq2u1E+ZCZ18PEmjM
         N61AMQkKoZpHIrKZeLCkwPs15FOJ7UPwK6EpbQSjbMMBx70AmWS9BIHdKHtRKuRHv5E8
         nmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Qhhn0VwMxiaOVltVT+JHeQEc8jO/6BKzGmuLUsypl40=;
        b=cLyJqEMTZNs8jVMagNJ6ydN2vgzIDZIH10seUJR/fUx9J1BYQmf8MVKtybaXguriAk
         0lKNXrjlwh5mz9S8bVl62LHMb5sADO0a6jD9q8OA93EUy3jQh8wqxGbEPVBKlt1n3obP
         qNdV6uKRCOtIcoTM/4FKs/WxBnKfccCekKgHTIvFhSUjDUcCQyA8g4DnNQ4YaW0qdbon
         Gn43FiGojd6fVHfUGAuPiTxQ8z/j2DASrWlL2hfPdz5FxEuERI7UeAOqTdW+dalZPQFM
         ryohBVgFASMtvRD96MYJsIU+izmou6e1LcpTz8fEBFHT+4kW5EruxQ5/nyWdFkn9YE8J
         ls2w==
X-Gm-Message-State: AOAM531dm2RLeioz+L7ipg6xif7f025NyyRrKmL3jxGxKjJt/XpmgnQW
        XKO9p5UaPi2EEPMyhnTg/VM=
X-Google-Smtp-Source: ABdhPJz+aUlgYRjsAuVFMjH0Upj5P2vQAMj98/L+5cMVNkUbB2poJnmdDIEg+Z9zfpO5y/4iHxakkg==
X-Received: by 2002:a17:902:d311:: with SMTP id b17mr6403665plc.147.1589795300476;
        Mon, 18 May 2020 02:48:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u73sm8955021pfc.0.2020.05.18.02.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 02:48:19 -0700 (PDT)
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>, rppt@kernel.org
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net> <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <418aa44b-6fb3-c3d8-a920-1a26e5edec62@roeck-us.net>
Date:   Mon, 18 May 2020 02:48:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518083715.GA31383@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/20 1:37 AM, Will Deacon wrote:
> On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
>> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
>>> On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
>>>> Now that the page table allocator can free page table allocations
>>>> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
>>>> to avoid needlessly wasting memory.
>>>>
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Signed-off-by: Will Deacon <will@kernel.org>
>>>
>>> Something in the sparc32 patches in linux-next causes all my sparc32 emulations
>>> to crash. bisect points to this patch, but reverting it doesn't help, and neither
>>> does reverting the rest of the series.
>>>
>> Actually, turns out I see the same pattern (lots of scheduling while atomic
>> followed by 'killing interrupt handler' in cryptomgr_test) with several
>> powerpc boot tests.  I am currently bisecting those crashes. I'll report
>> the results here as well as soon as I have it.
> 
> FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
> issues. However, linux-next is a different story, where I don't get very far
> at all:
> 
> BUG: Bad page state in process swapper  pfn:005b4
> 
> If you're seeing this on powerpc too, I wonder if it's related to:
> 
> https://lore.kernel.org/r/20200514170327.31389-1-rppt@kernel.org
> 
> since I think it just hit -next and the diffstat is all over the place. I've
> added Mike to CC just in case.
> 

Here are the bisect results for ppc:

# bad: [bdecf38f228bcca73b31ada98b5b7ba1215eb9c9] Add linux-next specific files for 20200515
# good: [2ef96a5bb12be62ef75b5828c0aab838ebb29cb8] Linux 5.7-rc5
git bisect start 'HEAD' 'v5.7-rc5'
# good: [3674d7aa7a8e61d993886c2fb7c896c5ef85e988] Merge remote-tracking branch 'crypto/master'
git bisect good 3674d7aa7a8e61d993886c2fb7c896c5ef85e988
# good: [87f6f21783522e6d62127cf33ae5e95f50874beb] Merge remote-tracking branch 'spi/for-next'
git bisect good 87f6f21783522e6d62127cf33ae5e95f50874beb
# good: [5c428e8277d5d97c85126387d4e00aa5adde4400] Merge remote-tracking branch 'staging/staging-next'
git bisect good 5c428e8277d5d97c85126387d4e00aa5adde4400
# good: [f68de67ed934e7bdef4799fd7777c86f33f14982] Merge remote-tracking branch 'hyperv/hyperv-next'
git bisect good f68de67ed934e7bdef4799fd7777c86f33f14982
# bad: [54acd2dc52b069da59639eea0d0c92726f32fb01] mm/memblock: fix a typo in comment "implict"->"implicit"
git bisect bad 54acd2dc52b069da59639eea0d0c92726f32fb01
# good: [784a17aa58a529b84f7cc50f351ed4acf3bd11f3] mm: remove the pgprot argument to __vmalloc
git bisect good 784a17aa58a529b84f7cc50f351ed4acf3bd11f3
# good: [6cd8137ff37e9a37aee2d2a8889c8beb8eab192f] khugepaged: replace the usage of system(3) in the test
git bisect good 6cd8137ff37e9a37aee2d2a8889c8beb8eab192f
# bad: [6987da379826ed01b8a1cf046b67cc8cc10117cc] sparc: remove unnecessary includes
git bisect bad 6987da379826ed01b8a1cf046b67cc8cc10117cc
# good: [bc17b545388f64c09e83e367898e28f60277c584] mm/hugetlb: define a generic fallback for is_hugepage_only_range()
git bisect good bc17b545388f64c09e83e367898e28f60277c584
# good: [9b5aa5b43f957f03a1f4a9aff5f7924e2ebbc011] arch-kmap_atomic-consolidate-duplicate-code-checkpatch-fixes
git bisect good 9b5aa5b43f957f03a1f4a9aff5f7924e2ebbc011
# bad: [89194ba5ee31567eeee9c81101b334c8e3248198] arch/kmap: define kmap_atomic_prot() for all arch's
git bisect bad 89194ba5ee31567eeee9c81101b334c8e3248198
# good: [022785d2bea99f8bc2a37b7b6c525eea26f6ac59] arch-kunmap_atomic-consolidate-duplicate-code-checkpatch-fixes
git bisect good 022785d2bea99f8bc2a37b7b6c525eea26f6ac59
# good: [a13c2f39e3f0519ddee57d26cc66ec70e3546106] arch/kmap: don't hard code kmap_prot values
git bisect good a13c2f39e3f0519ddee57d26cc66ec70e3546106
# first bad commit: [89194ba5ee31567eeee9c81101b334c8e3248198] arch/kmap: define kmap_atomic_prot() for all arch's

I don't know if that is accurate either. Maybe things are so broken
that bisect gets confused, or the problem is due to interaction
between different patch series.

Guenter
