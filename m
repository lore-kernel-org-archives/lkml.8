Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A19AC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B9220735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386750;
	bh=fGBeDcGkMF8qnx98mzK/4Lz582y1joSmdAPT16srA5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sy4WlmydmsxiTA2/UPw+xV/KiHuHX/fYhUuwQ0u0lrqwm6iAxC4Cgt9KjqfxuJoxl
	 Cz6wQwS3vgPDBEslfZXtmpV/Lvi1dHUIX3f9TDd6K3QMEEHYDHnde9DEGkoIG2I3Ug
	 +sMKK6jaqIry4przkPMHTawueAY7RGQ3Cp6dCCFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgDTMpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbgDTMpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:45:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A7D20736;
        Mon, 20 Apr 2020 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386746;
        bh=fGBeDcGkMF8qnx98mzK/4Lz582y1joSmdAPT16srA5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfHTLSr0aEveML/yccqaDGViFXNQVguBYaF8MN8MBDLsgjQARX7QcxCukd50Monce
         1JX5lH9/0C2q3EjfJXOWM/hwLS68HzG3JiEfMmaPB0JmbWzReNsoKlkYWkh85JhWDL
         FR9U9o0VAWjWNUWGlu7NkxLG/6COYnRNHpKDxmGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 02/60] hsr: check protocol version in hsr_newlink()
Date:   Mon, 20 Apr 2020 14:38:40 +0200
Message-Id: <20200420121501.202750478@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
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
 net/hsr/hsr_netlink.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -61,10 +61,16 @@ static int hsr_newlink(struct net *src_n
 	else
 		multicast_spec = nla_get_u8(data[IFLA_HSR_MULTICAST_SPEC]);
 
-	if (!data[IFLA_HSR_VERSION])
+	if (!data[IFLA_HSR_VERSION]) {
 		hsr_version = 0;
-	else
+	} else {
 		hsr_version = nla_get_u8(data[IFLA_HSR_VERSION]);
+		if (hsr_version > 1) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Only versions 0..1 are supported");
+			return -EINVAL;
+		}
+	}
 
 	return hsr_dev_finalize(dev, link, multicast_spec, hsr_version);
 }


