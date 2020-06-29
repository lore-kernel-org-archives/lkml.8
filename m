Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C618C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE00207D0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464969;
	bh=X3SpH3cEO2qEabbYJ3jLb7aQhxaAWEW5SjVBMz55dNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVJGdRfs4Z/wrZbXUsWwil8E97VfcN7lw003RU5tzWejhc7IuNjiZFCnmeeyZbmvN
	 g71ebgMYZ4E2TlOg2M4SKmW7ennzXlxg7AIO7sPneYhFIaU3/6Z9RYcIyaZy71Q63V
	 87aKSzIw7t55s07tYpd+WFCpc+npsDV3ShRa+s9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbgF2VJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730320AbgF2TAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF5125520;
        Mon, 29 Jun 2020 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446084;
        bh=X3SpH3cEO2qEabbYJ3jLb7aQhxaAWEW5SjVBMz55dNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gShZp1t+Ac9RlkMTfASzm+AHvj26EXVhmZRFFFOUvQZeAP52mM1eqJXk6wczb2p7K
         8JMdnPhnDjuCppKfuko6R1PnUc5iyJoDNQh+ja9XWrrg4lSOmvPdu0OuZRVZ095Zln
         lyJahRudkX51g0Ol9trfgoXEGG5Gk+Wh51pnGLy0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ridge Kennedy <ridge.kennedy@alliedtelesis.co.nz>,
        James Chapman <jchapman@katalix.com>,
        "David S . Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 079/135] l2tp: Allow duplicate session creation with UDP
Date:   Mon, 29 Jun 2020 11:52:13 -0400
Message-Id: <20200629155309.2495516-80-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ridge Kennedy <ridge.kennedy@alliedtelesis.co.nz>

commit 0d0d9a388a858e271bb70e71e99e7fe2a6fd6f64 upstream.

In the past it was possible to create multiple L2TPv3 sessions with the
same session id as long as the sessions belonged to different tunnels.
The resulting sessions had issues when used with IP encapsulated tunnels,
but worked fine with UDP encapsulated ones. Some applications began to
rely on this behaviour to avoid having to negotiate unique session ids.

Some time ago a change was made to require session ids to be unique across
all tunnels, breaking the applications making use of this "feature".

This change relaxes the duplicate session id check to allow duplicates
if both of the colliding sessions belong to UDP encapsulated tunnels.

Fixes: dbdbc73b4478 ("l2tp: fix duplicate session creation")
Signed-off-by: Ridge Kennedy <ridge.kennedy@alliedtelesis.co.nz>
Acked-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 239464045697e..53c53b1c881c5 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -351,8 +351,13 @@ int l2tp_session_register(struct l2tp_session *session,
 
 		spin_lock_bh(&pn->l2tp_session_hlist_lock);
 
+		/* IP encap expects session IDs to be globally unique, while
+		 * UDP encap doesn't.
+		 */
 		hlist_for_each_entry(session_walk, g_head, global_hlist)
-			if (session_walk->session_id == session->session_id) {
+			if (session_walk->session_id == session->session_id &&
+			    (session_walk->tunnel->encap == L2TP_ENCAPTYPE_IP ||
+			     tunnel->encap == L2TP_ENCAPTYPE_IP)) {
 				err = -EEXIST;
 				goto err_tlock_pnlock;
 			}
-- 
2.25.1

