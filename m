Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F997C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48920208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879370;
	bh=eMxBwmkartGXTYGADKlxhAJ/RgekzyG4eplZyM7RwHQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=doF5YStuspv+f/5yZSGRL3N2KZCEdwM+sjHNQUwmk2gxILN++AD9DjVY9o7v8gknZ
	 qOntmD4ydExkMLF3wF+8Hsex6+Ym2vpa5lNWe/wA2X1+kpW9ci+pURX9I3wL8bNvOD
	 dVHH0NqviaK2zQaHvXsw2TVaG/3cSyov5t6atGd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgEGTWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgEGTWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:22:46 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A28F3208D6;
        Thu,  7 May 2020 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879365;
        bh=eMxBwmkartGXTYGADKlxhAJ/RgekzyG4eplZyM7RwHQ=;
        h=Date:From:To:Cc:Subject:From;
        b=pZCS+/asI/pHxGRJC2Gj2OWLQWg9ywyNPIoJtvVKseI+kuRpbP/7albbvmWBnhRy5
         /AEW/BC6t00F+QxnlsOrpPcF6dvGrW3sWP4u8IdSwTORRjH3TzuDxuHjuIucocD65E
         +1MiAdmUYusbzcKw9c33+bLtbWf9AN6mCy0yPmCY=
Date:   Thu, 7 May 2020 14:27:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] efi: Replace zero-length array with flexible-array
Message-ID: <20200507192712.GA16805@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/dma/ti-cppi5.h                   |    4 ++--
 include/linux/efi.h                            |    2 +-
 include/linux/mailbox/zynqmp-ipi-message.h     |    2 +-
 include/linux/platform_data/cros_ec_commands.h |    4 ++--
 include/linux/platform_data/cros_ec_proto.h    |    2 +-
 kernel/params.c                                |    2 +-
 kernel/tracepoint.c                            |    2 +-
 scripts/kallsyms.c                             |    2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/dma/ti-cppi5.h b/include/linux/dma/ti-cppi5.h
index 579356ae447e..78c911269107 100644
--- a/include/linux/dma/ti-cppi5.h
+++ b/include/linux/dma/ti-cppi5.h
@@ -47,7 +47,7 @@ struct cppi5_host_desc_t {
 	u32 buf_info1;
 	u32 org_buf_len;
 	u64 org_buf_ptr;
-	u32 epib[0];
+	u32 epib[];
 } __packed;
 
 #define CPPI5_DESC_MIN_ALIGN			(16U)
@@ -139,7 +139,7 @@ struct cppi5_desc_epib_t {
  */
 struct cppi5_monolithic_desc_t {
 	struct cppi5_desc_hdr_t hdr;
-	u32 epib[0];
+	u32 epib[];
 };
 
 #define CPPI5_INFO2_MDESC_DATA_OFFSET_SHIFT	(18U)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 251f1f783cdf..a657850899f0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1234,7 +1234,7 @@ struct linux_efi_memreserve {
 	struct {
 		phys_addr_t	base;
 		phys_addr_t	size;
-	} entry[0];
+	} entry[];
 };
 
 #define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
index 9542b41eacfd..35ce84c8ca02 100644
--- a/include/linux/mailbox/zynqmp-ipi-message.h
+++ b/include/linux/mailbox/zynqmp-ipi-message.h
@@ -14,7 +14,7 @@
  */
 struct zynqmp_ipi_message {
 	size_t len;
-	u8 data[0];
+	u8 data[];
 };
 
 #endif /* _LINUX_ZYNQMP_IPI_MESSAGE_H_ */
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 69210881ebac..451885c697cc 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5065,7 +5065,7 @@ struct ec_response_pd_log {
 	uint8_t type;       /* event type : see PD_EVENT_xx below */
 	uint8_t size_port;  /* [7:5] port number [4:0] payload size in bytes */
 	uint16_t data;      /* type-defined data payload */
-	uint8_t payload[0]; /* optional additional data payload: 0..16 bytes */
+	uint8_t payload[]; /* optional additional data payload: 0..16 bytes */
 } __ec_align4;
 
 /* The timestamp is the microsecond counter shifted to get about a ms. */
@@ -5691,7 +5691,7 @@ struct ec_response_fp_encryption_status {
 
 struct ec_response_tp_frame_info {
 	uint32_t n_frames;
-	uint32_t frame_sizes[0];
+	uint32_t frame_sizes[];
 } __ec_align4;
 
 /* Create a snapshot of current frame readings */
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 383243326676..7f03e02c48cd 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -69,7 +69,7 @@ struct cros_ec_command {
 	uint32_t outsize;
 	uint32_t insize;
 	uint32_t result;
-	uint8_t data[0];
+	uint8_t data[];
 };
 
 /**
diff --git a/kernel/params.c b/kernel/params.c
index 8e56f8b12d8f..55c07e3b9903 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -529,7 +529,7 @@ struct module_param_attrs
 {
 	unsigned int num;
 	struct attribute_group grp;
-	struct param_attribute attrs[0];
+	struct param_attribute attrs[];
 };
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 73956eaff8a9..3ee46cda2692 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -50,7 +50,7 @@ static bool ok_to_free_tracepoints;
  */
 struct tp_probes {
 	struct rcu_head rcu;
-	struct tracepoint_func probes[0];
+	struct tracepoint_func probes[];
 };
 
 static inline void *allocate_probes(int count)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 3e8dea6e0a95..6dc3078649fa 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -34,7 +34,7 @@ struct sym_entry {
 	unsigned int len;
 	unsigned int start_pos;
 	unsigned int percpu_absolute;
-	unsigned char sym[0];
+	unsigned char sym[];
 };
 
 struct addr_range {

