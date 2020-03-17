Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42284C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174BD20771
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442711;
	bh=pte+ry5UAsmYSUCab+3GUPBpJLu/ieMTbRejIfv0htg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXve6bq2P9beouZoJSrUznIJC1oy2mPRVzfJz70hDhEDi82t8ZWJkJGHkDEHAhlbF
	 eJ2DFssP1aF/oedNu6Gu/OU0hlrMOHQveCzvIsqiGZpm2EGPCf0COl2ixB1jf66MWI
	 gVUTAVPNQeh7tsaYngtETNSK8b+mP0g7c3Rrs2oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCQK63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbgCQK6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:58:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0379C20736;
        Tue, 17 Mar 2020 10:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442702;
        bh=pte+ry5UAsmYSUCab+3GUPBpJLu/ieMTbRejIfv0htg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1UnpjO6R0jc2k89Yz930MfeAmm29i/zeOOmJGG/21bmH1oFL2m/YEmd+EBv5ggMP
         FmusUOCpwUlhE3rVveQDYEcQo1dW4u6OBDEipMe3Zmk6xlMve0vLnAwnMihpRXM7JG
         lwLnElxGRFQw+pP8x3m5RFRz/cmRFjZwR2BbEzwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 52/89] netfilter: synproxy: synproxy_cpu_seq_next should increase position index
Date:   Tue, 17 Mar 2020 11:55:01 +0100
Message-Id: <20200317103305.912541907@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

commit bb71f846a0002239f7058c84f1496648ff4a5c20 upstream.

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
 net/netfilter/nf_synproxy_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -273,7 +273,7 @@ static void *synproxy_cpu_seq_next(struc
 		*pos = cpu + 1;
 		return per_cpu_ptr(snet->stats, cpu);
 	}
-
+	(*pos)++;
 	return NULL;
 }
 


