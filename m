Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9618BC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCFA2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZDwMV4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA3WSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:18:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53400 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:18:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so5601284wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GL8YlOuK+lPzvntmToerBw7cag+fxZ5AswnfHKR/VLk=;
        b=qZDwMV4crOkitMmF78zyNFVYRJb9e5CEAC4FCpSUWyji9TxxJJgsUSjQudQUxFKjDe
         OnWpEQMl0la0WRTBE71vLNCTqZ0FYROPkKOith/+dgUtPhzurU8FSu7MZT9BHX5pKJsg
         Odnw+zIk7XQEqj69zFrjvFnedoTatx8SnUj/qphLqeOX3aUAs9gi9YogmZLEQ0orZMYU
         BLBhKyWM8Ea3XP+ewS0doz/fBpU9LVhRAnEEs9DKAav5GgWUmOP903EdO9Crdn3c4ag/
         kCObtj/qfwF4ndTi6VhjJ56L85HTLk6oryAENEQ7g4+78P1CH5lkHv2JOaOKVsWfptSt
         rhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GL8YlOuK+lPzvntmToerBw7cag+fxZ5AswnfHKR/VLk=;
        b=BK+YyN8KLhFJ3AWIdHo9W1709pvyKOIFMCkqSW+TEq8G0G0oc/R0EKWXHy0rTjqqcK
         H5ofyxDyNyUPE3JPdVmir/VCLitrzYekQ6vgpUcS5Bm8ZSYDrlk/GcKvuPMYT2EbGjZY
         qXt1z9YlsB2O0nejW8gJh1fuRYjxeZmsmkZsOPZjU7vT1A9DOnumYCDgi5bQfIoXDJIB
         4oWjcoxpiu+8ea1erVO1Vr7UwprReeggu4beY0bwNTsZc+nei9jYE5K2qgdWKByQeFVD
         5ldcMvpEOTEsPsY6IQwQ/EASrUHGqmAlu4pxeLpZFYD2J6KAotKaeuzgtMl/WjhEq/ed
         mPkA==
X-Gm-Message-State: APjAAAX/EqTlwqWwsRnu6o33C6s8spJCX4trXfLQ/CPoyK6LZ4vdmwJH
        ZonB9KvE2xxhd4kBt8+P16Y=
X-Google-Smtp-Source: APXvYqzXvgPJ14PpKCOak++6YdVlnp+Bo55KVfK80pKxm/zXXmnUS0dnTImjZ9kxihgjtrdnQMUchQ==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr8017311wmg.151.1580422683872;
        Thu, 30 Jan 2020 14:18:03 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y10sm8959076wrw.68.2020.01.30.14.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 14:18:03 -0800 (PST)
Subject: Re: [Patch v2 0/4] mm/mremap: cleanup move_page_tables() a little
To:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        kirill@shutemov.name, dan.j.williams@intel.com,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200129002642.13508-1-richardw.yang@linux.intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <50f408bd-502e-bd02-53d4-719300736ce2@gmail.com>
Date:   Fri, 31 Jan 2020 01:18:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200129002642.13508-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.01.2020 03:26, Wei Yang пишет:
> move_page_tables() tries to move page table by PMD or PTE.
> 
> The root reason is if it tries to move PMD, both old and new range should
> be PMD aligned. But current code calculate old range and new range
> separately.  This leads to some redundant check and calculation.
> 
> This cleanup tries to consolidate the range check in one place to reduce
> some extra range handling.
> 
> v2:
>   * remove 3rd patch which doesn't work on ARM platform. Thanks report from
>     Dmitry Osipenko
> 
> Wei Yang (4):
>   mm/mremap: format the check in move_normal_pmd() same as
>     move_huge_pmd()
>   mm/mremap: it is sure to have enough space when extent meets
>     requirement
>   mm/mremap: calculate extent in one place
>   mm/mremap: start addresses are properly aligned
> 
>  include/linux/huge_mm.h |  2 +-
>  mm/huge_memory.c        |  8 +-------
>  mm/mremap.c             | 17 ++++++-----------
>  3 files changed, 8 insertions(+), 19 deletions(-)
> 

Hello Wei,

I haven't noticed any problems using the v2. Thank you very much for
addressing the problem!

Tested-by: Dmitry Osipenko <digetx@gmail.com>
