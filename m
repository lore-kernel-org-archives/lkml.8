Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EDBC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86282082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgAJUtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:49:18 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:42631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgAJUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:49:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MDQNq-1j0R5F1Bvq-00AYsu; Fri, 10 Jan 2020 21:49:11 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Rich Felker <dalias@libc.org>, Guy Harris <guy@alum.mit.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] hcidump: add support for time64 based libc
Date:   Fri, 10 Jan 2020 21:49:03 +0100
Message-Id: <20200110204903.3495832-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/h9Dsyrfgqwfb1d0gBYxKrEQQCWg4bujxtrnwT3k69wgG/HcyJx
 SCNlCHyOmNHVBHKg3xWZ25yYNx47e894CdRU18dUGtPrjXLD4Q15+vteQxInyyvWPyBJgyN
 aCQ0eJaA+ntnx4e1Fh7xNMXCsW8qaznzZhRo/UXItsEjj6nAxiv9mQlMSb+yFSuLSO+w8Xg
 TX8IW9yAyj3AYQs0Cv/jQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lO4Yb3kycvY=:4X6ve/YIqvpcDzfPVG9/XO
 odIxjDHkkryW+alKWrotg7ttLTtLADIupSTIcdzSKnWZsKOxFYPy9g3u26znY8/YsGhuDPxc5
 Rubfx00oBVuQqsg37S4CnpzjN4ChtJJynBFCJYSm9W5WU0DWLG/Uvj+b5Hzt+LIlBr3FO3ATi
 Cc1jX81Y5XO2jmCjAyunnQQ+/GlEgSSJEvwvyklwqEuC2FPq9SajuY627V49H3lNO2x5h1+ed
 A0Lpp7IxH4WpS/x7bikIMDHx02O4HUvKm4IcZqlCjAdwa1slh1heFK6tMEEiqdpBnsHu/fYzU
 lpdOIUpKelNLszvYsEh0BPfQ4FnPZY2qmgbeUOWHiyJu8qT7ibEYzfdi/ldRVCjYmabACFxkO
 qS81I0W2cMiLLkCEFaa6+KWCKge9CklEDsqxdsEpXQPLl5gGuT6H6A2uffhqIXM/YyLN6vwcG
 iMHiVjyefaOycd1QzyIdWpp+fFLohSd1KlyQWr0rIk81A1GVOGYcRYZgAlRfI/DyATZGbLS6w
 soS/5V7VtOA07bKwpfbTXSuiQxAT+ldprDUcWijMRcfkZJriaxYGUwF2f6MO+LjUcnoDXGjfm
 FrcRhtpKZ3WEgLQsxeJUf1vSbSAsGSgOyavYo6m69UlNesq5uo0AwWPaAQsJmhIdG/UqZwskn
 utKPO+TLE/dUuOLvcxT5y5Nah8JNWSK39MObmSO+T+9mkf6/qB9Xo3YuqUYKVBhOHjbAO0XGd
 3WyoeftTCtXysaW+UMim6/tZy0v+In+NUp4MrKTVcY9Ll7GtS6aTsNvVVTR5SV7zpJhjdzulF
 ucDpG4lje9l3vYB6Tgpvh7IZJLrT593zv+Q2Fg0bVwyuccBmV8mBkkHUSb7LJwDloYlPb1TnT
 7VwYHlKqKuPlVorb5QyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

musl is moving to a default of 64-bit time_t on all architectures,
glibc will follow later. This breaks reading timestamps through cmsg
data with the HCI_TIME_STAMP socket option.

Change both copies of hcidump to work on all architectures.  This also
fixes x32, which has never worked, and carefully avoids breaking sparc64,
which is another special case.

I have only compiled this on one architecture, please at least test
it to ensure there are no regressions. The toolchain binaries from
http://musl.cc/ should allow testing with a 64-bit time_t, but it may
be hard to build all the dependencies first.

libpcap has the same bug and needs a similar fix to work on future
32-bit Linux systems. Everything else apparently uses the generic
SO_TIMESTAMP timestamps, which work correctly when using new enough
kernels with a time64 libc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 monitor/hcidump.c | 32 +++++++++++++++++++++++++++++++-
 tools/hcidump.c   | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/monitor/hcidump.c b/monitor/hcidump.c
index 8b6f846d3..6d2330287 100644
--- a/monitor/hcidump.c
+++ b/monitor/hcidump.c
@@ -107,6 +107,36 @@ static int open_hci_dev(uint16_t index)
 	return fd;
 }
 
+static struct timeval hci_tstamp_read(void *data)
+{
+	struct timeval tv;
+
+	/*
+	 * On 64-bit architectures, the data matches the timeval
+	 * format. Note that on sparc64 this is different from
+	 * all others.
+	 */
+	if (sizeof(long) == 8) {
+		memcpy(&tv, data, sizeof(tv));
+	}
+
+	/*
+	 * On 32-bit architectures, the timeval definition may
+	 * use 32-bit or 64-bit members depending on the C
+	 * library and architecture.
+	 * The cmsg data however always contains a pair of
+	 * 32-bit values. Interpret as unsigned to make it work
+	 * past y2038.
+	 */
+	if (sizeof(long) == 4) {
+		unsigned int *stamp = data;
+		tv.tv_sec = stamp[0];
+		tv.tv_usec = stamp[1];
+	}
+
+	return tv;
+}
+
 static void device_callback(int fd, uint32_t events, void *user_data)
 {
 	struct hcidump_data *data = user_data;
@@ -150,7 +180,7 @@ static void device_callback(int fd, uint32_t events, void *user_data)
 				memcpy(&dir, CMSG_DATA(cmsg), sizeof(dir));
 				break;
 			case HCI_CMSG_TSTAMP:
-				memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
+				ctv = hci_tstamp_read(CMSG_DATA(cmsg));
 				tv = &ctv;
 				break;
 			}
diff --git a/tools/hcidump.c b/tools/hcidump.c
index 33d429b6c..be14d0930 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -136,6 +136,36 @@ static inline int write_n(int fd, char *buf, int len)
 	return t;
 }
 
+static struct timeval hci_tstamp_read(void *data)
+{
+	struct timeval tv;
+
+	/*
+	 * On 64-bit architectures, the data matches the timeval
+	 * format. Note that on sparc64 this is different from
+	 * all others.
+	 */
+	if (sizeof(long) == 8) {
+		memcpy(&tv, data, sizeof(tv));
+	}
+
+	/*
+	 * On 32-bit architectures, the timeval definition may
+	 * use 32-bit or 64-bit members depending on the C
+	 * library and architecture.
+	 * The cmsg data however always contains a pair of
+	 * 32-bit values. Interpret as unsigned to make it work
+	 * past y2038.
+	 */
+	if (sizeof(long) == 4) {
+		unsigned int *stamp = data;
+		tv.tv_sec = stamp[0];
+		tv.tv_usec = stamp[1];
+	}
+
+	return tv;
+}
+
 static int process_frames(int dev, int sock, int fd, unsigned long flags)
 {
 	struct cmsghdr *cmsg;
@@ -230,8 +260,7 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 				frm.in = (uint8_t) dir;
 				break;
 			case HCI_CMSG_TSTAMP:
-				memcpy(&frm.ts, CMSG_DATA(cmsg),
-						sizeof(struct timeval));
+				frm.ts = hci_tstamp_read(CMSG_DATA(cmsg));
 				break;
 			}
 			cmsg = CMSG_NXTHDR(&msg, cmsg);
-- 
2.20.0

