Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF12C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068FF2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TPGr2ttT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgDGQjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:39:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:51491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbgDGQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586277582;
        bh=sgFBcuEhJ09mNWZg34/SHX56SC+2GL9Chr9TTaUeP1s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TPGr2ttTPy4K7zMAmRKEHRH79rNJIQOVUG/T7ryGHLGo10c9OK46Z3nfWObswQWTn
         QVxqsnXaIWsOxeB3hozsxGWyJObUhrDXzmAktAhmFFkXcGbdmqeomxmmENr8plYb6q
         9vneJQT1e8U9SdG+3+PIx5UrvTmIu+8fwaefyzNc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M8ygO-1jPisi2mgw-006At5; Tue, 07 Apr 2020 18:39:42 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] staging: vt6656: Use define instead of magic number for tx_rate
Date:   Tue,  7 Apr 2020 18:39:14 +0200
Message-Id: <20200407163915.7491-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407163915.7491-1-oscar.carter@gmx.com>
References: <20200407163915.7491-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:80gdE0QlBjoYBKLhB15CgxM2/0qdTaSX6YXBn+M3I/XTjQLkEk3
 3f0twBV+6Yee+7jaZPU22/kN3PSGSMQ66NAgUhe8DuUmTceeVyFXYiVZCe2uCQUns1TsohY
 1nwjSyS56NHIAhpL9fkGluik6/oYFMfpooPwtkyL3pwF2LgkZGSld0+Qy3kEHharogd5kAb
 5r7MVEicf+xLoMhJ/Q+Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:irZJPE8IK2k=:HeMx1OxnRCK+wsO10X51Vk
 i5SrpEPdI2/YYhcsvTSeD0pAqRfzqCuvxPHec1oNK5J989yA9Y4T0QNyQczh0gbMTU25Fihbl
 68pae8CJa/eY0JBekvUcK89U3sHM3xjeIRwWdcxyReKnqiYutEVLbZtDxc/6p1adzD/xn52W4
 XAM9o0muwLDcXTBQhUvlMwSiW8djbjrlTFMaNYvpv8laq1OIYQgtKDNgsTGYc+OHM7x2PDebQ
 Rb0kv7IZeE0AW39fJ5yf0vWdxv6Li4M3fCxKJ3E1QnaOVhBq/3urmdWo2a7aa680AlcOhfhDs
 dGRhfOYpK66KRTW8DArOdPQLhLD/fqsYR2d+c1lJMxQ2JTy4lM+cCrDXWDCymNLaSatsPsIWn
 NSC5wTdV1q4iwhP3x5LZXptBnBtDKe2wEVQk0b+p4Y2TEtvqKab6Qg0+HI5kW/Rfb3XekvOEZ
 w52dHxPKZMUSgOHE0cy47WcVG90WcG7zFhJDTXxNNPOqksZmWqzgA1nSe/M0oOm/QV3lIMr7T
 g7qXXu/F9jSapRQo4TttvfaLvYU1OAyqceIzemJpKQn5+boCSRwQMledNsnoovZ20qvxTgonn
 hxHAzzT63wIUwQGRDvNpCgIGs9PQVThKryM64lCdQcCZ13gy2y/QRdEWoKS7oX1swhftn2Mpc
 ipU7XTMU3X0xMTMeI4Mg6jrXo/wcTX7ScjnKeTut4h69sAyRHnPpS/cao/avWlbPgoEhr76jd
 K85uPgqIQ2fKTPg/rRH6kincw3spMCJH6vKayFB952fYyT8gKqttWSacP+zsLo38cHF5snrcD
 gJ5V0vjaTB4IoWr+ARtZOl/XtkAYZdENw3xX4Hsa04hJCDJFNnqUfWoI1KRlw/f9f4SVN0UOj
 GpFtPPBbznyVmx4p17t9v5Uo+IhcqhxdMb6e/zniWABhBC2ypEnnxTFrj1LQ5RNoQWifW567f
 RhnadIX93eML1XTG4BNwpPYd7/Rj6bvEheCVVnr7heLCgpFI6OHlEmpGcPgoLcw6bZS3sl/GX
 13+w3gqk+GtLjW7rQeM7M1GsGtjL+8Covvge1NhnK32Cpv0qEpZKC+hFhp6/CXX3px0k6D0pd
 AFbJ4+N9dAmNSr9W40nWHZqqFH6VIfX0QTMZZs8aW22psH3TIeOjx7QPpOuv7ZJidcA/TZATE
 uBB2kyJVfMeTzjUwAqE22ZfK6IOEsGPAfMMBWi5QrWdkT3v9EuSaIm7B0k93G55dkNV05cMuO
 fnEjETBqQpq1DZ2CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the define RATE_11M present in the file "device.h" instead of the
magic number 3. So the code is more clear.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index a19a563d8bcc..092e56668a09 100644
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

