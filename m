Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B643C20748
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jVNHBz9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgGIUPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:15:21 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3053 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:15:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f077aa10000>; Thu, 09 Jul 2020 13:14:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jul 2020 13:15:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jul 2020 13:15:20 -0700
Received: from [10.2.51.208] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 20:15:15 +0000
Subject: Re: [PATCH V4] mm/vmstat: Add events for THP migration without split
To:     Zi Yan <ziy@nvidia.com>, Randy Dunlap <rdunlap@infradead.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
 <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
 <27CD781D-48F0-4019-934F-78994BAEC656@nvidia.com>
 <97219d3b-96e1-4371-59ea-d038f37a672a@infradead.org>
 <C5E3C65C-8253-4638-9D3C-71A61858BB8B@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5968b2ca-98cd-cede-0716-9d44af630dce@nvidia.com>
Date:   Thu, 9 Jul 2020 13:15:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <C5E3C65C-8253-4638-9D3C-71A61858BB8B@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594325665; bh=64de6mj32knug1ycAsIEPDw/tob+o4DwaofLTy/EY8c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jVNHBz9sSrgErZeEEZoiG/rvQlgR6ly4c3320YPwhznMocgqLizDOnxgOyQklSy10
         b3ACumHDt9VEpuCs513lLiaQnITNl0JKaSP/2a97gjCnslDAl8JFJvtixWnyNCoqkE
         v/2u7EI/JznYXKxRapFzkl3Px9sTyTcEiqOTqdiYyf9rNNjFVuZfd6Putu0XYGG6DW
         CYf2iEnnEEz4VBIegeuKoY38uNJPH5WfvlEFeOSay0UAZe0LcRM3b+neXqiY/fkmKh
         bdvqvYld+GiqI2/gfAatyN8uYzQ2sowNQM7l1/Z9+XVJjJuH/M4dx40Y+lvOTIWIjn
         fkXJCX1DKbmOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-09 10:42, Zi Yan wrote:
...
> diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
> index e65d49f3cf86..68883ac485fa 100644
> --- a/Documentation/vm/page_migration.rst
> +++ b/Documentation/vm/page_migration.rst
> @@ -253,24 +253,32 @@ which are function pointers of struct address_space_operations.
>        PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
>        for own purpose.
> 
> -Quantifying Migration
> +Monitoring Migration
>   =====================
> -Following events can be used to quantify page migration.
> -
> -1. PGMIGRATE_SUCCESS       /* Normal page migration success */
> -2. PGMIGRATE_FAIL          /* Normal page migration failure */
> -3. THP_MIGRATION_SUCCESS   /* Transparent huge page migration success */
> -4. THP_MIGRATION_FAILURE   /* Transparent huge page migration failure */
> -5. THP_MIGRATION_SPLIT     /* Transparent huge page got split, retried */
> -
> -THP_MIGRATION_SUCCESS is when THP is migrated successfully without getting
> -split into it's subpages. THP_MIGRATION_FAILURE is when THP could neither
> -be migrated nor be split. THP_MIGRATION_SPLIT is when THP could not
> -just be migrated as is but instead get split into it's subpages and later
> -retried as normal pages. THP events would also update normal page migration
> -statistics PGMIGRATE_SUCCESS and PGMIGRATE_FAILURE. These events will help
> -in quantifying and analyzing various THP migration events including both
> -success and failure cases.
> +
> +The following events (counters) can be used to monitor page migration.
> +
> +1. PGMIGRATE_SUCCESS: Normal page migration success. Each count means that a
> +   page was migrated. If the page was a non-THP page, then this counter is
> +   increased by one. If the page was a THP, then this counter is increased by
> +   the number of THP subpages. For example, migration of a single 2MB THP that
> +   has 4KB-size base pages (subpages) will cause this counter to increase by
> +   512.
> +
> +2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules as for
> +   _SUCCESS, above: this will be increased by the number of subpages, if it was
> +   a THP.
> +
> +3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.
> +
> +4. THP_MIGRATION_FAIL: A THP could not be migrated nor it could be split.
> +
> +5. THP_MIGRATION_SPLIT: A THP was migrated, but not as such: first, the THP had
> +   to be split. After splitting, a migration retry was used for it's sub-pages.


Just a documentation nit: "its sub-pages", not "it's sub-pages".


thanks,
-- 
John Hubbard
NVIDIA
