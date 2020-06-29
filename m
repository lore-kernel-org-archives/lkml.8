Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72411C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521DD206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Iro6T0LA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbgF2TTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:19:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10297 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgF2TS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:18:58 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200629110342epoutp046f1a3d2da5700b2819c41541f978e1d4~c-uPQ-tb30737007370epoutp04G
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:03:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200629110342epoutp046f1a3d2da5700b2819c41541f978e1d4~c-uPQ-tb30737007370epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593428622;
        bh=Zyhj8gV47zhrcYl9w/BuVya5Auwt/6potpNwZISDEnE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Iro6T0LA0FEeaP/a8LPbggWk77srCTly29D+WXVAxyML5kWMeLte5u0zk9m5MPnUH
         +wC6SRs0/XORL/2ZnJYqPCFgqJVTB5eFV2ifJDY1rCW9uJrlcEIkcAJ81cP/oRhYnT
         maKQQFpM15jcOHjvDs2LZr8g2R7O0v5KUZ/Tf/QM=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200629110342epcas5p255b8fe6e43fbfe29d7491d2dc5027e35~c-uPB55B80897608976epcas5p2S;
        Mon, 29 Jun 2020 11:03:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.FB.09703.E8AC9FE5; Mon, 29 Jun 2020 20:03:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200629110320epcas5p34ccccc7c293f077b34b350935c328215~c-t6zDjsu1432714327epcas5p3j;
        Mon, 29 Jun 2020 11:03:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200629110320epsmtrp1aae6e1dd9b08a88f838b831ddc11168a~c-t6ybuB01726217262epsmtrp1Q;
        Mon, 29 Jun 2020 11:03:20 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-d2-5ef9ca8e95c1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.A3.08382.87AC9FE5; Mon, 29 Jun 2020 20:03:20 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200629110319epsmtip2ee4f361c0e6349cad43a0b25433b5b4e~c-t50fakG0135001350epsmtip2C;
        Mon, 29 Jun 2020 11:03:19 +0000 (GMT)
From:   Anupam Aggarwal <anupam.al@samsung.com>
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Anupam Aggarwal <anupam.al@samsung.com>
Subject: [PATCH] fs: fat: add check for dir size in fat_calc_dir_size
Date:   Mon, 29 Jun 2020 16:32:39 +0530
Message-Id: <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCmpm7fqZ9xBmte81pc3J1q8b7hCrvF
        9LkbWCwu75rD5sDicf9tokffllWMHp83yQUwR3HZpKTmZJalFunbJXBlLLh3nLFgJ1fF8tUP
        WRoYj3J0MXJySAiYSBx808bexcjFISSwm1GiZ9lvRgjnE6NE2+xPzBDON0aJgwtfsMG0rL1w
        mQUisZdR4u61d1D9X4FaFp4Fq2IT0JWY+2I2K4gtIiAvcenQdSYQm1kgWaLn6WuwGmEBV4mH
        m56A2SwCqhL/fzUC1XBw8ALFZy+QgVgmJ3HzXCfYFRIC7ewSL7e/AquREHCRWH87CaJGWOLV
        8S3sELaUxMt+iH8kBPoZJbqWXWCFcGYwShzZs40Fospe4nVzA9ggZgFNifW79CHCshJTT62D
        upNPovf3EyaIOK/EjnkwtrLE1GuvWSFsSYnHna3MELaHxOTNU8GOEBKIlXg4bRL7BEbZWQgb
        FjAyrmKUTC0ozk1PLTYtMMpLLdcrTswtLs1L10vOz93ECI5iLa8djA8ffNA7xMjEwXiIUYKD
        WUmE97P1tzgh3pTEyqrUovz4otKc1OJDjNIcLErivEo/zsQJCaQnlqRmp6YWpBbBZJk4OKUa
        mKyrjkiuF1M4Wu1kGhzZXBLzy+GCzKFPwnlPs9KjP5Y9/fnNZTt3UqPQ9KU6fP5v98RHb16k
        8sXlwMUtpvNdlMTl35xIsndV/WW4RNq4lr187tI9P+9rsq1YIvfBKHr3oc1brylt+SQ7j6eS
        a+pOppVLRbv3FCb+VW37b5sYpHdjrqqQoJrqkX1BhvfPzPx7pbDchXHj1hqzG59EvrTr6T49
        eEYkpCCi/aCpz+n3F592z2n9VfaeX/SWidyD9XUc83csigotVO3fJGIyo3LBvJN8OmGGmyc/
        7LxYuq/648+ptd/DdV9qSKxkm7jwdfFRpzeuFxdel76lHbNSyun/m0kSArHpvjKWf3nLYs/c
        e63EUpyRaKjFXFScCAD5REVjUQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMJMWRmVeSWpSXmKPExsWy7bCSvG7FqZ9xBhcXyFlc3J1q8b7hCrvF
        9LkbWCwu75rD5sDicf9tokffllWMHp83yQUwR3HZpKTmZJalFunbJXBlLLh3nLFgJ1fF8tUP
        WRoYj3J0MXJySAiYSKy9cJmli5GLQ0hgN6PEsou9rBAJSYmm1xsYIWxhiZX/nrNDFH1mlLh6
        bTYLSIJNQFdi7ovZYA0iAvISlw5dZwKxmQVSJbbe+scGYgsLuEo83PQEzGYRUJX4/6sRqIaD
        gxcoPnuBDMR8OYmb5zqZJzDyLGBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwO
        Wpo7GLev+qB3iJGJg/EQowQHs5II72frb3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowT
        EkhPLEnNTk0tSC2CyTJxcEo1MNldmjT1XsOEomtVisHMyS9ZZ81YM+uq8sbnwhb/mr35VZOF
        Pssf8En8yvv4XIq161GnTX3JLPtLVzfa7LttdW67z+RjhnciLLpSFM6cu7+TefnWBffu1DT2
        8+1Vyei0+OjoK6ytN+OOI++bZdPu/2E+mHtAs2nz9ScTJPr81exOdnEvFxN8Zb9crO9wttmq
        N/pPjrdf4l7/asKVrzXNu3MWtaTfbvzxpfrQUoPsHbkHfsZuX+J4f3uQScbRL3cLJ05juvTl
        xyX9POk6nqUmXLvyTy67fPKwSOQ7LZXHQny2xqbyfEJhnRrdZ/kTzBf3dPPcneub87pj4neZ
        qXKTnk4rTFlwYDMHS4U9x/1wtlQlluKMREMt5qLiRADtARSPdgIAAA==
X-CMS-MailID: 20200629110320epcas5p34ccccc7c293f077b34b350935c328215
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200629110320epcas5p34ccccc7c293f077b34b350935c328215
References: <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max directory size of FAT filesystem is FAT_MAX_DIR_SIZE(2097152 bytes)
It is possible that, due to corruption, directory size calculated in
fat_calc_dir_size() can be greater than FAT_MAX_DIR_SIZE, i.e.
can be in GBs, hence directory traversal can take long time.
for example when command "ls -lR" is executed on corrupted FAT
formatted USB, fat_search_long() function will lookup for a filename from
position 0 till end of corrupted directory size, multiple such lookups
will lead to long directory traversal

Added sanity check for directory size fat_calc_dir_size(),
and return EIO error, which will prevent lookup in corrupted directory

Signed-off-by: Anupam Aggarwal <anupam.al@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 fs/fat/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a0cf99d..9b2e81e 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -490,6 +490,13 @@ static int fat_calc_dir_size(struct inode *inode)
 		return ret;
 	inode->i_size = (fclus + 1) << sbi->cluster_bits;
 
+	if (i_size_read(inode) > FAT_MAX_DIR_SIZE) {
+		fat_fs_error(inode->i_sb,
+			     "%s corrupted directory (invalid size %lld)\n",
+			     __func__, i_size_read(inode));
+		return -EIO;
+	}
+
 	return 0;
 }
 
-- 
1.9.1

