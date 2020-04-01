Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEF1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584F020776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThHm2dCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbgDAMPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:15:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732496AbgDAMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585743335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gKRsQzj1wHjyshbJp6pZihNgfn9EIDeX0M9nbIEjc5U=;
        b=ThHm2dCInLrHkhS1SPzI1aaL8dOVK9ix8TdltEwnNOpxBB0sGWz1TLsndGQI5eIbSfi8A7
        EnCU6l5n82Efi14aE/U9WPVcmkIk2/8HeQAyba1jP5lwbp5IQruk+2DBfe72j52g8sXGxp
        bpgk+lK3kY56OZWuTOkkWa0L4jMuADI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-RVWAq1UwPIyVYY5wkF0cbA-1; Wed, 01 Apr 2020 08:15:31 -0400
X-MC-Unique: RVWAq1UwPIyVYY5wkF0cbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4D62107ACCA;
        Wed,  1 Apr 2020 12:15:29 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B67419C70;
        Wed,  1 Apr 2020 12:15:29 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B113F418CC3E; Wed,  1 Apr 2020 09:15:03 -0300 (-03)
Message-ID: <20200401121018.104226700@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Apr 2020 09:10:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: [patch 0/4] affine kernel threads to nohz_full= cpumask (v4)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a kernel enhancement that configures the cpu affinity of kernel
threads via kernel boot option nohz_full=.

When this option is specified, the cpumask is immediately applied upon
thread launch. This does not affect kernel threads that specify cpu
and node.

This allows CPU isolation (that is not allowing certain threads
to execute on certain CPUs) without using the isolcpus=domain parameter,
making it possible to enable load balancing on such CPUs
during runtime (see kernel-parameters.txt).

Note-1: this is based off on Wind River's patch at
https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch

Difference being that this patch is limited to modifying
kernel thread cpumask: Behaviour of other threads can
be controlled via cgroups or sched_setaffinity.

Note-2: Wind River's patch was based off Christoph Lameter's patch at
https://lwn.net/Articles/565932/ with the only difference being
the kernel parameter changed from kthread to kthread_cpus.

v2: use isolcpus= subcommand (Thomas Gleixner)

v3: s/MontaVista/Wind River/ on changelog (Chris Friesen)
    documentation updates                 (Chris Friesen)
    undeprecate isolcpus                  (Chris Friesen)
    general cleanups                      (Frederic Weisbecker)
    separate cpu_possible_mask kthread
    mask change                           (Frederic Weisbecker)

v4: disable idle load balancing for nohz_full=
    use nohz_full= option for kthread isolation (Frederic Weisbecker)

