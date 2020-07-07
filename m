Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5822220738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594108166;
	bh=CVePBN888INea7ywvCAsmXbwNJlV06gx1hSh3Oz/o04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AqkSRSVRNjEprtRadtHOvzBWY8AFx51Bkx8rwwl5TbSpOkVdGeKGXnn7flbXOV/w6
	 bJUwzfs6H8W9d6IivrvkrC/LDTBlnRWNFTkToTQfPJAAKimkgkv7vcEHPruWvQFhyi
	 x+L0x9qajd7vZCXM8cyNIjdgX/RutRpW3H2DayUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgGGHtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGHtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:49:24 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F67B206E2;
        Tue,  7 Jul 2020 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594108163;
        bh=CVePBN888INea7ywvCAsmXbwNJlV06gx1hSh3Oz/o04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fx2kSVTeTD5lk0ULyPMK9IQ05r83DTv81nFso5+auGDFO6tdAnC4xYVGjvvsHk07S
         6t11omFqlTxQ6wBqW8sdfew4xe0gtnwE+XaWNtVoNcir/qlmR4Fb9Gp6yT5xEemQ33
         dAGJs8euhiFbPNDapnfTyV5qBO2nQCZZsSgRe0ac=
Date:   Tue, 7 Jul 2020 10:49:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, foersleo@amazon.de,
        irogers@google.com, jolsa@redhat.com, kirill@shutemov.name,
        mark.rutland@arm.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, sblbir@amazon.com, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, david@redhat.com, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 12/15] Documentation/admin-guide/mm: Add a document
 for DAMON
Message-ID: <20200707074906.GC9449@kernel.org>
References: <20200706115322.29598-1-sjpark@amazon.com>
 <20200706115322.29598-13-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706115322.29598-13-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello SeongJae,

On Mon, Jul 06, 2020 at 01:53:19PM +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a document for DAMON under
> `Documentation/admin-guide/mm/damon/`.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/admin-guide/mm/damon/api.rst    |  20 ++
>  .../admin-guide/mm/damon/damon_heatmap.png    | Bin 0 -> 8366 bytes
>  .../admin-guide/mm/damon/damon_wss_change.png | Bin 0 -> 7211 bytes
>  .../admin-guide/mm/damon/damon_wss_dist.png   | Bin 0 -> 6173 bytes
>  Documentation/admin-guide/mm/damon/eval.rst   | 222 +++++++++++++
>  Documentation/admin-guide/mm/damon/faq.rst    |  59 ++++
>  .../admin-guide/mm/damon/freqmine_heatmap.png | Bin 0 -> 9999 bytes
>  .../admin-guide/mm/damon/freqmine_wss_sz.png  | Bin 0 -> 5589 bytes
>  .../mm/damon/freqmine_wss_time.png            | Bin 0 -> 6550 bytes
>  Documentation/admin-guide/mm/damon/guide.rst  | 194 ++++++++++++
>  Documentation/admin-guide/mm/damon/index.rst  |  35 +++
>  .../admin-guide/mm/damon/mechanisms.rst       | 159 ++++++++++
>  Documentation/admin-guide/mm/damon/plans.rst  |  29 ++
>  Documentation/admin-guide/mm/damon/start.rst  | 117 +++++++
>  .../mm/damon/streamcluster_heatmap.png        | Bin 0 -> 42210 bytes
>  .../mm/damon/streamcluster_wss_sz.png         | Bin 0 -> 6327 bytes
>  .../mm/damon/streamcluster_wss_time.png       | Bin 0 -> 8830 bytes
>  Documentation/admin-guide/mm/damon/usage.rst  | 296 ++++++++++++++++++
>  Documentation/admin-guide/mm/index.rst        |   1 +

It's really cool to see documentation along with the code!

I'd suggest to reorganize the DAMON docs to better match the current
structure of Documentation/ directory.

The description of DAMON usage from the userspace and reference for the
userland tools does belong to Documentation/admin-guide/mm. However, the
kernel APIs are better to be placed in Documentation/core-api or even
Documentation/dev-tools. As for the detailed description of the internal
DAMON operation, this would naturally belong to Documentation/vm.

Another thing is that this patch is really hard to review because of the
encoded png blobs. In general, we try to keep Documentation/ readable in
plain text, but if you think that the images are essential and must be a
part of DAMON in-tree docs rather than links to an external resource,
please split them to a separate patch.

-- 
Sincerely yours,
Mike.
