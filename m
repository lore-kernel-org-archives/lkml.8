Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD495C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB008206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Znq/a1bL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDDOO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:14:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:46691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDDOO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586009692;
        bh=7fP+0r534ORAa7EBrhAOJZ8ezwRecYYukKw5BxCWheE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Znq/a1bLDmfQ0QxVqxwISeclo9Xw4oR4pVPVlOyNOCk2MYQWRyhW6D9PJ9VB27SKO
         N7KQxEpfD2Bzts5i+6oshXcmHvFA5dJ9SVH3Yi5KIBoOKd4h3APHkOzULLS6qvFms/
         h7pKGpNqbMPZYQrSe3kqZwTBTds2QSrfw3vtKtcg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M7sDq-1jPfFW1ORm-004y0p; Sat, 04 Apr 2020 16:14:52 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: vt6656: Use define instead of magic number for tx_rate
Date:   Sat,  4 Apr 2020 16:13:59 +0200
Message-Id: <20200404141400.3772-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200404141400.3772-1-oscar.carter@gmx.com>
References: <20200404141400.3772-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wdol1i82bzr+NiPJVfHu57Yk2KGiOjnqJkPGNV7zEbsu0JaBtSF
 DUj0KwFi5pnJ70T3E/IZcMees0ihC8YRQTs30Nq7x5+DCSJ5+3s1ncfJtcSpjPRha+hLRzt
 ok+VvwF94OuKZ34WahZlFWor3pUfD/ajRlCAJjJwkGewvF3Nw5eprjPIKKbYTZ17NPMlS6j
 7b3FkgU7l7TzBX3CNSG8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xeuFhSr/bQ8=:WsEU0siDOw10GFLlLpoMlG
 0bzl0TYgxCMvkG3otsAemqGAVxysBBUSm4xOIhklT0CPzxMYtR88fmYsyo1uGUXNIxqjcE3W1
 kWJMPrjyYcJaUVgmUGz9Nz5d44q09rCu3PBN7XjwUQ5klOC0TPMgFcsEs4KzyHCo3E++fKLK5
 +8IYQXv8CoaRQYpg6o+6j25Li44646xqWnaYWe4VteSnqmOTzAz0bQoyV+g1aX6O91RGxeKHE
 z17EkcDeFMS9Yleu/HqnPaMlTs+olA+Av/zXfror9odSQXENsTuEO84mIiCOJKhC6mO+xkoLH
 9vbakmvO/rnyvEJvBnQCrKV/qfrDs+6EkMHRO6iBE2jstKOLxF0ZkQcBe3ylXuTVLJYWD1H5F
 +Rdhf+wprC6mOTIWjKhbj/GBMKRonnv7YYfWi5zrZ5DHOinL7m0ffEwxDkz7SqGxKrh3xJD3C
 O2RM5Oj/s/fNcrMAPKZVhK+gSodvZY6XphUP+xOM2T9ipKh9rwlRG4swvkR/4/TTMoDmG8Hy1
 mFCRmfZqzCc1xW6knShOzXzh7blsGCOBcO88KX9OYQhyJIEgCCdlt0eyYGtb96TlLFRsb50mj
 +RaMbDwSTEpmZ5aawU3NMTypoREne2X8xCJxvTDuzM9xjfSNSWYiFAQt7LmBvxu9KP3wQpFsK
 AXx80j3vbS4sYzat1sHAJZxUdzNCQI8nu/NnhOtZe9pUT+2ZQuFC+/GZyUw+eukxvjnlyTCPG
 XXRkqLbhlDegoxLvM6+0ZJFeuWzG6cQJZiJmJMTSzbInRdoByKo1seOc26fYMOb9SsEdSt+5s
 qxOvTkVc38MBStyxOB/lDpx7IxTI4z+FfIQ5nAgSiDEy+T6T2WrXtFnWlUwU3BvotXQgsPFir
 kU2B6HeSuap7RoDri6VDFThxQ7oG6Hc/t+i4waOtviU/milIG799hcCYc+wUYk0P0jwNeJEl2
 WcqLLAkwiudP0siesKh3DI4n+K5F8EOOjW2sVBADW/NuctwXGGbOEVAlBNNHIjtNIBeBR1oNo
 CWgCKDTfCiyFGfEHfXuQmQAf+buR5Ys6XLIJ3lZVPgg5IVJ8H+m8Po3jvIlkkR455hGdevFdV
 J+iLleNJGuze09Q6FbXntTesaQz+fFyCzN108Y8/D/bfL+r7b45t8SVBfkEVTKzbN4/WEVrVs
 GBdKIyYNAsdZpdilC0fN1nQE4TTYyhrJy+BJvk/zMklE2I3F2Cx8LNQNghtmQo0MjOWwepw8I
 0YIoXpTrROQgdlukt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the define RATE_11M present in the file "device.h" instead of the
magic number 3. So the code is more clear.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 3e4bd637849a..a785f91c1566 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -24,6 +24,7 @@

 #include <linux/bits.h>
 #include <linux/kernel.h>
+#include "device.h"
 #include "mac.h"
 #include "baseband.h"
 #include "rf.h"
@@ -141,7 +142,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 p=
kt_type,

 	rate =3D (unsigned int)vnt_frame_time[tx_rate];

-	if (tx_rate <=3D 3) {
+	if (tx_rate <=3D RATE_11M) {
 		if (preamble_type =3D=3D 1)
 			preamble =3D 96;
 		else
=2D-
2.20.1

