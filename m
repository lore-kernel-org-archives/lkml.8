Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3571AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094B22083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589840059;
	bh=onfFTV2EHN95M3D7dQOFHRH3PPQXSDCcX3o8p3KOPZ0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ni2JsoCoKsKgJBzWftaGHfUju0H3jA0DdNySWGr0QygM8O4gd9SF6prHBT2DUAkJ7
	 A4Qf0HEi8sfwm8Dwj/w79uXDJ5/faaeSVC5Jf6Nz5t2BZqUoxd1Y9k/JufuQ9WpbT7
	 V32TCWGCI2vUafBuYPyUs5A24jpqeMrY4nhd4jNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgERWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:32874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgERWOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:14:18 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2062081A;
        Mon, 18 May 2020 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589840057;
        bh=onfFTV2EHN95M3D7dQOFHRH3PPQXSDCcX3o8p3KOPZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=ZRWpi2SmYbpuYdb5oz+hDLU8XiiN4QEZj2hJutTRJftiKi1WLPyBj7tPr9UzuoBwS
         VO6qxp10IIaWhM85ElMDSGVMilvYdd2XmeQ/Nyl4U63CWKMUpry0y9pg+dy2yC7PEX
         3C5oLaFwGgIUbzZeStStjKDxlFAWo+VT8ykoUIq4=
Date:   Mon, 18 May 2020 17:19:04 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] soc: fsl: qe: Replace one-element array and use
 struct_size() helper
Message-ID: <20200518221904.GA22274@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of one-element arrays in the following
form:

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

but the preferred mechanism to declare variable-length types such as
these ones is a flexible array member[1][2], introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on. So, replace
the one-element array with a flexible-array member.

Also, make use of the new struct_size() helper to properly calculate the
size of struct qe_firmware.

This issue was found with the help of Coccinelle and, audited and fixed
_manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/soc/fsl/qe/qe.c | 4 ++--
 include/soc/fsl/qe/qe.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 447146861c2c1..2df20d6f85fa4 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -448,7 +448,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	unsigned int i;
 	unsigned int j;
 	u32 crc;
-	size_t calc_size = sizeof(struct qe_firmware);
+	size_t calc_size;
 	size_t length;
 	const struct qe_header *hdr;
 
@@ -480,7 +480,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	}
 
 	/* Validate the length and check if there's a CRC */
-	calc_size += (firmware->count - 1) * sizeof(struct qe_microcode);
+	calc_size = struct_size(firmware, microcode, firmware->count);
 
 	for (i = 0; i < firmware->count; i++)
 		/*
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index e282ac01ec081..3feddfec9f87d 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -307,7 +307,7 @@ struct qe_firmware {
 		u8 revision;		/* The microcode version revision */
 		u8 padding;		/* Reserved, for alignment */
 		u8 reserved[4];		/* Reserved, for future expansion */
-	} __attribute__ ((packed)) microcode[1];
+	} __packed microcode[];
 	/* All microcode binaries should be located here */
 	/* CRC32 should be located here, after the microcode binaries */
 } __attribute__ ((packed));
-- 
2.26.2

