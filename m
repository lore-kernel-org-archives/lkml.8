Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23134C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08C920776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuLNsIZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgH1NvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbgH1NvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598622661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ljr3BWVg1KGhtkgQvIGb9sjmr9D7YopQJEcP8hioYqE=;
        b=CuLNsIZsHuDxmx9E/UPgCL/0Z01a2OTtdbon1gWpUaTNXU571BbmYa/DuzRhVru1giloO4
        vv13/PUHpoL0fa2VAvrayIz7hpXLWF7x9Yc1KBLHzkyzZ69YHxLElFgVK2iGRDRPZ+SkV+
        fBiLNLq0Smq7foZJOT8YDnYcxxzFFDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-g72IHILWMXClwDIqqONPPQ-1; Fri, 28 Aug 2020 09:32:51 -0400
X-MC-Unique: g72IHILWMXClwDIqqONPPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DDD618A2240;
        Fri, 28 Aug 2020 13:32:50 +0000 (UTC)
Received: from max.home.com (unknown [10.40.194.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA5097D4F6;
        Fri, 28 Aug 2020 13:32:34 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [GIT PULL] gfs2: Fix memory leak on filesystem withdraw
Date:   Fri, 28 Aug 2020 15:32:33 +0200
Message-Id: <20200828133233.1147149-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following gfs2 fix?

We didn't detect this bug because we have slab merging on by default
(CONFIG_SLAB_MERGE_DEFAULT).  Adding "slub_nomerge" to the kernel
command line exposed the problem.

Thanks,
Andreas

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.9-rc2-fixes

for you to fetch changes up to 462582b99b6079a6fbcdfc65bac49f5c2a27cfff:

  gfs2: add some much needed cleanup for log flushes that fail (2020-08-24 13:54:07 +0200)

----------------------------------------------------------------
Fix memory leak on filesystem withdraw

----------------------------------------------------------------
Bob Peterson (1):
      gfs2: add some much needed cleanup for log flushes that fail

 fs/gfs2/log.c   | 31 +++++++++++++++++++++++++++++++
 fs/gfs2/trans.c |  1 +
 2 files changed, 32 insertions(+)

