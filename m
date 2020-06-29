Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F6C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3ECA2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457280;
	bh=+tp58noZXQoEUGiIglKdWJQNuoOipzmLxZuJLK3D7ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YZQgEX0DIifX9oRxB2b1h6EC3/ifWn4eJHZWFivv2s85vg2ptx5P5aDSGefXxek3y
	 4GYuwV3zDZ4l+NFlALV9iimvCxb/e0Z7HK5pJr3PzJNsQwAE8xxXxqK2PR/iXVXptx
	 swNimc7zoxWD+zcNzPzEJ5P+rWdTpQ1MJG0XqSHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgF2TBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730364AbgF2TAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D7A254F2;
        Mon, 29 Jun 2020 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446050;
        bh=+tp58noZXQoEUGiIglKdWJQNuoOipzmLxZuJLK3D7ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zuy4gx/Gx1fV9tsSoUzbnZw9At47H2+/K9zjy3x4AklnrvonWpR8ACJdLeadx/fSw
         4xZXZthd218rpfCuN+PlOZdBpjlddBDesNXdjQ+HyHKyLrwj1nzpaVbq4kmJuQep2t
         gjDgZwYTKbHMelE2UdphoPcwU/oKWye/HIuYHOQc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     tannerlove <tannerlove@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 053/135] selftests/net: in timestamping, strncpy needs to preserve null byte
Date:   Mon, 29 Jun 2020 11:51:47 -0400
Message-Id: <20200629155309.2495516-54-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
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
index 5cdfd743447b7..900ed4b478996 100644
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

