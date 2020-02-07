Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A862C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42114222D9
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlQ+VhSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGLGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:06:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39225 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:06:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so2242999wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zMsp4UuAC/b8KhB/mSZIHIFY0+hSXiMGCvZikBQPSDs=;
        b=AlQ+VhSSpa1w8im3H1saI+wH+pPu18xiDfClRNoHpuj/Y+IYkgToiTVl2CtkNoPvFq
         uDozDztwK1niVDVCk75dNY2f/F1bj3xin2h9ZZv1dD647xqMJSiFHmZ+5r/AkX28ZW+c
         SrbARE9aW4FefNGo9AgGyrXEkKVmBoKpHI2PJjELIbW1WN2uBL8bmCGHq7/6m0+++Uyq
         CBMB8JWEpo6uMTCZRQGHsKjRugNdsh7wBuf0monJ4WwEtkmxiIHjDv/8eZAgkCF49OFV
         e5zZUWl7KPbnNwuw8sz3rKt5ks58cx7ojBYXj7xcA7YZmas7zcgu4+GnTNwYFDaStPkf
         R+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMsp4UuAC/b8KhB/mSZIHIFY0+hSXiMGCvZikBQPSDs=;
        b=iw/rTGEMqDKaWDD1QaD61fwY4w055pe0l1lCSxkQcqijwrHBXWCSOEmmbOye30+uuO
         /oggOyczcD9+v2puU0LyWfoYpDWDhxti9qyCiaWTYF+9vet+Z8L9JumqFhsIpPO/WAxK
         J0V7PRQlnGJ6P6ZjEFsLwBEXKo44AU3QOWqovdj1opzAb0iQH5VvE5bYmSVK6MYD9nSw
         4u4GdMejfVJ35vStHDhkk8h5KaZPTEqPrMmn5d5rZ6A7kmRtNOOEARTc3ShdvbZyanuU
         k79/OoDeSlGNHj13s6bjtGRJWUfkfDys34J/wTaEiIJ32M1KeAJJTYio2i7wnG63tbs+
         WRpA==
X-Gm-Message-State: APjAAAUNdGBIyQLkK8/rRfavq+RG9J5/5eimrwQvLjBiEk7QJ0K5bqfD
        3Dck6YNIx1L6IDBqz9azMOM=
X-Google-Smtp-Source: APXvYqwaz34FrR+VaKtjmRw/hi1Yf+8hNOUqovGFUy/3IcWiCY3MDALc+IYhcL6yliuvqPKToXVkew==
X-Received: by 2002:a1c:5441:: with SMTP id p1mr3992501wmi.161.1581073590233;
        Fri, 07 Feb 2020 03:06:30 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l15sm2925650wrv.39.2020.02.07.03.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 03:06:29 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:06:29 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/3] mm/sparsemem: adjust memmap only for
 SPARSEMEM_VMEMMAP
Message-ID: <20200207110629.qkovh23k7ihzh4a3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-2-richardw.yang@linux.intel.com>
 <CAPcyv4h9C+QLO0VVn2W97p2sYxP2LocCyxYF+Gzy3tM=DYxH4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h9C+QLO0VVn2W97p2sYxP2LocCyxYF+Gzy3tM=DYxH4Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 06:00:13PM -0800, Dan Williams wrote:
>On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> Only when SPARSEMEM_VMEMMAP is set, memmap returned from
>> section_activate() points to sub-section page struct. Otherwise, memmap
>> already points to the whole section page struct.
>>
>> This means only for SPARSEMEM_VMEMMAP, we need to adjust memmap for
>> sub-section case.
>>
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  mm/sparse.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index 586d85662978..b5da121bdd6e 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -886,7 +886,8 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>         section_mark_present(ms);
>>
>>         /* Align memmap to section boundary in the subsection case */
>> -       if (section_nr_to_pfn(section_nr) != start_pfn)
>> +       if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>> +               section_nr_to_pfn(section_nr) != start_pfn)
>
>Aren't we assured that start_pfn is always section aligned in the
>SPARSEMEM case? That's the role of check_pfn_span(). Does the change
>have a runtime impact or is this just theoretical?

You are right, I missed this point.

Thanks

-- 
Wei Yang
Help you, Help me
