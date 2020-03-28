Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0188C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979012073B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA/RjouT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgC1P2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:28:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27625 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgC1P17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585409278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TFXpc95MWFpmINkrmlqeEwf0gt3DMMUZi+ptiJjBuYM=;
        b=EA/RjouTD+FIv0do8bYPT30TFAHPGtzMuvcnoZQZ3f/QGHjFANcMRbc6r3Cttvhu0SnY5i
        4Ng/gjn0tFYcueTwnXyA5YWOWnhO0VJMG7T/iWdVAX61f3RNu82FD36hrcHyRNTN4kA8C+
        dGQvX2r8Vwm5s0Efyr49QjgiSsa9mM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-QBLMmoqHOZ68o-2HZ5Uh2Q-1; Sat, 28 Mar 2020 11:27:54 -0400
X-MC-Unique: QBLMmoqHOZ68o-2HZ5Uh2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E5161083E80;
        Sat, 28 Mar 2020 15:27:52 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A8EACDBE7;
        Sat, 28 Mar 2020 15:27:52 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 4B636416C887; Sat, 28 Mar 2020 12:27:27 -0300 (-03)
Message-ID: <20200328152117.881555226@redhat.com>
User-Agent: quilt/0.66
Date:   Sat, 28 Mar 2020 12:21:17 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: [patch 0/3] affine kernel threads to specified cpumask (v3)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a kernel enhancement to configure the cpu affinity of kernel
threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>

When this option is specified, the cpumask is immediately applied upon
thread launch. This does not affect kernel threads that specify cpu
and node.

This allows CPU isolation (that is not allowing certain threads
to execute on certain CPUs) without using the isolcpus=domain parameter,
making it possible to enable load balancing on such CPUs
during runtime.

Note-1: this is based off on Wind River's patch at
https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch

Difference being that this patch is limited to modifying
kernel thread cpumask: Behaviour of other threads can
be controlled via cgroups or sched_setaffinity.

Note-2: Wind River's patch was based off Christoph Lameter's patch at
https://lwn.net/Articles/565932/ with the only difference being
the kernel parameter changed from kthread to kthread_cpus.

Changelog:

v2: use isolcpus= subcommand (Thomas Gleixner)

v3: s/MontaVista/Wind River/ on changelog (Chris Friesen)
    documentation updates		  (Chris Friesen)
    undeprecate isolcpus		  (Chris Friesen)
    general cleanups			  (Frederic Weisbecker)
    separate cpu_possible_mask kthread    
    mask change				  (Frederic Weisbecker)


