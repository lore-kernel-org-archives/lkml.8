Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D155AC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4B22072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386540;
	bh=2wn0F3Rb9BTNHNvimEOaOhQbgSSFphhXDg2fGL1HMX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+ZgS6cKZe8qCOSFPUHyPTQM5pJgoVORy5MYfFvgSpyLYyQlDchYYZux+EJd3eDp8
	 NFLsfhr2oGHhTMpGgK4mqdOCE0RZ3TQR5CcYLa9GQtHyzwO4jBA8MAqvLouUJP3/rv
	 OCFOTiMOS38hACv/av0ztmDmM/Hf06EM5tjuODbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgDTMmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbgDTMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:42:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207292070B;
        Mon, 20 Apr 2020 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386533;
        bh=2wn0F3Rb9BTNHNvimEOaOhQbgSSFphhXDg2fGL1HMX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjJUBs7436ZHVuV3h0NDMZ6eWZSuEorAkS6x2FBW3wvtksXZd0AuV/nQBriQIzL3+
         43VCPpkWiWhiWGT1uLH5n7hUQYEblpwbkvoBs6hqDeCXRSgGq12ov5hGWtIrYslojn
         zEst8UbiYJ+itpvfJ2osHSkrxH+l6NQEIzEOkoi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.5 61/65] x86/resctrl: Preserve CDP enable over CPU hotplug
Date:   Mon, 20 Apr 2020 14:39:05 +0200
Message-Id: <20200420121519.717649306@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
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
 arch/x86/kernel/cpu/resctrl/core.c     |    2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   13 +++++++++++++
 3 files changed, 16 insertions(+)

--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -578,6 +578,8 @@ static void domain_add_cpu(int cpu, stru
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
+	rdt_domain_reconfigure_cdp(r);
+
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
 		kfree(d);
 		return;
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -601,5 +601,6 @@ bool has_busy_rmid(struct rdt_resource *
 void __check_limbo(struct rdt_domain *d, bool force_free);
 bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
 bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
+void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1769,6 +1769,19 @@ static int set_cache_qos_cfg(int level,
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


