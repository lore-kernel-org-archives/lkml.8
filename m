Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ACA24689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686240;
	bh=K5YyR0azjiv/e1ZJo5XVeYbPbX1Pec8euXUNLaJ1FZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bv5OIq00xSOgShPANW6zMGEMEXa10Hz4u6h4TNiMvjkAPmuOSb+onIKxPTRWcBBFx
	 a8NN3K89lDSCfI/u/RfWoH/yigCxTFHhuGGavkl96Qyrvh5JvZmCIFwAbCN5IOUB3q
	 nizn7DOr3FBx7Jd59zZTJDdMpos7UYRT4k2iRKng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbgAVJn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733238AbgAVJny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:43:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580FB24688;
        Wed, 22 Jan 2020 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686233;
        bh=K5YyR0azjiv/e1ZJo5XVeYbPbX1Pec8euXUNLaJ1FZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kw9yElU/ffQp7lmJmidOH8cySMnZ5mINL5ytdvvqosItcHn8mlyBtBYfl3ZlSMaoq
         FCVSZoSJ/1Lf6bJ94etYhc430S1V2IR96n2Z935ZaBLKzjsxcGsh/W5lFNQ48eer6e
         f7vRu+R4Sf0Qzkr4tF9S/Mp7fkGUEA77YmTFFEqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0e63ae76d117ae1c3a01@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 062/103] netfilter: nf_tables: remove WARN and add NLA_STRING upper limits
Date:   Wed, 22 Jan 2020 10:29:18 +0100
Message-Id: <20200122092813.141459145@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 9332d27d7918182add34e8043f6a754530fdd022 upstream.

This WARN can trigger because some of the names fed to the module
autoload function can be of arbitrary length.

Remove the WARN and add limits for all NLA_STRING attributes.

Reported-by: syzbot+0e63ae76d117ae1c3a01@syzkaller.appspotmail.com
Fixes: 452238e8d5ffd8 ("netfilter: nf_tables: add and use helper for module autoload")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -24,6 +24,8 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
+#define NFT_MODULE_AUTOLOAD_LIMIT (MODULE_NAME_LEN - sizeof("nft-expr-255-"))
+
 static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
@@ -504,7 +506,7 @@ static void nft_request_module(struct ne
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
 	va_end(args);
-	if (WARN(ret >= MODULE_NAME_LEN, "truncated: '%s' (len %d)", module_name, ret))
+	if (ret >= MODULE_NAME_LEN)
 		return;
 
 	mutex_unlock(&net->nft.commit_mutex);
@@ -1129,7 +1131,8 @@ static const struct nla_policy nft_chain
 				    .len = NFT_CHAIN_MAXNAMELEN - 1 },
 	[NFTA_CHAIN_HOOK]	= { .type = NLA_NESTED },
 	[NFTA_CHAIN_POLICY]	= { .type = NLA_U32 },
-	[NFTA_CHAIN_TYPE]	= { .type = NLA_STRING },
+	[NFTA_CHAIN_TYPE]	= { .type = NLA_STRING,
+				    .len = NFT_MODULE_AUTOLOAD_LIMIT },
 	[NFTA_CHAIN_COUNTERS]	= { .type = NLA_NESTED },
 };
 
@@ -2012,7 +2015,8 @@ static const struct nft_expr_type *nft_e
 }
 
 static const struct nla_policy nft_expr_policy[NFTA_EXPR_MAX + 1] = {
-	[NFTA_EXPR_NAME]	= { .type = NLA_STRING },
+	[NFTA_EXPR_NAME]	= { .type = NLA_STRING,
+				    .len = NFT_MODULE_AUTOLOAD_LIMIT },
 	[NFTA_EXPR_DATA]	= { .type = NLA_NESTED },
 };
 
@@ -3796,7 +3800,8 @@ static const struct nla_policy nft_set_e
 	[NFTA_SET_ELEM_USERDATA]	= { .type = NLA_BINARY,
 					    .len = NFT_USERDATA_MAXLEN },
 	[NFTA_SET_ELEM_EXPR]		= { .type = NLA_NESTED },
-	[NFTA_SET_ELEM_OBJREF]		= { .type = NLA_STRING },
+	[NFTA_SET_ELEM_OBJREF]		= { .type = NLA_STRING,
+					    .len = NFT_OBJ_MAXNAMELEN - 1 },
 };
 
 static const struct nla_policy nft_set_elem_list_policy[NFTA_SET_ELEM_LIST_MAX + 1] = {


