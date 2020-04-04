Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C8CC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EB6206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LjVijot4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDDOOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:14:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:33609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDDOOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586009685;
        bh=WSffiIyo51Rojwse2fXv4RYk6E6kNLfPBGNLqeexlHk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LjVijot4U0EN3EqFYTvfjw2RSsUaVbO1DGZU/xuh/en1vhe36Hfu5zSemQ4fupf87
         3nkm3WgrXVqbiUIz54upGmMN5cDKJ1sTe7M9sdu8Gci7vVaxddCaTW1ssrG+ZVY6qS
         jBWqTGKpN92+gkL8Vl3DPQ12jzLT7cUPVyR3eWQk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MbRjt-1ijU4q1E9h-00bovg; Sat, 04 Apr 2020 16:14:45 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: vt6656: Use ARRAY_SIZE instead of define RATE_54M
Date:   Sat,  4 Apr 2020 16:13:58 +0200
Message-Id: <20200404141400.3772-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200404141400.3772-1-oscar.carter@gmx.com>
References: <20200404141400.3772-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CMfo5+R6LSyz6GmD+T60rQ6fSDRfJVJ3lHLwc5LtnFIKQIP1NCo
 PjAqyHUEpaaM7ANcDBj0rImcW1QWq6cWluqni/W7otViwxeIwtWIkTb/se4z0hQtvd+BPlm
 0b9O/ySmfzqNG6p7mQQwD5o342ddCcNPqsaixKXlwsPNKeST2Ga6c3D8mMsh2L4SOkbTbl0
 HQaURs/dhWE67vZ9l46bQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ai4Bj2d9d6M=:nQLpHR/oVT1o2HdpbrKvgL
 d/E3zD9Be9tcY6z5RyTUOBHygYdJ1r8lQNwKR9ju7rkNylwoPlj64A8zV0O1ASk3V5c+BH8yz
 tWWRMCjodMUP1rqpuMeXH5J4yXzcPixih0+jO1tkxZmviqTOT3nVvUEpVop5jMNVLRZ2qHObI
 6YNrbMbrZt0pCU2zQe7C3i6D+4or5UbCLgFSLzWy2fPlsGbSNBBFLMMNP7cZnrlxjwPpvUyDq
 qYr8rO4yPVycGxBbHv19w4r9RZDaBuNB6oizvLa0GOuPWHDFgnvFTPHGC5j7doqESVIIgfSu7
 +jGh/AoaoQIxtJKcl3Rm5evFOc4Xm6rQLeSRrjZlJpLvsA5+nbHwWKkaD4L7EBX1v+n9xTacx
 PiNjFMJSIpEOjm8IkAG1Gc7GhNKheXgP4Hod5YesgXOi/J0Sd+tnUdhyLlYnMV3EYXDYe4v88
 5uYfjXKL8MP6Og4xAvBuw2A2K65di7rcDXfSGeHhoyVyd69PsNFdbSVHZt4h+UzroePPPT8ZT
 7O3mJuALzp/VoXy/Xfo1ca+VF07aqCLuMyMDNsFWMTZD5ZGDQxQN9vFET05V/DITiewMJ7CJm
 KNff4uLC7zWC6wrBZUfL79hXyBiaBQaIMUjk6xyeVlPxqCKPkQX/J73o+jHcrwsCi0EVVzv2K
 poBvwP4zPoTN/ZmV7gtMqY0ODGR7+KUKGBYbAunBAYJOOfTHnkmxanYrMianRy+NylXCUIi/b
 pZrxWe6iPGl6wj9JS/FuxTL1HqZglkx+/ltiwt2ogzGfae772XRMtJ6G+ZgarNjzPkb0htVVF
 x0HxWBTiYYCaLyiUwD1/vRPeyXAc5RnYk5tv0Ph3GTLOKUt/8Vpg2RBXAFBSuUyQZUwJLxUBI
 z0B0sdLs4kN7Vs2MHpcIPZs9Q4Gqx9dyOaW2EuqHsQyaIXLHNHEF/wvM3trCmlUiaQBV/L1mD
 9iDB8R+e+KPbPjQAYLQaaGjScVKbH6f/KsO7zSg1HWlW54qzxMN89TYePKClSb9aAqHDSUhJ2
 I9sxF88uitDRciNfX5GJaJORMjREUsaz/TM68OkuUL/B8JITEu9JgoN2zH0n7LTM5lUi2ZQb6
 U5jf3FY41A3KJgTcEdFWKxgVc/f4oC0cngSlEKVhdypwTKLtLp/jtaAbwk5TRH/8eOi5ORr4O
 +zUQXP0vMddaD4q5zTJTlGPR6x5wAScJbGq/b6YlzFydWwsAqWkQirYGaOS+FmCGLXpxH8owr
 MyfVBVQMl5luv8NmA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE to replace the define RATE_54M so we will never have a
mismatch. In this way, avoid the possibility of a buffer overflow if
this define is changed in the future to a greater value.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index a19a563d8bcc..3e4bd637849a 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -136,7 +136,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 p=
kt_type,
 	unsigned int preamble;
 	unsigned int rate =3D 0;

-	if (tx_rate > RATE_54M)
+	if (tx_rate >=3D ARRAY_SIZE(vnt_frame_time))
 		return 0;

 	rate =3D (unsigned int)vnt_frame_time[tx_rate];
=2D-
2.20.1

