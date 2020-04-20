Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C747C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA546206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lsYROrcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgDTPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:53:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:50781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgDTPxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587397991;
        bh=KuLTOA1QfKC7SolQCPu3ppRZXOTYJZ4TqJ92c1D3IBc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lsYROrcIVALwszh4JGY7//1JDV/dYHZVCrNOvlENoljDvWymYVCFrlGadL1v7Tdya
         pWVmYWeJx4qoFV6DvI3lsbox9aZgLMnsnP23qjm3lMM2pWM/uIwmZobjWIMK6ETnUZ
         NZxCoiz11VbUDlLi9ZEeo1lCOaNu19hS/egimwD0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mg6dy-1ik6B71neo-00haeP; Mon, 20 Apr 2020 17:53:11 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        "John B . Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6656: Use fls instead of for loop in vnt_update_top_rates
Date:   Mon, 20 Apr 2020 17:52:46 +0200
Message-Id: <20200420155246.4925-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IL+LvGI/q4eU0/MdCc2loxlURjvQbUcZBHvz8+25JV+3eDsU4Hv
 Nf+tMGvAGg+KnihorlU5Z2wztRX7f92DdtoW+XLGwdYyHjTMzMMxmsv2TuUJPHW8Cwmcq2U
 gE45I8AiGza7F9Y3vQMdk2jDcd9oK05EqJvWYrGnWysIyWsFyC2koMdRq8LmiCEZO5Od9C4
 bWtRc47NjjqmepdI/zVAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4R5DqqVr00=:0rmCVwASIJghwwOz0wtvk7
 I1toLZYyYRcyoTIMeurUEpQKeIdOFTJJrT+tRuy+yiNK0vm8eNJh8B1PdW9AI/rqAuCNtErjU
 1HKwTvMXFtZaCGTDiSwBh3sRs3UC/ApQYxLna4T1uwmuF6Kk/yCGOe6POI4G5S2gALMJNUILg
 Y3i09Qtchos1dSB2QgHVX0jcdaduB6AUTYBicg6c+QEr8jwNgSYbVI64+uDBz02MYqe0Kwdej
 FgfqhaIi53H06DFYkDR1u0307OeNsa5eyys4Qqrkypblco3ObCd/EgDeiQYM2eMBRLhUQbXce
 IklyxpIaLN/OXmGQb9wLn7MiQumlLoIPjRauHkbfXrzHEg9+vAlkNhjJv81Y/g/aCGE/ey+uc
 cRiKeff4Tgtx65o7CVJr94sVMYj5YkxvxBsXqC78yKznEB1x7xTpA0daBjpsm9kkZCWEIwiCH
 zmtWNmLFx9BlHHcNCg3uM9r/brV1bAJI0HU6aWuESf9XvPVQl3t1LNm0iMhLBe7PuqR9KVhU3
 6VM99L88S0KUe58uri4vtmAULAIM6Zhr063hrkrWIsdDB9IRXa7PNlGGWpSO/wddg9uNu37j8
 8/xH9qCOvg7pdEESBtnWY9M3FshKf9ef9pnxZ2rhMM5X9ESmNViQrR0712lPRsilRCuPCyWqx
 8iJaKuCIMj6vFuXR8wIHG6RsKssj8M5aoRcqDuardOAbxqf3MFAnAzFU+Wfw6u3cD7XmaM08w
 wrBGg9S987XQjFyjREK6eEs9uk3g8jgLnG/6QVqEKi8ImFTfvsTgAhwgWd3BPXv7Ko/E4zTG1
 gRv0NIZllCv0mpPYZ1Fv9IFAvr2QVeAAPiM82ErkYN4qjlz0SMTXVXNiMKz5UtjKypXWOfM3W
 GGDkUKDu1sMcdl4nNk+7n9RenRB9mBRRTAVDHKExIFCvkE0WTm8I/J8TDer3rf4EDgDdp8Qis
 yuhkrUf9OJYvFy9CDM1gXeYWuSUnOMFzdWCx49qvR+a0QOxULerP/noHsyy1BsVHhK3OoVI6E
 BMPTfAJNDIX2m6afADv6K3W/YFWDXWedGjMx7jdC8rXNpDk3gPLKWS5AIN3SH4aKx+i64M+zk
 LiLkqL0mmFf7JziZdhRaDUGyWMjUcYxhrNiS82cLchq4EwD6wsski2gnw/h00LQx7flVwu3hn
 8KE1xPqpfWFYBR8VVpv8fXY3B585mjW0zJJtBMVCXwopT7DCYrxeDKKPL7SJrB71A57iOzhBt
 vH3IgD75EQXxe+zLU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the for loops of the vnt_update_top_rates function by the fls
function.

The purpose of the two for loops is to find the most significant bit set
in a range of bits. So, they can be replace by the fls function (find
last set) with a previous mask to define the range.

This way avoid the iteration over unnecessary for loops.

The header "linux/bits.h" can be remove as it is included in the header
"linux/bitops.h".

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Replace the expression pos-- with the expresion (pos - 1) as Dan
  Carpenter suggested.

 drivers/staging/vt6656/card.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index f8bfadd4b506..2478edee756a 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -26,7 +26,7 @@
  *
  */

-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include "device.h"
 #include "card.h"
 #include "baseband.h"
@@ -223,29 +223,13 @@ void vnt_update_ifs(struct vnt_private *priv)

 void vnt_update_top_rates(struct vnt_private *priv)
 {
-	u8 top_ofdm =3D RATE_24M, top_cck =3D RATE_1M;
-	u8 i;
+	int pos;

-	/*Determines the highest basic rate.*/
-	for (i =3D RATE_54M; i >=3D RATE_6M; i--) {
-		if (priv->basic_rates & BIT(i)) {
-			top_ofdm =3D i;
-			break;
-		}
-	}
-
-	priv->top_ofdm_basic_rate =3D top_ofdm;
-
-	for (i =3D RATE_11M;; i--) {
-		if (priv->basic_rates & BIT(i)) {
-			top_cck =3D i;
-			break;
-		}
-		if (i =3D=3D RATE_1M)
-			break;
-	}
+	pos =3D fls(priv->basic_rates & GENMASK(RATE_54M, RATE_6M));
+	priv->top_ofdm_basic_rate =3D pos ? (pos - 1) : RATE_24M;

-	priv->top_cck_basic_rate =3D top_cck;
+	pos =3D fls(priv->basic_rates & GENMASK(RATE_11M, RATE_1M));
+	priv->top_cck_basic_rate =3D pos ? (pos - 1) : RATE_1M;
 }

 int vnt_ofdm_min_rate(struct vnt_private *priv)
=2D-
2.20.1

