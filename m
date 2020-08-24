Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759EE2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258550;
	bh=Jneed6ie/AYBGZ4JnR/nz3pF9fM3dYNvhGU5zeQzGlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XLFbCFxlmpikRc6R0nZ609zs+ZrMsDboJCz99BtWpOzf+AfLVCBfHmQ/JtI9x5t70
	 WH72NauZ1qMugGXkJjCPdVuJflKMsnS77cbS+fASyegTjV2PHdijnTSIRWZw6ZwpSq
	 9XDGOM/ew+8NH8or1QzJOm2Z/GAEkKxB7SDm3CIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgHXIm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgHXImO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:42:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5B621775;
        Mon, 24 Aug 2020 08:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258533;
        bh=Jneed6ie/AYBGZ4JnR/nz3pF9fM3dYNvhGU5zeQzGlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiY5fJQqa2SwkmTXfggr1ooRbb5l6eiUihnAy1jA/wtWR/oGEmd568/iiYYjXPwEl
         nUrrkGAwGnKr/AnJEnoO/VZocEnu06LAdZF6NVPJ8g1RK+oX0m7wXeIOQ0PF586dv+
         ET7sdkctq0PkU30BNeYiPHhjNIVdVccJaNvQO9iA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 080/124] can: j1939: abort multipacket broadcast session when timeout occurs
Date:   Mon, 24 Aug 2020 10:30:14 +0200
Message-Id: <20200824082413.349996764@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Changzhong <zhangchangzhong@huawei.com>

[ Upstream commit 2b8b2e31555cf55ba3680fb28e2b382e168d7ea1 ]

If timeout occurs, j1939_tp_rxtimer() first calls hrtimer_start() to restart
rxtimer, and then calls __j1939_session_cancel() to set session->state =
J1939_SESSION_WAITING_ABORT. At next timeout expiration, because of the
J1939_SESSION_WAITING_ABORT session state j1939_tp_rxtimer() will call
j1939_session_deactivate_activate_next() to deactivate current session, and
rxtimer won't be set.

But for multipacket broadcast session, __j1939_session_cancel() don't set
session->state = J1939_SESSION_WAITING_ABORT, thus current session won't be
deactivate and hrtimer_start() is called to start new rxtimer again and again.

So fix it by moving session->state = J1939_SESSION_WAITING_ABORT out of if
(!j1939_cb_is_broadcast(&session->skcb)) statement.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Link: https://lore.kernel.org/r/1596599425-5534-4-git-send-email-zhangchangzhong@huawei.com
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index d1a9adde677b0..e3167619b196f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1074,9 +1074,9 @@ static void __j1939_session_cancel(struct j1939_session *session,
 	lockdep_assert_held(&session->priv->active_session_list_lock);
 
 	session->err = j1939_xtp_abort_to_errno(priv, err);
+	session->state = J1939_SESSION_WAITING_ABORT;
 	/* do not send aborts on incoming broadcasts */
 	if (!j1939_cb_is_broadcast(&session->skcb)) {
-		session->state = J1939_SESSION_WAITING_ABORT;
 		j1939_xtp_tx_abort(priv, &session->skcb,
 				   !session->transmission,
 				   err, session->skcb.addr.pgn);
-- 
2.25.1



