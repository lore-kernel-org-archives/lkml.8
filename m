Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61088C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36ACC20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823679;
	bh=bsCDHVysTRk/2H++MUm/dWsYevvXR/NMcYunC3JMh3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qbeww5GDYIuEhtvmSq2gu7kf8zE+CTEUcmthW9KTSUu2Zos0Vqgp9iuQLZdq7Wfx/
	 N/nG5nj28DNh2XCrTF75wp/eb1ils9YBRz7OnLm8TXO/CBabfsxyBvyplJ9tGXeBpk
	 HrxZGK9UMfSCZq+YqBXig9+/Z1hr9hnNrgTztuaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgERRlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgERRlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:41:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BB9120715;
        Mon, 18 May 2020 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823660;
        bh=bsCDHVysTRk/2H++MUm/dWsYevvXR/NMcYunC3JMh3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sr5Vvns/plnucgZH5LWvHYczLG3Aev/bXqPe5uCtXbgpLRyP7cwEz054YwB3dnDRm
         PiXmrcDWLyetJZERR6rOhv9ORKYreAILiSopbIOq09OH49kEfiArgH+OPynNi7eZHr
         +zCmkQ3Q4xP6AHMq/KExDDGge47uJOLplBuJeMN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Sheets <matthew.sheets@gd-ms.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 71/86] netlabel: cope with NULL catmap
Date:   Mon, 18 May 2020 19:36:42 +0200
Message-Id: <20200518173504.834119661@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
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
 net/netlabel/netlabel_kapi.c |    6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1343,7 +1343,8 @@ static int cipso_v4_parsetag_rbm(const s
 			return ret_val;
 		}
 
-		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+		if (secattr->attr.mls.cat)
+			secattr->flags |= NETLBL_SECATTR_MLS_CAT;
 	}
 
 	return 0;
@@ -1524,7 +1525,8 @@ static int cipso_v4_parsetag_rng(const s
 			return ret_val;
 		}
 
-		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+		if (secattr->attr.mls.cat)
+			secattr->flags |= NETLBL_SECATTR_MLS_CAT;
 	}
 
 	return 0;
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -605,6 +605,12 @@ int netlbl_catmap_getlong(struct netlbl_
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


