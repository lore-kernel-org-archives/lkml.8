Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59F3CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8ECF20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364241;
	bh=IDIvI+1772k1Od1sxCmC/aHtQx79JKNpyEUnrjOlVXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uPDU2/DuSpTG1xfafWFxTRAue+936TlInN/wG7P+44of7AHrMwTIYONyd5vfzTL4E
	 RikqAzQn7336R92SDifXgACEUFxfrPaYT0vuMCgLmSgISw2dOhxj6e7MNBDzaAOrCo
	 mO+K2klCxs3nr+Niy+aDdNhEff9ILNBZ9QL/1XTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbgEMKEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733006AbgEMJsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:48:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 218C620740;
        Wed, 13 May 2020 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363288;
        bh=IDIvI+1772k1Od1sxCmC/aHtQx79JKNpyEUnrjOlVXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0WARAdSQ2lATN6aYv7FEby3Hu4PMinMsQgftIkwJgv8k1xVbDLwA2j2wXuQFDNZKe
         HGRfuccdNyEdK8WgkIpC1nfuA4JoJ22H51+EV1aSGgrtm994/fruqQTppyxrdR7Egz
         FF22kDMqu/ItzpQKo3qPwd3DDL8MbGNq2wxNNLJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 14/90] mlxsw: spectrum_acl_tcam: Position vchunk in a vregion list properly
Date:   Wed, 13 May 2020 11:44:10 +0200
Message-Id: <20200513094410.465523372@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Pirko <jiri@mellanox.com>

[ Upstream commit 6ef4889fc0b3aa6ab928e7565935ac6f762cee6e ]

Vregion helpers to get min and max priority depend on the correct
ordering of vchunks in the vregion list. However, the current code
always adds new chunk to the end of the list, no matter what the
priority is. Fix this by finding the correct place in the list and put
vchunk there.

Fixes: 22a677661f56 ("mlxsw: spectrum: Introduce ACL core with simple TCAM implementation")
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -986,8 +986,9 @@ mlxsw_sp_acl_tcam_vchunk_create(struct m
 				unsigned int priority,
 				struct mlxsw_afk_element_usage *elusage)
 {
+	struct mlxsw_sp_acl_tcam_vchunk *vchunk, *vchunk2;
 	struct mlxsw_sp_acl_tcam_vregion *vregion;
-	struct mlxsw_sp_acl_tcam_vchunk *vchunk;
+	struct list_head *pos;
 	int err;
 
 	if (priority == MLXSW_SP_ACL_TCAM_CATCHALL_PRIO)
@@ -1025,7 +1026,14 @@ mlxsw_sp_acl_tcam_vchunk_create(struct m
 	}
 
 	mlxsw_sp_acl_tcam_rehash_ctx_vregion_changed(vregion);
-	list_add_tail(&vchunk->list, &vregion->vchunk_list);
+
+	/* Position the vchunk inside the list according to priority */
+	list_for_each(pos, &vregion->vchunk_list) {
+		vchunk2 = list_entry(pos, typeof(*vchunk2), list);
+		if (vchunk2->priority > priority)
+			break;
+	}
+	list_add_tail(&vchunk->list, pos);
 	mutex_unlock(&vregion->lock);
 
 	return vchunk;


