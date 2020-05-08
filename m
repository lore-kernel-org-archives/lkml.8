Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BABCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F41920731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941694;
	bh=AaVBMed/jK2tTG+Zl65dMFrH0jP3Wozb96iodgcBeLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kISN3bm7tXUI9ozx6SB8rptQ/DaMHfGaKOFNgDqDLBT6GF9Na9NH3uevNkENLdwh0
	 4+Yvz7fgdXhwrblZHDROjT2wIEb0xUqTAqe0AxgLMbRYCGfDHltCqQtv7uBVotiPJS
	 19JSFXovYxbM2n5lAWJCchCGyEd3ZO8GmwJeCeHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgEHMld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgEHMl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:41:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E15FB2495F;
        Fri,  8 May 2020 12:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941685;
        bh=AaVBMed/jK2tTG+Zl65dMFrH0jP3Wozb96iodgcBeLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqt18IfLeao4MTKZ/+gAq0xrwJwyi4r+K3kLC1a/YpUhji2TFlXwFHbQOlYxwehM0
         GqTjYEhMPcJMpofYitve6iNFFgGTGwWosFWIWqQn+uD9Kwx3z5xCQUuJTGR7AtGdGP
         YREFPklQqfedKgoaLcPqbAgiaFWUZXrfqYIbSNbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 131/312] net: get rid of an signed integer overflow in ip_idents_reserve()
Date:   Fri,  8 May 2020 14:32:02 +0200
Message-Id: <20200508123133.721321591@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit adb03115f4590baa280ddc440a8eff08a6be0cb7 upstream.

Jiri Pirko reported an UBSAN warning happening in ip_idents_reserve()

[] UBSAN: Undefined behaviour in ./arch/x86/include/asm/atomic.h:156:11
[] signed integer overflow:
[] -2117905507 + -695755206 cannot be represented in type 'int'

Since we do not have uatomic_add_return() yet, use atomic_cmpxchg()
so that the arithmetics can be done using unsigned int.

Fixes: 04ca6973f7c1 ("ip: make IP identifiers less predictable")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/route.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -477,12 +477,18 @@ u32 ip_idents_reserve(u32 hash, int segs
 	atomic_t *p_id = ip_idents + hash % IP_IDENTS_SZ;
 	u32 old = ACCESS_ONCE(*p_tstamp);
 	u32 now = (u32)jiffies;
-	u32 delta = 0;
+	u32 new, delta = 0;
 
 	if (old != now && cmpxchg(p_tstamp, old, now) == old)
 		delta = prandom_u32_max(now - old);
 
-	return atomic_add_return(segs + delta, p_id) - segs;
+	/* Do not use atomic_add_return() as it makes UBSAN unhappy */
+	do {
+		old = (u32)atomic_read(p_id);
+		new = old + delta + segs;
+	} while (atomic_cmpxchg(p_id, old, new) != old);
+
+	return new - segs;
 }
 EXPORT_SYMBOL(ip_idents_reserve);
 


