Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAA7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B6F2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b2ReVjeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgFBLwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:52:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60236 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgFBLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:52:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200602115214euoutp01fdae2ff0687a588a95c5ba6b77afae9a~Ut95w7_zi0115001150euoutp01P
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:52:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200602115214euoutp01fdae2ff0687a588a95c5ba6b77afae9a~Ut95w7_zi0115001150euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591098734;
        bh=DFymYLd+WxEKwPEsz1W/bGa1Yq98RkN02bjpEnWFsTI=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=b2ReVjeCHIbTEYLUNo7df+Ejz6XJk0/Ccdc8vOpFl0fsiA8cUHYj/N6QTpK+TFrd5
         gCBBAwkOtprApXI9BUNfrRBkwqJsYtAvhXeMGDNzx/Y9iCgyNh1KJ8RX5dxTzQrhhw
         +LMqZJ82sjEL2Ce4rkhavDoCcfnjvjpJznYdUPt8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200602115214eucas1p1ba66739f7837d7083674aa6543cdb6a4~Ut95oRZM40113401134eucas1p14;
        Tue,  2 Jun 2020 11:52:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AA.39.61286.E6D36DE5; Tue,  2
        Jun 2020 12:52:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602115213eucas1p2a9a2ebb2afccca0354cf196caf762c81~Ut95XPpzJ2114421144eucas1p2H;
        Tue,  2 Jun 2020 11:52:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200602115213eusmtrp22e94988dfefaa16a48822c76e001af9f~Ut95WrdIp2672126721eusmtrp2H;
        Tue,  2 Jun 2020 11:52:13 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-79-5ed63d6e409c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7D.4A.08375.D6D36DE5; Tue,  2
        Jun 2020 12:52:13 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200602115213eusmtip1bf6e913a99c16fcd84809478e5a5e394~Ut95AXli90275702757eusmtip1h;
        Tue,  2 Jun 2020 11:52:13 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/2] video: fbdev: amifb: add FIXMEs about
 {put,get}_user() failures
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <380c0494-ed02-b2be-65b0-d385627fb894@samsung.com>
Date:   Tue, 2 Jun 2020 13:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87p5ttfiDL7s5ba48vU9m8WzW3uZ
        LE70fWC1uLxrDpvF8idrmS3O/z3O6sDmcehwB6PH/e7jTB4nW7+xeHzeJOex6clbpgDWKC6b
        lNSczLLUIn27BK6MM8cPMhUs4qyY/vsEawPjNvYuRk4OCQETiQ/nJrGB2EICKxglvr0p7WLk
        ArK/MErsuNbGBOF8ZpRYsGwWXMe0llY2iMRyRokDT7YzQzhvGSVmv1kFVsUmYCUxsX0VI4gt
        LBApMfFiA9gOEQEHiSk3JoDVMAssYJTYcsgZxOYVsJN4/WAfM4jNIqAicfjpEzBbVCBC4tOD
        w6wQNYISJ2c+YQGxOQU8JXb0XmaCmCMucevJfChbXmL72zlgB0kIrGOXOHnzFdAyDiDHReLq
        IimID4QlXh3fAvWNjMT/nfOZoOoZJf52vIBq3s4osXzyPzaIKmuJO+d+sYEMYhbQlFi/Sx8i
        7Chx5sJLJoj5fBI33gpC3MAnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbtXMk8gVFpFpLPZiH5
        ZhaSb2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMPGc/nf80w7Gr5eSDjEK
        cDAq8fAaGF6LE2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNF
        L2OFBNITS1KzU1MLUotgskwcnFINjOZbnVs5tvH0Wtg0MMnebKmUXvpTQDREqn1pI9c/SaPe
        2/Lzi4N1jiUaHZzxvJXvYG/dS1bDq5W2O/MmdWwOiVvzuK9kR60bsylrQP73uRpyLCJZrEqG
        V/g23Xl8o9a45t9nRx3PHVNZjPqcZyQJ837c5vSnOvlywqQ7D0XZ96mfWXz+laKrEktxRqKh
        FnNRcSIAnQ8NdjgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xu7q5ttfiDHbcM7O48vU9m8WzW3uZ
        LE70fWC1uLxrDpvF8idrmS3O/z3O6sDmcehwB6PH/e7jTB4nW7+xeHzeJOex6clbpgDWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MM8cPMhUs
        4qyY/vsEawPjNvYuRk4OCQETiWktrWxdjFwcQgJLGSXuNc8CcjiAEjISx9eXQdQIS/y51gVV
        85pR4t3v/YwgCTYBK4mJ7avAbGGBSIlXR6+xgNgiAg4SU25MYAdpYBZYwChxtu0gK0T3HEaJ
        Ha9ugHXwCthJvH6wjxnEZhFQkTj89AmYLSoQIXF4xyyoGkGJkzOfgE3lFPCU2NF7mQnEZhZQ
        l/gz7xIzhC0ucevJfKi4vMT2t3OYJzAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFec
        mFtcmpeul5yfu4kRGG3bjv3cvIPx0sbgQ4wCHIxKPLwGhtfihFgTy4orcw8xSnAwK4nwOp09
        HSfEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cBEkFcSb2hqaG5haWhubG5sZqEkztshcDBG
        SCA9sSQ1OzW1ILUIpo+Jg1OqgXHShuc1174L9Kw/2l2n2/OiSHFO45F1GVwCSU9z3u1f7Vf2
        +bXp8wOqGxsP6OasTFmn9zP8zLnld14ev33p4qQ+nnnvLEKuV8w7z+q4KOz9olOPP1l9li/l
        vv/Y9NeaL9t23ohae+2YyB/7UwJzX7Wd9hB55VQaL7cm+vgZvVv8T3/d2epx+ceHcCWW4oxE
        Qy3mouJEANp7p+rMAgAA
X-CMS-MailID: 20200602115213eucas1p2a9a2ebb2afccca0354cf196caf762c81
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

Since we lack the hardware (or proper emulator setup) for
testing needed changes add FIXMEs to document the issues
(so at least they are not forgotten).

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- rebased on top of updated patch #1/2

 drivers/video/fbdev/amifb.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/video/fbdev/amifb.c
===================================================================
--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -1892,6 +1892,7 @@ static int ami_get_var_cursorinfo(struct
 				 | ((datawords >> 15) & 1));
 			datawords <<= 1;
 #endif
+			/* FIXME: check the return value + test the change */
 			put_user(color, data++);
 		}
 		if (bits > 0) {
@@ -1962,6 +1963,7 @@ static int ami_set_var_cursorinfo(struct
 		bits = 16; words = delta; datawords = 0;
 		for (width = (short)var->width - 1; width >= 0; width--) {
 			unsigned long tdata = 0;
+			/* FIXME: check the return value + test the change */
 			get_user(tdata, data);
 			data++;
 #ifdef __mc68000__
