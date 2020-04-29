Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C32C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1BC2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgD2TAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:00:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2TAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:00:37 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEFfB-1jLvSk42HV-00AE83; Wed, 29 Apr 2020 21:00:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Haslam <ahaslam@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johan Hovold <johan@hovoldconsulting.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] greybus: uart: fix uninitialized flow control variable
Date:   Wed, 29 Apr 2020 21:00:09 +0200
Message-Id: <20200429190022.12671-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Mlh1BapjxIyzREDPZHO4Hsp4KHejN/8Ty1YIQCptm26zBMM5I3P
 wQTQKDgLNwYUCbAgRy4fe93olczzoNzwMHGD9JAaN5/yWKmh5SFbVNZfUZOS6Fx/8cAo3oi
 /azCZ5byWZRmS0620KRUL+RlGTToj0G0ZRT15dQ49siFwfOA5k+TUt8LYAOsL8Lm4800AQq
 9osmsZVASt7O7yqPQpkVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KGOa0CrtfLc=:CWMlEOVkWkLMggCRWjllmT
 wbM/3K/fRtpJ28a/tXXlV0dZxMoQegCX0a8EWZEqsT0gxOEsGbFmpi9Y/TjFxAG9ZD/es3WJi
 pZfVawR6Hz+z/JTUEVssBCpVXH7h2h5/FrOO9AGuS12Oqrv/wDzWgyKpIe/GS7xg4XLoweITD
 5w8nyW9cYFuGh8GoEq82RVqO7J/qbfcEiPcQ6CDpkA5NHHulX0N8az7QsQAMqW+kNWqQLU+ej
 0uQNHrxNbJM68U8KbgNfM4hW07bHN+SxCAecphVoOPiDhWQg3A/KuomKLXhq0ExjD847a8FpT
 KgPmN+zKVKhJCj9r1sNLRu9JumHKu5/KM4PcRgcX/9UV8AHWhPYISeM/oRNJjzm2TTKRTcSc5
 fZ8mtFc74F4yZEyxtEufzQc9AJIMGXZKKWwhHhXrUm/03bQFttRgy6foKMcvYN6BMAHPnh1+R
 fKhN48XsvrsVo4yVlOaZHai2tB3bzW2Jq2WSgfgLT5KLEv0aMYqxwtbqEXUosJeKZEwbJXLjI
 tSJRoAdQvnLjDUo716/qR3Dhrua60vBzngu0mWddP3PAhcQInGA9vdADtta4Qcc1b2ssrZ01l
 BUYU/9xybCkqzA3QeU8kQsB9hYBu03jxzE4m+pl2afsT5hizpm8cJuEB1KEDeblgZkYf7TrXy
 cyqU9pc3nExqtODcgmd2GAXOapIZdVyFQv3LPKdY7MYZD9ATIkzvF9vEoor0TDS7KKbe1fp0P
 5ckuxbImGobBOxpJRsaXahO5enR6X91hWfVLKJApkJ8ExESmf290qzGOeXWwD5aGo1evDQJVv
 vDHXeBjvIgG0KVouw0ZAXgjlMx38ZpQvdqkrLPgleiYzpvBxA4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-10 points out an uninitialized variable use:

drivers/staging/greybus/uart.c: In function 'gb_tty_set_termios':
drivers/staging/greybus/uart.c:540:24: error: 'newline.flow_control' is used uninitialized in this function [-Werror=uninitialized]
  540 |   newline.flow_control |= GB_SERIAL_AUTO_RTSCTS_EN;

Instead of using |= and &= on the uninitialized variable, use a
direct assignment.

Fixes: e55c25206d5c ("greybus: uart: Handle CRTSCTS flag in termios")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/greybus/uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 55c51143bb09..4ffb334cd5cd 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -537,9 +537,9 @@ static void gb_tty_set_termios(struct tty_struct *tty,
 	}
 
 	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
-		newline.flow_control |= GB_SERIAL_AUTO_RTSCTS_EN;
+		newline.flow_control = GB_SERIAL_AUTO_RTSCTS_EN;
 	else
-		newline.flow_control &= ~GB_SERIAL_AUTO_RTSCTS_EN;
+		newline.flow_control = 0;
 
 	if (memcmp(&gb_tty->line_coding, &newline, sizeof(newline))) {
 		memcpy(&gb_tty->line_coding, &newline, sizeof(newline));
-- 
2.26.0

