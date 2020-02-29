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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CB4C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A73E24699
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Zzma2bbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgB2N2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:28:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:42671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgB2N2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582982880;
        bh=2GkD3a67omBM4btmmj6s4PJQvIZ/iSlOCrqt16OSVyk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Zzma2bbj3jujQMCUo3GFO42Tr8wrIsPjcvq3rOUTWNWa8JX1EeagyYMUbjuxZroyF
         OlUx7/nRMnspi3JNymTBqhXGBn6mMqzEAF8Lh7oknK7vMsAx6FmGWHatxPX+PKPOG6
         ssphKLAi2+F5u/+zU3x/BJzGB0iK6CbRXeyhIwz0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.5]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1jB2pb1em7-00HSYJ; Sat, 29
 Feb 2020 14:28:00 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: admin-guide: kernel-parameters: Document earlycon options for i.MX UARTs
Date:   Sat, 29 Feb 2020 14:27:48 +0100
Message-Id: <20200229132750.2783-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1VGkfDgASuDBsQ/DrDPKFLU0AJKFsUAAAyN9HZl5vHBWniybjGw
 ETT+7xSao2jKGK9yc1lYOuOinEX5Tw2OiCHRFIhX7p00w2x7+09tKIkztNiiT1lfpRqIt2B
 hi+sK1Ik+bTnrXWLSF5trFBUOU0DOzTnVuvzBv2WxOPi/4OtZwXuIYf9W+1qiR9IuFdv5Uu
 WIKhasM5nzHbDDQ6rD23A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KDO1UFQ67J0=:ETat77Cyobjg8abUPIEHtA
 2cp/8baAuX3mvKq8ny+nsQaYo26yBHTCiYwIBctipwavlkGDSatAFlMreIJF7bKwsckEDAIRS
 As7kKFjoK/E5jIPaQWCqvUg2m9f0mpAVpQiSewhBSEcCGTiNhMatCU9T7u6D1szRtC5EpFXiE
 Yg47oj4b8tjLh4ScwW9styJXMzJWcLds5afZnaxs3yE87yMVPc85miHGMcYnROYDF9V+v3DQH
 8ID6HKzuLm9f6WlkUF49jfYtjq8uKecUhwqs9WyDSNeTltlbsmJDN4hSMhnQnbSdjKXnO6O+y
 kPqE4J8K5LJPlLxX/ippDHjApglWGtjdpqIICJWxXaj17bqyG94YbowopjPej+ahGd+sIMiQs
 rxdaEkdLNQ9KA5enpWHTch2Ma9qXAVUGp/wr2X2JTNeLD+wvWyoe2FEka39z+g4r68mjSJcGo
 pAQXPTTmq9KfYZLgL3qPS/1xBfNprXMQi4xNIHMn8oGa5/Kn1E46eib5Wk2z5MrHmRYuD3IwJ
 hAiFc5LfcxiNz2q7CsaTSPIGHahSjpAFAL2sm9+dQEdXTl2RQzRinF1DcLkJ9F+K/aIgi7NaD
 piluHxZwa+d2YDU7b9MNwTGwYcRNOerQj4xzzQuzl6GXGEI5l8GghwvyTUYhtL6aIskBmh4Ai
 ogbfHEV/TAJdmqxYwrxgQeQMODNqjV5vKv9nhaYr7tvDKNE/xRsNkQZvg5OHFHL/utonhMs0q
 qnhqBpYJN6ZTDkr19igMaNJjAG9V/0uVdLc429cCbqpU3SQnBlyDHdIJTX5ze2dJYQx+XD3DH
 8aPae+69HzLS4y07EQ5l3USjnfhIsLKQ3H8REmNGKc8yljY3Cw+qTX0l5mbkQ7PO7AL3+DAb6
 IqAZaEqWl4bZkA3sqDudMEJE896cjBtZP1DFeyNKRQ/R4sklDxi84Ic9+A97DUhTiSo27oso3
 MYpwU3DwAnDfazEf7CPMDhXxm4zx219xUmK/KyIzdPVuvbeJb2hMBhsB3C1F2ALl3+whLk2qA
 tieHbR+GITriiv6K25zSIr2a2jSO8so6Sb1pNWn7pgjdDrJzKZAFIklXQPQ/VgoHNGP3DCThf
 2xuBC35ftRFzueu/2au1d6FOOGj786pUnUG+TboKICOqJi0e36sUgAbo3amRQZDkAjx7WhRi/
 Ufw9OcCxrivRNwHgE/k9+IERoDUWDYGtSXNs2HnRAgweEnzzHPINMSMruU2pIo3aJHrGxxDEB
 UJ4mp/HkB6UUJdqnx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/tty/serial/imx.c implements these earlycon options.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index 47cd55e339a5..d118ee5721b7 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1095,6 +1095,12 @@
 			A valid base address must be provided, and the serial
 			port must already be setup and configured.

+		ec_imx21,<addr>
+		ec_imx6q,<addr>
+			Start an early, polled-mode, output-only console on the
+			Freescale i.MX UART at the specified address. The UART
+			must already be setup and configured.
+
 		ar3700_uart,<addr>
 			Start an early, polled-mode console on the
 			Armada 3700 serial port at the specified
=2D-
2.20.1

