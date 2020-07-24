Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92A9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90543206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595591476;
	bh=Xw3x5vASXphVNgXoqOa3wbQBOjeoPPtwQp6ERGqHuM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0JMG8wTTh0LVxQaV15R5nYeT8JH2hfslitKAZG+5xWw+Mp8ia7iehnP/iZmFdU8hx
	 0uDN26oZSbX7pUDj0Dmvl7Q55kGIn231X3FtHIq3vCnoD5ldYp/z9vTRC0c9GVLz4i
	 AJsvlnLq0IJZv/eDtLRTHVeoecJiriCdZlikPeI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGXLvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgGXLvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:51:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55D8206E3;
        Fri, 24 Jul 2020 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595591473;
        bh=Xw3x5vASXphVNgXoqOa3wbQBOjeoPPtwQp6ERGqHuM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxuUqCVFGn0j5YrrBYniVsa6ZhQQDLo2WITIa7vuidKb0jFz5Nflf6cz9Ru7lGoa0
         jnqHEEP8rMnnCMCz5ZuHmUyStcst5bb+InJqnhvC44JmstVHLoFLPE58Rt4LLo5IFf
         Cx6WQjMxsHT7hR6c0GuqOykpXe0PGkK25VgYXI8s=
Date:   Fri, 24 Jul 2020 12:51:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.9
Message-ID: <20200724115109.GA17451@willie-the-truck>
References: <20200721080352.GA13023@willie-the-truck>
 <20200722133323.GG27672@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722133323.GG27672@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Wed, Jul 22, 2020 at 03:33:23PM +0200, Joerg Roedel wrote:
> On Tue, Jul 21, 2020 at 09:03:53AM +0100, Will Deacon wrote:
> > Please pull these Arm SMMU driver updates for 5.9. Summary is in the tag,
> > but the main thing is support for two new SoC integrations, one of which
> > is considerably more brain-dead than the other (determining which one is
> > left as an exercise to the reader although the diffstat is fairly revealing).
> 
> :)
> 
> > The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:
> > 
> >   Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> Pulled, thanks. Given the number of arm-smmu* files it probably makes
> sense to create a drivers/iommu/arm-smmu/ directory and move it all
> there. If you agree feel free to send this as an additional patch on-top
> of this pull-request.

Sure, that makes sense to me: I've included a diff below in case anybody
has comments. I've tackled it slightly differently to how the intel and
amd drivers are handled, since we have a header file (arm-smmu.h) which
is shared by a couple of different drivers. I've also moved the v3 driver
under the arm/ directory as Jean Philippe plans to split out the SVA work
for 5.10.

I'll send a second pull early next week if there are no objections (or
you can pick this patch directly).

Cheers,

Will

--->8

From 0e4a152062600f7f43ea4ea47925d12ec3a477ab Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Fri, 24 Jul 2020 12:43:20 +0100
Subject: [PATCH] iommu/arm-smmu: Move Arm SMMU drivers into their own
 subdirectory

The Arm SMMU drivers are getting fat on vendor value-add, so move them
to their own subdirectory out of the way of the other IOMMU drivers.

Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 MAINTAINERS                                        | 2 +-
 drivers/iommu/Makefile                             | 5 +----
 drivers/iommu/arm/Makefile                         | 2 ++
 drivers/iommu/arm/arm-smmu-v3/Makefile             | 2 ++
 drivers/iommu/{ => arm/arm-smmu-v3}/arm-smmu-v3.c  | 0
 drivers/iommu/arm/arm-smmu/Makefile                | 4 ++++
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-impl.c   | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-nvidia.c | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-qcom.c   | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu.c        | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu.h        | 0
 drivers/iommu/{ => arm/arm-smmu}/qcom_iommu.c      | 0
 12 files changed, 10 insertions(+), 5 deletions(-)
 create mode 100644 drivers/iommu/arm/Makefile
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/Makefile
 rename drivers/iommu/{ => arm/arm-smmu-v3}/arm-smmu-v3.c (100%)
 create mode 100644 drivers/iommu/arm/arm-smmu/Makefile
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-impl.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-nvidia.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-qcom.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu.h (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/qcom_iommu.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee2c0ba13a0f..6383801828c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1498,7 +1498,7 @@ R:	Robin Murphy <robin.murphy@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/arm,smmu*
-F:	drivers/iommu/arm-smmu*
+F:	drivers/iommu/arm/
 F:	drivers/iommu/io-pgtable-arm-v7s.c
 F:	drivers/iommu/io-pgtable-arm.c
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 2b8203db73ec..d971cffc810b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y += arm/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
@@ -14,9 +15,6 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
-obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
-arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
-obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
 obj-$(CONFIG_INTEL_IOMMU) += intel/trace.o
@@ -35,6 +33,5 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
-obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
diff --git a/drivers/iommu/arm/Makefile b/drivers/iommu/arm/Makefile
new file mode 100644
index 000000000000..0f9efeab709f
--- /dev/null
+++ b/drivers/iommu/arm/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y += arm-smmu/ arm-smmu-v3/
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
new file mode 100644
index 000000000000..569e24e9f162
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
similarity index 100%
rename from drivers/iommu/arm-smmu-v3.c
rename to drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
diff --git a/drivers/iommu/arm/arm-smmu/Makefile b/drivers/iommu/arm/arm-smmu/Makefile
new file mode 100644
index 000000000000..e240a7bcf310
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
+obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
+arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
similarity index 100%
rename from drivers/iommu/arm-smmu-impl.c
rename to drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
similarity index 100%
rename from drivers/iommu/arm-smmu-nvidia.c
rename to drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
similarity index 100%
rename from drivers/iommu/arm-smmu-qcom.c
rename to drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
similarity index 100%
rename from drivers/iommu/arm-smmu.c
rename to drivers/iommu/arm/arm-smmu/arm-smmu.c
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
similarity index 100%
rename from drivers/iommu/arm-smmu.h
rename to drivers/iommu/arm/arm-smmu/arm-smmu.h
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
similarity index 100%
rename from drivers/iommu/qcom_iommu.c
rename to drivers/iommu/arm/arm-smmu/qcom_iommu.c
-- 
2.28.0.rc0.142.g3c755180ce-goog

