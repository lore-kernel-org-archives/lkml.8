Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1BAC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48224221F7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941860;
	bh=NqgqboknEU7W4j7DX3XTLO0NqJtAt0PmLbZvEGdEgVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gAVvhdX8x9jUsB6EB4FXTu+BHgdRl7CqUq05kdgpt9PB7D7fqvhUfFoX0NUdZPqAE
	 GLEPu8jGUwjnCCPU2oLK7dzAKXgwK0iSj9jGIhxpjoVqg8J0jrCxBZhIUUhLALzQwr
	 39xOe6ktK7O7fuVpjtRb+u2It4HkouDG3hRq94gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgEHMoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbgEHMoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E90A21473;
        Fri,  8 May 2020 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941849;
        bh=NqgqboknEU7W4j7DX3XTLO0NqJtAt0PmLbZvEGdEgVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OC2GFxrd3LIB1oGxz8el+gKN/KfOITILmy7Obs9HE21NxCwKf7munr2E+bIMtO03l
         x0xPK1UrGM/J662SlpqDTqYvPilOOmGBSGI0ouQLF4z312ehynnniUp7oaTe+jPVv4
         ICqr3gu4NzUeeb0lJZ/vrM2Aprh9SE/003ZsgTI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 198/312] netfilter: nft_dynset: fix panic if NFT_SET_HASH is not enabled
Date:   Fri,  8 May 2020 14:33:09 +0200
Message-Id: <20200508123138.365229007@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liping Zhang <zlpnobody@gmail.com>

commit bb6a6e8e091353770074608c1d1bfde0e20b8154 upstream.

When CONFIG_NFT_SET_HASH is not enabled and I input the following rule:
"nft add rule filter output flow table test {ip daddr counter }", kernel
panic happened on my system:
 BUG: unable to handle kernel NULL pointer dereference at (null)
 IP: [<          (null)>]           (null)
 [...]
 Call Trace:
 [<ffffffffa0590466>] ? nft_dynset_eval+0x56/0x100 [nf_tables]
 [<ffffffffa05851bb>] nft_do_chain+0xfb/0x4e0 [nf_tables]
 [<ffffffffa0432f01>] ? nf_conntrack_tuple_taken+0x61/0x210 [nf_conntrack]
 [<ffffffffa0459ea6>] ? get_unique_tuple+0x136/0x560 [nf_nat]
 [<ffffffffa043bca1>] ? __nf_ct_ext_add_length+0x111/0x130 [nf_conntrack]
 [<ffffffffa045a357>] ? nf_nat_setup_info+0x87/0x3b0 [nf_nat]
 [<ffffffff81761e27>] ? ipt_do_table+0x327/0x610
 [<ffffffffa045a6d7>] ? __nf_nat_alloc_null_binding+0x57/0x80 [nf_nat]
 [<ffffffffa059f21f>] nft_ipv4_output+0xaf/0xd0 [nf_tables_ipv4]
 [<ffffffff81702515>] nf_iterate+0x55/0x60
 [<ffffffff81702593>] nf_hook_slow+0x73/0xd0

Because in rbtree type set, ops->update is not implemented. So just keep
it simple, in such case, report -EOPNOTSUPP to the user space.

Fixes: 22fe54d5fefc ("netfilter: nf_tables: add support for dynamic set updates")
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_dynset.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -121,6 +121,9 @@ static int nft_dynset_init(const struct
 			return PTR_ERR(set);
 	}
 
+	if (set->ops->update == NULL)
+		return -EOPNOTSUPP;
+
 	if (set->flags & NFT_SET_CONSTANT)
 		return -EBUSY;
 


