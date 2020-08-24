Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54463C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEE42075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261679;
	bh=NSM0kikoMYd4CitRmeGSudrfPq2pKTmsMTIAOfWWzhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uhp7ddBSnTvbbkEbDhq1CMvEbN6HikYLJhAI8FzO5q/MKGltqu6M91Slnn0KgZc3X
	 rXuC9f5Snnn/jWhzytlwIRM79QsPItjxJrK+zm7Tbk0ztCpoBy0EkEp19EfmbqHOo3
	 SjLECGHgM9WOY1+Zr+FRfCtpffi2V8xkBwvPdubs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgHXIta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbgHXItT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:49:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1718E206F0;
        Mon, 24 Aug 2020 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258958;
        bh=NSM0kikoMYd4CitRmeGSudrfPq2pKTmsMTIAOfWWzhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAVeuyauxz4ohbt7cLv4D3+oxfQHLdMlTlOvPgCD+eo8j6Tvexdy/Tv8O9TnoNVeF
         KpMblvtCXFzQz/yScYPI961gs8j5cSBgWXADbwoxfOO+Sk8xcriPDqb8eXXljnWnow
         PIUPPvrM6wDECdUbtk2JNsguXswAG7XhpwJhjnrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 078/107] can: j1939: cancel rxtimer on multipacket broadcast session complete
Date:   Mon, 24 Aug 2020 10:30:44 +0200
Message-Id: <20200824082408.981713342@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Changzhong <zhangchangzhong@huawei.com>

[ Upstream commit e8b17653088f28a87c81845fa41a2d295a3b458c ]

If j1939_xtp_rx_dat_one() receive last frame of multipacket broadcast message,
j1939_session_timers_cancel() should be called to cancel rxtimer.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Link: https://lore.kernel.org/r/1596599425-5534-3-git-send-email-zhangchangzhong@huawei.com
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/j1939/transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 67189b4c482c5..d1a9adde677b0 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1811,6 +1811,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	}
 
 	if (final) {
+		j1939_session_timers_cancel(session);
 		j1939_session_completed(session);
 	} else if (do_cts_eoma) {
 		j1939_tp_set_rxtimeout(session, 1250);
-- 
2.25.1



