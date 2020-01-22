Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6681BC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DB92467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699388;
	bh=WDHFmtGhG10YbiH7PL2Z0ayF3nFw7FCKt/ukbS1zEQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MPYOjenWHezCRYv1xtCQS4NLY0WF/kDVDZoi4As6MuvfmFaD3ahKfisHhbrREwJr6
	 QRXcVmxcLxNH5Pe81xbsqFEVSjlS4nIU/pz2rdwqoseEngL8HXl6vdtXi9ofTQliy3
	 sQq0xxw700AfYbT4y/XLjvCXpovVmcHnv4gA7NuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgAVNXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbgAVNXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:03 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79822467B;
        Wed, 22 Jan 2020 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699383;
        bh=WDHFmtGhG10YbiH7PL2Z0ayF3nFw7FCKt/ukbS1zEQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTvcnFz9/3R0xIlM2Y0tAlo8JIipOQhQK6cUURFbP/VtejJacClZbna1RUxjMdw6q
         4DwRCznNUfA6hTuzjrON+ryW0ZbOOkc1ViDmX7k1IcgR2tx9MGbu4BOU80hQJ87SOX
         uiUxoxhPBnlja6UoqbSpG+tC/VHDjwQV1vqdIVQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 128/222] netfilter: nft_tunnel: ERSPAN_VERSION must not be null
Date:   Wed, 22 Jan 2020 10:28:34 +0100
Message-Id: <20200122092842.914363198@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 9ec22d7c6c69146180577f3ad5fdf504beeaee62 upstream.

Fixes: af308b94a2a4a5 ("netfilter: nf_tables: add tunnel support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_tunnel.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -266,6 +266,9 @@ static int nft_tunnel_obj_erspan_init(co
 	if (err < 0)
 		return err;
 
+	if (!tb[NFTA_TUNNEL_KEY_ERSPAN_VERSION])
+		 return -EINVAL;
+
 	version = ntohl(nla_get_be32(tb[NFTA_TUNNEL_KEY_ERSPAN_VERSION]));
 	switch (version) {
 	case ERSPAN_VERSION:


