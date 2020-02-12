Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17310C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EB2206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQTsaJJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBLPi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:38:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727026AbgBLPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581521934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=MbW2YnMhHrnti05AbCnniicq1RE8qb1tYRSDIpwlVSk=;
        b=BQTsaJJZW24ZvdY8Y/DI/S9gsWAoEgcE76XQ/7RzsEBDCARZQG99nkjGXpdGdsvwhCm35B
        gOdspzIhMbudO5MW6woG3K4ssDe2awpXMZ6JOz0Bkhy/aYjluhTzJUmkOpDVs8gZy95ycT
        4krGRV/drSewV1HSemwILQ04sth098g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-HsmF2q9MO2e1lQKQGhcnmA-1; Wed, 12 Feb 2020 10:38:51 -0500
X-MC-Unique: HsmF2q9MO2e1lQKQGhcnmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E32048017DF;
        Wed, 12 Feb 2020 15:38:49 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBE7D6E40A;
        Wed, 12 Feb 2020 15:38:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 0/3] locking/lockdep: Cleaning up lockdep code
Date:   Wed, 12 Feb 2020 10:38:25 -0500
Message-Id: <20200212153828.346-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following conditional compilation macros are used throughout the
lockdep code making it hard to understand.
 - CONFIG_PROVE_LOCKING
 - CONFIG_LOCK_STAT
 - CONFIG_DEBUG_LOCKDEP
 - CONFIG_LOCKDEP_SMALL
 - CONFIG_TRACE_IRQFLAGS

In particular, almost half of the code is for CONFIG_PROVE_LOCKING and
there are several blocks of them in lockdep.c. It is very hard to see if
a function is for CONFIG_PROVE_LOCKING or not.

This patchset cleans up this mess by putting all the CONFIG_PROVE_LOCKING
functions into a separate lockdep_prove.c file making it easier to know
what they are for. It also consolidates the CONFIG_DEBUG_LOCKDEP code
to a certain extend.

This is a code relocation patchset. There is no functional change.

Waiman Long (3):
  locking/lockdep: Make remove_class_from_lock_chains() depend on
    CONFIG_PROVE_LOCKING
  locking/lockdep: Extract CONFIG_PROVE_LOCKING code out to
    lockdep_prove.c
  locking/lockdep: Consolidate CONFIG_DEBUG_LOCKDEP code

 kernel/locking/lockdep.c       | 3300 +++-----------------------------
 kernel/locking/lockdep_prove.c | 2820 +++++++++++++++++++++++++++
 2 files changed, 3066 insertions(+), 3054 deletions(-)
 create mode 100644 kernel/locking/lockdep_prove.c

-- 
2.18.1

