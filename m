Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D97C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747972082E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKRXcfBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBFOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:15:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37312 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgBFOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:15:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so7396834wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0mIHdzeqpLLVAXoLxv/ivBAsxFJuMaQ5HhkNdYNHfr4=;
        b=GKRXcfBgyN60W5V2e8tDnm6xwx6oVQO5KxN0UZzvrxv8sWQ57CAfKlafMjX9J77pUg
         zJu6NKvaZOR+P7+bwPSMDXQiM6sB0KtlEPGvnWYe0nkKRhR0Xw5UjvC8arnDzPUtLQip
         o/T4OSqrLxCwfsOTGgIt6q64XfdMAd+kqZbBcrzFSJq63QLeqvBl5kh2YETlpx3T4J3Z
         Ve0Zc6F36TFZnoWaXAlm13wTdRjOR3ZkDtpef65HGZWhjH/LZwn0tLBdcBBeKWB35NkR
         oSFpJiJ+XrVRSnQWw6UP5tszeYWMujYxbExGIhcQEAWdlLGWdJVN75X1ypUxpBsKHyCy
         z9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0mIHdzeqpLLVAXoLxv/ivBAsxFJuMaQ5HhkNdYNHfr4=;
        b=JYCtS8Nt+EevH8udgs2ZxT+vsWIEPS5+k2sEjpRV+hUpLbyQ0TGYh1c+9yIGtYJiZ7
         8NrhcB1C7DqB/uulwIWPLP1qmmzWeuP4aiQ+ZJIcMPVysfFb1+RozzaRgXQzaiaFYdSp
         HGiCHczb1d+HSDtB5ebcb7bjbBgNbX+PPuc7db08IMPD5mgJa2I0MSLkmQlrFO0YFIuV
         25Z28DvxPPmPRR4ZjAY4FQqtz4vy2dKDTIiB8V/KVYJD2bK1UflwONisf/sjnmQmYXoQ
         Tvi+S26jaY7mWZ1G/gllxfmwfgFQyh3k08yyvCeXy76hshO8tCWiu8jspYAo6TvO4omj
         dBxA==
X-Gm-Message-State: APjAAAVaDdoUSmdjiyzXTpUh+KdD5JeVxlIkyrEsbZSj/gzo1WfOru2a
        rYB9FphvLNAHA4NkKEXCHRJgVLR+
X-Google-Smtp-Source: APXvYqwlFtXkc/fLOIFGq/La92vf3hEm0/tY90sXdfwPMayErioHT7JocFcXfKn80KPhAQb5mrIuag==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr4051750wrq.155.1580998536235;
        Thu, 06 Feb 2020 06:15:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t9sm3667009wmj.28.2020.02.06.06.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 06:15:35 -0800 (PST)
Date:   Thu, 6 Feb 2020 14:15:35 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Message-ID: <20200206141535.4w4h5wnuzxmi37wu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200206125343.9070-1-richardw.yang@linux.intel.com>
 <6d9e36cb-ee4a-00c8-447b-9b75a0262c3a@redhat.com>
 <20200206135016.GA25537@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206135016.GA25537@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:50:16PM +0800, Baoquan He wrote:
>On 02/06/20 at 02:28pm, David Hildenbrand wrote:
>> On 06.02.20 13:53, Wei Yang wrote:
>> > When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
>> > doesn't work before sparse_init_one_section() is called. This leads to a
>> > crash when hotplug memory.
>> > 
>> > We should use memmap as it did.
>> > 
>> > Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> > CC: Dan Williams <dan.j.williams@intel.com>
>> > ---
>> >  mm/sparse.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/mm/sparse.c b/mm/sparse.c
>> > index 5a8599041a2a..2efb24ff8f96 100644
>> > --- a/mm/sparse.c
>> > +++ b/mm/sparse.c
>> > @@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>> >  	 * Poison uninitialized struct pages in order to catch invalid flags
>> >  	 * combinations.
>> >  	 */
>> > -	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
>> > +	page_init_poison(memmap, sizeof(struct page) * nr_pages);
>> 
>> If you add sub-sections that don't fall onto the start of the section,
>> 
>> pfn_to_page(start_pfn) != memmap
>> 
>> and your patch would break that under SPARSEMEM_VMEMMAP if I am not wrong.
>
>It returns the pfn_to_page(pfn) from __populate_section_memmap() and
>assign to memmap in vmemmap case, how come it breaks anything. Correct
>me if I was wrong.
>

Just see your reply.

Thanks for your explanation. :-)

>> David / dhildenb

-- 
Wei Yang
Help you, Help me
