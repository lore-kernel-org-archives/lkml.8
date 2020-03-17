Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21759C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC03F2071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443432;
	bh=OOSINW/hyFAGnHO/xbPruDAzEoRO0OuNE9KOW1QvA0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1uCiOCNB3Xzmo1MikUEicaCHa1RXWa4Sg3loZSZpeKidTb9TrHs/lGnlGaa9RD9cV
	 bZ7wZ1A8aeebRtzDyZN5S8WIk6hw1vNDAKliVPV0mG9Nhy8185hnhCiRQQV/u97O6U
	 nD4DHQqggPQ8XelBabdn9NpLeTrwzs9bVpr87UCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgCQLKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgCQLK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:10:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3158E20658;
        Tue, 17 Mar 2020 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443425;
        bh=OOSINW/hyFAGnHO/xbPruDAzEoRO0OuNE9KOW1QvA0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUH67r6o8DYXJEm2912VMNmBIw9k2pkCXJu86lJ1GSfm0XLrkxP92SraBXpvtpdIk
         7lTHuAVdtbyvM4zDxv4c8vTrEGAtgpv6r8xB4PgNYbNrnV1En/xejQfap01A3ZYEZC
         FrfjcvhMTBOujn6Vz8w8bJwDM39WTb4uBrcHLm/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.5 079/151] netfilter: nf_conntrack: ct_cpu_seq_next should increase position index
Date:   Tue, 17 Mar 2020 11:54:49 +0100
Message-Id: <20200317103332.086246873@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

commit dc15af8e9dbd039ebb06336597d2c491ef46ab74 upstream.

If .next function does not change position index,
following .show function will repeat output related
to current position index.

Cc: stable@vger.kernel.org
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_standalone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -411,7 +411,7 @@ static void *ct_cpu_seq_next(struct seq_
 		*pos = cpu + 1;
 		return per_cpu_ptr(net->ct.stat, cpu);
 	}
-
+	(*pos)++;
 	return NULL;
 }
 


