Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF440C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F53208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055648;
	bh=AOHyuhvzktPTttvJSEAEVR9ETVavf3UqYS6NfIBpBsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SazkCq5PYcA8+3Ljeg4picS/rUSvpxjzKJ+7Ym9Us52fJt13mn18+IndBKvO2reLT
	 GVdcfTCM0a3AdpDTN6ZGBYPTNtWjkUXcAMoU/6F2m4jd/wWObkXyihboSH7gTv0LOs
	 Vx5Ufd/LotOPAnCWahov8O4p43ZttyCM9KaUBzNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgCXNOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbgCXNOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:14:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1430620775;
        Tue, 24 Mar 2020 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055644;
        bh=AOHyuhvzktPTttvJSEAEVR9ETVavf3UqYS6NfIBpBsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neE0x3xV6FxOnTxmhJN55D0qqzENmVmyOVSOgO1dgdQ7DPU6jYIP08YIotLMjnj7u
         ohOJhutYBBH/I0lDe50r174Mj4w0W2bObW59e1IBbeA62TjCwCPTPbN0MthYgR68MN
         IvVb25YQjfaIYX1MEKlGCDogAoIU+c1QOXNrIRWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Igor M. Liplianin" <liplianin@netup.ru>,
        Daniel Axtens <dja@axtens.net>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/65] altera-stapl: altera_get_note: prevent write beyond end of key
Date:   Tue, 24 Mar 2020 14:10:31 +0100
Message-Id: <20200324130758.048261828@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Axtens <dja@axtens.net>

[ Upstream commit 3745488e9d599916a0b40d45d3f30e3d4720288e ]

altera_get_note is called from altera_init, where key is kzalloc(33).

When the allocation functions are annotated to allow the compiler to see
the sizes of objects, and with FORTIFY_SOURCE, we see:

In file included from drivers/misc/altera-stapl/altera.c:14:0:
In function ‘strlcpy’,
    inlined from ‘altera_init’ at drivers/misc/altera-stapl/altera.c:2189:5:
include/linux/string.h:378:4: error: call to ‘__write_overflow’ declared with attribute error: detected write beyond size of object passed as 1st parameter
    __write_overflow();
    ^~~~~~~~~~~~~~~~~~

That refers to this code in altera_get_note:

    if (key != NULL)
            strlcpy(key, &p[note_strings +
                            get_unaligned_be32(
                            &p[note_table + (8 * i)])],
                    length);

The error triggers because the length of 'key' is 33, but the copy
uses length supplied as the 'length' parameter, which is always
256. Split the size parameter into key_len and val_len, and use the
appropriate length depending on what is being copied.

Detected by compiler error, only compile-tested.

Cc: "Igor M. Liplianin" <liplianin@netup.ru>
Signed-off-by: Daniel Axtens <dja@axtens.net>
Link: https://lore.kernel.org/r/20200120074344.504-2-dja@axtens.net
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/202002251042.D898E67AC@keescook
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/altera-stapl/altera.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index d2ed3b9728b7c..94bde09d9323d 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2126,8 +2126,8 @@ static int altera_execute(struct altera_state *astate,
 	return status;
 }
 
-static int altera_get_note(u8 *p, s32 program_size,
-			s32 *offset, char *key, char *value, int length)
+static int altera_get_note(u8 *p, s32 program_size, s32 *offset,
+			   char *key, char *value, int keylen, int vallen)
 /*
  * Gets key and value of NOTE fields in the JBC file.
  * Can be called in two modes:  if offset pointer is NULL,
@@ -2184,7 +2184,7 @@ static int altera_get_note(u8 *p, s32 program_size,
 						&p[note_table + (8 * i) + 4])];
 
 				if (value != NULL)
-					strlcpy(value, value_ptr, length);
+					strlcpy(value, value_ptr, vallen);
 
 			}
 		}
@@ -2203,13 +2203,13 @@ static int altera_get_note(u8 *p, s32 program_size,
 				strlcpy(key, &p[note_strings +
 						get_unaligned_be32(
 						&p[note_table + (8 * i)])],
-					length);
+					keylen);
 
 			if (value != NULL)
 				strlcpy(value, &p[note_strings +
 						get_unaligned_be32(
 						&p[note_table + (8 * i) + 4])],
-					length);
+					vallen);
 
 			*offset = i + 1;
 		}
@@ -2463,7 +2463,7 @@ int altera_init(struct altera_config *config, const struct firmware *fw)
 			__func__, (format_version == 2) ? "Jam STAPL" :
 						"pre-standardized Jam 1.1");
 		while (altera_get_note((u8 *)fw->data, fw->size,
-					&offset, key, value, 256) == 0)
+					&offset, key, value, 32, 256) == 0)
 			printk(KERN_INFO "%s: NOTE \"%s\" = \"%s\"\n",
 					__func__, key, value);
 	}
-- 
2.20.1



