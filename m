Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C760C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FFB206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Wd9txCpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCOBuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:50:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:32873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgCOBuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584237001;
        bh=+Cey9W0qDhL9blf7YDqnmxt2qHCMNZyrQN8bBA3CrSY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Wd9txCpQI/5g4UWUlwhMVouTlFAPSplltTJTgYiEkgXWWWKWDg3CVQjLH4W2/4dKH
         j5eIFSEo58SmcaZslrtR2padOrmdrXdi9KjWEhtCDS3AznBH8+7zuvBBq5IaelLeFB
         xqP0TFxIeCh2grsoufff12Q9Xsf2XMAUFktmTDf0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MSc1L-1ikOBt21pR-00StSE; Sat, 14 Mar 2020 17:15:20 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6656: Use BIT_ULL() macro instead of bit shift operation
Date:   Sat, 14 Mar 2020 17:14:41 +0100
Message-Id: <20200314161441.4870-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dr3jVjQMoh0KUHNN6Az3uPVe0kI6mi8G0B3vSf4x9r+DxqbFhq0
 zPDObF/FNVkou6QlsKW4UeWcu3yfV3hwabmhPHwmjWSYt9VjBduGCds+IUfRrheMSO2qlZl
 h0GRY9v+TbKcccwkpV7OVaeCb2gX6QEg9YSqxdH73FtTHhgDkilyXiO+AMKy0XCgNMS14P6
 KQRy1E40L1+4Oq5UykBvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3xtwA/ZkCsc=:pgSRMdjVyQ00J1SdbOfXfm
 EH10/ZUoj7oipiSE6So2KYO92C57N8cNMEtV/3QRty8TDJY8oGRGqcd2ZBX2odlDAE6xHtns7
 Ux65fkQsaDAvFUyxRU7HUOro3xutnGJ/LYTg890fGKynFWW9k04ft1Pd2AtmezOMeRcdd1alI
 yh+Qc+ujDs+UHij+oRmZczR/CylgXlf2+cdnuaq7avgU1oXO6gnOe7jkNRU7hMLJI4NIh44bb
 r+Qqxd6TL1slQMi+3sHqfNqiGUDptI2nLD/mRPdwoZSXDX6Ke/EekHBkBR9aMbTnwKyn5IVFM
 kYvcFYSHX/iaf0yxbmW9jxLnJ8iK9MAYNj5QEUgw50mkX8jB+j7JaY98F8YwpuxjzhPne98DN
 +VOw2juP0tQfDh6psWWG/piwFso+aMFiTsxdJoUJ0a4W2ae3k83lN/4Oo9O1/V6SqAoTNmx6d
 fICOuGhJtG44BiIB1LM4d7jjMtP7PpE/mHhSJU8pSisX6JTToRBiHGnZ293qXtTSXSflyFuEr
 wbFTcgc4IyNj637Sgk1SW7TqH0C++15/VxzgqT7byv8WneTnhVLmI8cnnjVqK3DXG9XIuAwL5
 XwGMxjpPuPkMU2KvkikE5UqoNlcdKmfnaKKevfFcS12MA0J/GUm3v140AI1u3/jA3epikyqTl
 uNG5XdpjDdMEwSdf5NDnBHbvKfdyQIWDr+aOVZiqc1EtEkrpvCSRe+B0kuf0Py1Uqs0n0J0Qg
 9oEnUTUlIcAL+Rv0MM+g7qpr31/n8k2j/phd9jrJg//dpcR4ESAtX2yyN2bHBnrrGcCLaTeAj
 rxv9M19OWE6Y4xQTuDLTmk04MZbzN0yiGuy6LBsMxk715wra/wtB8LLaFkztUnQE+WWHPLCro
 mMccjJy84vRh2yaJLdzJAyBG2VbafQSxJDXQC8yvaqxVNzz1XTr8gnJtxr4Y0mzcAN31WpQhV
 dk+ZtT1FuJ2k5ncun1H1YZue67zZUyOaLS1v89HBwrU/90Mzh9pftAnvHOAeA90EWJLd/+OeR
 e6NBNN66TcnhilNHQLUyAGKm1UA+MeakmWlTA6lDqtLga2YfnRVM1zs/ltBfN2Z+nrtmI1A8I
 nwHBEAU+Pw5SAxDTOWDthRNkx+BJ6uGyTtK1ndyfbZ9CMzXvX0zkUGGHYNk3TMoyS7hL89RKt
 PP/3lyHRDGYiC2cjrcc1EbRaQWpn2myk2HkFmiQt7Rj0M/Is697P8Vqiv0FF0E+NTarWurOgz
 s6Y3XjSlr2h7BgPZr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the bit left shift operation with the BIT_ULL() macro and remove
the unnecessary mask off operation against the bit_nr variable.

This mask is only there for legacy reasons. Originally it was 31 (0x1f)
and the bit_nr variable spread across an mc_filter array with two u32
elements. Now, this mask is not needed because its value is 0x3f and the
mc_filter variable is an u64 type.

In this situation, the 26 bit right shift operation against the value
returned by the ether_crc function set the bit_nr variable to the
following value:

bit 31 to bit 6 -> All 0 (due to the bit shift operation happens over an
unsigned type).

bit 5 to bit 0 -> The 6 msb bits of the value returned by the ether_crc
function.

The purpose of the 0x3f mask against the bit_nr variable is to reset
(set to 0) the 26 msb bits (bit 31 to bit 6), but these bits are yet 0.
So, the mask off operation is now unnecessary.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Add more information to clarify the patch.
- Add notes about the legacy provide by Malcolm Priestley.

 drivers/staging/vt6656/main_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 5e48b3ddb94c..f7ca9e97594d 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -21,6 +21,7 @@
  */
 #undef __NO_VERSION__

+#include <linux/bits.h>
 #include <linux/etherdevice.h>
 #include <linux/file.h>
 #include "device.h"
@@ -802,8 +803,7 @@ static u64 vnt_prepare_multicast(struct ieee80211_hw *=
hw,

 	netdev_hw_addr_list_for_each(ha, mc_list) {
 		bit_nr =3D ether_crc(ETH_ALEN, ha->addr) >> 26;
-
-		mc_filter |=3D 1ULL << (bit_nr & 0x3f);
+		mc_filter |=3D BIT_ULL(bit_nr);
 	}

 	priv->mc_list_count =3D mc_list->count;
=2D-
2.20.1

