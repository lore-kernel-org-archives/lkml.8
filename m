Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBB5C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F169B206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N3YBjdf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCLP5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:57:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40007 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgCLP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:57:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id n5so4753045qtv.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9rmranj04CV+/bM0tC2lSxig8Zqz06WK1k9QT8UzDQ=;
        b=N3YBjdf76Z8gKJ6vMp2o+QuB4HHTTg+q3Sl74raGR1run59phAIAAD8tHj0FybK+nZ
         NqFCb5OK8lzy6SEruJjkh7PYL1YRbdmSVzEnDvWjOqWhFoHkcQMoi6uEpIWe8LhBT5Lr
         8WxXpNKl3LE05tgkoqcG4udhxfvVYtBZzVDibenCnfA0qdnNN5r/o3hIfNghWKCiufX0
         VdAH2r3TSHfDFtcSeeFQjPlawa3smxKEzuq6PPE/CRpJssz0xo+Qx0JYf1UO09LHXiXY
         Aw2tQ/K5+DVfFUqrR3PdLV7nFaHvxTFbpQRGoHIrEPQz+ist+1sZuYIsWX6n3t46oGxg
         //9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9rmranj04CV+/bM0tC2lSxig8Zqz06WK1k9QT8UzDQ=;
        b=hvlP5eFa8+BEQ6pi3g8pnrBzow87updnKUMeEzVR8Fn5SG84EW7UfRuo0lVjV0szpP
         bjGNerkojiHHtyIqrjiDlt6ew7uTjZCByHd/svTnbIh+TNi0gYI9D/5AJguiHecTvJ7z
         qwPy9HlI802LMz5JfK6i4E16h6tAgHAy75/kDE2fBGxdLHQrm196Jt0ZyOXhZmpr+/S6
         Je/dUUx60kM9htEEIBk4NiHaINVSXn4rXw0FhHX250VJke6qCRcxb5GIqcZcb8Lb1YA0
         3ffhdglnnsQLaDaDoxxymXruqaFbkZ6RLq7J2MH7UC3RBZavhXo8UDQqXGEpWeIWpc10
         2/WQ==
X-Gm-Message-State: ANhLgQ0g7BbHgYcNQlC6v+rN8LpIALZVYYBTlu8nqv+oXdalYGpLIYIy
        uNWu31voGvc7PpdSOgbA30wUZd7wJU4=
X-Google-Smtp-Source: ADFU+vujBVyWiAmEaWmhrBEVbqSV/mb2taPoq4RQ3EEx1AJNbKumneHVS+1gnQ98n3s9IaiFtAAKvA==
X-Received: by 2002:ac8:4404:: with SMTP id j4mr7531686qtn.95.1584028672307;
        Thu, 12 Mar 2020 08:57:52 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 4sm22960559qky.106.2020.03.12.08.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 08:57:51 -0700 (PDT)
Message-ID: <1584028670.7365.182.camel@lca.pw>
Subject: Re: [PATCH 0/2] hugetlbfs: use i_mmap_rwsem for more synchronization
From:   Qian Cai <cai@lca.pw>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 12 Mar 2020 11:57:50 -0400
In-Reply-To: <20200305002650.160855-1-mike.kravetz@oracle.com>
References: <20200305002650.160855-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 16:26 -0800, Mike Kravetz wrote:
> While discussing the issue with huge_pte_offset [1], I remembered that
> there were more outstanding hugetlb races.  These issues are:
> 
> 1) For shared pmds, huge PTE pointers returned by huge_pte_alloc can become
>    invalid via a call to huge_pmd_unshare by another thread.
> 2) hugetlbfs page faults can race with truncation causing invalid global
>    reserve counts and state.
> 
> A previous attempt was made to use i_mmap_rwsem in this manner as described
> at [2].  However, those patches were reverted starting with [3] due to
> locking issues.
> 
> To effectively use i_mmap_rwsem to address the above issues it needs to
> be held (in read mode) during page fault processing.  However, during
> fault processing we need to lock the page we will be adding.  Lock
> ordering requires we take page lock before i_mmap_rwsem.  Waiting until
> after taking the page lock is too late in the fault process for the
> synchronization we want to do.
> 
> To address this lock ordering issue, the following patches change the
> lock ordering for hugetlb pages.  This is not too invasive as hugetlbfs
> processing is done separate from core mm in many places.  However, I
> don't really like this idea.  Much ugliness is contained in the new
> routine hugetlb_page_mapping_lock_write() of patch 1.
> 
> The only other way I can think of to address these issues is by catching
> all the races.  After catching a race, cleanup, backout, retry ... etc,
> as needed.  This can get really ugly, especially for huge page reservations.
> At one time, I started writing some of the reservation backout code for
> page faults and it got so ugly and complicated I went down the path of
> adding synchronization to avoid the races.  Any other suggestions would
> be welcome.

Reverted this series on the top of today's linux-next fixed the hang with LTP
move_pages12 on both powerpc and arm64,

# /opt/ltp/testcases/bin/move_pages12
tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:263: INFO: Free RAM 260577280 kB
move_pages12.c:281: INFO: Increasing 2048kB hugepages pool on node 0 to 4
move_pages12.c:291: INFO: Increasing 2048kB hugepages pool on node 8 to 4
move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 8
<hang>

[ 3948.791155][  T688] INFO: task move_pages12:32930 can't die for more than
3072 seconds.
[ 3948.791181][  T688] move_pages12    D26224 32930      1 0x00040002
[ 3948.791199][  T688] Call Trace:
[ 3948.791210][  T688] [c000200816b4f680] [c0000000010b7a68]
cpufreq_update_util_data+0x0/0x8 (unreliable)
[ 3948.791234][  T688] [c000200816b4f860] [c00000000002615c]
__switch_to+0x38c/0x520
[ 3948.791247][  T688] [c000200816b4f8d0] [c0000000009a1c94]
__schedule+0x4b4/0xba0
[ 3948.791268][  T688] [c000200816b4f9a0] [c0000000009a2428] schedule+0xa8/0x170
[ 3948.791288][  T688] [c000200816b4f9d0] [c0000000009a2d0c]
io_schedule+0x2c/0x50
[ 3948.791300][  T688] [c000200816b4fa00] [c000000000331020]
__lock_page+0x150/0x3c0
[ 3948.791322][  T688] [c000200816b4fac0] [c000000000420164]
hugetlb_no_page+0xb04/0xd40
lock_page at include/linux/pagemap.h:480
(inlined by) hugetlb_no_page at mm/hugetlb.c:4286
[ 3948.791342][  T688] [c000200816b4fc10] [c000000000420bd8]
hugetlb_fault+0x738/0xc00
[ 3948.791363][  T688] [c000200816b4fcd0] [c0000000003b9c44]
handle_mm_fault+0x444/0x450
[ 3948.791384][  T688] [c000200816b4fd20] [c000000000070b98]
__do_page_fault+0x2b8/0xf90
[ 3948.791406][  T688] [c000200816b4fe20] [c00000000000aa88]
handle_page_fault+0x10/0x30

> 
> [1] https://lore.kernel.org/linux-mm/1582342427-230392-1-git-send-email-longpeng2@huawei.com/
> [2] https://lore.kernel.org/linux-mm/20181222223013.22193-1-mike.kravetz@oracle.com/
> [3] https://lore.kernel.org/linux-mm/20190103235452.29335-1-mike.kravetz@oracle.com
> 
> Mike Kravetz (2):
>   hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
>   hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race
> 
>  fs/hugetlbfs/inode.c    |  34 +++++---
>  include/linux/fs.h      |   5 ++
>  include/linux/hugetlb.h |   8 ++
>  mm/hugetlb.c            | 175 +++++++++++++++++++++++++++++++++++-----
>  mm/memory-failure.c     |  29 ++++++-
>  mm/migrate.c            |  24 +++++-
>  mm/rmap.c               |  17 +++-
>  mm/userfaultfd.c        |  11 ++-
>  8 files changed, 264 insertions(+), 39 deletions(-)
> 
