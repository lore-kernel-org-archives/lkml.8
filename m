Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8075BC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FF024958
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347493;
	bh=OkqVTyJHlSgHHi60ZQtwTsdw3lbAKzeOmZo1DT2RrRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y1dqUVu8oWvtI6bV+nrmTthzmC8FrgIghcn+nMiZj0NHlHOapa+lytBHt9xM4LXu6
	 bWTR6vAjuCJ3klAIrzF/GegpVzacURWQ+lPm1Oj6HDMk+EM98ttKLmptO5rjTfxGik
	 Mr16Bg3oe+oGGU2ItSBlnfoLy5NFpVg2BpajloVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgEAPiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgEAPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2503F24966;
        Fri,  1 May 2020 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=OkqVTyJHlSgHHi60ZQtwTsdw3lbAKzeOmZo1DT2RrRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwLryyDV9dMteAeO3qxETGfzzk+h+M40YrRPckTxYJ9O2ZPflRAdACrHzRibfNTNg
         4jr5QYU5uZof7TlGLC0/3YTgPPXmiWOMQaRFoTPskzRu0mciUxX6rupsO3IY4GPmiN
         1zbsLnPbAmh4k/9/TfnG/UyfIzsvv+fUisqs9+iE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE54-72; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Will Deacon <will@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 10/14] docs: move locking-specific documenta to locking/ directory
Date:   Fri,  1 May 2020 17:37:54 +0200
Message-Id: <dd833a10bbd0b2c1461d78913f5ec28a7e27f00b.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several files under Documentation/*.txt describe some type of
locking API. Move them to locking/ subdir and add to the
locking/index.rst index file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{futex-requeue-pi.txt => locking/futex-requeue-pi.rst} | 0
 Documentation/{hwspinlock.txt => locking/hwspinlock.rst}   | 0
 Documentation/locking/index.rst                            | 7 +++++++
 .../percpu-rw-semaphore.rst}                               | 0
 Documentation/{pi-futex.txt => locking/pi-futex.rst}       | 0
 .../{preempt-locking.txt => locking/preempt-locking.rst}   | 0
 .../{robust-futex-ABI.txt => locking/robust-futex-ABI.rst} | 0
 .../{robust-futexes.txt => locking/robust-futexes.rst}     | 0
 Documentation/locking/rt-mutex.rst                         | 2 +-
 MAINTAINERS                                                | 6 +++---
 10 files changed, 11 insertions(+), 4 deletions(-)
 rename Documentation/{futex-requeue-pi.txt => locking/futex-requeue-pi.rst} (100%)
 rename Documentation/{hwspinlock.txt => locking/hwspinlock.rst} (100%)
 rename Documentation/{percpu-rw-semaphore.txt => locking/percpu-rw-semaphore.rst} (100%)
 rename Documentation/{pi-futex.txt => locking/pi-futex.rst} (100%)
 rename Documentation/{preempt-locking.txt => locking/preempt-locking.rst} (100%)
 rename Documentation/{robust-futex-ABI.txt => locking/robust-futex-ABI.rst} (100%)
 rename Documentation/{robust-futexes.txt => locking/robust-futexes.rst} (100%)

diff --git a/Documentation/futex-requeue-pi.txt b/Documentation/locking/futex-requeue-pi.rst
similarity index 100%
rename from Documentation/futex-requeue-pi.txt
rename to Documentation/locking/futex-requeue-pi.rst
diff --git a/Documentation/hwspinlock.txt b/Documentation/locking/hwspinlock.rst
similarity index 100%
rename from Documentation/hwspinlock.txt
rename to Documentation/locking/hwspinlock.rst
diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.rst
index 5d6800a723dc..d785878cad65 100644
--- a/Documentation/locking/index.rst
+++ b/Documentation/locking/index.rst
@@ -16,6 +16,13 @@ locking
     rt-mutex
     spinlocks
     ww-mutex-design
+    preempt-locking
+    pi-futex
+    futex-requeue-pi
+    hwspinlock
+    percpu-rw-semaphore
+    robust-futexes
+    robust-futex-ABI
 
 .. only::  subproject and html
 
diff --git a/Documentation/percpu-rw-semaphore.txt b/Documentation/locking/percpu-rw-semaphore.rst
similarity index 100%
rename from Documentation/percpu-rw-semaphore.txt
rename to Documentation/locking/percpu-rw-semaphore.rst
diff --git a/Documentation/pi-futex.txt b/Documentation/locking/pi-futex.rst
similarity index 100%
rename from Documentation/pi-futex.txt
rename to Documentation/locking/pi-futex.rst
diff --git a/Documentation/preempt-locking.txt b/Documentation/locking/preempt-locking.rst
similarity index 100%
rename from Documentation/preempt-locking.txt
rename to Documentation/locking/preempt-locking.rst
diff --git a/Documentation/robust-futex-ABI.txt b/Documentation/locking/robust-futex-ABI.rst
similarity index 100%
rename from Documentation/robust-futex-ABI.txt
rename to Documentation/locking/robust-futex-ABI.rst
diff --git a/Documentation/robust-futexes.txt b/Documentation/locking/robust-futexes.rst
similarity index 100%
rename from Documentation/robust-futexes.txt
rename to Documentation/locking/robust-futexes.rst
diff --git a/Documentation/locking/rt-mutex.rst b/Documentation/locking/rt-mutex.rst
index c365dc302081..3b5097a380e6 100644
--- a/Documentation/locking/rt-mutex.rst
+++ b/Documentation/locking/rt-mutex.rst
@@ -4,7 +4,7 @@ RT-mutex subsystem with PI support
 
 RT-mutexes with priority inheritance are used to support PI-futexes,
 which enable pthread_mutex_t priority inheritance attributes
-(PTHREAD_PRIO_INHERIT). [See Documentation/pi-futex.txt for more details
+(PTHREAD_PRIO_INHERIT). [See Documentation/locking/pi-futex.rst for more details
 about PI-futexes.]
 
 This technology was developed in the -rt tree and streamlined for
diff --git a/MAINTAINERS b/MAINTAINERS
index 6eb3d85a646f..1aa6e89e7424 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7042,13 +7042,13 @@ R:	Darren Hart <dvhart@infradead.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
-F:	Documentation/*futex*
+F:	Documentation/locking/*futex*
 F:	include/asm-generic/futex.h
 F:	include/linux/futex.h
 F:	include/uapi/linux/futex.h
 F:	kernel/futex.c
 F:	tools/perf/bench/futex*
-F:	tools/testing/selftests/futex/
+F:	Documentation/locking/*futex*
 
 GASKET DRIVER FRAMEWORK
 M:	Rob Springer <rspringer@google.com>
@@ -7519,7 +7519,7 @@ L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git hwspinlock-next
 F:	Documentation/devicetree/bindings/hwlock/
-F:	Documentation/hwspinlock.txt
+F:	Documentation/locking/hwspinlock.rst
 F:	drivers/hwspinlock/
 F:	include/linux/hwspinlock.h
 
-- 
2.25.4

