Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF8C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709592078B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+ULRwY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgGKSW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:22:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60221 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726281AbgGKSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594491777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ltTy2GcHC036Egycy6GY0oL2cPL6zzaGde4AZbh1z7Q=;
        b=e+ULRwY0dSgF0SGhJagMvmFR+BJguRBbQse7bgNjcQdzDr1iTab5M92ujBTVSF2mgh2B3R
        n439LaAzO5waj0/BgZo6yi8kIdz+c5Ya3pASY8Z4PqgbEq9vyi2+VSNvFpO1SNJe9QHqmk
        Qrz8gCW4P5QqhS375+uVc94UK8gwx7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-5zlWZQn6MS6VvBPZPers8Q-1; Sat, 11 Jul 2020 14:22:53 -0400
X-MC-Unique: 5zlWZQn6MS6VvBPZPers8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB3A1107ACCA;
        Sat, 11 Jul 2020 18:22:51 +0000 (UTC)
Received: from llong.com (ovpn-112-135.rdu2.redhat.com [10.10.112.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC965D9CC;
        Sat, 11 Jul 2020 18:22:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] locking/qspinlock: Allow lock to store lock holder cpu number
Date:   Sat, 11 Jul 2020 14:21:26 -0400
Message-Id: <20200711182128.29130-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset modifies the qspinlock code to allow it to store the lock
holder cpu number in the lock itself if feasible for easier debugging
and crash dump analysis. This lock holder cpu information may also be
useful to architectures like PowerPC that needs the lock holder cpu
number for better paravirtual spinlock performance.

A new config option QUEUED_SPINLOCKS_CPUINFO is added. If this config
option is set, lock holder cpu number will always be stored if the
number is small enough.  Without this option, lock holder cpu number
will only be stored in the slowpath of the native qspinlock.

Waiman Long (2):
  locking/qspinlock: Store lock holder cpu in lock if feasible
  locking/pvqspinlock: Optionally store lock holder cpu into lock

 arch/Kconfig                              | 12 ++++++
 arch/x86/include/asm/qspinlock_paravirt.h |  9 ++--
 include/asm-generic/qspinlock.h           | 13 ++++--
 include/asm-generic/qspinlock_types.h     |  5 +++
 kernel/locking/qspinlock.c                | 50 +++++++++++++++--------
 kernel/locking/qspinlock_paravirt.h       | 41 ++++++++++---------
 6 files changed, 87 insertions(+), 43 deletions(-)

-- 
2.18.1

