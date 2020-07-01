Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CA6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270842077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K5CyJGPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGAXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:25:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31541 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgGAXZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:25:43 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200701232540epoutp021a5672ccc835bbba9253288f414f6437~dxIoMbcT60803308033epoutp02a
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:25:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200701232540epoutp021a5672ccc835bbba9253288f414f6437~dxIoMbcT60803308033epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593645940;
        bh=5bep2QhQ25PvkbHaJR7gObnvaxyWQ3Hj7Fmcb4WTXig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5CyJGPeO4mYALZp0tbNLCGDJNKjpZyRCKXWhwKHwJ3E0Y8fTzEh7gFHDRBfpPnYG
         detSPtORrWvyioqJkJyhs7YknXZAeerj6N88JOytrkxHS07tFq4eIzgbt/ykfW6dec
         qPMu9vwiWa+5YpMQ5+jz92Pjfj3qY1IcILuPkRHs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200701232539epcas1p17037f448dd655aa05cae95b35341e5ca~dxIntl9Wy1842918429epcas1p1X;
        Wed,  1 Jul 2020 23:25:39 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49xy5G4yPPzMqYkV; Wed,  1 Jul
        2020 23:25:38 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.C6.28578.27B1DFE5; Thu,  2 Jul 2020 08:25:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200701232538epcas1p1e1e682b31b736069e70f5799244e27d5~dxImG7gAj1844418444epcas1p1b;
        Wed,  1 Jul 2020 23:25:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200701232538epsmtrp1479099760c1dfae70f656c9adcaddf6a~dxImGGAx71659116591epsmtrp1-;
        Wed,  1 Jul 2020 23:25:38 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-98-5efd1b729403
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.0C.08382.17B1DFE5; Thu,  2 Jul 2020 08:25:37 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200701232537epsmtip255962a510a09792e521259c714fe4d77~dxIl6GWJn2598425984epsmtip2T;
        Wed,  1 Jul 2020 23:25:37 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     gregkh@linuxfoundation.org, sashal@kernel.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 5.7.y 3/5] exfat: call sync_filesystem for read-only remount
Date:   Thu,  2 Jul 2020 08:20:22 +0900
Message-Id: <20200701232024.2083-4-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701232024.2083-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7bCmrm6R9N84gzm96hbNi9ezWVy7/57d
        4vKuOWwWP6bXW2xac43NYsHGR4wObB47Z91l99i0qpPNY//cNewefVtWMXp83iQXwBqVY5OR
        mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
        KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY8Fp
        94KT3BW7lv1kb2A8ydnFyMkhIWAisebuJKYuRi4OIYEdjBJH/zUwQjifGCXu9fSzQjjfGCXW
        X//BBNOy4uccNhBbSGAvo8Sd+8lwHUtbbwB1cHCwCWhL/NkiClIjImAocePzNRaQGmaBZkaJ
        By0XmUESwgI+Erc3fGYFsVkEVCU+HulgAunlFbCW6DnmDrFLXmL1hgNg5ZwCNhLrzv0Hu05C
        4BC7xNPTE5khilwk+m6vZoOwhSVeHd/CDmFLSbzsb2MHmSkhUC3xcT9UeQejxIvvthC2scTN
        9RvATmYW0JRYv0sfIqwosfP3XEYQm1mAT+Ld1x5WiCm8Eh1tQhAlqhJ9lw5DQ0Raoqv9A9RS
        D4n7bxexQEKkn1Fi36vfLBMY5WYhbFjAyLiKUSy1oDg3PbXYsMAUObo2MYKTl5blDsbpbz/o
        HWJk4mA8xCjBwawkwnva4FecEG9KYmVValF+fFFpTmrxIUZTYNBNZJYSTc4Hps+8knhDUyNj
        Y2MLEzNzM1NjJXFeJ+sLcUIC6YklqdmpqQWpRTB9TBycUg1Mi5q3/l6ldmeZzn1O//Qj3bMk
        PRv3BzYWaS+rOFjoLyBdpq11f6f+nK11wjfNHz/cX3/sqtZ9Qf2j5g+E3l9xcjGYWLjlym/G
        LdkdEtnpHkKWPhwzFjtdazHZuM54xyGBlZ6PfB9uMVt3q3y+nYOI6Izc57Gr1gVftbRjX1r2
        3t77l9ftmTs0PG19AzK1thc1CwZ4PMgSWXyj86AzF+sRz7NanYlhIeI72G5O9yrj3e3M73er
        4BPfYwkfwcc1GYVPFCONetZ3CV6uuf3mp2HVsuraO5H5S98+/PmBW7hTdedLM4ckg+2OZ84+
        PFJ4iPEz+25jZstT90STp4Z7p6y/kBP0d8WF5knffzwyDvJTYinOSDTUYi4qTgQAO0qPPucD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJXrdQ+m+cwY+5NhbNi9ezWVy7/57d
        4vKuOWwWP6bXW2xac43NYsHGR4wObB47Z91l99i0qpPNY//cNewefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlbHgtHvBSe6KXct+sjcwnuTsYuTkkBAwkVjxcw5bFyMXh5DAbkaJhuc72CAS
        0hLHTpxh7mLkALKFJQ4fLoao+cAoceFVIxtInE1AW+LPFlEQU0TAWKL9axlICbNAO6PE7P+b
        2EHGCAv4SNze8JkVxGYRUJX4eKSDCaSeV8BaoueYO8QmeYnVGw4wg9icAjYS6879ZwSxhYBK
        Nl55yTKBkW8BI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgENPS3MG4fdUHvUOM
        TByMhxglOJiVRHhPG/yKE+JNSaysSi3Kjy8qzUktPsQozcGiJM57o3BhnJBAemJJanZqakFq
        EUyWiYNTqoEpa0Va28lNT959mNTdV5M6/8PJZxsulD/dHH+xPOrDpkzbDp71Var810WjUm5P
        9A5SK5MyP3984TVeg/cvU4J43yyf+YjvT89b6Zx+j7ilrIEM8w6I+Oqf27HwRa8gJ6+o11vd
        NbOFr7w+xSv2+IbB0rA72bfNz7y51L9FJ+JOwrrpliqn3OY7TjQSEjcwX7e8S4NP5U5tkH3f
        up/alxzZj5/Yeb7+UPk0m8Rnx9P6V5zoj91Tq8e74wO7kImw5+fvl1uOr3J+MXvvXtHwxV7X
        yiT5rPxVuqUmqBzgvhv3r/fn8UXuO+bdElBymPQr9ovAphNi14v2thsyb+G4pu32x+jff4sF
        TVrrJyQ9iOl5pMRSnJFoqMVcVJwIAFYM3gSgAgAA
X-CMS-MailID: 20200701232538epcas1p1e1e682b31b736069e70f5799244e27d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200701232538epcas1p1e1e682b31b736069e70f5799244e27d5
References: <20200701232024.2083-1-namjae.jeon@samsung.com>
        <CGME20200701232538epcas1p1e1e682b31b736069e70f5799244e27d5@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunchul Lee <hyc.lee@gmail.com>

We need to commit dirty metadata and pages to disk
before remounting exfat as read-only.

This fixes a failure in xfstests generic/452

generic/452 does the following:
cp something <exfat>/
mount -o remount,ro <exfat>

the <exfat>/something is corrupted. because while
exfat is remounted as read-only, exfat doesn't
have a chance to commit metadata and
vfs invalidates page caches in a block device.

Fixes: 719c1e182916 ("exfat: add super block operations")
Cc: stable@vger.kernel.org # v5.7
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 fs/exfat/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index c1b1ed306a48..e87980153398 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -637,10 +637,20 @@ static void exfat_free(struct fs_context *fc)
 	}
 }
 
+static int exfat_reconfigure(struct fs_context *fc)
+{
+	fc->sb_flags |= SB_NODIRATIME;
+
+	/* volume flag will be updated in exfat_sync_fs */
+	sync_filesystem(fc->root->d_sb);
+	return 0;
+}
+
 static const struct fs_context_operations exfat_context_ops = {
 	.parse_param	= exfat_parse_param,
 	.get_tree	= exfat_get_tree,
 	.free		= exfat_free,
+	.reconfigure	= exfat_reconfigure,
 };
 
 static int exfat_init_fs_context(struct fs_context *fc)
-- 
2.17.1

