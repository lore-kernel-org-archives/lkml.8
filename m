Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19612C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17652074A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KTB7nCKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgH0AnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:43:12 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61848 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgH0AnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598488992; x=1630024992;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gJAOuvCNVESTNELiVRxYhjymGe+a8wcK8KsX+jC97+8=;
  b=KTB7nCKMKR9kI2/NH6sBM1hcZH4bf+L+syEpDok2jtIhRbpvjs5FB/dA
   OUbJDkQ8QCZC3swXKtxjuWMYWpL3LG65gPF9DopdG9qagC0onxiuhWxHt
   IiKlbxIPVYrpswF/N170WV7KNur83VPNcVli5te+S1/3V9zZf2uylY8RN
   o=;
X-IronPort-AV: E=Sophos;i="5.76,357,1592870400"; 
   d="scan'208";a="70024280"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 27 Aug 2020 00:43:07 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id C4069A18F5;
        Thu, 27 Aug 2020 00:43:04 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:43:04 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.160.192) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:42:58 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <pjt@google.com>,
        <torvalds@linux-foundation.org>, <subhra.mazumdar@oracle.com>,
        <fweisbec@gmail.com>, <keescook@chromium.org>,
        <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, <joel@joelfernandes.org>,
        <vineethrp@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/3] Add HRTICK support to Core Scheduling
Date:   Thu, 27 Aug 2020 02:42:47 +0200
Message-ID: <20200827004250.4853-1-graf@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D28UWC002.ant.amazon.com (10.43.162.145) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFS supports a feature called "HRTICK" which allows scheduling
decisions to be made independent of the HZ tick. That means that
we can achieve much more fine grained time slices and thus be
more fair in distributing time to different workloads.

Unfortunately, HRTICK currently does not work with the Core
Scheduling patch set. This patch set adds support for it.
Feel free to squash bits in where it makes sense.


Alex

Alexander Graf (3):
  sched: Allow hrticks to work with core scheduling
  sched: Trigger new hrtick if timer expires too fast
  sched: Use hrticks even with >sched_nr_latency tasks

 kernel/sched/core.c  | 13 +++++++++++++
 kernel/sched/fair.c  | 18 ++++++++++++++++--
 kernel/sched/sched.h |  4 ++++
 3 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.26.2




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



