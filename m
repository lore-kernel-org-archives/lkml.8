Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F228C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A8E207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457692;
	bh=Kfu+XxVXJeh86b6zyQ0ONniE1Ud6R7QhS1dDN4UNn1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wKBEXaQ1RLj4PTRg0MG9Kz4SUE0L778gTJDPDJVlR5VxjbL68fvbAhaq3GX5fvmoU
	 iFUB6abUkRa8EHqHjYBfz4nTUqd6bdbtgnHrFf7QZzv5iZluMTzccocf+pFIHyVkBY
	 QjQTGEaunavml1jb8PveLntKpeD1hFZljtRfMFqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgHCM2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgHCM2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:28:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 689E3204EC;
        Mon,  3 Aug 2020 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457683;
        bh=Kfu+XxVXJeh86b6zyQ0ONniE1Ud6R7QhS1dDN4UNn1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k53xwjHhqkuO0y3YKrlZj7evh42wnQ6mYtIg/ae1/Of37LJAj2Lbr/HhlNbt8HVau
         F7O9RJI3Zw2hUAOAqvlaKzi9LfVBkKIpQcBWoN/IyfE9e49EgLjrPVzjZp/eri0US7
         YvYEdAj0GYI//283/2VGvYobtQM12Q0I9T89o2SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 37/90] xfrm: Fix crash when the hold queue is used.
Date:   Mon,  3 Aug 2020 14:18:59 +0200
Message-Id: <20200803121859.406238820@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 101dde4207f1daa1fda57d714814a03835dccc3f ]

The commits "xfrm: Move dst->path into struct xfrm_dst"
and "net: Create and use new helper xfrm_dst_child()."
changed xfrm bundle handling under the assumption
that xdst->path and dst->child are not a NULL pointer
only if dst->xfrm is not a NULL pointer. That is true
with one exception. If the xfrm hold queue is used
to wait until a SA is installed by the key manager,
we create a dummy bundle without a valid dst->xfrm
pointer. The current xfrm bundle handling crashes
in that case. Fix this by extending the NULL check
of dst->xfrm with a test of the DST_XFRM_QUEUE flag.

Fixes: 0f6c480f23f4 ("xfrm: Move dst->path into struct xfrm_dst")
Fixes: b92cf4aab8e6 ("net: Create and use new helper xfrm_dst_child().")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e7a480a4ffb90..12aa6e15e43f6 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -945,7 +945,7 @@ struct xfrm_dst {
 static inline struct dst_entry *xfrm_dst_path(const struct dst_entry *dst)
 {
 #ifdef CONFIG_XFRM
-	if (dst->xfrm) {
+	if (dst->xfrm || (dst->flags & DST_XFRM_QUEUE)) {
 		const struct xfrm_dst *xdst = (const struct xfrm_dst *) dst;
 
 		return xdst->path;
@@ -957,7 +957,7 @@ static inline struct dst_entry *xfrm_dst_path(const struct dst_entry *dst)
 static inline struct dst_entry *xfrm_dst_child(const struct dst_entry *dst)
 {
 #ifdef CONFIG_XFRM
-	if (dst->xfrm) {
+	if (dst->xfrm || (dst->flags & DST_XFRM_QUEUE)) {
 		struct xfrm_dst *xdst = (struct xfrm_dst *) dst;
 		return xdst->child;
 	}
-- 
2.25.1



