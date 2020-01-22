Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A3FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1C72468D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686728;
	bh=xEqQe+iFvcpuTaewfAEDo85AX9dkiNHS+PTLtfioDOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GSgoy/ESY7/9brBC1GLhxCuUa9zX0ZgWcrBhUiNsp7jf6sjaHmH0nN/jelEmUIrjV
	 R1k1BrleLl0+Rwn/N5f+tXgtxMfTHwI0FcxNPg4As9R/nh+VvNKBm+ZKr6R5IVNwfF
	 3I6l1wOOw0HPWJzXaehfP31KPonXlNuoErK8Shvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbgAVJgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731737AbgAVJgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:36:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C40F020704;
        Wed, 22 Jan 2020 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685782;
        bh=xEqQe+iFvcpuTaewfAEDo85AX9dkiNHS+PTLtfioDOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1LVNFqEh+Ozljs7IbRySJHaN3JoTfAocuAt/S6mQnM3kSTvfw9mDWn7dy5USFzYQ
         7TCBY5M97zMbMRkclE3rxRYdiXwYjbFZdSu3uBOL7VfFHg4z2+3M/uq3Nvbmj9W8hk
         48ao1CoBlib8pdMUDuGunr6rPnKWfEUfrXpfJsnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 77/97] cfg80211: fix page refcount issue in A-MSDU decap
Date:   Wed, 22 Jan 2020 10:29:21 +0100
Message-Id: <20200122092808.715746329@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

commit 81c044fc3bdc5b7be967cd3682528ea94b58c06a upstream.

The fragments attached to a skb can be part of a compound page. In that case,
page_ref_inc will increment the refcount for the wrong page. Fix this by
using get_page instead, which calls page_ref_inc on the compound head and
also checks for overflow.

Fixes: 2b67f944f88c ("cfg80211: reuse existing page fragments in A-MSDU rx")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/r/20200113182107.20461-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -653,7 +653,7 @@ __frame_add_frag(struct sk_buff *skb, st
 	struct skb_shared_info *sh = skb_shinfo(skb);
 	int page_offset;
 
-	page_ref_inc(page);
+	get_page(page);
 	page_offset = ptr - page_address(page);
 	skb_add_rx_frag(skb, sh->nr_frags, page, page_offset, len, size);
 }


