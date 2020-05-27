Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44208C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B7F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G9RV5jm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbgE0LYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:24:49 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:37405 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgE0LYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590578688; x=1622114688;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=fADxTWlH4LAMEkm7SQ4zYt5RXIjtw/oHDeubD8oayko=;
  b=G9RV5jm4NdNK0qCcVhMHreN/5jwLAPrWOzjO5jzEGo4D9JYLjOO0Kl30
   fDKmEk4asDJ5jq9KQzBInOihO0F0Jl2pPMVKuHFXwb2ldsCh0TSdZEdzi
   SQzP5hPTnucFcewauCNEFn5dIFQg3OV/c1SpsIhmS2ihdvbPx0KDP7P/p
   4=;
IronPort-SDR: XaM+HO73RYSwTbWe6FcJbQ3RvsKcI7mFm5fHC3DTQ9UqCWzGH8oRn6YrXwKO4skKyKiUU+t6o8
 8vq8gjFR4IwA==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="46374335"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 May 2020 11:24:45 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 55B40A250B;
        Wed, 27 May 2020 11:24:33 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 04RBOUDW027457;
        Wed, 27 May 2020 13:24:30 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 04RBOUEO027456;
        Wed, 27 May 2020 13:24:30 +0200
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
Subject: Re: [PATCH v13 09/15] mm/damon: Add debugfs interface
Date:   Wed, 27 May 2020 13:24:29 +0200
Message-Id: <1590578669-27408-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200525091512.30391-10-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25T11:15:06+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a debugfs interface for DAMON.
> 
> DAMON exports four files, ``attrs``, ``pids``, ``record``, and
> ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
> 
> Attributes
> ----------
> 
> Users can read and write the ``sampling interval``, ``aggregation
> interval``, ``regions update interval``, and min/max number of
> monitoring target regions by reading from and writing to the ``attrs``
> file.  For example, below commands set those values to 5 ms, 100 ms,
> 1,000 ms, 10, 1000 and check it again::
> 
>     # cd <debugfs>/damon
>     # echo 5000 100000 1000000 10 1000 > attrs
>     # cat attrs
>     5000 100000 1000000 10 1000
> 
> Target PIDs
> -----------
> 
> Users can read and write the pids of current monitoring target processes
> by reading from and writing to the ``pids`` file.  For example, below
> commands set processes having pids 42 and 4242 as the processes to be
> monitored and check it again::
> 
>     # cd <debugfs>/damon
>     # echo 42 4242 > pids
>     # cat pids
>     42 4242
> 
> Note that setting the pids doesn't start the monitoring.
> 
> Record
> ------
> 
> DAMON supports direct monitoring result record feature.  The recorded
> results are first written to a buffer and flushed to a file in batch.
> Users can set the size of the buffer and the path to the result file by
> reading from and writing to the ``record`` file.  For example, below
> commands set the buffer to be 4 KiB and the result to be saved in
> '/damon.data'.
> 
>     # cd <debugfs>/damon
>     # echo 4096 /damon.data > pids
>     # cat record
>     4096 /damon.data
> 
> Turning On/Off
> --------------
> 
> You can check current status, start and stop the monitoring by reading
> from and writing to the ``monitor_on`` file.  Writing ``on`` to the file
> starts DAMON to monitor the target processes with the attributes.
> Writing ``off`` to the file stops DAMON.  DAMON also stops if every
> target processes is terminated.  Below example commands turn on, off,
> and check status of DAMON::
> 
>     # cd <debugfs>/damon
>     # echo on > monitor_on
>     # echo off > monitor_on
>     # cat monitor_on
>     off
> 
> Please note that you cannot write to the ``attrs`` and ``pids`` files
> while the monitoring is turned on.  If you write to the files while
> DAMON is running, ``-EINVAL`` will be returned.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
