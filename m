Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A55C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101E020658
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M7FlobI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIEPKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 11:10:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:50047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgIEPKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599318628;
        bh=fYLT42DRAjLGx4SOUkR0adm7dHZTNx1Xf2WMoFCeuKk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=M7FlobI0lYis+I4ffNGid+M7LxUwAzYemKuG+Ckb18xCBEvgzocHTJtKzU2M9MNYx
         MELyLM9kMQm1q+YA1JQRa5fOwERaMIqjcv8bhWhuAxEVTTeFmFRL9Xpq7bxmcoTTO9
         zMml7NR2+4EqDaekplv5I29C3dePPHVO+Nkpp7tU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1kktWI2kaw-00gXq6; Sat, 05
 Sep 2020 17:10:28 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: imx: gate2: Fix a few typos
Date:   Sat,  5 Sep 2020 17:10:16 +0200
Message-Id: <20200905151017.1086353-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DvrplQMA109kQN0Whs6f25qs5lwi7GOqTpyuGc6sGt0K5Hs6qzM
 fxqXbZj5znIN3zZJlZuR7pPef87/hP+dg78T3T+RqSnYBAEXEbVQdSQ2ayKyIGOMxqFV7bE
 JzaAUuRsPyVkMbhmsW9oR/LhYwXq/S9Tm7gbMVeYalphJ0F8FQzfHJVOA6mov2l5QRt4YJJ
 BJ/y9Qa+4SIvJkKZsvwng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8qRA+4MO+/g=:vSmJBzjGMKCBm7NMuPT/BJ
 W5KNSEna269gMo1CY3uSN5A9WxxD+8GRXpaWwRV7FpuKzi4J/mn+SNJ62KQqJhv4byoDxyAsX
 CE96OZWbJYbKoa/qQwHq8TULt36pKffZYV0f4tIV+tux1elZzvc0GW9xS0etl82BDp/pVSpj5
 AG78/+Cwz6wbgxtGXK2TgPWAIDYJRs7flNnyCa4lBJQKsnG6pNgtKajEtK1PfH8tv8RvLIhB3
 QHpKhf7yHDzO1N0wtI6uLmMtA3jwLLBy/qzbuTQXEqgwE04USxX2XYg08Xou4pgymcBVxUzgC
 KSEHchLh/XE3Y/0V2XeLEbSHmICL0oL6/CN9reGtPQqCvAa+hYU6huusS7KRagj6Q2ns/J0/x
 yhsKCIqlEOxdctm7qmxs784UCChcMqO1DbFrZaeS5UDkau4R51yhk4IMqyfyzopsogioWjRM+
 b65xI2AYP1/rBKK44l9c+XSl0BrOhMBTXkHNHJ3So5Nvl6lq55e8RWkzjj7j6VWEuIQmv6K7b
 X103jdiIJvzkQ8JdtuoWq9QFk7d8SIqLSRXVGXaz7iHF86EvnwZSTa/K1jw6qmBYDkThFXhdG
 tDf6zteOM/09BhI7eeA/FqPj6QTeTk4/04enhQur/6GjTeKCCmFa1jdK8JiFE0psmpE/HBXek
 NYg5f3USzBDFsdKpzoLbOkUFWOBaadQwE+iy4TJ+s+9ALCG0hg8mN2yca4QOsHKzzYqpRpJKc
 cZuhwIjPfjYnE9ODK3pXlLm+J7yNmxhPEzu/EFaXHJUWcq4jAe0kY8TYow47efcw0kvyhKsUL
 5hkQWznwGBOn902XubjnXt1dbLgWxvDBjX5uIAmSY9PzXUZRsvEobhNv9IvfKt/PK9lAxZa9n
 Q6sUegzYqnp5Of64vQqsbyxxaS8ASdmmtkfFgmftROAIeEW3iE3K7KxQ7FUf/ZYknWJMHVNIw
 XgKuML/duPoXJUTIsagKYRK8SfIB/K99FShJoY7J2fSu+FLGlWfPSKndTeRM7mANW5T+nXp3x
 0hMKyD/DOcVokrB4bAEgrQKC26Hk8IR8h7iMNCApSJkfe9yo51QsqhGVOMFnSOMWlczoYhaMn
 bPJzrPLu3X6zAsQqZlDv17BGR2Tjt7cgKNbifzTKyidra81gCPKgN0KxAR3asb5D8s88+4e98
 o5rR6ygSOLxJd1C/ObNAYev9lpLnfFTTrDqZ11sCUWZiFaPJH1XNrgELyYT+JFBHM1bV9Bu2q
 PUcfR/QetRocqHjrSl6nAT53YjIZhJ/MT9J5W6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few words were misspelled in this comment.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v2:
- Provide a patch description

v1:
- https://lore.kernel.org/lkml/20200308214927.16688-1-j.neuschaefer@gmx.ne=
t/
=2D--
 drivers/clk/imx/clk-gate2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index b87ab3c3ba1ea..cc64713c5e5f4 100644
=2D-- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -15,7 +15,7 @@
 #include "clk.h"

 /**
- * DOC: basic gatable clock which can gate and ungate it's ouput
+ * DOC: basic gateable clock which can gate and ungate its output
  *
  * Traits of this clock:
  * prepare - clk_(un)prepare only ensures parent is (un)prepared
=2D-
2.28.0

