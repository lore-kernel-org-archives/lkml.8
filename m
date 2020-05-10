Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A66C54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 10:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9216D208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JVw1N+XQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgEJKPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 06:15:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:48871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgEJKPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 06:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589105704;
        bh=c94OQCbIxiDreJXOOPOYlV8SFiSiAocVWa/041VZVpQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JVw1N+XQrYvsd6AeYc+5u5cw1mxRmhQ8gzhFW8lSrmJ45l6bEEge34PSxfJdOfcQG
         TvhMR+Kbe8lqoRu6r170Rf4e+sN8n2weZKMnuOtcjoZ7j0FuXqA9ocnhgQ+ZIYShPQ
         wWPzQi/UX0BIq2JAmCAjPxmCm6yV88aXLvYRWN70=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mgeo8-1iv4qq0miq-00hAdO; Sun, 10 May 2020 12:15:04 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Axel Haslam <ahaslam@baylibre.com>, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH] staging: greybus: Fix uninitialized scalar variable
Date:   Sun, 10 May 2020 12:14:26 +0200
Message-Id: <20200510101426.23631-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ps47P7hYVAoS31u+W1goqC5mfPrNR/UEtJYg44fQfgXMP7xUMLR
 VyH32hTPzXF8DfglQWutmqHJQygU63dOrB5mN6HHOswWY/Q4ScyS4jj3LKp9UVJl3nhuWFe
 yf3FlT+KTGCBpvXsA6kf+esHXmEtMbut/1NvexTWaRH2WFcbZ9sSWHo4jpDWfWx2JgMVhOJ
 Ec8V+AP/T1B3/1EhuqEWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g/kiqP+Wlmc=:lF7MhoWLDll1mzH2Ei7uf3
 MhpX/geJXvT92bJd6tFNz6tnzeYK6kFCy2VHvY4v+v9fCBLRVNuIJ1Oh9xvjeH8Z8hXYdEUMy
 8+277b4AxH+9j9gCDMrZnEiXZBcfpwcPukj+5HnS4Wqarvr2mt7lO/sMfpNls04SIsEJUUgGS
 X2RJA3Azg9W3bZxF7bQ6/Uuoaxs5DihLoLkGSius8k2SZJyPk/EdTTpx2/+sHz9jRfUPNP43K
 HKOOjy3F5E5nB9q5KZB38ilYZLKRoGWmxaJx28cMsmdzRN5DGWSjHdYDElRivH7Us9hpAHaqN
 S7760GF5W84KwCLTrJe1uXDHnwDzjNAyferRRjP5qTxN+5Sm9lC1JuzxW8fD1mV4fSg/34wRJ
 4cu92mj7NuJGUj233GMs8cOWqrcdQZGxg3abLmmh4q/S3zNlNyIm9wgSFRHgsR7hr7zBh/gOF
 OGlROH5PyOBLup0djfevEPoM+qaVq/qdRk/u5v0Tqw4QvLJrw6wYnHFmvOzsQSHkiEJGBlpXU
 /cL8tyZXKin3EC88MppinNmMF4XHxaqS2qvQnjpO/Wxus29uG3wAHr4BXJgmhLchkuwwjT5aV
 MwU25wF1qFVIGRtQI6rdUOfIAtm4wxMJ0dHnyAlUZ9HzePkq/yk4RLODB8LuiSX7cUA+wmMs0
 iDc2vF3oJetpFIRaURZXIxIDsVP3+mi1eSnDD1nYrmas1vNrOE4q7XLwALvUkS8DvB1m9xIbN
 /S1DFpMGDKVoio2TtqYbI7hh++izSR7U0tQKE2oSzLZGlJnLlTtWFPwNncpnpVs7DEYpUbV5b
 EgszLtp2dqViYnc0w67UOh8ewyE63ZZc4DJp3FtCHnlepTwEV20qxM+X2xu60+gdQyJSs7R93
 BQtzFHibDlUdSLqUn7bhTOI7F39qvAU4hENfCTKMT3/0w40Q+WkSoNb5/GaRNeOWYFrSxOvKJ
 9M2Dl30rYcenAG5duzFEkdGY2U8Dbny2D4jM6SCT0PUqrzX3R3WQm3zIaoRbw7uFTbX2JSqgW
 TArH41REMiTHxkQHud0XsS0wDC1DKdDgmFPhOeVZ6uhJSgWtpzHNTCiz7haOcxPNAaKojzFXc
 IDsd31gqGn7hcdtKhr01i4u5xaQ18Q5VqF3o2aWp8+ISIP6UNBA3ZJWQ/DwmZKEvuIQOqfK5C
 /X3qmFJvSjWoUtRzRAMh13mY4CXeQrzU5FAyaDg3s+OggVESQprqeytijhN1v4nETkZh2uH1X
 E+1E88RE90iYt88GM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the "gb_tty_set_termios" function the "newline" variable is declared
but not initialized. So the "flow_control" member is not initialized and
the OR / AND operations with itself results in an undefined value in
this member.

The purpose of the code is to set the flow control type, so remove the
OR / AND self operator and set the value directly.

Addresses-Coverity-ID: 1374016 ("Uninitialized scalar variable")
Fixes: e55c25206d5c9 ("greybus: uart: Handle CRTSCTS flag in termios")
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/greybus/uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart=
.c
index 55c51143bb09..4ffb334cd5cd 100644
=2D-- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -537,9 +537,9 @@ static void gb_tty_set_termios(struct tty_struct *tty,
 	}

 	if (C_CRTSCTS(tty) && C_BAUD(tty) !=3D B0)
-		newline.flow_control |=3D GB_SERIAL_AUTO_RTSCTS_EN;
+		newline.flow_control =3D GB_SERIAL_AUTO_RTSCTS_EN;
 	else
-		newline.flow_control &=3D ~GB_SERIAL_AUTO_RTSCTS_EN;
+		newline.flow_control =3D 0;

 	if (memcmp(&gb_tty->line_coding, &newline, sizeof(newline))) {
 		memcpy(&gb_tty->line_coding, &newline, sizeof(newline));
=2D-
2.20.1

