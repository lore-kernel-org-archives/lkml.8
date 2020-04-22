Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E8EC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9D20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549937;
	bh=+/PB+AYdWM6kXS4AUrEw7cQyj/+8hWvtqpBUiJRA5S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GG9kzVvco+5moeHsygkQWG7WXfo2487GP6YCfKbFVaPH1iA93Varkvtrb0yKD3qWH
	 wX6Q+itFNFdaU7YyX/xBfjKBdRCVl5FqtUVq75JMiNVvTv6oNLfB1atyapstdqsh5G
	 JdwXbfnkXJ3MMzJ5izQbRV4+Z18G1udGYo5+a3n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgDVKFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbgDVKFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:05:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EB020780;
        Wed, 22 Apr 2020 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549930;
        bh=+/PB+AYdWM6kXS4AUrEw7cQyj/+8hWvtqpBUiJRA5S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=it7CxpNpSUk4yGtwiTehBLfGbKgzgf8r2mzjS03PLai+nnpmU6x0COsWCRLus5LGZ
         9SMKElBTEdOm33bvg3qnd/PZ8B7woXKuDQ3MHhs/6sf33gQ/d/K1fS0rye/hqEbJjB
         Fqh5Q6ezk4a8jjmUmX2flFYAXf41KRnosPVV+aZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 066/125] hsr: check protocol version in hsr_newlink()
Date:   Wed, 22 Apr 2020 11:56:23 +0200
Message-Id: <20200422095043.948209729@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 4faab8c446def7667adf1f722456c2f4c304069c ]

In the current hsr code, only 0 and 1 protocol versions are valid.
But current hsr code doesn't check the version, which is received by
userspace.

Test commands:
    ip link add dummy0 type dummy
    ip link add dummy1 type dummy
    ip link add hsr0 type hsr slave1 dummy0 slave2 dummy1 version 4

In the test commands, version 4 is invalid.
So, the command should be failed.

After this patch, following error will occur.
"Error: hsr: Only versions 0..1 are supported."

Fixes: ee1c27977284 ("net/hsr: Added support for HSR v1")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/hsr/hsr_netlink.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -63,10 +63,15 @@ static int hsr_newlink(struct net *src_n
 	else
 		multicast_spec = nla_get_u8(data[IFLA_HSR_MULTICAST_SPEC]);
 
-	if (!data[IFLA_HSR_VERSION])
+	if (!data[IFLA_HSR_VERSION]) {
 		hsr_version = 0;
-	else
+	} else {
 		hsr_version = nla_get_u8(data[IFLA_HSR_VERSION]);
+		if (hsr_version > 1) {
+			netdev_info(dev, "Only versions 0..1 are supported");
+			return -EINVAL;
+		}
+	}
 
 	return hsr_dev_finalize(dev, link, multicast_spec, hsr_version);
 }


