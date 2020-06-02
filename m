Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29108C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8582074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OhqalJ2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgFBLu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:50:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37884 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgFBLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:50:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200602115051euoutp020b126c6c63a5b18287c9ad87ccdee418~Ut8sv-p0t0250302503euoutp02I
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:50:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200602115051euoutp020b126c6c63a5b18287c9ad87ccdee418~Ut8sv-p0t0250302503euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591098651;
        bh=I0Dn5BxzJ+CXY2oWZbgxWOBH4kPjXztDF8cgyoiRsiw=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=OhqalJ2NrcZNvb6+2JQcZrmCdk210myfkPYG9ZRknXvMXqxZFdidGKXjxiqFJeaqJ
         SkfnwNvHRJzLjwl0OROCdjRM/FqxgaZ71fzfTAYRG1qZMBgmBvUKsj7BsLA8fFgIQi
         GDtPz3WTTM469UM2qAEi7cbslu5atDeBDB9AO37M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200602115051eucas1p2427ab69d905703d29b3cabf4b7b29267~Ut8skURLL3250832508eucas1p2_;
        Tue,  2 Jun 2020 11:50:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C4.09.61286.B1D36DE5; Tue,  2
        Jun 2020 12:50:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602115051eucas1p235883fa1de4738974b6066f24c9351de~Ut8sSXGSp2118021180eucas1p24;
        Tue,  2 Jun 2020 11:50:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200602115051eusmtrp290e10a7da754d2a574a23a8f6bf576ef~Ut8sRyQX92574825748eusmtrp2w;
        Tue,  2 Jun 2020 11:50:51 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-66-5ed63d1b92b1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.14.07950.B1D36DE5; Tue,  2
        Jun 2020 12:50:51 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200602115050eusmtip267e0418b6b1a0734543180ef1c0a774e~Ut8r3Wjm20841708417eusmtip2o;
        Tue,  2 Jun 2020 11:50:50 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 1/2] video: fbdev: amifb: add FIXME about dead APUS
 support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com>
Date:   Tue, 2 Jun 2020 13:50:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87rSttfiDJpWS1hc+fqezeLZrb1M
        Fif6PrBaXN41h81i+ZO1zBbn/x5ndWDzOHS4g9HjfvdxJo+Trd9YPD5vkvPY9OQtUwBrFJdN
        SmpOZllqkb5dAlfGowNTmAsWc1dM3fCbpYFxAWcXIweHhICJxKaJ9l2MnBxCAisYJX41WXQx
        cgHZXxglLs07yQjhfGaU2PjpITtIFUjDgwcv2CESyxkleuYuZYFof8sosXsXmM0mYCUxsX0V
        I4gtLBAg8ef4S7C4iICDxJQbE8AGMQssYJTYcsgZxOYVsJP42LiJGcRmEVCR2L77EBOILSoQ
        IfHpwWFWiBpBiZMzn4DN4RTwlNjRe5kJYo64xK0n86FseYntb+cwgxwnIbCOXeL2jJVMEFe7
        SJx7u5oFwhaWeHV8C9Q3MhL/d4I0gzUwSvzteAHVvZ1RYvnkf2wQVdYSd879YgMFGLOApsT6
        XfoQYUeJMxdeMkHCkU/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZJzAqzULy
        2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBKad0/+Of9rB+PVS
        0iFGAQ5GJR5eA8NrcUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zmu86GWskEB6YklqdmpqQWoRTJaJg1OqgXGZsdvdVFMGJ36Puz2r63d++/dSas8vgxlZbd0K
        m5ctOLbq7OodVnfnmNvG8lw8draG7eP8ev39KjMXtf6/suWCp9Wj9n9+01jYU7NyUr/6BxYf
        eLmlk/U6w5xqpVUv+FdIRNUr9D26JTP3DdfjA3NXvTeYpTYhU/3kUd6vubVzf21cPi2urfKI
        EktxRqKhFnNRcSIAhvVaGjcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7rSttfiDGYeYLO48vU9m8WzW3uZ
        LE70fWC1uLxrDpvF8idrmS3O/z3O6sDmcehwB6PH/e7jTB4nW7+xeHzeJOex6clbpgDWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MRwemMBcs
        5q6YuuE3SwPjAs4uRk4OCQETiQcPXrCD2EICSxkl9v827mLkAIrLSBxfXwZRIizx51oXWxcj
        F1DJa0aJP8uWsIEk2ASsJCa2r2IEsYUF/CR2rL/FDGKLCDhITLkxgR2kgVlgAaPE2baDrBDd
        cxgldry6AdbBK2An8bFxE1gHi4CKxPbdh5hAbFGBCInDO2ZB1QhKnJz5hAXE5hTwlNjRexms
        hllAXeLPvEvMELa4xK0n86Hi8hLb385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6x
        kV5xYm5xaV66XnJ+7iZGYKxtO/Zzyw7GrnfBhxgFOBiVeHgNDK/FCbEmlhVX5h5ilOBgVhLh
        dTp7Ok6INyWxsiq1KD++qDQntfgQoynQcxOZpUST84FpIK8k3tDU0NzC0tDc2NzYzEJJnLdD
        4GCMkEB6YklqdmpqQWoRTB8TB6dUA2P6vZzCKfN5kmwsQ/eeS1d7F6HSyMgbIzHBP+lI+hnp
        Z0u39Up4ntqz4MCRq0JFQUHhSjmH5/5/lvrhC6v/ccXjxjrZzSndFxVbq68uXHYotan448nV
        5zxfMVSH77nv3uQh/iMvNXtjbpeoRuHLgxYmN3Kv/vAVkYlafajr1qcW4y+B6ouyGpVYijMS
        DbWYi4oTAXm2VwPLAgAA
X-CMS-MailID: 20200602115051eucas1p235883fa1de4738974b6066f24c9351de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200504232908eucas1p296927bc7c736ad924cefaea9a546459d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504232908eucas1p296927bc7c736ad924cefaea9a546459d
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
        <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:

> These #ifdefs are relics from APUS (Amiga Power-Up System), which
> added a PPC board.  APUS support was killed off a long time ago,
> when arch/ppc/ was still king, but these #ifdefs were missed, because
> they didn't test for CONFIG_APUS.

Add FIXME about using the C code variants (APUS ones) in the future.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- added FIXME comment instead of removing the C code variants

 drivers/video/fbdev/amifb.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/video/fbdev/amifb.c
===================================================================
--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -575,6 +575,12 @@ static u_short maxfmode, chipset;
 #define downx(x, v)	((v) & -(x))
 #define modx(x, v)	((v) & ((x) - 1))
 
+/*
+ * FIXME: Use C variants of the code marked with #ifdef __mc68000__
+ * in the driver. It shouldn't negatively affect the performance and
+ * is required for APUS support (once it is re-added to the kernel).
+ * Needs to be tested on the hardware though..
+ */
 /* if x1 is not a constant, this macro won't make real sense :-) */
 #ifdef __mc68000__
 #define DIVUL(x1, x2) ({int res; asm("divul %1,%2,%3": "=d" (res): \
