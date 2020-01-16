Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD05C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B71B246D3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195699;
	bh=tMVDp8rNj4vWf/qGzy/RdOINQJk3zZMVBehdyYEx/7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0gGt4adpDmTzEzw/lf6FPTA4RliFWmZHSvYKPoFDMJwK8D4El4BrhUW3Kj9tTBViD
	 zB8NRcHn/MQ8i9Ge7FwOMGO20w6jymAHBcDJiwBoV8pM2PJ2VY0IhMgDnMNKPKbMhk
	 UEMzUTnVFbOaEuyvkq/TOKNBZldCJKrPgFDN8Cuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404178AbgAPR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404119AbgAPR2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:28:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B414246D7;
        Thu, 16 Jan 2020 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195694;
        bh=tMVDp8rNj4vWf/qGzy/RdOINQJk3zZMVBehdyYEx/7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOXRZErkKRRC+8vGQ6gGEHeBXfpaCCsmg+5JluXkOB3gTrvil2fYjAqoNzL0qproB
         5hzUUQ6KVekNgoszaKPoToOC/Igy6DMZMZ5xBGy9URSdQmI/dIbwKOjH3EU89J/Rnu
         n3fC5dTsuSsqHbOUsXFNQdLfOXPwFNWCfsRoZRLc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 244/371] rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()
Date:   Thu, 16 Jan 2020 12:21:56 -0500
Message-Id: <20200116172403.18149-187-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 3427beb6375d04e9627c67343872e79341a684ea ]

With gcc 4.1:

    net/rxrpc/output.c: In function ‘rxrpc_send_data_packet’:
    net/rxrpc/output.c:338: warning: ‘ret’ may be used uninitialized in this function

Indeed, if the first jump to the send_fragmentable label is made, and
the address family is not handled in the switch() statement, ret will be
used uninitialized.

Fix this by BUG()'ing as is done in other places in rxrpc where internal
support for future address families will need adding.  It should not be
possible to reach this normally as the address families are checked
up-front.

Fixes: 5a924b8951f835b5 ("rxrpc: Don't store the rxrpc header in the Tx queue sk_buffs")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5b67cb5d47f0..edddbacf33bc 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -404,6 +404,9 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 		}
 		break;
 #endif
+
+	default:
+		BUG();
 	}
 
 	up_write(&conn->params.local->defrag_sem);
-- 
2.20.1

