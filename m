Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E033C47257
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4BD20CC7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589069777;
	bh=rcEsrsDljCvjlGQcVUHPCm18WB0VkP4lxtaiG5DbAyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hZ2BXV1BLNEmZ4ek40q4B3aakD8GjH0HWaVOg33ykFBYJsPSZ5A8fd65QJXN2ffqX
	 4y9/3izfMEMCqeuuNpyeMR0+TrpC98aO+BekKm1693WHQIL4/Xl7kOTpkUihLCESH6
	 Vxc/zo/FMzf6wPQS8rDmYLux9684U4kfC0sGWMRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgEJAQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 20:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgEJAQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:16:14 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 924AF20735;
        Sun, 10 May 2020 00:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589069774;
        bh=rcEsrsDljCvjlGQcVUHPCm18WB0VkP4lxtaiG5DbAyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/CJP4rfOuAYUekGlno04mT1Bs4lSQLdciQD+tx1rHltWBYBtvFb+B4LUrQlbHjBw
         UW04g6EtzWPm5sfdxjNzKUcndsgGiQnoKqJbwTmr1gRmhfy5sziX1U8aQ0QHjqGc6a
         IYL4qvBvGH/VJgSMEmkxSCU36sL9Vj/k7/fB2KjE=
Date:   Sat, 9 May 2020 17:16:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH hmm v2 1/5] mm/hmm: make CONFIG_DEVICE_PRIVATE into a
 select
Message-Id: <20200509171612.94ee332ad4f494521d911ac0@linux-foundation.org>
In-Reply-To: <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
References: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
        <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 15:20:44 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:

> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> There is no reason for a user to select this or not directly - it should
> be selected by drivers that are going to use the feature, similar to how
> CONFIG_HMM_MIRROR works.
> 
> Currently all drivers provide a feature kconfig that will disable use of
> DEVICE_PRIVATE in that driver, allowing users to avoid enabling this if
> they don't want the overhead.
> 

I'm not too sure what's going on here, but i386 allmodconfig broke.

kernel/resource.c: In function '__request_free_mem_region':
kernel/resource.c:1653:28: error: 'PA_SECTION_SHIFT' undeclared (first use in this function); did you mean 'SECTIONS_PGSHIFT'?
  size = ALIGN(size, 1UL << PA_SECTION_SHIFT);

because in current mainline, allmodconfig produces
CONFIG_DEVICE_PRIVATE=n but in current linux-next, allmodconfig
produces CONFIG_DEVICE_PRIVATE=y.  But CONFIG_SPARSEMEM=n so the build
breaks.

Bisection fingers this commit, but reverting it doesn't seem to fix
things.  Could you take a look please?

I'm seeing this from menuconfig:

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ZONE_DEVICE [=n]
  Selected by [m]:
  - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && DRM_NOUVEAU [=m] && MMU [=y] && STAGING [=y]
  - TEST_HMM [=m] && RUNTIME_TESTING_MENU [=y] && TRANSPARENT_HUGEPAGE [=y]

`select' rather sucks this way - easy to break dependencies.  Quite a
number of years ago the Kconfig gurus were saying "avoid", but I don't
recall the details.



