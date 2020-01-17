Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C98C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2494F20842
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579256268;
	bh=2Lv8EHNmlOaEt3WUsINfySlGqQNtY/f3joSziB+hUB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mit8zWspNx11n8Ai0YZAtYRcG6kG593/WVkrY8RBGGa72Nq1746T/qHHeZXRYo07Y
	 JC8A02dO4p89jlLsrq1JI/O0c4XowR5g5Qk+Yj4GZqh/9nn4RS7LJSEMyuJbvvKdny
	 KZqJdfrnBLS4WIkfOnXlA+6fcOd7C7dMUn1JJUio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgAQKRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:17:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40433 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAQKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:17:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so22108357wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 02:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrJxvLC7Z/aq3pNh/DrH8onU5ingWRht14zTkzqKmZo=;
        b=jqUPfG9dVgXrH5MQLdZS0y2gfQS09X1d9FifVRc4K1ZHjfctqJkqEdbxCnN79kvCz1
         ZNkLLAzVTER5TjWlZbrWm4/UsMiDOILso2K2BGvDmoapi372YOsLGy0E6zkPpSJcarG4
         KZzOgl2YjNumwdjvMBXksRrFyw8pbsK7Wsvh0tkGKMon5svjVrbxKtJkO+VozGAb+FLk
         +M9Z041o8WobMsq2yXJsF2Q1RELVFCqCzuZECzWL5a0s7DuUIbFoQkr78hfyvGVu2wvE
         t9GhHHyeBr6MQML9GdmD382cuyoNaTWV+eaGFWU5zbdDv+NUN17U5UmeuUihw/P8y02u
         /BdA==
X-Gm-Message-State: APjAAAWbNpDJeVhdYDDIEN1ObAlVjqzVEVARZ++T+K3jDXsCD7nzUrjV
        +j0hkH1Fi44Qlx5mydk/Jro=
X-Google-Smtp-Source: APXvYqw/9Ju3QNPOArhDuA/7fC6UkD4daXdr3tfG0dWNf1FgyI+rtjyzIPNWnW7nUK0JVYzpkHRGSw==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr2290353wrw.255.1579256264741;
        Fri, 17 Jan 2020 02:17:44 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s3sm8680818wmh.25.2020.01.17.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 02:17:44 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:17:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117101743.GS19428@dhcp22.suse.cz>
References: <20200117022111.18807-1-cai@lca.pw>
 <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
 <20200117085932.GK19428@dhcp22.suse.cz>
 <b8aba013-16a8-8407-9330-8884d17b9594@redhat.com>
 <20200117094009.GP19428@dhcp22.suse.cz>
 <521da382-d9b2-8556-d603-5537b030d8fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521da382-d9b2-8556-d603-5537b030d8fd@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 10:42:10, David Hildenbrand wrote:
> On 17.01.20 10:40, Michal Hocko wrote:
> > On Fri 17-01-20 10:25:06, David Hildenbrand wrote:
> >> On 17.01.20 09:59, Michal Hocko wrote:
> >>> On Fri 17-01-20 09:51:05, David Hildenbrand wrote:
> >>>> On 17.01.20 03:21, Qian Cai wrote:
> >>> [...]
> >>>>> Even though has_unmovable_pages doesn't hold any reference to the
> >>>>> returned page this should be reasonably safe for the purpose of
> >>>>> reporting the page (dump_page) because it cannot be hotremoved. The
> >>>>
> >>>> This is only true in the context of memory unplug, but not in the
> >>>> context of is_mem_section_removable()-> is_pageblock_removable_nolock().
> >>>
> >>> Well, the above should hold for that path as well AFAICS. If the page is
> >>> unmovable then a racing hotplug cannot remove it, right? Or do you
> >>> consider a temporary unmovability to be a problem?
> >>
> >> Somebody could test /sys/devices/system/memory/memoryX/removable. While
> >> returning the unmovable page, it could become movable and
> >> offlining+removing could succeed.
> > 
> > Doesn't this path use device lock or something? If not than the new code
> > is not more racy then the existing one. Just look at
> > is_pageblock_removable_nolock and how it dereferences struct page
> > (page_zonenum in  page_zone.)
> > 
> 
> AFAIK no device lock, no device hotplug lock, no memory hotplug lock. I
> think it holds a reference to the device and to the kernelfs node. But
> AFAIK that does not block removal of offlining/memory, just when the
> objects get freed.

OK, so we are bug compatible after this patch ;)
-- 
Michal Hocko
SUSE Labs
