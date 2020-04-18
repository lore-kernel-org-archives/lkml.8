Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600CC38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87447214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LsysFO3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDRNql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:46:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:50025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgDRNqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587217591;
        bh=BpcHpbLXJb+WHF2RoThe4fFeGdSByivKbXya/PGIWw4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LsysFO3+kglKOhmgmcfoghAYzKBKEP4aFieLpxChOiJtqzm8l9jy4IaTK+CDG+otY
         Piwopf0zXDGe8It2w0jpOaVxuwnms6RVlBLizOs6bhXX0Vpr+9sSgM4JYch9g/BJIm
         R9vCu7Ab61QX6RGh+IqUJ5tT2uv1Pg3Y0ESAvrG0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MlNtP-1iyCoE1ZXh-00lpbR; Sat, 18 Apr 2020 15:46:31 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Oscar Carter <oscar.carter@gmx.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B . Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Refactor the vnt_ofdm_min_rate function
Date:   Sat, 18 Apr 2020 15:45:53 +0200
Message-Id: <20200418134553.6415-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4JFtHOTdQkeOmzXA0/LYjINxluFdAMpRqtHOhwpeJebrmU3ZkS5
 Q6AZ0qRJj0o+UMJAXBvV0+IS1ZG+0Sc9noMFEdOLWtcbi3f8mf7Jpbq1LPWx9TahJKznBxM
 57T+a5xcnh9OULhjG2AFQ3CdtbIXmQUc23VQfhF3CysqoLuqnWHWJcn7ERswBrKExzt44bB
 Hs6i3S4vPfVDZ5zCZXQXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aa2gM4tW/X8=:ut/0Mb0Rrp4UmD3apbwkAR
 Ho6S626EEb4Pyvij+acmOhAnTftZatO6XC02S9vbdFevjOgN7b7K7fLxgRu+FDMYOawc3dVFA
 isLSqdtGoo3yCkNGuNe+FI2/sP6ulLjVNAlu4O5kZOiME/oK2OCU7fnEqbeW3dE1sGDMXSl0x
 hreOMXUaJ4mPv+HDV7iG86ePePSE1WzCrb6vibnjTflqRS+f1PGF4T+F2Qy51XqZYeGDDTi0U
 2ueJdZEmaRG6l6Abk99F37GzvpGjk13JrnjtlU7MVpYvQdGqggm0NY5yUY3dxliTshzwWWv9a
 nf/ewqeZuTn+lpuwGff1voM+/o9AWRgyoA9N1bDdAaf+5Hw/BrArQRgjzRydxXl+C3Qs/19ON
 UZPXl20YlKMH6ztGRy6jgQI5puvbFglvNlDZFUZnk8xAhbApZh3g2fNxFLH5xmhoJOnG12H1c
 yJYDu6+mLWTipR6NF0PW7RUem/rrJuxVpa/CXxofZGcEopLg/XTU4s3kAdUklqj99n1nasS6G
 kgR/44xN924GlSYTYcVJRMO5VwYzayy9t9cHPLWEN5YO7gWu3Nps5ICPYGhKsIZrw972IjVRM
 wjOrrse9iXfqo45p/zO2J+YVDp5bsCkVjlxfo0B2QyFtvk8t0ARRrfs5nOT9QW5BVGHv7jZni
 Bf9gTHKtSKRWiDHl39wTGoEqOK1APoicCzhbEUuRi+j0eTo2lqY+ZBbbOuT6f9lN0zMvBf6gb
 vXMp/GuO0DxevWEg8a2ItMCR9ggFgWo7tzEXbGUXpavAoXH2EVZIbl0LeCX+VbRg5rqV2MBuS
 2kQqg8n9/utToGBlQcb9yIW0uAB+L+b4p2glGA/xRozOVNG3auL74o6OBz7TNYpHQOmtXq1cs
 BSgLlpJOunyX0BIYCjJCjCA8093r1jl30iOqMhMnHnAu0geV+WrT6C/iEpBK7Iw0jD1ZIWfB8
 nXmIWKsTDK6wO+xU5mElP0nJi8yib3s2iMnz8Bbpb5J+MO05FFg0JBQ/orj9thIlkyc6+k2oa
 p2ADOHqxLdOdxyc7NxamvNUvjP+jrQSRuYTUZ6OJTKR7R9YrOF8fSCCwBAOyYOd9lbsjfyA7R
 9U4IWWigeBoas4GnKLXRWynXs24F9oOlS2O+U5DEkJVG20dLGZlkrftdzLgExEMw3Q1N6jweX
 ns7L9x7pSDsjNJKzSDpe0m0adt3z62e/yffuKt6FTYN0qA0o8E6YaJksoozFq+VPRuAw1JgTg
 MPBy4I2Fx4pcJk3Bo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the for loop by a ternary operator whose condition is an AND
bitmask against the priv->basic_rates variable.

The purpose of the for loop was to check if any of bits from RATE_54M to
RATE_6M was set, but it's not necessary to check every individual bit.
The same result can be achieved using only one single mask which
comprises all the commented bits.

This way avoid the iteration over an unnecessary for loop.

Also change the return type to bool because it's the type that this
function returns.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/card.c | 11 ++---------
 drivers/staging/vt6656/card.h |  2 +-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 9bd37e57c727..adaf93cf653a 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -248,16 +248,9 @@ void vnt_update_top_rates(struct vnt_private *priv)
 	priv->top_cck_basic_rate =3D top_cck;
 }

-int vnt_ofdm_min_rate(struct vnt_private *priv)
+bool vnt_ofdm_min_rate(struct vnt_private *priv)
 {
-	int ii;
-
-	for (ii =3D RATE_54M; ii >=3D RATE_6M; ii--) {
-		if ((priv->basic_rates) & ((u16)BIT(ii)))
-			return true;
-	}
-
-	return false;
+	return priv->basic_rates & GENMASK(RATE_54M, RATE_6M) ? true : false;
 }

 u8 vnt_get_pkt_type(struct vnt_private *priv)
diff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card.h
index 75cd340c0cce..eaa15d0c291a 100644
=2D-- a/drivers/staging/vt6656/card.h
+++ b/drivers/staging/vt6656/card.h
@@ -29,7 +29,7 @@ void vnt_set_channel(struct vnt_private *priv, u32 conne=
ction_channel);
 void vnt_set_rspinf(struct vnt_private *priv, u8 bb_type);
 void vnt_update_ifs(struct vnt_private *priv);
 void vnt_update_top_rates(struct vnt_private *priv);
-int vnt_ofdm_min_rate(struct vnt_private *priv);
+bool vnt_ofdm_min_rate(struct vnt_private *priv);
 void vnt_adjust_tsf(struct vnt_private *priv, u8 rx_rate,
 		    u64 time_stamp, u64 local_tsf);
 bool vnt_get_current_tsf(struct vnt_private *priv, u64 *current_tsf);
=2D-
2.20.1

