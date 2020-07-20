Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77292C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5263F2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261147;
	bh=EEaYoc/pEyzEgkAYaFBflSjPGHg/lWurb1kBnI+GpFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ukD+vOHVtDtUxVtPTuXfiErTT+oc6yQmFZfbtAtpDLKHoYShtoOLef5GvuMHYLvCw
	 WqjnUUToBs87AQ2l41l6ic8Xk5nr0ju4K/bZMGxC/mZP8ADLpcM7WSV8Rk04W5/IBs
	 CQcL8ZpuYAdKroWkQD+52CKmhZPNX1BcjW28knTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbgGTQFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732990AbgGTQFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:05:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876B52065E;
        Mon, 20 Jul 2020 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261143;
        bh=EEaYoc/pEyzEgkAYaFBflSjPGHg/lWurb1kBnI+GpFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V37TbAVuoy1unMvmXhC/eV7Z05GHFB+Za2Cx8hPNwtUZrfQDKca74MzENdsKFZIMz
         38xHMLIojHopVkBYgGtdwV22v+I7ZKXTYXAaZywXKPOc+qqjG+tGkK0QKIJHPeyryQ
         e0AT8r7qVWnWKc+gDUUaZEfc4m6Z5SWHRuOwPY4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 001/244] bridge: mcast: Fix MLD2 Report IPv6 payload length check
Date:   Mon, 20 Jul 2020 17:34:32 +0200
Message-Id: <20200720152825.935530758@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Linus Lüssing" <linus.luessing@c0d3.blue>

[ Upstream commit 5fc6266af7b427243da24f3443a50cd4584aac06 ]

Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
igmp3/mld2 report handling") introduced a bug in the IPv6 header payload
length check which would potentially lead to rejecting a valid MLD2 Report:

The check needs to take into account the 2 bytes for the "Number of
Sources" field in the "Multicast Address Record" before reading it.
And not the size of a pointer to this field.

Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Linus LÃ¼ssing <linus.luessing@c0d3.blue>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_multicast.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1007,7 +1007,7 @@ static int br_ip6_multicast_mld2_report(
 		nsrcs_offset = len + offsetof(struct mld2_grec, grec_nsrcs);
 
 		if (skb_transport_offset(skb) + ipv6_transport_len(skb) <
-		    nsrcs_offset + sizeof(_nsrcs))
+		    nsrcs_offset + sizeof(__nsrcs))
 			return -EINVAL;
 
 		_nsrcs = skb_header_pointer(skb, nsrcs_offset,


