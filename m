Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A875CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7865A208B6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EDVTjmO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbgE0LY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:24:26 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:15236 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbgE0LYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590578665; x=1622114665;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=iRjowuh3rsT6KaQa5IoA4dyPWOraak/h0is2Gj8OFRE=;
  b=EDVTjmO0uOAvpsvLalthUw6AtLp90rxaC3btJG/mQj+IN5rbHxgEZpsT
   Y+KqN92eqcpZj4sNUmi9Frzmj2Q2C8PbSEDK03EJU6KQnoqcJzcMMvBVy
   R0Dby40jAqAw++3KBhqgPHKml6BN3KD2RDXIcZF2dUAMP/Kcek5mOwmjw
   k=;
IronPort-SDR: gzc5vzbcQcGaYviq5tmSnNk32G+8h0J63+22zkVNJ+T1UWGfmr+qKW/YCRNCQybor1A8DI6n0t
 rAch2mHLhG1g==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="33842691"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 27 May 2020 11:24:22 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id D1D4CA1EA7;
        Wed, 27 May 2020 11:24:18 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 04RBOGT4027335;
        Wed, 27 May 2020 13:24:16 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 04RBOG5A027331;
        Wed, 27 May 2020 13:24:16 +0200
From:   Leonard Foerster <foersleo@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, irogers@google.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        sblbir@amazon.com, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 07/15] mm/damon: Implement callbacks
Date:   Wed, 27 May 2020 13:24:15 +0200
Message-Id: <1590578655-27285-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200525091512.30391-8-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25T11:15:04+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements callbacks for DAMON.  Using this, DAMON users can
> install their callbacks for each step of the access monitoring so that
> they can do something interesting with the monitored access patterns
> online.  For example, callbacks can report the monitored patterns to
> users or do some access pattern based memory management such as
> proactive reclamations or access pattern based THP promotions/demotions
> decision makings.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
