Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B76C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA1620684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579515128;
	bh=qp4K8DL9HEHur5FlmGuyzAoFcE4kY/SDPSg81o3APtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gLNluqBpDiX7AMLY4tU0TxxrVnQ+umuT2uXrSaIZb6DnwY1Lq2IpNrqI5nHXxSBNA
	 B0rkr09siQ4Md1pws8dst+0l0II+KWEjCeM2YVYKBW2uJcpHLs0rIszuXO1SXFWH4T
	 drc5FmrsBS9DOLgbwG+gTn+nN/R79kdIB1m6YcjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgATKMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:12:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37257 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:12:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so28925521wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=adbdjiVau9etS2t3ssB2A258KBgSziRfDhmtS4rPNeg=;
        b=E9J9CtpzBiyvN4K0Q0eX/BXDwJXv5DtNjB9TcU9U5WqWOdtnhl0nPw64eym1CBNNct
         iG/+rfDRErgoz6m09FX9OyeuOPq0aQ1RKzOA5GUFd3jZnvGqxB/Iha2S7HuOCs/Gj7Uh
         vxSiH29xS8hmO61s/7AsWH3qQazbgn5tlLfUwAcSy4rtnqzHwNRz2gAzBF4uJH8u1VSm
         N8pInsolBGMeOYC3EMWIFlQuxaMv17c3zGyKkpmE/idmJs3YRDyiAeKesDa+955vzx+/
         +DN4i4FAiae9EIcAQsrBpTIaYvDuReKImDkaInLi8q1XHmCunzU/NNGlV2aSTFa7GI9I
         9iAA==
X-Gm-Message-State: APjAAAUxvrdx8fOf45EmhW+AmfDlRDDDq9p49Gm7tWzhhOkfrgRhcv9v
        3uDfIBGQaiSQAoupv6nthNpEWIY3
X-Google-Smtp-Source: APXvYqwW64eGQuTciaQ3HWJJV04lMNiwPvt8E1ucZmn7e11oSVtpFHrRA3RB5+CQWUXtndsga1WrSA==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr17148681wrr.309.1579515124093;
        Mon, 20 Jan 2020 02:12:04 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id p26sm21404509wmc.24.2020.01.20.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 02:12:03 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:12:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Li Xinhai <lixinhai.lxh@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4] mm/mempolicy,hugetlb: Checking hstate for hugetlbfs
 page in vma_migratable
Message-ID: <20200120101202.GU18451@dhcp22.suse.cz>
References: <1579147885-23511-1-git-send-email-lixinhai.lxh@gmail.com>
 <20200116095614.GO19428@dhcp22.suse.cz>
 <20200116215032206994102@gmail.com>
 <20200116151803.GV19428@dhcp22.suse.cz>
 <20200116233817972969139@gmail.com>
 <20200117111629898234212@gmail.com>
 <20200118111121432688303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200118111121432688303@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18-01-20 11:11:23, Li Xinhai wrote:
> On 2020-01-17 at 11:16 Li Xinhai wrote:
> >On 2020-01-16 at 23:38 Li Xinhai wrote:
> >>On 2020-01-16 at 23:18 Michal Hocko wrote:
> >>>On Thu 16-01-20 21:50:34, Li Xinhai wrote:
> >>>> On 2020-01-16 at 17:56 Michal Hocko wrote:
> >>>> >On Thu 16-01-20 04:11:25, Li Xinhai wrote:
> >>>> >> Checking hstate at early phase when isolating page, instead of during
> >>>> >> unmap and move phase, to avoid useless isolation.
> >>>> >
> >>>> >Could you be more specific what you mean by isolation and why does it
> >>>> >matter? The patch description should really explain _why_ the change is
> >>>> >needed or desirable.
> >>>>
> >>>> The changelog can be improved:
> >>>>
> >>>> vma_migratable() is called to check if pages in vma can be migrated
> >>>> before go ahead to isolate, unmap and move pages. For hugetlb pages,
> >>>> hugepage_migration_supported(struct hstate *h) is one factor which
> >>>> decide if migration is supported. In current code, this function is called
> >>>> from unmap_and_move_huge_page(), after isolating page has
> >>>> completed.
> >>>> This patch checks hstate from vma_migratable() and avoids isolating pages
> >>>> which are not supported.
> >>>
> >>>This still explains what but not why this is relevant. If by isolating
> >>>pages you mean isolate_lru_page then this really a noop for hugetlb
> >>>pages. Or do I still misread your changelog?
> >>
> >>I mean isolate_huge_page will queue pages for moving, and
> >>unmap_and_move_huge_page will call
> >>hugepage_migration_supported then refuse moving.
> >>
> >
> >Forgot to mention that this patch has no relevant with this one
> >https://patchwork.kernel.org/patch/11331639/, 
> >
> >Code change at here is common for avoids walking page table and
> >isolate hugepage in case architecture or page size are not supported
> >for migration. Comments from code are copied here:
> >
> >static int unmap_and_move_huge_page(...)
> >{
> >	/*
> >	* Migratability of hugepages depends on architectures and their size.
> >	* This check is necessary because some callers of hugepage migration
> >	* like soft offline and memory hotremove don't walk through page
> >	* tables or check whether the hugepage is pmd-based or not before
> >	* kicking migration.
> >	*/
> >	if (!hugepage_migration_supported(page_hstate(hpage))) {
> >	putback_active_hugepage(hpage);
> >	return -ENOSYS;
> >	}
> >}
> >
> >For current code change, we are able to know the 'hstate' because we have 'vma', so
> >do early check instead of later.
> > 
> 
> https://lore.kernel.org/linux-mm/20200117111629898234212@gmail.com/
> 
> Revise with more details on changelog for reason why this patch
> is need. Thanks for your comments.
> 
> ---
> vma_migratable() is called to check if pages in vma can be migrated
> before go ahead to further actions. Currently it is used in below code
> path:
> - task_numa_work (kernel\sched\fair.c)
> - mbind (mm\mempolicy.c)
> - move_pages (mm\migrate.c)
> 
> For hugetlb mapping, vma is migratable or not is determined by:
> - CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> - arch_hugetlb_migration_supported
> 
> Issue: current code only checks for CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION.

Explain why this is an issue. Because as things stand now this doesn't
cause any problems at all. All architectures simply support migrating
all hugetlb sizes AFAIK. If this is not the case then mention which of
them are not.

> This patch checks the two factors to impove code logic. Besides, caller
> of vma_migratable can take action properly in case architecture don't
> support migration, e.g., mbind don't go further to try isolating/moving
> pages, but currently it do continue because vma_migratable say yes.

I do not follow. What are you trying to say here?

The changelog should be explicit it doesn't really fix any existing
problem. And the whole purpose is a code robustness cleanup. Should we
ever have an architecture that doesn't support all hugetlb sizes then
we would safe pointless huge page isolation for a page that cannot be
migrated in the first place.

See how the above actually explains _why_ you want to make the change?

> No adding for Fix tag, since vma_migratable was implemented before
> arch_hugetlb_migration_supported, it is up to the caller to use it.

This is also of no relevance.
-- 
Michal Hocko
SUSE Labs
