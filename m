Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A8BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D742467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686492;
	bh=DBde7uZQI+nAKqKHJs8EuTBmhlPbAKjNh1GJFTUbcss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C/cVXteTZ8eSVoX66xdjtkVJotfRAOEWK62RRgYYduqPJJzIwSQlbCTA5BsNCUJC3
	 ygG16ZOKjdOxq0t7Qzmp876hfMS3MJZ+9a6ITbc31Kcy+La6C4sI5APztKUqD1VPFE
	 D4GH3lKSinTg4x5HRwZGSxVtDSfZC0FXONOG2aZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbgAVJlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387563AbgAVJlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A57524684;
        Wed, 22 Jan 2020 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686082;
        bh=DBde7uZQI+nAKqKHJs8EuTBmhlPbAKjNh1GJFTUbcss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2tv6bYl3RTp77BYaVpasAznrZ116rCkwSSFlv5lud4NfFhwfWjdlNOeZZMNbd/aT
         pwpwjfTFEEqMjURDvYiG7Ryd7tna5y6RlgIVZrlet2tknrzMD7Dv9X5FshJXZa5jM1
         5QpsijhM9vEYpdeyjHjdL2U7fffILKnTtbybivfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Borislav Petkov <bp@suse.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.19 037/103] x86/resctrl: Fix potential memory leak
Date:   Wed, 22 Jan 2020 10:28:53 +0100
Message-Id: <20200122092809.478517811@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
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
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1749,9 +1749,6 @@ static int set_cache_qos_cfg(int level,
 	struct rdt_domain *d;
 	int cpu;
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	if (level == RDT_RESOURCE_L3)
 		update = l3_qos_cfg_update;
 	else if (level == RDT_RESOURCE_L2)
@@ -1759,6 +1756,9 @@ static int set_cache_qos_cfg(int level,
 	else
 		return -EINVAL;
 
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
 		/* Pick one CPU from each domain instance to update MSR */


