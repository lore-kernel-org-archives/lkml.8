Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9DCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0139B207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=exactco.de header.i=@exactco.de header.b="n9TrCahZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHUNB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:01:58 -0400
Received: from mx.exactcode.de ([144.76.154.42]:58946 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgHUNBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:01:55 -0400
X-Greylist: delayed 1548 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 09:01:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:To:Message-Id:Date; bh=EZakprQURThyScfP48Tq8ctA9RQ6xHO0ZAnyTU/h0CI=;
        b=n9TrCahZbh3QFtbJbr1Yr1LaDvppcZN+wYZtvI/hVX6hTT5SfNWIgCCvJEK+Akm6R2puEmw0ltV38Pf5vgh14h6ov5eoF6+tMV+z3EK7L/MKno9KqQUgeglt+q2mt4naMWMKWQzlm5LDo3ziSl756zq0T8TFNU67ggr/duhuUaM=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1k96HX-0002kE-I8
        for linux-kernel@vger.kernel.org; Fri, 21 Aug 2020 12:36:31 +0000
Received: from [192.168.2.130] (helo=localhost)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1k95ys-0002O4-PH
        for linux-kernel@vger.kernel.org; Fri, 21 Aug 2020 12:17:16 +0000
Date:   Fri, 21 Aug 2020 14:35:53 +0200 (CEST)
Message-Id: <20200821.143553.1830499839841272707.rene@exactcode.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] zstd compressed firmware loading
From:   Rene Rebe <rene@exactcode.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now with zstd compressed kernel & initrd upstream, we would rather
compress everything with one type of compressor, so I added support
for zstd compressed firmware loading, too.

Tested on x86-64, sparc64 and mips64.

Signed-off-by: Ren=E9 Rebe <rene@exactcode.de>

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmwa=
re_loader/Kconfig
index 5b24f3959255..30d440bec257 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -169,6 +169,16 @@ config FW_LOADER_COMPRESS
 	  be compressed with either none or crc32 integrity check type (pass
 	  "-C crc32" option to xz command).
 =

+config FW_LOADER_COMPRESS_ZSTD
+	bool "Enable Zstd compressed firmware support"
+	select FW_LOADER_PAGED_BUF
+	select ZSTD_DECOMPRESS
+	help
+	  This option enables the support for loading Zstd compressed firmwar=
e
+	  files. The caller of firmware API receives the decompressed file
+	  content. The compressed file is loaded as a fallback, only after
+	  loading the raw file failed at first.
+
 config FW_CACHE
 	bool "Enable firmware caching during suspend"
 	depends on PM_SLEEP
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmwar=
e_loader/main.c
index 9da0c9d5f538..5deb73dbe81e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -33,7 +33,9 @@
 #include <linux/syscore_ops.h>
 #include <linux/reboot.h>
 #include <linux/security.h>
+#include <linux/decompress/mm.h>
 #include <linux/xz.h>
+#include <linux/zstd.h>
 =

 #include <generated/utsrelease.h>
 =

@@ -435,6 +437,140 @@ static int fw_decompress_xz(struct device *dev, s=
truct fw_priv *fw_priv,
 }
 #endif /* CONFIG_FW_LOADER_COMPRESS */
 =

+/*
+ * Zstd-compressed firmware support
+ */
+#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
+/* show an error and return the standard error code */
+static int handle_zstd_error(size_t ret)
+{
+	const int err =3D ZSTD_getErrorCode(ret);
+
+	if (!ZSTD_isError(ret))
+		return 0;
+
+	switch (err) {
+	case ZSTD_error_memory_allocation:
+		printk("ZSTD decompressor ran out of memory");
+		break;
+	case ZSTD_error_prefix_unknown:
+		printk("Input is not in the ZSTD format (wrong magic bytes)");
+		break;
+	case ZSTD_error_dstSize_tooSmall:
+	case ZSTD_error_corruption_detected:
+	case ZSTD_error_checksum_wrong:
+		printk("ZSTD-compressed data is corrupt");
+		break;
+	default:
+		printk("ZSTD-compressed data is probably corrupt");
+		break;
+	}
+	return -1;
+}
+
+/* single-shot decompression onto the pre-allocated buffer */
+static int fw_decompress_zstd_single(struct device *dev, struct fw_pri=
v *fw_priv,
+				   size_t in_size, const void *in_buffer)
+{
+	const size_t wksp_size =3D ZSTD_DCtxWorkspaceBound();
+	void *wksp =3D large_malloc(wksp_size);
+	ZSTD_DCtx *dctx =3D ZSTD_initDCtx(wksp, wksp_size);
+	int err;
+	size_t ret;
+
+	printk("zstd_single\n");
+
+	if (dctx =3D=3D NULL) {
+	        dev_warn(dev, "Out of memory while allocating ZSTD_DCtx");
+		err =3D -1;
+		goto out;
+	}
+	/* Find out how large the frame actually is, there may be junk at
+	 * the end of the frame that ZSTD_decompressDCtx() can't handle.
+	 */
+	ret =3D ZSTD_findFrameCompressedSize(in_buffer, in_size);
+	err =3D handle_zstd_error(ret);
+	if (err)
+		goto out;
+	in_size =3D (long)ret;
+
+	ret =3D ZSTD_decompressDCtx(dctx, fw_priv->data, fw_priv->allocated_s=
ize, in_buffer, in_size);
+	err =3D handle_zstd_error(ret);
+	if (err)
+		goto out;
+
+	fw_priv->size =3D ret;
+
+out:
+	if (wksp !=3D NULL)
+		large_free(wksp);
+	return err;
+}
+
+/* decompression on paged buffer and map it */
+static int fw_decompress_zstd_pages(struct device *dev, struct fw_priv=
 *fw_priv,
+				  size_t in_size, const void *in_buffer)
+{
+#if 0
+	struct zstd_dec *zstd_dec;
+	struct zstd_buf zstd_buf;
+	enum zstd_ret zstd_ret;
+	struct page *page;
+	int err =3D 0;
+
+	printk("zstd_pages\n");
+
+	zstd_dec =3D zstd_dec_init(ZSTD_DYNALLOC, (u32)-1);
+	if (!zstd_dec)
+		return -ENOMEM;
+
+	zstd_buf.in_size =3D in_size;
+	zstd_buf.in =3D in_buffer;
+	zstd_buf.in_pos =3D 0;
+
+	fw_priv->is_paged_buf =3D true;
+	fw_priv->size =3D 0;
+	do {
+		if (fw_grow_paged_buf(fw_priv, fw_priv->nr_pages + 1)) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+
+		/* decompress onto the new allocated page */
+		page =3D fw_priv->pages[fw_priv->nr_pages - 1];
+		zstd_buf.out =3D kmap(page);
+		zstd_buf.out_pos =3D 0;
+		zstd_buf.out_size =3D PAGE_SIZE;
+		zstd_ret =3D zstd_dec_run(zstd_dec, &zstd_buf);
+		kunmap(page);
+		fw_priv->size +=3D zstd_buf.out_pos;
+		/* partial decompression means either end or error */
+		if (zstd_buf.out_pos !=3D PAGE_SIZE)
+			break;
+	} while (zstd_ret =3D=3D ZSTD_OK);
+
+	err =3D fw_decompress_zstd_error(dev, zstd_ret);
+	if (!err)
+		err =3D fw_map_paged_buf(fw_priv);
+
+ out:
+	zstd_dec_end(zstd_dec);
+	return err;
+#endif
+	return -ENOMEM;
+}
+
+static int fw_decompress_zstd(struct device *dev, struct fw_priv *fw_p=
riv,
+			    size_t in_size, const void *in_buffer)
+{
+	/* if the buffer is pre-allocated, we can perform in single-shot mode=
 */
+	if (fw_priv->data)
+		return fw_decompress_zstd_single(dev, fw_priv, in_size, in_buffer);
+	else
+		return fw_decompress_zstd_pages(dev, fw_priv, in_size, in_buffer);
+}
+#endif /* CONFIG_FW_LOADER_COMPRESS_ZSTD */
+
 /* direct firmware loading support */
 static char fw_path_para[256];
 static const char * const fw_path[] =3D {
@@ -773,6 +909,11 @@ _request_firmware(const struct firmware **firmware=
_p, const char *name,
 		ret =3D fw_get_filesystem_firmware(device, fw->priv, ".xz",
 						 fw_decompress_xz);
 #endif
+#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
+	if (ret =3D=3D -ENOENT)
+		ret =3D fw_get_filesystem_firmware(device, fw->priv, ".zst",
+						 fw_decompress_zstd);
+#endif
 =

 	if (ret =3D=3D -ENOENT)
 		ret =3D firmware_fallback_platform(fw->priv, opt_flags);

-- =

  Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactcode.com | https://t2sde.org | https://rene.rebe.de
