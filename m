Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008F5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C678220FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443978;
	bh=WJhUlbUTIN1K73n4tY0V57/KVBPeXnvmTmlAw1UHdiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Av5VBRp6Y7tf2enn9xLdMXd5UAokIUN775k2lCNiDM59Mp1QwO38KTMbp/77ATaNE
	 Bm+3ckeXNQfLvnfZQuLhKjilLm7aYR+fJ/FkTRrEJnHHs0dNr6IGlfbqW16c6dJ+vP
	 3JlJ6XMNwqGaIi2mPMo5CWNlfrYjFKLA+NfIxOhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgFRBc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732440AbgFRBaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:30:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B5C22251;
        Thu, 18 Jun 2020 01:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443802;
        bh=WJhUlbUTIN1K73n4tY0V57/KVBPeXnvmTmlAw1UHdiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjRrNfS/vVsz/oFYnw077MuI2eVdNHPnUp/P8dTRbUfJcgOjAOgl6YnYQU73ZRjwR
         1Bf4LdgnLXTx14H66cDwD5A40Hjpd0qcVZhlkf1NEcnEJ+f6RY98+FICTZZEQzvVmC
         uSEaEdhvejBKjZ9/XtGSmcgVrh8BqK4JiYc/wrw0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     tannerlove <tannerlove@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 79/80] selftests/net: in timestamping, strncpy needs to preserve null byte
Date:   Wed, 17 Jun 2020 21:28:18 -0400
Message-Id: <20200618012819.609778-79-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tannerlove <tannerlove@google.com>

[ Upstream commit 8027bc0307ce59759b90679fa5d8b22949586d20 ]

If user passed an interface option longer than 15 characters, then
device.ifr_name and hwtstamp.ifr_name became non-null-terminated
strings. The compiler warned about this:

timestamping.c:353:2: warning: ‘strncpy’ specified bound 16 equals \
destination size [-Wstringop-truncation]
  353 |  strncpy(device.ifr_name, interface, sizeof(device.ifr_name));

Fixes: cb9eff097831 ("net: new user space API for time stamping of incoming and outgoing packets")
Signed-off-by: Tanner Love <tannerlove@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/networking/timestamping/timestamping.c   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/networking/timestamping/timestamping.c b/tools/testing/selftests/networking/timestamping/timestamping.c
index 5cdfd743447b..900ed4b47899 100644
--- a/tools/testing/selftests/networking/timestamping/timestamping.c
+++ b/tools/testing/selftests/networking/timestamping/timestamping.c
@@ -332,10 +332,16 @@ int main(int argc, char **argv)
 	int val;
 	socklen_t len;
 	struct timeval next;
+	size_t if_len;
 
 	if (argc < 2)
 		usage(0);
 	interface = argv[1];
+	if_len = strlen(interface);
+	if (if_len >= IFNAMSIZ) {
+		printf("interface name exceeds IFNAMSIZ\n");
+		exit(1);
+	}
 
 	for (i = 2; i < argc; i++) {
 		if (!strcasecmp(argv[i], "SO_TIMESTAMP"))
@@ -369,12 +375,12 @@ int main(int argc, char **argv)
 		bail("socket");
 
 	memset(&device, 0, sizeof(device));
-	strncpy(device.ifr_name, interface, sizeof(device.ifr_name));
+	memcpy(device.ifr_name, interface, if_len + 1);
 	if (ioctl(sock, SIOCGIFADDR, &device) < 0)
 		bail("getting interface IP address");
 
 	memset(&hwtstamp, 0, sizeof(hwtstamp));
-	strncpy(hwtstamp.ifr_name, interface, sizeof(hwtstamp.ifr_name));
+	memcpy(hwtstamp.ifr_name, interface, if_len + 1);
 	hwtstamp.ifr_data = (void *)&hwconfig;
 	memset(&hwconfig, 0, sizeof(hwconfig));
 	hwconfig.tx_type =
-- 
2.25.1

