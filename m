Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D003C10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000C420684
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EygN2SjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCHVt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:49:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:33383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCHVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 17:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583704176;
        bh=uvTnr5QT5mOgGF73WARSWzpFJoFtVP4k+lkjGy7VaEE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EygN2SjKr6omx8QyzHBd3aD+c/3WnsdyRbRwwqN87qTpwotlDUm4oHZhcerMEVS9A
         OKgWBdsvnPRdXX3iYab3IrKnn4Jp8rcWA8hQe85hp1849j2uHhJnznJ0nSQqqkA1jY
         YiCpHQZTntXk0QbdadJu2mt8buClnbj2rwBVvCb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.212]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1jP8If2jHx-017l3H; Sun, 08
 Mar 2020 22:49:36 +0100
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
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: gate2: Fix a few typos
Date:   Sun,  8 Mar 2020 22:49:26 +0100
Message-Id: <20200308214927.16688-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TR0iVzdX+30Zder+jNCdtNUVjBN6YV/5WNwW7AyqXPrAWGNQWUM
 /ysJa9gQ6nGCJJejBMJPcfDhNEroAVHxs7orNweEg97xgrHZ7gMuiDv2kitzBDaFuCD4FZ8
 /vJooFp24hWq+C1nZ+7r6yOZgoLW5JNsoO0sOW5PN/lj9TWLn9fPAHlq1tmOAtnRHhqxqZW
 xAytEn1376bJoGjKOW8xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wwDlsyUpAjg=:MsBHMYfRXw/ljJvdaaAlmq
 Ww+UVemjqlWKGpGxwfYa92RtEtiLFydmZjBBoV1MSkRF2cuSEfWssEAIqQCkih0l5++voqsXs
 TFCvIB0749vQ859whrkJa8dgnBnuTvLcp8GPn2s30T6hy7zFefkzmPrsrBXkbiyxYcFbn0saZ
 XzxJ6tWvCFcAl7rbZb//OPVj6dhTrR6Id3T6NLH1pDrU6BZqD7B1ou4sl/QL2iVSSvNPioTNd
 sFNJJNkE2phGwkumMENE1B/tYjkXkH7L1rDa5JzquAMVPw0t6BfdLZmz+ZJyig7/5BBz+/7wZ
 cbSjed88LUtr/heJe3+ZgXaUa+5JeST/Z4VHmP6nOz2IVgZVlpYWqx+LtKIhKN6vnrKy8dUjh
 GUKm+bX5jyL8LQ58RjQuxWqv3j1NsctW0wSpOmPF7rlahfl0VxDMmG0OWE1JHK7Qlw0Or6Ibi
 zEAnX5NQ00Xe4bASKTZeVimgMsXdkH+W4dlZCLpLT6/9z/81XICttfd0lewWT59Qo2dBbO8wU
 E5bbcZi4hKE+pSili1XhX6+53rYkkl1Bj7KA7OjX0vi03wROQeLBNDzuYEW05Zx145w5w3Tjd
 dlSXuHKxnalLeSCkBCXndZNsssLxosM7jGGKtAfyCUQUJIqP6enfaUJ9BGxiYc44TtsAS3znE
 y88zwyQfk5h28t7lXsm95pMECsQFb3mQTiPoxVTW7WOdznOOADpmG9XGcayMyFPOQPIZVdEF2
 SuHfoAuVkiKOgjqIXvtdZuH163xbUizGs+WHTDVcc7S8BKFtYsu62ZCZytVthmrZfCH1A20EA
 fU1ol910Iz/lT6uHWSuLV21sI/Coswd0nK/iH1m0AlxeYDgysN3Gvq/MiD6VwAIQBXAp7VFD7
 LPE4xTY9DjJxHMD7fH/OPxEX2lWD75qQptWZY66Ieh2W2OqGiNiDVZMN5vkjo45qarGLWoBi4
 wMhNAWusjOOimBw91s6lQCTUuiwWbf/DGHSaVf7PGY+TLS1jxP410+GDuvgIsz5m85YG+oBWQ
 f3L1Ah5UlimAJStD7j0DtBFBbN4q/nOrQZjWq+XF0fXqfUklwdrM5Wq/kKxA6OmToqQCHT5kH
 HTNY25gCnQ8LS58lvxgiwm+lwqffE2/Y6L3252UKMET+S63TbIm6cXe89I+cGnuElGL0bBmvm
 +kMkhoxEAs4wAZnI3N5Z+FUJH9fxW8eS9HRpiuvw6/G+CkWGEXt+BEtcVj+3ZMgCEkq/tf08l
 KpD0SdgJuHLMmQTq4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/imx/clk-gate2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 7d44ce814806..a1230cc215c4 100644
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
2.20.1

