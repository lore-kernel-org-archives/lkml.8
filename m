Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A915C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB892051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196443;
	bh=HGhx/zmL8/C/mfUQHP9jB2DLzEnwQZgZWd7IWiSc1eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uKcUUsShzRrhasU1hGFeJsGEY+X8Px8QLo4GWr7r3nh/oxXU/1oAyHy4rYvcgQc+o
	 A5mFkwvh6Z9ioOMcKrfXJtu4+ps2WaESuUEI4vKDoMlw08IuR73tAMUsGiMZ2p+IS6
	 A5bTsCdhsYRkNdGwa4ch98FocidMKNXdcjlw+l0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405577AbgAPRkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393499AbgAPRjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 246122471F;
        Thu, 16 Jan 2020 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196381;
        bh=HGhx/zmL8/C/mfUQHP9jB2DLzEnwQZgZWd7IWiSc1eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqCp7b8mNJ/MgMyXnwu+sLrw5E868dxJh7fQlXWcGrJvQBi2vwUhHaeazTVq0M3rs
         3pa2y3kJkCKqERsfEAVJIJvCqszsQEIiKAiIacAn30KHGRRUmd8p86M1A2UYIp3NuA
         cozM5Bh1YujEUGzU4PBYOHNqFOjBHU86hklaROBs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 164/251] rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()
Date:   Thu, 16 Jan 2020 12:35:13 -0500
Message-Id: <20200116173641.22137-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
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
index 59d328603312..64389f493bb2 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -400,6 +400,9 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
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

