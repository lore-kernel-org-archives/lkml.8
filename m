Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E5C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57120768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd1Bchu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgDFQKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:10:02 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35457 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgDFQKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:10:02 -0400
Received: by mail-pj1-f67.google.com with SMTP id g9so49953pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WkoK9eOo3jxX/ZMr07VW5CQfweVLKsOKrOBu3dllxs=;
        b=cd1Bchu2c9ROFaCpeTSYw8aDQj9D/amAIE3E5AJ2sk4uajkqPr0368tcgzvZNw/gd5
         A5KYbrIqj/6UHQdd420rCelaobfdCCx4exj75OWcKjgo9FWDqLL86GXRqLr/REYm7agu
         yQaexJqpfpP4jwbfEng5PlTVd8EWJ4g7mmxmotOdgL71Nn4cd68f2DIL6NYQNH0/Xw1S
         QLGYGGRfSDmUPLI1yI9Ga1IVA4OTZS/2QltXrHv4zRhsAzILKPbfzYUpOgfgRrBiZupF
         hKK8GHidAfqbbaYqeEqJtbwkxSJbFiWGvptuwMeIAxHUNHkw6W+aOozPmVkYo6V/h8yG
         +Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WkoK9eOo3jxX/ZMr07VW5CQfweVLKsOKrOBu3dllxs=;
        b=BDci9y5TbJp58OCJBDwIx7aT+xQZrQdDW+E+ulDBLffSMS/iuEVyww4ND2zBfsWlkM
         z7nO5Pkoi/CqTBdqDWlVIszQtRgo7gfhsL+eQzCu9Of/CiSUlt83OHjWl5Fv2KD+HoIQ
         xXeQ1fj/RcUD21Rt/DhMbp6oA1Ml+t4xwTYqFVmakmkoRYyu7VHCHS7jTi3wRbh1Rali
         5cosCGcgZ0gjf8mqNzlz0XUx3l8EMwdGwyrZrIjRo09RnzX49R7fkIzbgsTkhLwBDomJ
         QcFqx5fpCKTZw9yr6m4tDkx3gRySR07teEcfYVgoh15WlrrnY9Sc64Q6DBAbIEL+LrnI
         CrJA==
X-Gm-Message-State: AGi0PuakDIsd9PS2asCuqU1ZoFHQdJC3LLQBNFwnYQDxEaZ3qiAiocgH
        J+LugvcYHrW+eDOqVQcRKAI=
X-Google-Smtp-Source: APiQypLW2+hk2HRhI7Td9Jl9Sdkz5Z5glDoXOKZEYa0pW703MJ9vJ5kxV4E+ghEwKkJw4Cv7ZtixkA==
X-Received: by 2002:a17:90a:8909:: with SMTP id u9mr3007pjn.149.1586189401046;
        Mon, 06 Apr 2020 09:10:01 -0700 (PDT)
Received: from minnich.svl.corp.google.com ([2620:15c:2c5:3:65f9:fd8e:a0b8:2917])
        by smtp.googlemail.com with ESMTPSA id y3sm5242416pfy.6.2020.04.06.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:10:00 -0700 (PDT)
From:   "Ronald G. Minnich" <rminnich@gmail.com>
X-Google-Original-From: "Ronald G. Minnich" <rminnich@google.com>
To:     miquel.raynal@bootlin.com, rminnich@google.com, richard@nod.at,
        vigneshr@ti.com, linus.walleij@linaro.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: parsers: Support '[]' for id in mtdparts
Date:   Mon,  6 Apr 2020 09:09:14 -0700
Message-Id: <20200406160914.14698-1-rminnich@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MTD subsystem can support command-line defined partitions
for one or more MTD devices.

The format is:
 * mtdparts=<mtddef>[;<mtddef]
 * <mtddef>  := <mtd-id>:<partdef>[,<partdef>]

The ':' separates the id from the partdef.

On PCI MTD devices, the name can be the PCI slot name,
e.g. 0000:00:1f.5. There are two ':' in the name alone.

Change the definition of <mtd-id> so it can be bracketed
with '[]' and hence contain any number of ':'.
An opening '[' must be matched with a closing ']'.
The ':' continues to separate the mtd-id from the <partdef>.

Signed-off-by: Ronald G. Minnich <rminnich@google.com>
Change-Id: I17a757e65f532b11606c7bb104f08837bcd444b9
---
 drivers/mtd/parsers/cmdlinepart.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/parsers/cmdlinepart.c b/drivers/mtd/parsers/cmdlinepart.c
index c86f2db8c882..ef9dc0bd7724 100644
--- a/drivers/mtd/parsers/cmdlinepart.c
+++ b/drivers/mtd/parsers/cmdlinepart.c
@@ -10,7 +10,8 @@
  * mtdparts=<mtddef>[;<mtddef]
  * <mtddef>  := <mtd-id>:<partdef>[,<partdef>]
  * <partdef> := <size>[@<offset>][<name>][ro][lk]
- * <mtd-id>  := unique name used in mapping driver/device (mtd->name)
+ * <mtd-id>  := unique name used in mapping driver/device (mtd->name) |
+ *              '[' unique name as above, not including a "]" ']'
  * <size>    := standard linux memsize OR "-" to denote all remaining space
  *              size is automatically truncated at end of device
  *              if specified or truncated size is 0 the part is skipped
@@ -221,14 +222,38 @@ static int mtdpart_setup_real(char *s)
 		char *p, *mtd_id;
 
 		mtd_id = s;
+		mtd_id_len = 0;
+		p = s;
 
-		/* fetch <mtd-id> */
+		/*
+		 * fetch <mtd-id>
+		 * If the first char is '[',
+		 * the form is [mtd-id]:
+		 * otherwise it is mtd-id:
+		 */
+		if (*s == '[') {
+			mtd_id++;
+			p = strchr(s, ']');
+			if (!p) {
+				pr_err("mtd (%s) has '[' but no ']'", s);
+				return -EINVAL;
+			}
+			mtd_id_len = p - mtd_id;
+		}
+
+		/* There is always a : following mtd-id. */
 		p = strchr(s, ':');
 		if (!p) {
 			pr_err("no mtd-id\n");
 			return -EINVAL;
 		}
-		mtd_id_len = p - mtd_id;
+
+		/*
+		 * If the mtd-id was bracketed, mtd_id_len will be valid.
+		 * If it is still 0, we must set it here.
+		 */
+		if (mtd_id_len == 0)
+			mtd_id_len = p - mtd_id;
 
 		dbg(("parsing <%s>\n", p+1));
 
-- 
2.26.0.292.g33ef6b2f38-goog

