Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDAEC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B90320857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758189;
	bh=HShBr38L9TtO0Jru578++oUHXplOTkg6vdn9iu3NCIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LfXlvX1viQv7fxZIgwIL2XJ5GkyBRdnBwC72q3OjeZQVUOxSndWwuhD7VTOR8zDGE
	 Nshyh6Wpw5nACkD8a6mWJKlSt19jW3JQyogkeeFlfr9N99FCz1ruPESSmVr/9C3mcz
	 lTZY6hL4o9qI5dzA8CnATRhD6BTBJLEKLsi+TiDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbgDAQXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387561AbgDAQXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:23:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9647020857;
        Wed,  1 Apr 2020 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758182;
        bh=HShBr38L9TtO0Jru578++oUHXplOTkg6vdn9iu3NCIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOKTaBFIhS/N6yPTZOuHT9Usz8Q99FpVcNlc0EOyyI1r+jVUhA7hqwNPx3nQ58DXN
         WYO3PZvdnAgDsiloBhfrhE4NS222Z1Na4MWf2PRL+cdh9k2oWM1IJmVhXRyDK9LzL5
         wWgnJQy/ny73PQVWDiKqVaZPhpaIihgI1Mm0i74c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 010/116] mlxsw: spectrum_mr: Fix list iteration in error path
Date:   Wed,  1 Apr 2020 18:16:26 +0200
Message-Id: <20200401161543.451874223@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit f6bf1bafdc2152bb22aff3a4e947f2441a1d49e2 ]

list_for_each_entry_from_reverse() iterates backwards over the list from
the current position, but in the error path we should start from the
previous position.

Fix this by using list_for_each_entry_continue_reverse() instead.

This suppresses the following error from coccinelle:

drivers/net/ethernet/mellanox/mlxsw//spectrum_mr.c:655:34-38: ERROR:
invalid reference to the index variable of the iterator on line 636

Fixes: c011ec1bbfd6 ("mlxsw: spectrum: Add the multicast routing offloading logic")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
@@ -637,12 +637,12 @@ static int mlxsw_sp_mr_vif_resolve(struc
 	return 0;
 
 err_erif_unresolve:
-	list_for_each_entry_from_reverse(erve, &mr_vif->route_evif_list,
-					 vif_node)
+	list_for_each_entry_continue_reverse(erve, &mr_vif->route_evif_list,
+					     vif_node)
 		mlxsw_sp_mr_route_evif_unresolve(mr_table, erve);
 err_irif_unresolve:
-	list_for_each_entry_from_reverse(irve, &mr_vif->route_ivif_list,
-					 vif_node)
+	list_for_each_entry_continue_reverse(irve, &mr_vif->route_ivif_list,
+					     vif_node)
 		mlxsw_sp_mr_route_ivif_unresolve(mr_table, irve);
 	mr_vif->rif = NULL;
 	return err;


