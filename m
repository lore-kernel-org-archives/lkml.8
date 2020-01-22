Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8352BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5822720678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699228;
	bh=uafhk5sWJvoBC4coMWjV2mrDWqrFLj8kEONNP6ybf40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uyqEpCae7SANNQnjTWWRwc0CubOv+EdqzuVrNGCAjVk0DSjxDeF+pr8DwcWMFZKkg
	 5OqSKE1yNVv8kfW8jYeGjieVoHVGu7sXG8WOWx3LurFBduzXRnc0MrrpSH9lLgHZpQ
	 o+gn1KMkhaDCOhf2u2zDqAomudbQf9bCh+qxX2MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgAVNU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbgAVNUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:20:24 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C242467F;
        Wed, 22 Jan 2020 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699223;
        bh=uafhk5sWJvoBC4coMWjV2mrDWqrFLj8kEONNP6ybf40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5lv3YxK91GZfixCYCSG9TbM3U/kwRxwn1iL4JxMlAlslEozrN7WtPI2TzdnHe67E
         wIKZxxVR1fx6T3TXfuaBwMkJhwLehikHN9xWPpQHsWpiT5f4jfaAjaL4sJmG/KKbo4
         UflXUV9kH33YmeJt/WvEwDikZnjKaHYWdu8GnV/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Borislav Petkov <bp@suse.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 5.4 071/222] x86/resctrl: Fix potential memory leak
Date:   Wed, 22 Jan 2020 10:27:37 +0100
Message-Id: <20200122092838.804074617@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shakeel Butt <shakeelb@google.com>

commit ab6a2114433a3b5b555983dcb9b752a85255f04b upstream.

set_cache_qos_cfg() is leaking memory when the given level is not
RDT_RESOURCE_L3 or RDT_RESOURCE_L2. At the moment, this function is
called with only valid levels but move the allocation after the valid
level checks in order to make it more robust and future proof.

 [ bp: Massage commit message. ]

Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20200102165844.133133-1-shakeelb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1741,9 +1741,6 @@ static int set_cache_qos_cfg(int level,
 	struct rdt_domain *d;
 	int cpu;
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	if (level == RDT_RESOURCE_L3)
 		update = l3_qos_cfg_update;
 	else if (level == RDT_RESOURCE_L2)
@@ -1751,6 +1748,9 @@ static int set_cache_qos_cfg(int level,
 	else
 		return -EINVAL;
 
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
 		/* Pick one CPU from each domain instance to update MSR */


