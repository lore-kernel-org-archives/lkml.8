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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD9FC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10093214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/ebsK+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGKvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:51:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39724 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGKvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:51:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so2097978wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zc3jMaChYZfioTbBOk9kpxLi+oHkdXLRPRb4H8775Ng=;
        b=I/ebsK+TWi7aYsC74HDQmsHiiYDR7MnGLFxe+hHyowxI6oJWDn6uiLJs3HFspDquZT
         Cmqxt3uF5uL5FWMe6o+KpUX3HoFTucsTgWkTbV83MTUudXADqXfmU9Z+BfAs++Any3iH
         TOuzamkiD79BVAVq2HXW7ZQNB+ut77pKFCo9PVUn04kGu4+MFMzQK4S97yXXZ48khPMn
         tc7DZBqRYMgI4JFUPD33tkdAYE87FN9Mrki+rrliR1PfKB/0ebWCfP2cXr9MQ16zItb3
         J4nK9/is8w1kbgysfxj1Kw4ZgiHEIZoxdEaBMhvFP+Mrge6HzUybk4z5x+CXtzDnIR/s
         QXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zc3jMaChYZfioTbBOk9kpxLi+oHkdXLRPRb4H8775Ng=;
        b=X0CupoBa78MBNVfnHR9QbiRRY8BoP/7A3FpSsiMbJXOvy2VIhY6gjZFLdZw3lgMsxm
         DHLb0kjSQ+mYIg3o5LTLCKApj862EW30Znp4hE+IBKffyppFTOhxb+qG4sJD0Bn8tLfj
         HN531LnOBv1bUP7Qr6MgPQoNoTbJucw1JKzd8pQXgkQ0H7uB5AJvg2gVzq5r5pkoUXhp
         ab5giva5Dw+Cnb/3xSHVF1Z+VhfJ6M4mDFVxZRauDKbv59CVyY4K5HcC+4Nay3lx/srs
         bai0r9h87Jnl7ZRV19MfnvMnuPj6zqwhLmGKeOOyFyF6MtDXgYcsbpw5+hgiwz4mZeRd
         URlg==
X-Gm-Message-State: APjAAAW3ZLKVzjzgGh1IvHEjbR5C8GNVDkEKBfi9xUzCehyMu/IKXnR5
        IYa4XY8F1+O+EGvpW3Qz+2c=
X-Google-Smtp-Source: APXvYqwIKeDyNV4qkwYvgz0z2/KKIj/hgwRYUaTQDF9bezEOpITlkV5MUtAMke/EvdVbGGJ6jQh9ag==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr3816542wrb.33.1581072696736;
        Fri, 07 Feb 2020 02:51:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b16sm2761352wmj.39.2020.02.07.02.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 02:51:36 -0800 (PST)
Date:   Fri, 7 Feb 2020 10:51:35 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200207105135.cl2kelkrqlift273@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
 <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 06:19:46PM -0800, Dan Williams wrote:
>On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> memmap should be the physical address to page struct instead of virtual
>> address to pfn.
>>
>> Since we call this only for SPARSEMEM_VMEMMAP, pfn_to_page() is valid at
>> this point.
>>
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  mm/sparse.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index b5da121bdd6e..56816f653588 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>         /* Align memmap to section boundary in the subsection case */
>>         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>>                 section_nr_to_pfn(section_nr) != start_pfn)
>> -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>> +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>
>Yes, this looks obviously correct. This might be tripping up
>makedumpfile. Do you see any practical effects of this bug? The kernel
>mostly avoids ->section_mem_map in the vmemmap case and in the
>!vmemmap case section_nr_to_pfn(section_nr) should always equal
>start_pfn.

To summarize:

 * vmemmap, ->section_mem_map is not used mostly
 * !vmemmap, we are sure range is section aligned

Sounds we don't need to handle this?

-- 
Wei Yang
Help you, Help me
