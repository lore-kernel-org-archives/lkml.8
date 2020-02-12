Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF2C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34472465D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LFVtQtiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgBLBv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:51:56 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60368 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgBLBvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581472315; x=1613008315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvujFwzpw9mkwEK+Mb1EePlXzqe88waJ7+oOaZrzSZk=;
  b=LFVtQtiWwakF/6UYsJaIeaArG7EOA/cNeb0+iUkYMf+Y0R9QfTXRtlsc
   yE2+EGRXDYvzkmaPIOc+hHYDCgG7Jmfh9lxjGmPvmmPpQL4F5WeMC0vM/
   WJdiUTnJW9vInyF6Ydpdv8H4Oe3Q6XJ9C2uUtAiatAZQovgduwpubydKE
   VplZ8Pbn/rrh5EEsVj5EXVQ3O1pcckBKlC7btxoKMRS/2trWotyW76xhS
   fRhmW/G4AJyWcu0F6qhWOBzCNW8pdF7TM8F35yxk3BdgyuahRoZwzVIKC
   OWwcPBs4kG7todM9oCRj8essBubsbmrJUIIl02qkkkiLKdl8bHSwJH3K7
   w==;
IronPort-SDR: dR2yBFopTP8K8gdbWwkSOmg1war9jFF2uoipH66agFSaECZFEhlIxaW8E4HY378cdTJnWDlLfD
 TWTG6yPeryScY36/3OVanE05FK3cVNeB+BRmI1R2UAsDBRfs0dwExoKu/NcHiWkXwZ+Un2yE+I
 spKag0Kl2mRdNvq8b5mjXKqwy2sZOuHBedxwiHOa0NMvA/X4jh8egmFEkSTEHsO+6+4Ec+KqLP
 t3qbOaS5ocf0JpcopoTgfhmRzfXA9SnmqgJpGTxfWSbInaTCPk3YXZm6xO1MWULyjvLt9gra3e
 QLU=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237648940"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 09:51:54 +0800
IronPort-SDR: SZY3gvXbhiS400swzDdxktz3O3V9jvm3HBRXJEz6T9xV1P+77g034AuBWNK0XsF85V6crMRvjK
 1JEgAK0/FUkeKpZgODwNb8ayulr9TOMk+4tc3mvFOBPIg4vQavOb4YYEwTS6Z9CAEN0pQypCsB
 O2JmXN/Js++UOEIP4e8XPLJXFqcdpQ7Cuvq0s9/6r1zMOxEY6azt83OQjhm4ysDX6UsQNKkWOq
 4/unpKQCdf33PoKOo+8kaUol5mWQsPThAimv4sdYZoGFMIOosDeJHDZOzFoGSGQfYNGjfqb8lJ
 byWYK+T5DVAgmydfzIbRXlzO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 17:44:44 -0800
IronPort-SDR: vKfKktzwYwi+ypxIVNxWzM/zlHW3uSimMaqbKtKbdKO70vA7bMVnMTUlPusid/gNySjqBhQfY1
 Ra2m4bJ/rccO9FHpqT5A3PF21wEucKS8s/JaBLZu00mnop74izIk+AW7Ev4WEJAiL5EpFDshUh
 tQpBrWDm7lTfqXBy5wSNiX0hxvjSm9arjdHhjn04/TyOKh7zB8YQSJynzodWWdLl3tvwRrvp6k
 sKHN4gkHvnTokDWAuEQVJA6mryzk6RDG4N0+hDl61pehi60+EMEGabbs0crcLT2ABYIciemfFL
 dYc=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 17:51:54 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v8 03/11] RISC-V: Add SBI v0.2 extension definitions
Date:   Tue, 11 Feb 2020 17:48:14 -0800
Message-Id: <20200212014822.28684-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212014822.28684-1-atish.patra@wdc.com>
References: <20200212014822.28684-1-atish.patra@wdc.com>
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
2.24.0

