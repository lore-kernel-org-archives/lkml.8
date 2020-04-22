Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3EAC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECCE20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551118;
	bh=YQxzphHa73DRyaukxU8CKn6epfObbttvlqesspMGgIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ujBuIzFzTnEKirl/HDyeonTv+XQOVuoDTltphD1qKFv5niB5JomK4VDarrvzmWFn7
	 zky1tDa8EVDOSA5TSxjpu5uU/mZjTZ1MvpSEGs3qlEYU4fErPY+FAnxCnSoZkVvegf
	 9+X/uMzHd781Bpar0VNv5+w+WAZKcHEFIEP+SnZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgDVKZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730486AbgDVKZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:25:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6625B20776;
        Wed, 22 Apr 2020 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551103;
        bh=YQxzphHa73DRyaukxU8CKn6epfObbttvlqesspMGgIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiU40t8ZFABZFxIUL0vOjv5cOG6Ozv+0tR7Ol21FtwaAsyXbQhqS6QCoH5QdlyDQ0
         8CdPhhGw0DS17go7tm6EFniZRvedjYfpBdTV6751DKGAmbHoRBLBfPToDDD6cIzbB/
         a/carcQl6fegf7IRufnVMB6lHYf5G1eXi0LTl1R4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+7022ab7c383875c17eff@syzkaller.appspotmail.com
Subject: [PATCH 5.6 101/166] macsec: fix NULL dereference in macsec_upd_offload()
Date:   Wed, 22 Apr 2020 11:57:08 +0200
Message-Id: <20200422095059.773279794@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit aa81700cf2326e288c9ca1fe7b544039617f1fc2 ]

macsec_upd_offload() gets the value of MACSEC_OFFLOAD_ATTR_TYPE
without checking its presence in the request message, and this causes
a NULL dereference. Fix it rejecting any configuration that does not
include this attribute.

Reported-and-tested-by: syzbot+7022ab7c383875c17eff@syzkaller.appspotmail.com
Fixes: dcb780fb2795 ("net: macsec: add nla support for changing the offloading selection")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 061aada4748a7..9b4ae5c36da6b 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2398,6 +2398,9 @@ static int macsec_upd_offload(struct sk_buff *skb, struct genl_info *info)
 		return PTR_ERR(dev);
 	macsec = macsec_priv(dev);
 
+	if (!tb_offload[MACSEC_OFFLOAD_ATTR_TYPE])
+		return -EINVAL;
+
 	offload = nla_get_u8(tb_offload[MACSEC_OFFLOAD_ATTR_TYPE]);
 	if (macsec->offload == offload)
 		return 0;
-- 
2.20.1



