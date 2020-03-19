Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE04C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE326208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623251;
	bh=91ZeNh0qV2wiYcb7a2G7SGxyeWnlP3SieJA4AAUxPn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MRC4beJj9muXKhES8FFd60BvdQ2VO+bGv08/XqZ/qAW808OA7vhbYK/lVfNdSfIfw
	 ch20C4LEGfJ9j1VS9Jt5JLjsX0K4UmPWXAo59+dnZGeBwgT7QcHPb6Nqmgqu1TRGLZ
	 vRLYkA7TpiNsPdczXt0eHGpbQkNaA/Z83fl8uyFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCSNH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbgCSNH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:07:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF4D20722;
        Thu, 19 Mar 2020 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623246;
        bh=91ZeNh0qV2wiYcb7a2G7SGxyeWnlP3SieJA4AAUxPn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNAa8R+m2tMJR9IzOWeDIJ9eYXqrwgX6gNnQgQxEyaZkXyM1RpGXTuwxz1md+iSt9
         5ZvXXDBnAvEI3bRAdkxPBjEScP2Mam9vk78ga9+ATJ9xE60gY9eCf0SDIgqzVp2diX
         GNeHHFPe06tCe8CslwHKfzQS85o7KmUqERWBE0Yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Antonio Quartulli <a@unstable.cc>
Subject: [PATCH 4.4 38/93] batman-adv: Fix invalid read while copying bat_iv.bcast_own
Date:   Thu, 19 Mar 2020 13:59:42 +0100
Message-Id: <20200319123936.965726707@linuxfoundation.org>
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

From: Sven Eckelmann <sven@narfation.org>

commit 13bbdd370f67aef3351ad7bbc2fb624e3c23f905 upstream.

batadv_iv_ogm_orig_del_if removes a part of the bcast_own which previously
belonged to the now removed interface. This is done by copying all data
which comes before the removed interface and then appending all the data
which comes after the removed interface.

The address calculation for the position of the data which comes after the
removed interface assumed that the bat_iv.bcast_own is a pointer to a
single byte datatype. But it is a pointer to unsigned long and thus the
calculated position was wrong off factor sizeof(unsigned long).

Fixes: 83a8342678a0 ("more basic routing code added (forwarding packets / bitarray added)")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_iv_ogm.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -185,7 +185,8 @@ unlock:
 static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
 				     int max_if_num, int del_if_num)
 {
-	int chunk_size,  ret = -ENOMEM, if_offset;
+	int ret = -ENOMEM;
+	size_t chunk_size, if_offset;
 	void *data_ptr = NULL;
 
 	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
@@ -203,8 +204,9 @@ static int batadv_iv_ogm_orig_del_if(str
 	memcpy(data_ptr, orig_node->bat_iv.bcast_own, del_if_num * chunk_size);
 
 	/* copy second part */
+	if_offset = (del_if_num + 1) * chunk_size;
 	memcpy((char *)data_ptr + del_if_num * chunk_size,
-	       orig_node->bat_iv.bcast_own + ((del_if_num + 1) * chunk_size),
+	       (uint8_t *)orig_node->bat_iv.bcast_own + if_offset,
 	       (max_if_num - del_if_num) * chunk_size);
 
 free_bcast_own:


