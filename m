Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC15C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB992072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jAeeiq8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgDGQa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:30:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:47181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgDGQa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586277048;
        bh=sgFBcuEhJ09mNWZg34/SHX56SC+2GL9Chr9TTaUeP1s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jAeeiq8O37DIgn86++v52pz6abQzqk8q2GvBdYWbXyjsbslLvM5GYwplpqNy0MUMm
         v2cFFMXIWeQXKDCCg+S7VYPu+KAD8viGtH42Bnl0TMtSmYYCF12ckO5vkFt8AXHFln
         2/6UaW+6jn7eg9H3+wqYIO/ex+TH6AEyucIufvWA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MirjS-1ipqDk1z6q-00exHd; Tue, 07 Apr 2020 18:30:48 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: vt6656: Use define instead of magic number for tx_rate
Date:   Tue,  7 Apr 2020 18:29:58 +0200
Message-Id: <20200407162959.7318-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407162959.7318-1-oscar.carter@gmx.com>
References: <20200407162959.7318-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:szOayLQTAId7qo7NZHx+GS0NJkVobbE+8kh0SBj1Vzt8VOCnrLb
 7prfRQgPnbAcLNmGEadMG+UrXL6t9H1IAFTQFOMaXA1UFufJdWF9rK4ZH6UbqKF83dV9sir
 hJZT8SZv1/uq5H5+rflLgcnx9WHENFR0pFD+8CHnm19AiOfbBWUrE/NO9I+9YMjmQPLIInR
 hDlWJHmAVs/3MGHbVWnXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9q6i7Pi+KZs=:liAxVS0Sfys8sbMV+1krZD
 GSDfkUf0M3erwlSu4xcmTnwwVH0CCs8e4ZgfB1GtOLzMihnM8fd3Z1uQLSOpjuEEeTWN+sAOU
 k5giVl0TdfI7GDHo7pBxiAc39pG4u7erXdkbWdWl4RXGGunpWbvD8dQDeAvhcuUx7GbKdQJmi
 N8f1q2HbFmAiEaueZc3rv4omPIM6rrrLo0BVnOL320099qaohKTsjQgYXbUNCBBUIC2OVTuNG
 9welrHpM2vCFETiHfg9/nxs9A6RA2DSgnIBm+HOv+JO0xxvSxV76eRMlk9tU8GryxW2WYRj7X
 5IrK/jAsL5qZHxqGxC6pLP+h+lnvKU/vKdssMsEq8XaO0prP7Dyo17VYoDCZo1SzW9t+SGzhx
 YK3kNIjGon4nELMO1eb9ijnOwfmFde5adv1dvm0bKhxY3MLiOuwngHaNNVBz15OdMHZvUAyXg
 daBRiuXvrlD54vYuknJsB9rYLVZeQjHxrFFoV+pN8IyWoz/sygVrtDJHMi2RZ5pIaouo6dndW
 hkPmglSqR4D7LF+yjbCYBXlfuTgoXJZYeH++QGJYj8O1xMuze7uMZ2wMDAObG9UGfyOEj1T3x
 a7z6+K5h4+oMbJiUcs1iRtQuYo35LXdJTtkHM1SIk5bFSDzGTm6rkG8dLJDgAcLRdkHcuwBtk
 ttxO034yFgG5ncoh3+6DUOwq4PY/fgkQyOx8JUjI9vDY7oXRBcBOw3EBUKtKmIM3BxUp7N6G7
 8iJyF8TLn728r3QSmpcsUOifZPamWWg49uUG5gRZaW8rHdRx7ooJqa2rEOJHc4UIFGm6R0Gh8
 ZE8EEbwqif9b44NhOTbWpjj33zP7htBN63v4Ey3WfEl962zmVgSuhEcTNJZqy2yKTLVVrrzw0
 5U0BeVv3s1RdvYfJ+E9ogGRUjO0AaZNhAtLFk+qVk1gLAqNwBwUipkx0b/q8FNH+uwHML7G+H
 vpXFG3ELgKKZOLnNRP0DkIeL34jZri+WNRfMtWSxCVSqDKuo7JHopTVk3CwXveCrbOl/u/aax
 Bt7mnSFfjUWZki1Dy7Mw378RVx5MmNysKWsSG0YfXlKC87qmEzATLy/V/AQCTcnE779is1Tdm
 h6tPIWfsgIDoxij7ra6In1BMWwTyqr4Mc7LWA3OMZE9BkKAoV6V0rpoBFm9+vhoGu1Cg6Cxiz
 /lUZhIx6G0z5Fg16CzFv5zzJF2lEoLtnlYSlFBMid1axRJh7IsQGZLwmdvs8ffjLLNRhFB8iF
 BFcZjljnwjRseSd+v
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

