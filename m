Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41094C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C92620672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEMiy3wC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGITjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGITjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:39:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63324C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 12:39:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s9so3731171ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+OepO2nKSOxNGiVCQdNRNmLRtU3HAbEFcnSxXOT54vo=;
        b=oEMiy3wCm+PjX07etEOwp/E7fuQB95v5jee8fSzPlp3dJBHQ8hM+j7/tQN4UBmoibV
         ME0CUE/oCyWMEISAWmSXrE2btbICT74f2BpDfhB51efYFAQCerz2nQfDiyD6k+KF3DJH
         qZ/k3QmWMXgX2hx4g/E3CmPCcSbdZOqM2pc6RlJ/p/mwURCStQ/n7lBlVHpwChZHHAhe
         sCwhDQvteVSJwML0UxEYXu4vNOlpJ4onxW6+lzmKFjuHWBaicbcnHo9BQznosPs29jOk
         Cp4e/RurtT6bwfmLbCCR3cwc8SZQGqHraHxdVmr6ghHfVVqk6QIC0mgjmFSPE1K4s9fR
         dLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+OepO2nKSOxNGiVCQdNRNmLRtU3HAbEFcnSxXOT54vo=;
        b=bijatGgBSK82rllykMp+6Hw0WoXMiLV995BGlZIDIkFSs9H+x4oOIuLYPTCErbC1bq
         X6j6ki5ldmDUEJMIAIzH4AoKsDWZ8Zyp80f5WWdnw9w1N+1XKxfmwq2O4tOdOqh2SVs2
         /huh2mV4StG5272cPTY4y62k5lIXYPQrNTFmH7KXYF5SMcZ5fU6Jo3KyOphHByueZ0IQ
         zCygYh/LEHJ+5kKdi1JNgB5obn3u8gUwnoYEt1shrVcsnqWh2mvJajdGoPLrGFEtDKdT
         +dVB2y10VLJmgdyji+79WmuWJgDNQOVO8xnpEOHzZcHhdZEUz08551AztKjwwBqs1Z8A
         SOBw==
X-Gm-Message-State: AOAM532U5SgawIJNnbCW89zhcZayLfuFrwUm1ermDQQlD7344XBKrcOR
        0lPPVQ9x0GSl6tAR5+tPID8=
X-Google-Smtp-Source: ABdhPJz8Aa6ie8IofGNZQLA4EGGb1MufMR0+8zmxNYmbDdyzYFYN9ZTbkD3RWFyqIEcOvqLGHq4yEg==
X-Received: by 2002:a2e:88d0:: with SMTP id a16mr38853046ljk.213.1594323540901;
        Thu, 09 Jul 2020 12:39:00 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id q128sm1109477ljb.140.2020.07.09.12.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 12:39:00 -0700 (PDT)
Subject: Re: [Patch v4 0/4] mm/mremap: cleanup move_page_tables() a little
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, yang.shi@linux.alibaba.com, thomas_os@shipmail.org,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        peterx@redhat.com, aneesh.kumar@linux.ibm.com, willy@infradead.org,
        thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200708095028.41706-1-richard.weiyang@linux.alibaba.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3cab86b0-586e-781b-1620-f28b00c57d44@gmail.com>
Date:   Thu, 9 Jul 2020 22:38:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200708095028.41706-1-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.07.2020 12:50, Wei Yang пишет:
> move_page_tables() tries to move page table by PMD or PTE.
> 
> The root reason is if it tries to move PMD, both old and new range should be
> PMD aligned. But current code calculate old range and new range separately.
> This leads to some redundant check and calculation.
> 
> This cleanup tries to consolidate the range check in one place to reduce some
> extra range handling.
> 
> v4:
>   * remove a redundant parentheses pointed by Kirill
> 
> v3:
>   * merge patch 1 with 2 as suggested by Kirill

>   * add patch 4 to simplify the logic to calculate next and extent

Hello, Wei!

Unfortunately you re-introduced the offending change that was fixed in
v2 and today's next-20200709 on ARM32 is broken once again:

BUG: Bad rss-counter state mm:db85ec46 type:MM_ANONPAGES val:190

Please don't do it ;)

> v2:
>   * remove 3rd patch which doesn't work on ARM platform. Thanks report and
>     test from Dmitry Osipenko
> 
> Wei Yang (4):
>   mm/mremap: it is sure to have enough space when extent meets
>     requirement
>   mm/mremap: calculate extent in one place
>   mm/mremap: start addresses are properly aligned
>   mm/mremap: use pmd_addr_end to simplify the calculate of extent
> 
>  include/linux/huge_mm.h |  2 +-
>  mm/huge_memory.c        |  8 +-------
>  mm/mremap.c             | 27 ++++++++++-----------------
>  3 files changed, 12 insertions(+), 25 deletions(-)
> 

