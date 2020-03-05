Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A6C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808242073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YKoU0Z9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgCEWgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:36:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:55419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgCEWgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583447801;
        bh=/WaLuzj4TZ/6evI6CZs56EGcPtyYDt3Dc3R7bY4tebg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YKoU0Z9AWaTbmwv47llElpyQMUQ3e2/srX25rDykJpVMyeO8ABlOyLpAZqs36nY47
         8yAPbUrg10o2UUWXwlUxzj2CfRJLPiYcrzmqh+nYHQApjiLPXncxVEcOESIdkrwbgg
         y90kBIQ2B7zT5rCgr65qeVaLXV85BMQp8mtkIY+A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.153]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1isagE1455-00IXL6; Thu, 05
 Mar 2020 23:36:41 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: cros-ec: Fix indentation in the example
Date:   Thu,  5 Mar 2020 23:36:30 +0100
Message-Id: <20200305223631.27550-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RV732ro+WjnO8y3RvngeCN4jJkeyxaiS9dN5TImrSyuuC34ZZsX
 rcE93r8eUgrUv9FKhK+kJr5OeomlKPVCYRXDkKnccJh8ufGycx6BeRuf0OAv5OOaFGuB4Xo
 8nq3B56Co6oqFGDT8bTnm/lx9MbeMAzIFqa3CoU5ccQU0VqlkFZaUNsjV+ff9cODS11k6DJ
 eBMtvGZWvhIReAEl3vn/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+P2D811FeOY=:xwgXOY5rX1FQ8REHmDsIW+
 rRacRoTZkEZ8N9yYwJcCY0mllHWAg3PMwWf420MCzexAobAFo+f6COIkULu7rV/hIFZWjhSjo
 V7XJqOrQfTjgZg5YPt4ZofKzvrBmZhC/t6shPNpaqr6wbK74LjzuXYxqz+hQHTt5LD7DhZnp7
 N3EQUqzXn2r7oMKNqCmYP/MTv/PM1ANVGZbwtm3UtqXhOm71Vq0JhEjv4IZgNUki9pg/s2QnG
 wDkoi/tNJ7zKjDcSLcEu9eiboAQYagCcdgDmJ6ogT+KhdZKy53BH4lfcB9nkd/wwBh2BDMODk
 j1+r5HeX/xF0kk48CXUm3QXIARvO42MtcwWA5PxaRotveLEL4NMHrXtXW8LY6OVH/RhYdlJde
 BIYoQHPuqNECZrRWNd/haCJ/OOaElb6SkNjzqEfG+7TlgAX+eHakkRk4ES/4GkMLIvlaBoriR
 543PPOaVo8ReBhJJQA8JPsQVhHG0pLtWYD9EaBIPQhlU7VVzLuFPg/mgP4PGOXcceBDh3rRfh
 Eh7stwfwQ82ezsNFs84kJxFLwhCBOgYbzI3vB2WxtMtt3F0AquWZibXN5hBDV2gt7UTnmD2ZJ
 hYFb/lzJwJ5O5pHBfm7oDKFp42l4jllxXpfGVMkVpgxOfMDHa8poOK3WE2FWdeNC/IxENK079
 cuehMoOlFwKgbbI37mOhl9fyX4XWEawccC3uJARkrMRha5ir24i1unaARoi6kDuOzQZoD1IPx
 PmIl3mbFW/hmzG1C4DoJHkiVgJxlrIlnLEHlikQa1nlYaQaXaMs60iLZfSET7Uf1x4y6i6zu8
 ojRlC/wE4eIgMXuAMAZtmNr5q5R7WxzLvMFJ70HhQ2VEpIqSH48EGaQI9IR66UTAuEVtqwIPl
 LON578Ry5mugFPdiNwsTfvN0EDusI0L3b/rTryFb1G56rZoCZe+G3qE2z5jEGLI2yP+PsJztE
 5XmL5n4vzuqAIahA1Qq1pSCzDy+7GYI1gQ7DHd/RJwy29AoQRO11GghASy6VIt/PXBx4zGYWJ
 VNcY+cgxHjMlXUKj8yXWqsJh6N6UrobqS85RBsyUjZ9mSNUnj0qzqGkCXTz7EMV5lW7/8F4VO
 Nth7Ol6xmH2dGelQb+rghbMnYPXB0p0SL+soD4io5Mqve8OTNNVCFG5lMaKrNECsEGNRF81GA
 nmjgQ9vt63Ip9gypIn+JOrNGvB3t93E+6WMKNwArGCF9p07UwYD1pSYppXJBZrkqUTzgfyz8u
 t0PzdATbf2F8cHmDQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properties get one more level of indentation than the node they are in.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/mfd/cros-ec.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documenta=
tion/devicetree/bindings/mfd/cros-ec.txt
index 4860eabd0f72..3bf9d0868b98 100644
=2D-- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
+++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
@@ -65,9 +65,9 @@ spi@131b0000 {
 		wakeup-source;
 		spi-max-frequency =3D <5000000>;
 		controller-data {
-		cs-gpio =3D <&gpf0 3 4 3 0>;
-		samsung,spi-cs;
-		samsung,spi-feedback-delay =3D <2>;
+			cs-gpio =3D <&gpf0 3 4 3 0>;
+			samsung,spi-cs;
+			samsung,spi-feedback-delay =3D <2>;
 		};
 	};
 };
=2D-
2.20.1

