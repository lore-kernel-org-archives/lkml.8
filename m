Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E36C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F36F24676
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R1PIAybu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgBUAot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:44:49 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17954 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbgBUAor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582245903; x=1613781903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2zdJiOq4f3wJwRccJHyycNZQZCzm10RqZuxi1Brkdb0=;
  b=R1PIAybujoLSXZc/FlpW6eUSk9ywVUJ2pAth+pwoBPPfSw8Xho0BPbXM
   y7tnRl5YC35ni/m2g//Vy/9C6CtJVYvU3t2fikoQ/abu2i0q3oOo7+oWy
   tgSkn9noYreTUYmjwOZNLagDfnhm3DhhOwsTHT37Sntk0hAFPGJk+j4P4
   vezgJDPghrcKBrwchgUE8EwgZ9FDpTdm6ulNxdSfzMqBKCjhDLEqXC+6b
   lBnxLsDqGqN3NQNjcbUmOqxypkCksKLob/l5vIWNVN/63ynebIAUSS3jS
   7PVHkbFa/GuJVsEFfIqVSS1AES3D+yGnTDWFOBlMt9NhYkF/kvt9F5VEH
   w==;
IronPort-SDR: dN3R2IohjoNJXajkeJqV2FjWFMGhfaMrfyzT16PhHcwIW0Xotu5gDBDziI8AckAALVS4NbNMCb
 ovXmnH5+xAY0dohsgeE3Z5DtECbiKTqi2YU62iCubJ4xCu7+IwLhz4UAE/+vS+VToqU/lEck9w
 IXnr4+4yLqJGO6207icW1I9MCjVouoESnENs6WI5Y8/8ojRE99xc5i7qZC1K3BhMca3qwCq0RW
 OQ7ngEaVJ41vRVeAo5tK5NV1AS0HILMA+EyTasd04xxd3f1rIo1e0+E42GW75378//Xk1RRKHi
 wOE=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="232211057"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 08:45:03 +0800
IronPort-SDR: 2wwRNuWeD3mz56w7NoP0TiLgO/gt5HnPvSHjzAWbcQu2Eemtx455BaMOWEyQM5BZVRl4yLl/e1
 AGsXjayti/4L3c/bzaTIKwi/pdDCs7x0ddUhk/f91FSD0ZCaq5etrjMEmCUfvLR/jdxGyaUcIY
 5o2+OpaluIWCiqmtkOpxZHShHBdZZI71+szLatmFjwMaK4nN+N6yXX7WhdeJwX0OCj98TZMMBR
 K5CP8KY3s5+0QOPZOE90YOHvDnLl/TeTDUmPRTUiProuZEGGHulO/OgaAdRXbinebwjbbQMynz
 41h3bdg/peODzhZg5tzxb62E
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:37:21 -0800
IronPort-SDR: L4KuFcqyf9oql80GhFUx0COR/158IP2mIwpdmEivayTGqF/PTYrigQ6XKxUXr0zvfQ2c89gd/x
 fEVrQz94jqEPcZrRmV4HApCXSfViMnVtYNUKr3PzEe44jZCDDRG6y68bJtul6o/TXYX5TJzg2h
 TP8k/Wc7i9o/ajEX0rrOLvZquCS94SJ7wLLsFFAqOgZ+N6d0khlR4+KbZzLsVIqOMjj/Xu4DL9
 dJoOoH30yahRaBqnGmIR+PHG3aLOgk3JZ0NnsV0De/m+b5/qd/3yvgl3tQc/eOF44k07IXCvxn
 tss=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 16:44:46 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v9 03/12] RISC-V: Add SBI v0.2 extension definitions
Date:   Thu, 20 Feb 2020 16:44:04 -0800
Message-Id: <20200221004413.12869-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221004413.12869-1-atish.patra@wdc.com>
References: <20200221004413.12869-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few v0.1 SBI calls are being replaced by new SBI calls that follows
v0.2 calling convention.

This patch just defines these new extensions.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/sbi.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index fbdb7443784a..e478368a47f3 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -21,6 +21,9 @@ enum sbi_ext_id {
 	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
 	SBI_EXT_0_1_SHUTDOWN = 0x8,
 	SBI_EXT_BASE = 0x10,
+	SBI_EXT_TIME = 0x54494D45,
+	SBI_EXT_IPI = 0x735049,
+	SBI_EXT_RFENCE = 0x52464E43,
 };
 
 enum sbi_ext_base_fid {
@@ -33,6 +36,24 @@ enum sbi_ext_base_fid {
 	SBI_EXT_BASE_GET_MIMPID,
 };
 
+enum sbi_ext_time_fid {
+	SBI_EXT_TIME_SET_TIMER = 0,
+};
+
+enum sbi_ext_ipi_fid {
+	SBI_EXT_IPI_SEND_IPI = 0,
+};
+
+enum sbi_ext_rfence_fid {
+	SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
+	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
+	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.25.0

