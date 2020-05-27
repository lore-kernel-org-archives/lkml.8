Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC413C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C03207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbgE0Nwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:52:39 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbgE0Nwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:52:38 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MMoXE-1jLBAj349U-00Ik9A; Wed, 27 May 2020 15:52:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Henrik Rydberg <rydberg@bitmath.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] hwmon: applesmc: avoid overlong udelay()
Date:   Wed, 27 May 2020 15:51:57 +0200
Message-Id: <20200527135207.1118624-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2aeiuLmb1dLgi7CFDVrF6BpL6xMbUnnyYn6LzeFFcrLYkjJvi4Q
 zhD/aywWrEhjJlMHVsHJ9H7RZOXfvz03y1zixMWfLDaXmhdSdKAvA4vYOKPIR62dhsnjkRy
 PQrRhFB59J5Und0uBufrL1DUUZzgFupAr/+RKvLvmrr1sx8KERP0XOu019Q/Z/YD4ZqDQrj
 tJDlSk7aHf8ZJFFvcIIqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hEZH9Fbdx2c=:+3IXxtfC8iBrYIC5IMAbAL
 IfcqYO18TfCSdLwMOX5M4EoxfNKL38Q6LZ+VQ53ouFfTaNeoEbPXjj/cn4MnhhiCHJHBiefGD
 LrXWuSY7swE7VrFupA9C1T1qEwe5+4T9+XZ12s9YlyLdMZd1pq9sv+stsjNfdQIdr2VQgGS0z
 11gSNAA6zFDw51Imzg3t0+3O5iyS7sKZ1B/hZYJEmEcj5JL1lRrkQxFPezYLZN4zJwyZm6VAp
 wxsPeAObWQBmQofDe4yc0NjWlFNMbcPlw2/TLUN1v5XdgYzehEizJvEcIiJdvSwI8vcPt5hGB
 j3ASbQXrw1tQOopjyEMkZZRYjYubdG4ZUmMKMYlf2Rf59pqiNpnGMU0MaGHk5dgn6RM8+WvoY
 sl4e61i95h64RUMy9r33AscEvfhujA/w3eiuTSs/NLgkgwapB6Qpwfyjc9fKkDFj3Kuy5adKN
 /pMQjL9FryH5lPG6WrBPOwPQI/1gXZOmZPDbTIKZOL5eesEI0YqcMjP+PakK1xuwZguobzW+6
 7RFxuP/50rrZTRuvmO8BporZEkrXmOxX00UB7uNindyP8QeLer70ZmxsQlGAYDt3GgULswENs
 DSx6ZdyVZN8jnUeMR/QdkVL1gU8bHXpF2Ayqzeq7GP1+vnkc6EFyR2K8gv6+VBmWkgEJXPYlQ
 ZpaQKHDjPsO+laLtGlBXUYP6qVE15MozwBFTDFo3IZ8sY9wApFqL4u1F/Gad8Sp0I+lRg/2nS
 ZOuCBjo0tUFJ5A0mL/1NCUht0H09dxg+KMPuKIwXX0cXMVDbW2MGYupu3+lHMpTbTwTJ79GWZ
 4QcDUy7nZTynb+OYFvXnRovk4F0CQk/rH80IU19F7qcd4chv5s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building this driver with "clang -O3" produces a link error
after the compiler partially unrolls the loop and 256ms
becomes a compile-time constant that triggers the check
in udelay():

ld.lld: error: undefined symbol: __bad_udelay
>>> referenced by applesmc.c
>>>               hwmon/applesmc.o:(read_smc) in archive drivers/built-in.a

I can see no reason against using a sleeping function here,
as no part of the driver runs in atomic context, so instead use
usleep_range() with a wide range and use jiffies for the
end condition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/applesmc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index ec93b8d673f5..316618409315 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -156,14 +156,19 @@ static struct workqueue_struct *applesmc_led_wq;
  */
 static int wait_read(void)
 {
+	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
 	u8 status;
 	int us;
+
 	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		udelay(us);
+		usleep_range(us, us * 16);
 		status = inb(APPLESMC_CMD_PORT);
 		/* read: wait for smc to settle */
 		if (status & 0x01)
 			return 0;
+		/* timeout: give up */
+		if (time_after(jiffies, end))
+			break;
 	}
 
 	pr_warn("wait_read() fail: 0x%02x\n", status);
@@ -178,10 +183,11 @@ static int send_byte(u8 cmd, u16 port)
 {
 	u8 status;
 	int us;
+	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
 
 	outb(cmd, port);
 	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
-		udelay(us);
+		usleep_range(us, us * 16);
 		status = inb(APPLESMC_CMD_PORT);
 		/* write: wait for smc to settle */
 		if (status & 0x02)
@@ -190,7 +196,7 @@ static int send_byte(u8 cmd, u16 port)
 		if (status & 0x04)
 			return 0;
 		/* timeout: give up */
-		if (us << 1 == APPLESMC_MAX_WAIT)
+		if (time_after(jiffies, end))
 			break;
 		/* busy: long wait and resend */
 		udelay(APPLESMC_RETRY_WAIT);
-- 
2.26.2

