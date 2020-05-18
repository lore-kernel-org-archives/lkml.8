Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DFBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8177E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826157;
	bh=XjSsmsaj+0cGZzRkm6yFrZT7XEPAlcmNRcivnp2RI7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NQF+7LWgnv1xA4YWmTFABoWkNhN4BL67N3Si9ecuqyECSGNYBO2D58iHDStMAzM21
	 3gDuYOpNrPgLgNt7smfLAn0xxbiU28L4hg85rdIOoG3vjwzKkF7ZvGwNA15GrRZKpi
	 3DpO+LpN3zlcp8OptOn+wnaYBLpkrOkzGMBRqXyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgERRuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgERRuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:50:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7166207F5;
        Mon, 18 May 2020 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824217;
        bh=XjSsmsaj+0cGZzRkm6yFrZT7XEPAlcmNRcivnp2RI7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eauh8yL2VEEy5+GPe//GT6scqxijlKZEGgnaDmEgUZAyA1/nEHIxg1YSDcKwY+2uN
         Vmq9XamQoI1MVY/ZfijDQKn+z0a/3TrdgYWtCsTAs7InZrNVOcN6nRJx9tTqeUUCDv
         fU6TaFGY4ZxV2o1jR1/SOWQOTXMLbUGiQFPN0bCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Sheets <matthew.sheets@gd-ms.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 082/114] netlabel: cope with NULL catmap
Date:   Mon, 18 May 2020 19:36:54 +0200
Message-Id: <20200518173517.252613970@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit eead1c2ea2509fd754c6da893a94f0e69e83ebe4 ]

The cipso and calipso code can set the MLS_CAT attribute on
successful parsing, even if the corresponding catmap has
not been allocated, as per current configuration and external
input.

Later, selinux code tries to access the catmap if the MLS_CAT flag
is present via netlbl_catmap_getlong(). That may cause null ptr
dereference while processing incoming network traffic.

Address the issue setting the MLS_CAT flag only if the catmap is
really allocated. Additionally let netlbl_catmap_getlong() cope
with NULL catmap.

Reported-by: Matthew Sheets <matthew.sheets@gd-ms.com>
Fixes: 4b8feff251da ("netlabel: fix the horribly broken catmap functions")
Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the secattr.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/cipso_ipv4.c        |    6 ++++--
 net/ipv6/calipso.c           |    3 ++-
 net/netlabel/netlabel_kapi.c |    6 ++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1272,7 +1272,8 @@ static int cipso_v4_parsetag_rbm(const s
 			return ret_val;
 		}
 
-		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+		if (secattr->attr.mls.cat)
+			secattr->flags |= NETLBL_SECATTR_MLS_CAT;
 	}
 
 	return 0;
@@ -1453,7 +1454,8 @@ static int cipso_v4_parsetag_rng(const s
 			return ret_val;
 		}
 
-		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+		if (secattr->attr.mls.cat)
+			secattr->flags |= NETLBL_SECATTR_MLS_CAT;
 	}
 
 	return 0;
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1061,7 +1061,8 @@ static int calipso_opt_getattr(const uns
 			goto getattr_return;
 		}
 
-		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+		if (secattr->attr.mls.cat)
+			secattr->flags |= NETLBL_SECATTR_MLS_CAT;
 	}
 
 	secattr->type = NETLBL_NLTYPE_CALIPSO;
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -748,6 +748,12 @@ int netlbl_catmap_getlong(struct netlbl_
 	if ((off & (BITS_PER_LONG - 1)) != 0)
 		return -EINVAL;
 
+	/* a null catmap is equivalent to an empty one */
+	if (!catmap) {
+		*offset = (u32)-1;
+		return 0;
+	}
+
 	if (off < catmap->startbit) {
 		off = catmap->startbit;
 		*offset = off;


