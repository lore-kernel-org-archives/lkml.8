Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23282C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055CD20707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHaGLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:11:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:18469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgHaGLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:11:30 -0400
IronPort-SDR: KGSkUn6xepPMcrcfzIkjje311Fu8GK8RhvdVeb4GOuyecSUcX67kYINK82bphgPnr3yN46PUWS
 XS4Q970AiCcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="154446254"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="154446254"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 23:11:30 -0700
IronPort-SDR: nmN4WCP/Ni6BtZXit//VztUZ2aav8be9TF0gsCtI61qi8V5mrSv1PJ9BFUVTDLYH1hELypNi1o
 Qcmw2KdMJIxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="501743030"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2020 23:11:26 -0700
Date:   Mon, 31 Aug 2020 14:11:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, zhengjun.xing@intel.com
Subject: Re: [drm/mgag200] 913ec479bb: vm-scalability.throughput 26.2%
 improvement
Message-ID: <20200831061126.GC65971@shbuild999.sh.intel.com>
References: <20200826085847.GL4299@shao2-debian>
 <76926ade-15fb-75a3-17aa-a2b5a68471c8@suse.de>
 <99c7683c-f428-378d-2b19-ef51270a5d8e@oracle.com>
 <f9664139-e28c-ba8e-b4e4-d505baf9069a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9664139-e28c-ba8e-b4e4-d505baf9069a@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 08:06:04PM +0200, Thomas Zimmermann wrote:
> > Hello Thomas,
> > 
> > Did drm changes really impact anon-cow-seq-hugetlb performance?
> >
> > My change c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
> > synchronization") caused a -33.4% regression of anon-cow-seq-hugetlb.  A
> > recent change 34ae204f185 (hugetlbfs: remove call to huge_pte_alloc without
> > i_mmap_rwsem) was tested by Zhengjun Xing and improved performance by 20
> > something percent.  That seems in line with this report/improvement.
> 
> Some of DRM's memory management might be affected by hugetable changes.
> While I cannot really point to a specific location, it's not impossible
> that there's a connection.
> 
> > 
> > Perhaps the tooling is not always accurate in determining the commit which
> > causes the performance changes?
> > Perhaps I am misreading information in the reports?
> > 
> 
> From what I remember, some of these tests print to the console, which
> has always been slow, and has generally been a bad idea for performance
> tests. I guess these tests are not very accurate.

Yes, I also think that's the reason for this improvement. The test box is
using mgag200 driver, while the vm-scalability test case itself will print
many messages to the gfx console. If commit 913ec479bb "drm/mgag200: Replace
VRAM helpers with SHMEM helpers" improves the console handling, then it
will impact the final score of the test case.

Last time we met similar case that a console write slowdown triggers a
regression is discussed here:  
https://lore.kernel.org/lkml/20190729095155.GP22106@shao2-debian/

Thanks,
Feng

> Best regards
> Thomas
