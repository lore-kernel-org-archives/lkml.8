Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D17C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811C2206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D22WaNKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgFOPwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:52:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820E1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:52:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b16so7976327pfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LDHKdOZuiHjwBF8MzXf4mUCeCAxqrzvnu0BpkW8c2/A=;
        b=D22WaNKyfpwiAppT1rpTwc2nkOKxkj+LseD69tnh617QcI87ziRuuj1J2n0n7UGW56
         GejOTMaUeICzHB8zdGaeK4wYrOVxwSgz8DUs/MDtvV/vZZjqnEg8n2bi/RzyA43XyllT
         DzLAphx3ihjWpLBI/cM79a+WXWN0Wtp8n4U5+tVzp0iE8fcqfz+ERvP1W12O9piwhSE1
         vojtdOOvH/6cslx/7hxCV38TdpmVieZX935BN7xbovOBP6Qo913OX33qOF/5rvJp9ksz
         HZdvw+gCK6zcFdpgVxYlpiNNLMZLKrEIsNE359W5h/LQgfKG7Ddlfe2PK8Bnigh561S9
         kQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LDHKdOZuiHjwBF8MzXf4mUCeCAxqrzvnu0BpkW8c2/A=;
        b=IubtA7HNSQ9QeJLZA4ne+VufXnvyPu55oFt0KR1rBKkLP52u3l+7UpSZ115iBB49py
         RteCIrzHjVOjR2w/Sodffk/vRm3081dRVt4tsdc1DioRj9ACvCBVSn+7W5rCazsXPBRA
         epWuU7f1EEfTMnhs9wyPHzhaAhClwGjqpeSU04Z/HeBAORzZVN73vlLxGMrcoCHrjLSf
         swb0WYgP21Be3/IiUVTOvBDmy7+wGA/GW983Vp1JdWVImr55oIuTqCEGvuhR6JNArL5e
         f5uQf0kzCA80uxdesO2oaYXAgGZy/XCsIiOBIndzbbKWBTvSYuCzgQe92S7HhjHfok/k
         dHgQ==
X-Gm-Message-State: AOAM531JK3pJUVlmCq4+p8fEce2czDswDoNm7dRlweaFGgLx0Pj7AwEm
        lED2D8qGrMljo0au15MpLhk=
X-Google-Smtp-Source: ABdhPJzprVyOh1KvX42FIMxyj8jg/sBLjwI2ds3N275fc0gWEeY9avgnUYQstck4eEI5Mn+th7QXmw==
X-Received: by 2002:a65:6715:: with SMTP id u21mr22749853pgf.365.1592236362124;
        Mon, 15 Jun 2020 08:52:42 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s30sm9394387pgn.34.2020.06.15.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:52:41 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: set master partition panic write flag
Date:   Mon, 15 Jun 2020 11:51:34 -0400
Message-Id: <20200615155134.32007-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check and set master panic write flag so that low level drivers
can use it to take required action to ensure oops data gets written
to assigned mtdoops device partition.

Fixes: 9f897bfdd89f ("mtd: Add flag to indicate panic_write")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/mtdcore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index b47691e1b81c..6efca96dc110 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1235,8 +1235,8 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		return -EROFS;
 	if (!len)
 		return 0;
-	if (!mtd->oops_panic_write)
-		mtd->oops_panic_write = true;
+	if (!master->oops_panic_write)
+		master->oops_panic_write = true;
 
 	return master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
 				    retlen, buf);
-- 
2.17.1

