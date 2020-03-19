Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8731DC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB0120752
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623208;
	bh=sAfmogAQI1FrxifR9OmJIT0rXstwAqgQN9rJPMvCB6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HtOofWaOsxQs6fb/2pkvvfcrTIXp6Af17tU2PHYKU/xD8Gzdib6bc1009OFYQfRyU
	 l+HeoI06RFHGPjzDT9BlZJ8bTErh0a7QnaB+zsGkLt2n5u+IrNS7QH011JO5yQw3f6
	 gU0fy7afu8FGtjbPpkv6nCFkK+NUzpWoh1Ijv0UA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCSNGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbgCSNGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:06:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9C820722;
        Thu, 19 Mar 2020 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623203;
        bh=sAfmogAQI1FrxifR9OmJIT0rXstwAqgQN9rJPMvCB6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJZ9F9VoGEM0hiBPnEoE1zMnYdNqZabXZPeAPbAsF6Q2NSrnccWTxfzj2agXlaEBm
         ybFNqkCa4Guk1DWi+zBpeTlqHxsVfcJOsp0elDbkC4KU5emfC2gVZsJ1V71pMiTKAf
         Ay9PQUyQbJm/AJfS2CbNSCFf0jJYgA7lnc+pQCBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven.eckelmann@open-mesh.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Antonio Quartulli <a@unstable.cc>
Subject: [PATCH 4.4 43/93] batman-adv: Fix integer overflow in batadv_iv_ogm_calc_tq
Date:   Thu, 19 Mar 2020 13:59:47 +0100
Message-Id: <20200319123938.718072127@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

commit d285f52cc0f23564fd61976d43fd5b991b4828f6 upstream.

The undefined behavior sanatizer detected an signed integer overflow in a
setup with near perfect link quality

    UBSAN: Undefined behaviour in net/batman-adv/bat_iv_ogm.c:1246:25
    signed integer overflow:
    8713350 * 255 cannot be represented in type 'int'

The problems happens because the calculation of mixed unsigned and signed
integers resulted in an integer multiplication.

      batadv_ogm_packet::tq (u8 255)
    * tq_own (u8 255)
    * tq_asym_penalty (int 134; max 255)
    * tq_iface_penalty (int 255; max 255)

The tq_iface_penalty, tq_asym_penalty and inv_asym_penalty can just be
changed to unsigned int because they are not expected to become negative.

Fixes: c039876892e3 ("batman-adv: add WiFi penalty")
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_iv_ogm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1140,9 +1140,10 @@ static int batadv_iv_ogm_calc_tq(struct
 	u8 total_count;
 	u8 orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	int tq_asym_penalty, inv_asym_penalty, if_num, ret = 0;
+	int if_num, ret = 0;
+	unsigned int tq_asym_penalty, inv_asym_penalty;
 	unsigned int combined_tq;
-	int tq_iface_penalty;
+	unsigned int tq_iface_penalty;
 
 	/* find corresponding one hop neighbor */
 	rcu_read_lock();


