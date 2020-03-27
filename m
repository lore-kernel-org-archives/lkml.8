Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD081C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8295820705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="ToWrV+3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0HM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 03:12:28 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:35608 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgC0HMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 03:12:22 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id EB93C2DC682E;
        Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1585293141;
        bh=vpE3Z7AWSr9my143HyVtO4yHV91rl8rmhtd6A3TKrQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToWrV+3ZvZNUE2ymKS5AQKjdsoM8VnN0qS7Mcg9YpzMua6UKfnzZyjTa2CjCdkbAx
         KA4DnOTootSPbswhgz91nw0o0biwbDxGGtU0moHxcS4X33+W5cUSY031Xl/IrjDcZd
         k3akP1KgKpgAFMucLlxQ3QSayVxS+wFdH5r/CbdTgtEm2Lm0kz0rlKGVn2QnbTTmUY
         UkMI0q1W76+Cvy4N74Irk+FktDx/FAGYFcmEmjYiX7Nqu9M/8R0gPLHdVNTj3r5m56
         z8ExH4vvUt4YZDpKoUykg9YeTGV2GWmofs8LL315gf708HqmzIocIMebbvWxygke/J
         32agGl9J6xWPkVtSWxa+am6KzeJxoO0/g4PK3Ng2KA76AixIloAhpOJc7kNPGwysHV
         T7Z+WgI/ICr/00Hx0uOy+52nbSf4jEphgh3ufk7wZnG00NaTJJ565EWv8n93D9nR/C
         8gE9SepGUhdH3IliID4vYmthn4YIuB85FAXfMAQ6NpMPmma20AplulMTz4Potr3Qw/
         krKKVXInJ8PzHdWHNiOFeLBHEa011pvUyKeZs2wdc6f8SoFaBDJl2Fl1zKiU3R5MjB
         e4zLtL+yqH7gkqhY5wwcPBO/0Knua2Y3YlppmvVOY4DDN5PsenvhIhiww1FHkOXtoP
         NiMUvB+XldjBvNPEI3v1PTTo=
Received: from localhost.lan ([10.0.1.179])
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ak045934;
        Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v4 11/25] powerpc: Enable the OpenCAPI Persistent Memory driver for powernv_defconfig
Date:   Fri, 27 Mar 2020 18:11:48 +1100
Message-Id: <20200327071202.2159885-12-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:17 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the OpenCAPI Persistent Memory driver, as well
as DAX support, for the 'powernv' defconfig.

DAX is not a strict requirement for the functioning of the driver, but it
is likely that a user will want to create a DAX device on top of their
persistent memory device.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 arch/powerpc/configs/powernv_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 71749377d164..921d77bbd3d2 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -348,3 +348,8 @@ CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
 CONFIG_VHOST_NET=m
 CONFIG_PRINTK_TIME=y
+CONFIG_ZONE_DEVICE=y
+CONFIG_OCXL_PMEM=m
+CONFIG_DEV_DAX=m
+CONFIG_DEV_DAX_PMEM=m
+CONFIG_FS_DAX=y
-- 
2.24.1

