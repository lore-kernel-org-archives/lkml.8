Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1942CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D5D206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037868;
	bh=IUwtny+/JWT/oUv6BjzT1fZrlqINPZfCEVin8clKFn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Twzglmy7fhRH+QqsAf6LtIGuwebelQZ0VMJcQOi8ok7CXxtDr4mK7jHynCaWCrWO
	 FfEEWlKJzCRthYEvmoKJvfb7mhQ98I2m5ubTEV0Fx76kb5jr0rBMWr+N98ZWo5T5zi
	 +MyesRLqKgUoOkxFzgs+bT6HPn69qXMltgbpjWS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgFAS5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgFAR7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:59:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21912206E2;
        Mon,  1 Jun 2020 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034380;
        bh=IUwtny+/JWT/oUv6BjzT1fZrlqINPZfCEVin8clKFn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxI05sLSzyPs8MzG4ZHSFU0juAgSNC3lM827rbmFXfcu8YEOEaXk6MNXRgyx2MkUJ
         oUwfzhB3oYY/4p3HR8pCZhre/l1Zee//m629LmL6POfWuwRaHowhcs1LUDB1EZeob4
         jzPOzepLxm8Z+hCc5V9m87PSlHB3z2yorbbxxfGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 51/61] netfilter: ipset: Fix subcounter update skip
Date:   Mon,  1 Jun 2020 19:53:58 +0200
Message-Id: <20200601174020.897949902@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174010.316778377@linuxfoundation.org>
References: <20200601174010.316778377@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Sutter <phil@nwl.cc>

commit a164b95ad6055c50612795882f35e0efda1f1390 upstream.

If IPSET_FLAG_SKIP_SUBCOUNTER_UPDATE is set, user requested to not
update counters in sub sets. Therefore IPSET_FLAG_SKIP_COUNTER_UPDATE
must be set, not unset.

Fixes: 6e01781d1c80e ("netfilter: ipset: set match: add support to match the counters")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/ipset/ip_set_list_set.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -61,7 +61,7 @@ list_set_ktest(struct ip_set *set, const
 	/* Don't lookup sub-counters at all */
 	opt->cmdflags &= ~IPSET_FLAG_MATCH_COUNTERS;
 	if (opt->cmdflags & IPSET_FLAG_SKIP_SUBCOUNTER_UPDATE)
-		opt->cmdflags &= ~IPSET_FLAG_SKIP_COUNTER_UPDATE;
+		opt->cmdflags |= IPSET_FLAG_SKIP_COUNTER_UPDATE;
 	list_for_each_entry_rcu(e, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))


