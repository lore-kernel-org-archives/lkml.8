Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E02C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D740320702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945972;
	bh=+tp58noZXQoEUGiIglKdWJQNuoOipzmLxZuJLK3D7ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1PHErm+wyr6iKct9LzLey7sg5mpX4K7wV1Z9RaUHuUSQGFAWbUJgSMC3i8OAbaL5+
	 d4TOevUPiEUMAO4YOMkPltzhsPJqTbTSnTMgwkHWzLF9MhTYcE+pX+d1h1YtuebUW9
	 FdHR7b9c+nCpqrKBgGi+vQMBTwKG7VMW7scw9wEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393107AbgFWU7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403816AbgFWUk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:40:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF0E020702;
        Tue, 23 Jun 2020 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944858;
        bh=+tp58noZXQoEUGiIglKdWJQNuoOipzmLxZuJLK3D7ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXwdwyZPFu0QzQlZ+EmgR/zCafL0QcevBzyZ8/iZraOgSNCVs4ON6x6DI491Y/5RS
         5ybGNXiyHeaDd6nusw5vl4b44+3sGUwgLYdNPoAEz4I8uNHyvkou1kv7oz0raDRzel
         oyjfmqh91NSXolsRMWjOxnbBIlW8fZNjmqkmGeBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tanner Love <tannerlove@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 152/206] selftests/net: in timestamping, strncpy needs to preserve null byte
Date:   Tue, 23 Jun 2020 21:58:00 +0200
Message-Id: <20200623195324.468011841@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



