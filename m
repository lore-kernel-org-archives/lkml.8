Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36914C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0508A24656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CjSW1qUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgA1C2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:28:09 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43151 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgA1C2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580178489; x=1611714489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvujFwzpw9mkwEK+Mb1EePlXzqe88waJ7+oOaZrzSZk=;
  b=CjSW1qUab4V1q05u9rClX1ZLfaTwRa5VT4bJ1QvPh9DdQ8+rbtgJd/ji
   EqShK7RhM7bHkfv0oOhFn+HPA58N4oLKJgBkikY6VwrTEcEyGqIs7hIDE
   qysFRrdafFCx2Zy2VtLXwl+OwgnAUr/WF38xxyDut1NxbSJuljH0WjzIX
   DHcaAUkmGADaoy0toN/iya4JtiFUn3wChDlLO0VunWVGA/JJMuwaXXQQv
   goCkA0ctOQ1db6rT1ob1fmC5FJLeqNspJIeF++m/weJNIrSSBDfDVOxYq
   0Zp1Ag4goIsIyYbZYsgj2NfJ12IkgYqyIpi4SmX9Klym0FSKKSUYC7fLK
   Q==;
IronPort-SDR: eKAjDLgce5Y84HxUAXPA/AMqEot9Khn4lUY7u5JO92l2xDJJBZCwASbzaj+mzjDj+UFZ+zvqDT
 cH5WioKv/nVmF71GPbk2zTWoO90Tg0MGXXmJ4Z5POFpJkGoR75lTCXh3rkUdm+ci/ljKEAIhst
 HKvv+czwpqFcU1aUeWcgI1YcakQTUs4R+5z9BxrtbdZxf6iFKyLaiXKf8b/VX33hXE35EaMHkD
 34sIVdMOSM3OvD6JYuSpSATyWrfCCaqFTrfho8gGTkkZA5vGRJCrD82KNsKxOuvJFeUqa8rI8n
 cAQ=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; 
   d="scan'208";a="132899386"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 10:28:08 +0800
IronPort-SDR: G0jvzhw6MbGSDbDnLe6d7PhhvYoczKzKyFF/zjGcGTBYqK4Vu9Lp8c00Bq7X6S6syEv2hZqFGb
 0n1HDp2+SpS1Iv4nHKp68OZXkWvTahQ2Yocc17IJZNwpZ076wUV8BVSiD9/263jU1a4LMjSQWZ
 IRn9rLLDf5AIAlvdabMvR6a/eeB85mPFhHgZWRVTjZkxrMpcBWl6FFZsh6aR0Q4PIst5mSTLYm
 Yh4U+hCzmC/fghaYbA62vhzAqAmBVSX2ZHAGs9eQ7hVXIRbisyJBxmIlXCGZTkVJ5XxuLLnoqm
 T4Go6VqIf6zsSMonLC/Mei/1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 18:21:23 -0800
IronPort-SDR: jivIRt622RQuixUOnWng3LUuJnbJKVVQ7qUtWG71Bi5J48/9e8Mnl9BYKcQdKhqHgk7r3Mp9y+
 jjn3B4NiG2HneNnX1rXIkI1M8omt7FDie45rn4J34qruD7wUpIsyKkvu5jkFiR7Xjrj/W9B0B1
 fRAlDcnJFF32FP1PXXXlEmkvcHYV9F6V+y8FbTcmyFJIl3JmgTGY+rgPhiLk7OPujECPwFXOJp
 dXFxH+5yiBQy6SJM0pPhteEOaxxY/cWLVWsEBktvTgoywkvuD11kiL60cweP1OnEekKKFLiIN9
 6sU=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2020 18:28:08 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>, abner.chang@hpe.com,
        clin@suse.com, nickhu@andestech.com
Subject: [PATCH v7 03/10] RISC-V: Add SBI v0.2 extension definitions
Date:   Mon, 27 Jan 2020 18:27:30 -0800
Message-Id: <20200128022737.15371-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200128022737.15371-1-atish.patra@wdc.com>
References: <20200128022737.15371-1-atish.patra@wdc.com>
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

