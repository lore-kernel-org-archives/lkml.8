Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB9C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C62246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d+HtWXCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgB0QFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:05:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:60517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgB0QFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582819527;
        bh=eWtVTwa1th7imei13HiGdPvoztRW0QEQEO0StELpaQk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=d+HtWXCNUAi3CZGJK9aNSrgaENvpX7uPKj9Af+PmU5hZ/rAkkCW3M584V56PE47nC
         xz+6+iD8zMU1MN3UUDIQSq6ZNQXV2iiaeAMPK9BIG1gGLF8JBhNLf861rixZrpBIxL
         UFfVjvX7LQXfgoSu3oz4pwcbSUo66LTQgeKpuu4c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.148]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1jDvFn09Ky-00FUlX; Thu, 27
 Feb 2020 17:05:27 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: tps65910: Improve grammar
Date:   Thu, 27 Feb 2020 17:05:21 +0100
Message-Id: <20200227160522.17582-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zPc9krwbnc26FIFGxqw464VWx4CGeOTSxHzZVRxdjjCbFkGxwf1
 LuMRkl/p9EEACIl8yy5z/DhEvEoGJpWeGWhDYEdDJ7AdNiru2BpCLPy4gdunbcTVL8LnTIr
 k3X1mdqaEYyjUeyd8byhw4O70W1vVMb193X3V6+jkca67sPbRbF2wDGDH/0yQ6BKmgirxC6
 4vBJ/ZWaLwqoET+vbKXyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9EOg5/1GM1Q=:mQOiaxLiwsvUT53LiglLrt
 qthwv7B6MKJLBegv4s6JBK0KxBy+BDC0Q4xTgs4pFQ7rCct3MVFTt0FJWShtaMTkTFvMNLunG
 3sgK6fKN7h6qBP6NJixnKl5Di6GTFVV5M07UZhlwJTIzw/wiHkoDXDBVDDWE7Ee7Ukb69PXI2
 P8Oc7ltQNtv1+NkDiy58RSnxR/2xR1LBr+udyTPYFDuyIWeNqSzw0mA9Jqqw5et1aYkQe6U8l
 THqXxIL7Jtq2Vbk6zHfu5c3EE6mvDEAJXiCmATgSKdwun8v6x4GWD/oXAGvW+QWwfhB8gBXwb
 DyQnhuLSYGlmnry+RfOU558ZSL78yKwrNHGJMHZD0IjEHkfoz1CAR8brnYhuVCHUQl3Hb3Epq
 CdVbqm2YskMsUuJoBlE2iriI5Tvj4S8fizmqM7g+Dg7enkLKTTrtU6nnINYLGy6OCYmiCez0n
 fAxXWBC8+ToBk4knznHSY4MiNCinLeMmPM/A25W+dME9ruhtpgjNBXXyYJYlviik/5cEYIcbY
 XHDOm0G14sqO1aTe7bFFaQwhI4hORj/6WKI0OovsT2mV/9+s2Ex63Y1jfIHG9qAxlmfIhknEf
 MnGX9dojPcjQoK/jap8Q2h3v5+LPKgkUuhmeUk/95hlZiY5zBaEP0Sm6METjHstaGxCiJ3exY
 kCJY4r/JfL6yTk+mTZzdQU7QO3WaIyVRYy3SPhqpu5ReOgRisfgSuzkCCdqnHVUSf7+hEz/aF
 iHN+iaabTh0+o/b3mgdrlvLruwFWQ5UDgZ+sCzFVo/R6/5wr8LZwK08gaghEUeKOGAiY3nJsf
 KJ2NvrBAm4LQmltd1mX9oHzmNjQPNdVT7DZJPIie2yE3ySk6sgvLIjNuz4BOBeyaXZE36SeQi
 6MM4a7H9u48QSgU1nF1Z6l2Zt/7pjuYdflO6CrqCXm6Pvh+AaMRSRGlTJNJAPNheDg3gVTVOQ
 SHjAixUo0ppHw7mrb2+al5mxtTvbDVUHyIp8QIsLwLu0VIgvzJ/eOxxj1JEGSS30T4dnTHiDo
 TSs3PL2Yow57dNyHUzwvnyNf1SNhAcs3dnHISR/ICIkkaA2cV1AX5xmJg/vBJXOxXIewwh/RI
 T8DAOaZWcP/FwsvtZk0VKAYPIo9lnduK9E/LVQq8pMMK6fSk506u3Ey2cEEyQl3doaKbSUv3q
 MrkTXFG3uCKv11f09Sf6vCx5BTGB+Nun7RR0dbJQtsf6uJ0C0Oz0joRJuv7N6aWJBeizMMD55
 uefSV7U0sFOQgyV4V
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/mfd/tps65910.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps65910.txt b/Document=
ation/devicetree/bindings/mfd/tps65910.txt
index 4f62143afd24..a5ced46bbde9 100644
=2D-- a/Documentation/devicetree/bindings/mfd/tps65910.txt
+++ b/Documentation/devicetree/bindings/mfd/tps65910.txt
@@ -26,8 +26,8 @@ Required properties:
             ldo6, ldo7, ldo8

 - xxx-supply: Input voltage supply regulator.
-  These entries are require if regulators are enabled for a device. Missi=
ng of these
-  properties can cause the regulator registration fails.
+  These entries are required if regulators are enabled for a device. Miss=
ing these
+  properties can cause the regulator registration to fail.
   If some of input supply is powered through battery or always-on supply =
then
   also it is require to have these parameters with proper node handle of =
always
   on power supply.
=2D-
2.20.1

