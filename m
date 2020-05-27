Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3656EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9E12078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="plyM7FI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgE0LYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:24:41 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:37353 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbgE0LYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590578680; x=1622114680;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=QTcZ5qD0FayvieP+n15JSMMJ8RxzSZ9hkKMgdyePYl0=;
  b=plyM7FI24ylSxSVsctzof4+2tXoQIxcrSgg3tnsCf8rplz1XGYUs1baI
   qOv9DXnt3ddxFsajmLqkIAEzb5pPlga1GG1VJfeSprhM3OfTtCm5e1GPP
   MMBciVRrtk80CoUHIKsW1nSTLHFlwr+vprYNJd4Fn8EZoqOxyr1p6XacJ
   k=;
IronPort-SDR: UjrcPBbDIDtwAzxUSHYYy2Zs0BF2mpFsA3jrRnlRgUVFLc2w2DleD2rI6O0xnpqgMhyahdzSN/
 mjivdWn5aq4g==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="46374300"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 May 2020 11:24:37 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id EC12CA1CD4;
        Wed, 27 May 2020 11:24:25 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 04RBONgs027396;
        Wed, 27 May 2020 13:24:23 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 04RBONh4027394;
        Wed, 27 May 2020 13:24:23 +0200
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
Subject: Re: [PATCH v13 08/15] mm/damon: Implement access pattern recording
Date:   Wed, 27 May 2020 13:24:21 +0200
Message-Id: <1590578661-27344-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200525091512.30391-9-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25T11:15:05+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements the recording feature of DAMON. If this feature
> is enabled, DAMON writes the monitored access patterns in its binary
> format into a file which specified by the user. This is already able to
> be implemented by each user using the callbacks.  However, as the
> recording is expected to be used widely, this commit implements the
> feature in the DAMON, for more convenience and efficiency.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
