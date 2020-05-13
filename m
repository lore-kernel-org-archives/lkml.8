Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E794CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA7220753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363288;
	bh=koG9zMS6U71NJEzeLsMjNHHR1end4Vw6Ci19U1lhZVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hyM1wHUGkzrQsrYf8u/onjrczvbJJtvsMD8Id2aqJW0pKsbiTuMjtCBOmAzkbztBh
	 pUX9DTjsLljUnaW/C8ct9YCAPG0h+h9a3R5XNuG+RfxNZfXSoUxY6QaDgCm7g3pYJI
	 HQXzQ4BEA3Q/eGlYkJUuE9PcivGdslhWBQIrsXL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbgEMJsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732859AbgEMJsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:48:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3229720753;
        Wed, 13 May 2020 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363283;
        bh=koG9zMS6U71NJEzeLsMjNHHR1end4Vw6Ci19U1lhZVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uF6y2ydnZHTF55M0hSAt6E05kWHHVJTm5aU/OdECEOcnTV0sKyENE81/bfcDokf8b
         CY7obEDam/pUf9//rdB4iGMibeMGg729nmvj3KgjR6+vo8QtOnXc3zscPC33cZLL2z
         c1qh4FiwYy1a7NOjG+wg1pkQwwHXBMwQjdFUrBmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 12/90] fq_codel: fix TCA_FQ_CODEL_DROP_BATCH_SIZE sanity checks
Date:   Wed, 13 May 2020 11:44:08 +0200
Message-Id: <20200513094410.345720636@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 14695212d4cd8b0c997f6121b6df8520038ce076 ]

My intent was to not let users set a zero drop_batch_size,
it seems I once again messed with min()/max().

Fixes: 9d18562a2278 ("fq_codel: add batch ability to fq_codel_drop()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_fq_codel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -417,7 +417,7 @@ static int fq_codel_change(struct Qdisc
 		q->quantum = max(256U, nla_get_u32(tb[TCA_FQ_CODEL_QUANTUM]));
 
 	if (tb[TCA_FQ_CODEL_DROP_BATCH_SIZE])
-		q->drop_batch_size = min(1U, nla_get_u32(tb[TCA_FQ_CODEL_DROP_BATCH_SIZE]));
+		q->drop_batch_size = max(1U, nla_get_u32(tb[TCA_FQ_CODEL_DROP_BATCH_SIZE]));
 
 	if (tb[TCA_FQ_CODEL_MEMORY_LIMIT])
 		q->memory_limit = min(1U << 31, nla_get_u32(tb[TCA_FQ_CODEL_MEMORY_LIMIT]));


