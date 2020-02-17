Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F31FC761A6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25634206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXEj8u0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgBQNHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:07:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726801AbgBQNHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581944832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SpKPc5A4+hoXgRo+kcenP9f+2YW/SXepj7eKuZO/ZZc=;
        b=GXEj8u0z86dBzZ7OE/NKDyWbUc021Nv9JALpEW6QP5qnaSibgJYAgB1BmvXf2+MlvhLfzs
        6QTk4cI+WK3qyrO9f/0rImHMtW3WYhhJFlJ8vMf+gx5xOA8NRHn2HEEn9FXXx/NCeMuUUl
        usZoaoJy8/wrPv3C7UdcGv3n+grHyRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-VqZ5xVpxMWy9vMr47c6tSg-1; Mon, 17 Feb 2020 08:07:08 -0500
X-MC-Unique: VqZ5xVpxMWy9vMr47c6tSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53F8A800D50;
        Mon, 17 Feb 2020 13:07:06 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFE882CC39;
        Mon, 17 Feb 2020 13:07:03 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: [PATCH v2] x86/mce: Do not log spurious corrected mce errors
Date:   Mon, 17 Feb 2020 08:06:59 -0500
Message-Id: <20200217130659.15895-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user has reported that they are seeing spurious corrected errors on
their hardware.

Intel Errata HSD131, HSM142, HSW131, and BDM48 report that
"spurious corrected errors may be logged in the IA32_MC0_STATUS register
with the valid field (bit 63) set, the uncorrected error field (bit 61)
not set, a Model Specific Error Code (bits [31:16]) of 0x000F, and
an MCA Error Code (bits [15:0]) of 0x0005."

Block these spurious errors from the console and logs.

Links to Intel Specification updates:
HSD131: https://www.intel.com/content/www/us/en/products/docs/processors/=
core/4th-gen-core-family-desktop-specification-update.html
HSM142: https://www.intel.com/content/www/us/en/products/docs/processors/=
core/4th-gen-core-family-mobile-specification-update.html
HSW131: https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1=
200v3-spec-update.html
BDM48: https://www.intel.com/content/www/us/en/products/docs/processors/c=
ore/5th-gen-core-family-spec-update.html

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Co-developed-by: Alexander Krupp <centos@akr.yagii.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-edac@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/core.c     |  2 ++
 arch/x86/kernel/cpu/mce/intel.c    | 17 +++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
index 2c4f949611e4..fe3983d551cc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1877,6 +1877,8 @@ bool filter_mce(struct mce *m)
 {
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
 		return amd_filter_mce(m);
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		return intel_filter_mce(m);
=20
 	return false;
 }
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/in=
tel.c
index 5627b1091b85..989148e6746c 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -520,3 +520,20 @@ void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
 }
+
+bool intel_filter_mce(struct mce *m)
+{
+	struct cpuinfo_x86 *c =3D &boot_cpu_data;
+
+	/* MCE errata HSD131, HSM142, HSW131, BDM48, and HSM142 */
+	if ((c->x86 =3D=3D 6) &&
+	    ((c->x86_model =3D=3D INTEL_FAM6_HASWELL) ||
+	     (c->x86_model =3D=3D INTEL_FAM6_HASWELL_L) ||
+	     (c->x86_model =3D=3D INTEL_FAM6_BROADWELL) ||
+	     (c->x86_model =3D=3D INTEL_FAM6_HASWELL_G)) &&
+	    (m->bank =3D=3D 0) &&
+	    ((m->status & 0xa0000000ffffffff) =3D=3D 0x80000000000f0005))
+		return true;
+
+	return false;
+}
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce=
/internal.h
index b785c0d0b590..821faba5b05d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -175,5 +175,6 @@ extern bool amd_filter_mce(struct mce *m);
 #else
 static inline bool amd_filter_mce(struct mce *m)			{ return false; };
 #endif
+extern bool intel_filter_mce(struct mce *m);
=20
 #endif /* __X86_MCE_INTERNAL_H__ */
--=20
2.21.1

