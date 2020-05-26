Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA98C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCE1208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519574;
	bh=s5uIdwHoq0DUL8XtbeEATZDxARzNHyHj8OxFlLF9QVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IpWjxGqi3aodlf/OmUTFx8ANInXV7IiQWWXVVtrTl/NSRAoGNYWLm0lci33zsAB3/
	 5IiZqo8/NswAwbGLtj+YyOzCZDPIQXm6b3HHrWL3EOBIU94h/J+KENwyFSKFQSnz/H
	 0WZp6mCPE96cunSyW7qqNwn7ZTXaehx434ZGvj+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390545AbgEZS7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389923AbgEZS70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:59:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18843208DB;
        Tue, 26 May 2020 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519565;
        bh=s5uIdwHoq0DUL8XtbeEATZDxARzNHyHj8OxFlLF9QVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mc/uEHXFU1sQS+HDuHMhzVMNcZtN2GipUXXTfI7sxKjS3/moCL+L/ZJuvWunxuvBx
         pCCdigEC2B+9rl62jMaZn0x1e2KSSGysM+umWz6c5nAgzQDg9/XVbG5e+E72uiMoYo
         LBWVs23GyyRFZe0nmrOMFeR4chfDw59MFXt481CU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.9 36/64] l2tp: initialise sessions refcount before making it reachable
Date:   Tue, 26 May 2020 20:53:05 +0200
Message-Id: <20200526183924.899863279@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183913.064413230@linuxfoundation.org>
References: <20200526183913.064413230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <g.nault@alphalink.fr>

commit 9ee369a405c57613d7c83a3967780c3e30c52ecc upstream.

Sessions must be fully initialised before calling
l2tp_session_add_to_tunnel(). Otherwise, there's a short time frame
where partially initialised sessions can be accessed by external users.

Backporting Notes

l2tp_core.c: moving code that had been converted from atomic to
refcount_t by an earlier change (which isn't being included in this
patch series).

Fixes: dbdbc73b4478 ("l2tp: fix duplicate session creation")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1847,6 +1847,8 @@ struct l2tp_session *l2tp_session_create
 
 		l2tp_session_set_header_len(session, tunnel->version);
 
+		l2tp_session_inc_refcount(session);
+
 		err = l2tp_session_add_to_tunnel(tunnel, session);
 		if (err) {
 			kfree(session);
@@ -1854,10 +1856,6 @@ struct l2tp_session *l2tp_session_create
 			return ERR_PTR(err);
 		}
 
-		/* Bump the reference count. The session context is deleted
-		 * only when this drops to zero.
-		 */
-		l2tp_session_inc_refcount(session);
 		l2tp_tunnel_inc_refcount(tunnel);
 
 		/* Ensure tunnel socket isn't deleted */


