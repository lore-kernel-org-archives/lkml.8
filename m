Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ECAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337152145D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942043;
	bh=bYaOZUiO2/sAycHFzPVmFuEsY1cLjI1j9bTLA27NKW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oKpGDa0FKjHtMXYBGaqbTypJgSLACstjzkiL7etyrbEqN9zUl4fAJ3M9HwY1eAw5m
	 ZsVfsoxgGYgrl4h3d4TXYDolj2AWylL+QZka7bmaN2eibLzrd3XHe85pLOk6ehzQ24
	 Zef2AVvJL7pZwpXM8r42a93gEoiE8mJBWm5LXCVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgEHMrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbgEHMrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDE824974;
        Fri,  8 May 2020 12:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942028;
        bh=bYaOZUiO2/sAycHFzPVmFuEsY1cLjI1j9bTLA27NKW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quyrOeoUX3auJ8EkjbPxO/nOfFFmPH8e/l4aiAe90AEN7SAepbDd3Hn01MgVX53hJ
         N6yfuSYCYxKtw1skOUPcHYMxZbH8UbvGdMABaIobUgfNfvPUaCJw7gc6DC4096/3Cs
         c/Y/EM5aR3n8YxiaW8Y5c/nW4LM6jZc2PUGq0+6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Greg Rose <gregory.v.rose@intel.com>,
        Mathias Krause <minipli@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 267/312] rtnl: reset calcit fptr in rtnl_unregister()
Date:   Fri,  8 May 2020 14:34:18 +0200
Message-Id: <20200508123143.214629119@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Krause <minipli@googlemail.com>

commit f567e950bf51290755a2539ff2aaef4c26f735d3 upstream.

To avoid having dangling function pointers left behind, reset calcit in
rtnl_unregister(), too.

This is no issue so far, as only the rtnl core registers a netlink
handler with a calcit hook which won't be unregistered, but may become
one if new code makes use of the calcit hook.

Fixes: c7ac8679bec9 ("rtnetlink: Compute and store minimum ifinfo...")
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Greg Rose <gregory.v.rose@intel.com>
Signed-off-by: Mathias Krause <minipli@googlemail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/rtnetlink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -253,6 +253,7 @@ int rtnl_unregister(int protocol, int ms
 
 	rtnl_msg_handlers[protocol][msgindex].doit = NULL;
 	rtnl_msg_handlers[protocol][msgindex].dumpit = NULL;
+	rtnl_msg_handlers[protocol][msgindex].calcit = NULL;
 
 	return 0;
 }


