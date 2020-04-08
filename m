Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E48EC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF792074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JcHa2qdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgDHJpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:45:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgDHJpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:45:31 -0400
Received: from zn.tnic (p200300EC2F0A9300FDE94558DB0629D0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9300:fde9:4558:db06:29d0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 020E81EC0C89;
        Wed,  8 Apr 2020 11:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586339130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=NZoFPElFRpFdYyVeMbyRXXC+sgo8u8TwoA+gn+mRgIk=;
        b=JcHa2qdcDyD7o1xqkUqSykn8d/yFHAT2qyXV5Ac1iWKzhuis4RnljDiCGXqzd0tMzIYFUN
        3Lrp5wN/J3sauwJdnD/E1LUnXl594hKWYeNdGOSPyDy0I5Cg8ia14dutgQFiinD9pifULb
        wIIReKxn0PyY1a1/7mgvhKuoEl6nDHw=
Date:   Wed, 8 Apr 2020 11:45:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Export fw_get_builtin_firmware()?
Message-ID: <20200408094526.GC24663@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

so I've come across this recently where the microcode loader
has a trivial helper get_builtin_firmware() which scans through
the builtin firmware to find microcode in there. Looking at
fw_get_builtin_firmware(), that one does practically the same so how
about I export it and have the microcode loader use it instead of
homegrowing the same thing?

IOW, something like this below?

If you agree with the approach, I'll split it properly into patches,
etc, of course.

Thx.

---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1edf788d301c..4a1918963564 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1295,7 +1295,7 @@ config MICROCODE
 	bool "CPU microcode loading support"
 	default y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
-	select FW_LOADER
+	depends on FW_LOADER=y
 	---help---
 	  If you say Y here, you will be able to update the microcode on
 	  Intel and AMD processors. The Intel support is for the IA32 family,
@@ -1317,7 +1317,6 @@ config MICROCODE_INTEL
 	bool "Intel microcode loading support"
 	depends on MICROCODE
 	default MICROCODE
-	select FW_LOADER
 	---help---
 	  This options enables microcode patch loading support for Intel
 	  processors.
@@ -1329,7 +1328,6 @@ config MICROCODE_INTEL
 config MICROCODE_AMD
 	bool "AMD microcode loading support"
 	depends on MICROCODE
-	select FW_LOADER
 	---help---
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 2b7cc5397f80..4f10089f30de 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -131,15 +131,12 @@ int __init microcode_init(void);
 extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
 void reload_early_microcode(void);
-extern bool get_builtin_firmware(struct cpio_data *cd, const char *name);
 extern bool initrd_gone;
 #else
 static inline int __init microcode_init(void)			{ return 0; };
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
 static inline void reload_early_microcode(void)			{ }
-static inline bool
-get_builtin_firmware(struct cpio_data *cd, const char *name)	{ return false; }
 #endif
 
 #endif /* _ASM_X86_MICROCODE_H */
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3f6b137ef4e6..498781162364 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -457,17 +457,23 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_p
 
 static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
 {
-#ifdef CONFIG_X86_64
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
+	struct firmware fw;
+
+	if (IS_ENABLED(CONFIG_X86_32))
+		return false;
 
 	if (family >= 0x15)
 		snprintf(fw_name, sizeof(fw_name),
 			 "amd-ucode/microcode_amd_fam%.2xh.bin", family);
 
-	return get_builtin_firmware(cp, fw_name);
-#else
+	if (fw_get_builtin_firmware(&fw, fw_name, NULL, 0)) {
+		cp->size = fw.size;
+		cp->data = (void *)fw.data;
+		return true;
+	}
+
 	return false;
-#endif
 }
 
 static void __load_ucode_amd(unsigned int cpuid_1_eax, struct cpio_data *ret)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b2df0c..d1c46d2aec12 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -140,25 +140,6 @@ static bool __init check_loader_disabled_bsp(void)
 	return *res;
 }
 
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
-
-bool get_builtin_firmware(struct cpio_data *cd, const char *name)
-{
-#ifdef CONFIG_FW_LOADER
-	struct builtin_fw *b_fw;
-
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
-		if (!strcmp(name, b_fw->name)) {
-			cd->size = b_fw->size;
-			cd->data = b_fw->data;
-			return true;
-		}
-	}
-#endif
-	return false;
-}
-
 void __init load_ucode_bsp(void)
 {
 	unsigned int cpuid_1_eax;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6a99535d7f37..360a1ff142dc 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -499,6 +499,7 @@ static void save_mc_for_early(u8 *mc, unsigned int size)
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
+	struct firmware fw;
 	char name[30];
 
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -509,7 +510,13 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 	sprintf(name, "intel-ucode/%02x-%02x-%02x",
 		      x86_family(eax), x86_model(eax), x86_stepping(eax));
 
-	return get_builtin_firmware(cp, name);
+	if (fw_get_builtin_firmware(&fw, name, NULL, 0)) {
+		cp->size = fw.size;
+		cp->data = (void *)fw.data;
+		return true;
+	}
+
+	return false;
 }
 
 /*
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 76f79913916d..d0ad1ff0ce6d 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -106,8 +106,8 @@ static void fw_copy_to_prealloc_buf(struct firmware *fw,
 	memcpy(buf, fw->data, fw->size);
 }
 
-static bool fw_get_builtin_firmware(struct firmware *fw, const char *name,
-				    void *buf, size_t size)
+bool fw_get_builtin_firmware(struct firmware *fw, const char *name, void *buf,
+			     size_t size)
 {
 	struct builtin_fw *b_fw;
 
@@ -137,13 +137,6 @@ static bool fw_is_builtin_firmware(const struct firmware *fw)
 
 #else /* Module case - no builtin firmware support */
 
-static inline bool fw_get_builtin_firmware(struct firmware *fw,
-					   const char *name, void *buf,
-					   size_t size)
-{
-	return false;
-}
-
 static inline bool fw_is_builtin_firmware(const struct firmware *fw)
 {
 	return false;
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 4bbd0afd91b7..6f6dc52a9e60 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -56,6 +56,8 @@ int request_firmware_into_buf(const struct firmware **firmware_p,
 	const char *name, struct device *device, void *buf, size_t size);
 
 void release_firmware(const struct firmware *fw);
+bool fw_get_builtin_firmware(struct firmware *fw, const char *name,
+			     void *buf, size_t size);
 #else
 static inline int request_firmware(const struct firmware **fw,
 				   const char *name,
@@ -103,6 +105,13 @@ static inline int request_firmware_into_buf(const struct firmware **firmware_p,
 	return -EINVAL;
 }
 
+static inline bool fw_get_builtin_firmware(struct firmware *fw,
+					   const char *name, void *buf,
+					   size_t size)
+{
+	return false;
+}
+
 #endif
 
 int firmware_request_cache(struct device *device, const char *name);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
