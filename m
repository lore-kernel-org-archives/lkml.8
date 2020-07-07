Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31011C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0430320663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594134657;
	bh=gD03nvGzSUO+Oo71OUhqcW4bS147QATjZu1+N0L9dtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wIJ6+FOOr4aK1vFDRwLozvm8nmhTHeJw0AHlHSBuE7bCz4EWlIjjEIPQmi3AwgSRT
	 ZHqEEl0Um85mdj57KTx+je9PuSFZaQkhOO17OWKYQpaO0mfAm6H+fTNogC7w7woMhy
	 QhCL9XHzjGg+hKlj1bNSEp34p9jlDm7/wxc3nIWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgGGPKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgGGPKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:10:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6C6207BB;
        Tue,  7 Jul 2020 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594134652;
        bh=gD03nvGzSUO+Oo71OUhqcW4bS147QATjZu1+N0L9dtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipMXGHIe6REMLEXkXRAxaSLpyTydjJ5Y0+yWbezg8DWGysPOGz0KgwC9L3gGIqMa2
         6Gd0iD8hf3rgX/hxWcH+4nWTyt+kNTmp8xybYXyBfl3eGW6ZTeKlQaRHngF+X2XkRy
         207t3Qxw17LnvwhGGuoOF4obGUKA7spGbDPNOSJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 4.4 19/19] netfilter: nf_conntrack_h323: lost .data_len definition for Q.931/ipv6
Date:   Tue,  7 Jul 2020 17:10:22 +0200
Message-Id: <20200707145748.453060963@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145747.493710555@linuxfoundation.org>
References: <20200707145747.493710555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

Could you please push this patch into stable@?
it fixes memory corruption in kernels  v3.5 .. v4.10

Lost .data_len definition leads to write beyond end of
struct nf_ct_h323_master. Usually it corrupts following
struct nf_conn_nat, however if nat is not loaded it corrupts
following slab object.

In mainline this problem went away in v4.11,
after commit 9f0f3ebeda47 ("netfilter: helpers: remove data_len usage
for inkernel helpers") however many stable kernels are still affected.

Fixes: 1afc56794e03 ("netfilter: nf_ct_helper: implement variable length helper private data") # v3.5
cc: stable@vger.kernel.org
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_h323_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -1225,6 +1225,7 @@ static struct nf_conntrack_helper nf_con
 	{
 		.name			= "Q.931",
 		.me			= THIS_MODULE,
+		.data_len		= sizeof(struct nf_ct_h323_master),
 		.tuple.src.l3num	= AF_INET6,
 		.tuple.src.u.tcp.port	= cpu_to_be16(Q931_PORT),
 		.tuple.dst.protonum	= IPPROTO_TCP,


