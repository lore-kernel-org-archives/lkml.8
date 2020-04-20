Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F615C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCE4206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387042;
	bh=zfLSUs3Dq2oSO1Qvmk/OaAjgtJzb07dCTrMqO1Zdfa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UIPd/zCirlXLpfJiDalC1CMYwFwCb/rvC95K5U1EZI+qjx+IueomH35KZZGsZQe7m
	 O9VxxvrzdbNCnxPc8U7RZLU8l0YH0fEtK0KJOO4uq7+53NYnMlpM+qU7eZ0s0lEy/d
	 QhCYMvD1Ie2ifL3071x1b2WsVSyYKcRo63Fn5lVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgDTMuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbgDTMtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:49:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 480FE206DD;
        Mon, 20 Apr 2020 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386952;
        bh=zfLSUs3Dq2oSO1Qvmk/OaAjgtJzb07dCTrMqO1Zdfa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dazSWC141sP9E8aPqh8eWRqm891eekoZcDps28aYT3lJFvQMJ5kwJDkAY9PyI6tMH
         sRylL7lxBGLkvjwuYaS0jW7n4HA9STI9/pfaKVDRRFp6AU+Nkkantyzu7hpE0IPO3+
         hyUQQKwTFAV2OQTr9SPwQw8Ji+apfTJqiqEGeceo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.19 33/40] x86/resctrl: Preserve CDP enable over CPU hotplug
Date:   Mon, 20 Apr 2020 14:39:43 +0200
Message-Id: <20200420121505.491872082@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

commit 9fe0450785abbc04b0ed5d3cf61fcdb8ab656b4b upstream.

Resctrl assumes that all CPUs are online when the filesystem is mounted,
and that CPUs remember their CDP-enabled state over CPU hotplug.

This goes wrong when resctrl's CDP-enabled state changes while all the
CPUs in a domain are offline.

When a domain comes online, enable (or disable!) CDP to match resctrl's
current setting.

Fixes: 5ff193fbde20 ("x86/intel_rdt: Add basic resctrl filesystem support")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20200221162105.154163-1-james.morse@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel_rdt.c          |    2 ++
 arch/x86/kernel/cpu/intel_rdt.h          |    1 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |   13 +++++++++++++
 3 files changed, 16 insertions(+)

--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -555,6 +555,8 @@ static void domain_add_cpu(int cpu, stru
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
+	rdt_domain_reconfigure_cdp(r);
+
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
 		kfree(d);
 		return;
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -567,5 +567,6 @@ void cqm_setup_limbo_handler(struct rdt_
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
+void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
 #endif /* _ASM_X86_INTEL_RDT_H */
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1777,6 +1777,19 @@ static int set_cache_qos_cfg(int level,
 	return 0;
 }
 
+/* Restore the qos cfg state when a domain comes online */
+void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
+{
+	if (!r->alloc_capable)
+		return;
+
+	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA])
+		l2_qos_cfg_update(&r->alloc_enabled);
+
+	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA])
+		l3_qos_cfg_update(&r->alloc_enabled);
+}
+
 /*
  * Enable or disable the MBA software controller
  * which helps user specify bandwidth in MBps.


