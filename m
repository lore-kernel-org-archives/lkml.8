Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6ABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9094821974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c8rsaieI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgFRJYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:24:06 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:44585 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbgFRJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592472241; x=1624008241;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=NqBQVyg4uwgGurJD1OK/0Mw40EovCNrpIfD1ESnsdgw=;
  b=c8rsaieIO4PpiACctGZ7+8ZVUgneBdnZ699vbiitoy4jg4ntf363L9JX
   7nRaeqtetTX0AEXlRGpK55bRPdKNmw1eTlks3kKACugHxQkHSagEHeeoX
   hQ1DrLRHApVQvHZdfWjeLPlPWH5sB085KcY1g22JQkkBxc/Q4gu27FICu
   k=;
IronPort-SDR: B0IbgC/i6TutrZWpQCAdEPzC6VImJL1/IRg3ksa2yKAXwgXG/KWUrOopEC3lxZIb0h2TMjvrzp
 o72ggBtlW7og==
X-IronPort-AV: E=Sophos;i="5.73,526,1583193600"; 
   d="scan'208";a="44956919"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Jun 2020 09:23:58 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 69BEC221CE4;
        Thu, 18 Jun 2020 09:23:55 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 05I9NrKA022961;
        Thu, 18 Jun 2020 11:23:53 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 05I9NqB5022955;
        Thu, 18 Jun 2020 11:23:52 +0200
From:   Leonard Foerster <foersleo@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
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
Subject: Re: [PATCH v16 06/14] mm/damon: Implement callbacks for the virtual memory address spaces
Date:   Thu, 18 Jun 2020 11:23:51 +0200
Message-Id: <1592472232-22839-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200615161927.12637-7-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-15T18:19:19+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements the four essential callbacks of DAMON,
> '->init_target_regions', '->update_target_regions',
> '->prepare_access_checks', and '->check_accesses' for virtual memory
> address spaces.  Those internally use PTE Accessed bit.  Using these
> callbacks, users can easily monitor the virtual address space data
> accesses of specific processes.  Nonetheless, these are just reference
> implementations.  Users can implement and use their own callbacks for
> their special use case, if required.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
