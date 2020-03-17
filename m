Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D33FC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D2320735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442703;
	bh=CJWOWQa3hIlsT45lEVBrSR3FnQYkMwvvDTbOn39maNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAyYJsZiB+HVQ0SYlhhl8NA40vlQbtnant7wfshpQUwUULylIczrgTQDvdfvonhy8
	 lsFq7pe0VXprVrFfTwtU8zm6fBkAH3DZafthCb/g6L/y55ipbbN/S2hKQozxIBQ+Bv
	 nuSpC+gqniZfz0FFyc9p87FX0a+1jN39vGx2noFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCQK6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgCQK6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:58:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2808420719;
        Tue, 17 Mar 2020 10:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442699;
        bh=CJWOWQa3hIlsT45lEVBrSR3FnQYkMwvvDTbOn39maNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvlyABBPlMQPGhKIirIg45cGJGiDJMdtjjH8ORZOvf0OurzyTHqwciiZh02sfON2D
         X5mLhqOqQyErsn7DPaLWwqzXgyvYOTWC5aF21ACNPaS8BTnTHpFycFWqnKrsS5PILW
         U0dP3sdSxaiRd7CpvYaNHaVuotH6dRHdB6qDY1YQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 51/89] netfilter: nf_conntrack: ct_cpu_seq_next should increase position index
Date:   Tue, 17 Mar 2020 11:55:00 +0100
Message-Id: <20200317103305.791797399@linuxfoundation.org>
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
@@ -390,7 +390,7 @@ static void *ct_cpu_seq_next(struct seq_
 		*pos = cpu + 1;
 		return per_cpu_ptr(net->ct.stat, cpu);
 	}
-
+	(*pos)++;
 	return NULL;
 }
 


