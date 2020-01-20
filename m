Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0E4C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342772070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579536306;
	bh=snj6kBC+qwauXm+Cg4x1ZKCg9igIOoAgEOwVP0KDbaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rJRVk9tzPJjQ5YTW9sirm1ohAPAqvoWKee4kmtfGiQzh7qU2km9Na0E8HOaiNNXZf
	 DrUH8ZAcrZRWbgf5rTV7Ll528Przgrbyccmi3n1sZEkM/y28FeshhIpHZiXOdSk18h
	 JKKit1uP2yXZ+ZeFGXkPuyS+KyFAzBVQJbMvoPx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgATQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:05:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34302 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:05:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so34910wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pchtgtPl7QsNhnLKqQnFHxUQcOqFwM/PSkX6RSgnDKM=;
        b=pJEWgg9BoaUJFzHJGCRFrY23wQSQB+DL8BNjP9zRvE1tL6Rhdyso9DJ5L0ClPz8oQR
         i1T3gC7PQfqDwTrWwAxgL0BaRq4g5VvrYlW2Ho9+esksU1kdJ1Iy6Fci2Oeo4ZWjshqZ
         QRCT1uwVF18D/3F/bZhfh5UH+ZGp/VRikEpHVhqQL4i/e0GG6mRiGTAGseRMRUsY21vn
         CZ8j40Enhvtbt2CGbmyzdWwp4c8kTnWFKi3PIH+hYkiO9BIEyNICFmhMmVsnE5rS0zN6
         p7rgqqQiVEisvC4Q4Kbfq5gkuCsEO8vqPr2iKYAOtlCTK32KyyCE2bGHFvYLB3lKEGTv
         cZ7w==
X-Gm-Message-State: APjAAAXiJ4Eh4z6gQRxriZvR97PAw4n73NdMX2ifQ55foc0/h2ZNX7pm
        NqDLjVq/6U2qgNBG79yzxhM=
X-Google-Smtp-Source: APXvYqyMf+pGJvZD7BFKyy1zUboNw4H+hWUL04RoWn8vOUeeecst1TBK1XWG1ZIz+dYtdajL5OPYjw==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr228393wrx.244.1579536302938;
        Mon, 20 Jan 2020 08:05:02 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d8sm49235291wre.13.2020.01.20.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:05:01 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:05:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Li Xinhai <lixinhai.lxh@gmail.com>
Cc:     "anshuman.khandual" <anshuman.khandual@arm.com>,
        n-horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4] mm/mempolicy,hugetlb: Checking hstate for hugetlbfs
 page in vma_migratable
Message-ID: <20200120160500.GM18451@dhcp22.suse.cz>
References: <1579147885-23511-1-git-send-email-lixinhai.lxh@gmail.com>
 <20200116095614.GO19428@dhcp22.suse.cz>
 <20200116215032206994102@gmail.com>
 <20200116151803.GV19428@dhcp22.suse.cz>
 <20200116233817972969139@gmail.com>
 <20200117111629898234212@gmail.com>
 <20200118111121432688303@gmail.com>
 <20200120101202.GU18451@dhcp22.suse.cz>
 <20200120233723466954346@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120233723466954346@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 23:37:25, Li Xinhai wrote:
[...]
> Changelog is updated as below, thanks for comments:
> ---
> mm/mempolicy: Checking hugepage migration is supported by arch in vma_migratable
> 
> vma_migratable() is called to check if pages in vma can be migrated
> before go ahead to further actions. Currently it is used in below code
> path:
> - task_numa_work
> - mbind
> - move_pages
> 
> For hugetlb mapping, whether vma is migratable or not is determined by:
> - CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> - arch_hugetlb_migration_supported
> 
> Issue: current code only checks for CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION,
> which express less accurate semantics of vma_migratable(). (note that
> current code in vma_migratable don't cause failure or bug because
> unmap_and_move_huge_page() will catch unsupported hugepage and handle it
> properly)
> 
> This patch checks the two factors for impoveing code logic and
> robustness. It will enable early bail out of hugepage migration procedure,
> but because currently all architecture supporting hugepage migration is able
> to support all page size, we would not see performance gain with this patch
> applied.

This looks definitely better than the original one. I hope it is more
clear to you what I meant by a better description for the justification.
I would just add that the no code should use
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION directly and use
arch_hugetlb_migration_supported instead. This will be the case after
this patch.

Please keep in mind that changelogs are really important and growing in
importance as the code gets more complicated over time. It is much more
easier to see what the patch does because reading diffs and the code is
easy but the lack of motivation is what people usually fighting with.
-- 
Michal Hocko
SUSE Labs
