Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1490FC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3BF206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BJJD/x4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgDJL33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:29:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:34231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgDJL32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586518164;
        bh=sWYYu3vMxv+gaoLrrDxDuwL+UgyJB+3aK94jNvqAN2Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BJJD/x4jqvq8NcP0wyK/pY2vf35HluMdDC/CRo2x4vNPk1INvVbmM1P45Dg8ktR5t
         0K98hBx4DsqcxZ1DxdcBs6y2ByhlQDZSTp2RyXhuf/GtgonQAWX9Y0QemAf1toHdZz
         eeGzFriMDkuXGFNF/ojelaf8tu6DKp4P5hzljEA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M8ykW-1jK6gn3GvW-0069YE; Fri, 10 Apr 2020 13:29:23 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vt6656: Remove duplicate code for the phy->service assignment
Date:   Fri, 10 Apr 2020 13:28:34 +0200
Message-Id: <20200410112834.17490-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410112834.17490-1-oscar.carter@gmx.com>
References: <20200410112834.17490-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NjWxbGtEZJAAq5q9d0g2t52pyLQL1cNj7YfLf+Ywk7tnZX8Z8KN
 2L7jusOoUGtMZ3F+D+HvU/4v/Y2MJvSrSsCwkMmdN2Vaa7ZySflHMSQksANCnXHsiYoGW01
 aTfO/HAQ3gVRnIU5cY1Sq3mswAmE33pYsOjybyVw4MXUaQMxpS39YCg4py91AvMMduKgN+T
 RwEVZ5LjVyW7eiKMft81w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wy3xv9jGFSk=:iAyDj2NhE+ynqdygNhH/Ct
 lZQnd11jEtK6UzJ4SewJPHxNRA4JXoKiHjrwX7pUE5qartSUu3m8EpylNCFZpjMd620UnfHBR
 UltOpJtACX1h3ajBGnLpHpPOJEzjvb+2vZX6vdMS56TKtGrV/4UGutYOA0m6sh4LdSVW3WL3p
 Bk3tRzv2YXSK7xo6W1Nh7kFg3SGAFk4en3oKPDh2WtS9hALqvo55in/McWaEDvtRP9/44hnz9
 bYD9smU8rGdctYXcQgoHK/fYyFIZKmm/tUhqcjXJwJ/dIepOHrH0KdiS79BWc9Jktw5KNQq4R
 Rt+VPMPJmiQAmYxAxWe6R+msp3rWoJQq4YXNPT6j7wq9OejXClghKig35O1oEKXbqh5/L4LMB
 7AWKUCjGgtz9kMCW1SWSOOkXNmLqpM13Yl2mo1+DIo+cdrOcC4hkAHJp9HwkO8fojWCL5nsZk
 JSdokShKYloxHY7fM/SvHeV+bM45boJNQ1t/o2M5Rfxajf7elqFX6T11OLwv81TTls6QxIhjw
 6yQ+NQYXyLYX3P8vyBxbHiQ5FgmqWZzZsaiLksJvsT5wg2HLif6+061lF7h8hQ9i/J0w7+raL
 jZgI2a1maJmiYw+FZVHhUFoA6gSqq6KiTa7CtQN78jiAFeQlN+dCPVaOLKi3OprYe2XrSFii5
 OqpwEdTaITiZgc8AIaz4tTX47kF7KM/yO6XUXMPZrPw4gvRwZjx3w9A8iPpSGSR1cA6WqnnlL
 ZfuyCbeWlyVUqtNbpd83KcFO7/usoNRWUFwAGXWgdQzwYIJK1qA3mWiNEIpukg5slgSJgGnJo
 H/Nr3jqoj0CeqsI0EqkdfdwZEy3yWqQwlNgzJbnNddaGL2fa8UdHkX98oF1DGKYQHSU/OWb8W
 r4+8/tTcDzWDulK/40SxRrqmSxtv5IRz0DQJl60G5QsOAuqZhVxaf8WWiBTR0m0WLLjtr5W+Y
 EPSezMjas8FlTk1I2f7ny9cDpJHMQxBoUepkoVTZs4R6q97J95d/hPuUTf58UCX8AUnLOzifL
 iFsamqG94K+vyaLRRFdRpHeu5HXLHiB19xyRZUcvkWSRf4U7Jx8ZB8BdDm49XD9dJ42MkfByy
 T301XQhMWWaegvyetpTrB1K8me4afHvSv/CxOxC8PNYLQpeC1IV/ir8C3cZstvCYBdOjn6ueZ
 l8OR/Mua4jaeUVseenZ9ykHfQs0neyAA3vpqqKveIMS5PlBjKptE3vvjrYOLu62rh3r1ATME4
 PUrhHEoHzvXUIu2vi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take out the "phy->service" assignment from the if-else statement due to
it's the same for the two branches.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 47f93bf6e07b..b0054f6c07e6 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -233,14 +233,13 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
 frame_length,
 			       : preamble_type =3D=3D PREAMBLE_SHORT;

 	phy->signal =3D vnt_phy_signal[i][j];
+	phy->service =3D 0x00;

 	if (pkt_type =3D=3D PK_TYPE_11B) {
-		phy->service =3D 0x00;
 		if (ext_bit)
 			phy->service |=3D 0x80;
 		phy->len =3D cpu_to_le16((u16)count);
 	} else {
-		phy->service =3D 0x00;
 		phy->len =3D cpu_to_le16((u16)frame_length);
 	}
 }
=2D-
2.20.1

