Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A7C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4749320658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443110;
	bh=6Ht9hRcQ3x8A/4aWNjgCjoKSWvdw+u4LLN81XdYlhHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=krUm1LB3yhVsJUf66lhctUlKMjDKbLZ+2hw16l49VVsE3cUVhWOKvVeq+DsF3mPT+
	 vJy+G9S9w6l+Qcy5WKDZ88yyigxyk3itbbdiDtCq2VxsEdcmQSmYClCuKsAIUNWfeV
	 mBU+NC1/AUSaWYG86+Sfs7wk5KktLAkv44D5B02k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgCQLFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgCQLFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:05:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA6820736;
        Tue, 17 Mar 2020 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443103;
        bh=6Ht9hRcQ3x8A/4aWNjgCjoKSWvdw+u4LLN81XdYlhHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBHaCk7mtyb+V3fgeCyFr6baD3Hlyyglj8xQRiuJp4Zpp0b9gqbwWW+DilT6Iq0vJ
         O6/MVg5snrWUuLzzmH86j2KvQvav3VL0ttRvtroVJmACFT/4S6TYu3S+kCiS4/m6hU
         3gWvrIFGsYK5NBqaGPSX/8fUsYqortsb7wGFrrlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a98f2016f40b9cd3818a@syzkaller.appspotmail.com,
        syzbot+ac36b6a33c28a491e929@syzkaller.appspotmail.com,
        Sven Eckelmann <sven@narfation.org>,
        Hillf Danton <hdanton@sina.com>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.4 097/123] batman-adv: Dont schedule OGM for disabled interface
Date:   Tue, 17 Mar 2020 11:55:24 +0100
Message-Id: <20200317103317.657030422@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

commit 8e8ce08198de193e3d21d42e96945216e3d9ac7f upstream.

A transmission scheduling for an interface which is currently dropped by
batadv_iv_ogm_iface_disable could still be in progress. The B.A.T.M.A.N. V
is simply cancelling the workqueue item in an synchronous way but this is
not possible with B.A.T.M.A.N. IV because the OGM submissions are
intertwined.

Instead it has to stop submitting the OGM when it detect that the buffer
pointer is set to NULL.

Reported-by: syzbot+a98f2016f40b9cd3818a@syzkaller.appspotmail.com
Reported-by: syzbot+ac36b6a33c28a491e929@syzkaller.appspotmail.com
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: Hillf Danton <hdanton@sina.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/batman-adv/bat_iv_ogm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -789,6 +789,10 @@ static void batadv_iv_ogm_schedule_buff(
 
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
 
+	/* interface already disabled by batadv_iv_ogm_iface_disable */
+	if (!*ogm_buff)
+		return;
+
 	/* the interface gets activated here to avoid race conditions between
 	 * the moment of activating the interface in
 	 * hardif_activate_interface() where the originator mac is set and


