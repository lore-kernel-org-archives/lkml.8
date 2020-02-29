Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1ACC3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945E524672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gUciDOtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgB2Rf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:35:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:35961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgB2RfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582997719;
        bh=DxLAd7mt4KmJoGtBNn1zpKqDgvSYCuYU+rP2rIgAIT4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gUciDOtk8DFlHDY45oFg43sdithQ9B+vD8CPckVRmOqADJ3bjE83u1hQA+w8StL5U
         1Q1OXRCuLfq+PQChYY7i6a4DyUn5VtMhkrN+D+6BldppL4+epYuGA00Nd1JXF6rc6J
         BaZzSmFk+SARSIs6eYeidwDQq0rM9j01DHY6dUAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.5]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1iqZ8R2Z7I-00HjWP; Sat, 29
 Feb 2020 18:35:19 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: dev-tools: gcov: Remove a stray single-quote
Date:   Sat, 29 Feb 2020 18:35:14 +0100
Message-Id: <20200229173515.13868-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lraD7w8GoxlJIdEqXU4KAIWcRm0HS+laVwaF6uxNDSiaFluwidS
 JKTej1J589NiIs8nEyhdzSnMbycnLo5fXpL7Xp6ksu5vc11cjmCUg3KivchN7PEY29/Sxxx
 jVONIqLECcPNP2LqBpHcX6IiWuYh0GpFWfqr3ZpDGJAYU0hP3QUzgC9O1d7mZZXasGgUCNU
 TZHM+sTx6C3XDQzKTnbzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uhUbtcozoe0=:62UvAPlRj7h50TxtdeEvvD
 k6apzpQKn3MTG5W91C/g6g83RqK5S0lNkVNqm1zcIG0njYAlEiSM18Ypux1EGkg3TDUBDUZ2g
 Cd+Un6UfPfX+kEbLa781ip904pxjTmTKbCac21XM+1wOYUdyOolPNafSISyF5tydguu3XTUjH
 o94SiZMNwHTMjbf5XO8Vd2PeC5ISRMn4Supfbwm0MX8ev0PX2JNgyZOJOtJRyOWGifKx7P6pj
 VWUO1cl/kuWCd3lGSZmlAqKE5UJ1fHLP+SIDt6qotKWN8wxImEb5DBFdcxpIfy7xdAFVeUx0Y
 CUxa/qP/Veefweu7XD9GvcwvcA/9s2+xbBg1fUB4K95Cc5QKmhpwuY6tbQdE+3zLNVPuViExg
 OG0zA1rVxxAdl0HHDuOPkNhYVXrcQZ/Jnp6cBTxIMw7POVDJcH7b8yay5FmwVK9ImUW9MojA/
 kk+0FddSFb9Kh5qsH841gQRLRkpfeYTpcbPiamkzKscyBbdqQhnS2b9kc5sQK/s92HSz0p1nD
 FE2uOrtbscumM4mhZ3CpaPuPfTx4yeET6kGMpNAPv8ELnS6m6n2IPdC1w+g+0LAbZniWpD/u1
 W2ysewDUrL7IKdo7nP+2MNd6DZs5MbHU2JwY8CcHsqSwhmPwjMnb/aMdwpOcci/SNLtJ/0Hbl
 4ZNh1/+H+xR/h+cYAtjA2tbw+O12qYLYP2MPi2sDjAK76eOre2AfvUOh5tmAOxzOQr2+Q2FVk
 UPwAEr7TOXiIhnfghZpOr6rOwKKc7WULmDdd7RG2OsDHJlWFL/JqdsBwMWfR7KQjguyVJ1Xrl
 SrpSrX9W9jORPzoRwtIFh0ogsquqWYhUsC1cimU4z/2xJTCbbHNGm1jRg12tO+K+337raJDC/
 zEp6P9jvZo9iMfh+xkaXbBy7YD4dvCp2xrUX6WUaXJBNlXccdlVtUOUJV4AISjZrpDjqJet8g
 DmwU5TvcPxBd+dsA7K/167GHaQ9LJR2KVP5Ldb2+QyC9YEU+MMgZiUljBxCKQG8pa24XmsPvI
 nCGhFTpUx9kHmfsBEpmw7hkEPwWCS1tK5ZMVkZmsj+1++KUmZNeXi60H1I93nXyykXkGssntv
 /xPpJLod4B3B76Zowa6gtNN1ykVX0ajWMLyM0YQBXiSpwutGpS/UzhMiLityZR8Q2C2EBqDoB
 1LzZVg/pbok3i2qPGGDXhw8TeUqc2VjAcJ4eDM/rSt5o5BLBdGgkQi6J4+wsdWgqMBltx+LBY
 Z2x+ilQUXU3X3rb8Q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/dev-tools/gcov.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gc=
ov.rst
index 46aae52a41d0..7bd013596217 100644
=2D-- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -203,7 +203,7 @@ Cause
     may not correctly copy files from sysfs.

 Solution
-    Use ``cat``' to read ``.gcda`` files and ``cp -d`` to copy links.
+    Use ``cat`` to read ``.gcda`` files and ``cp -d`` to copy links.
     Alternatively use the mechanism shown in Appendix B.


=2D-
2.20.1

