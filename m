Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A2BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EC22067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591727015;
	bh=ps8pnlBp1WwH8dOmL2uAK8jQRRYb/JbeuNB5BmVB1l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2BjOdHRT6xNcpjnGfgmliBmQZZ2GcwoRomKIHmVCJA4qVWHMaufJkogvQtrS4vo2u
	 LMampaNGUq0x5JZNz1xy6tS3YyN/4E1mGb7BapND3r+DJl7Ru0d3Nt8RJbvNo9Womj
	 yBSMxpUOhWDl1GSRsXuqCGsjWcpgDLUURB34WA6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbgFISXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbgFIRrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:47:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D13D20823;
        Tue,  9 Jun 2020 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724844;
        bh=ps8pnlBp1WwH8dOmL2uAK8jQRRYb/JbeuNB5BmVB1l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+z4vdbCsZK8ZTXQA/RurSSylVPPisUzCsmSFsabfi8KT3VMT04kxxLPNp4dq/rsx
         PXA1gabhethlfHQDhYGkofsRmOgrFK9PkKjEMrjYLyLgvQZ9jZkfVkcgI15mh2QGQG
         ehd33yZCFY1pL+Hva+4Uhxz63xQxNcWq05W7Z8/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 16/36] slcan: Fix double-free on slcan_open() error path
Date:   Tue,  9 Jun 2020 19:44:16 +0200
Message-Id: <20200609173934.205737358@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

Commit 9ebd796e2400 ("can: slcan: Fix use-after-free Read in
slcan_open") was incorrectly backported to 4.4 and 4.9 stable
branches.

Since they do not have commit cf124db566e6 ("net: Fix inconsistent
teardown and release of private netdev state."), the destructor
function slc_free_netdev() is already responsible for calling
free_netdev() and slcan_open() must not call both of them.

yangerkun previously fixed the same bug in slip.

Fixes: ce624b2089ea ("can: slcan: Fix use-after-free Read in slcan_open") # 4.4
Fixes: f59604a80fa4 ("slcan: not call free_netdev before rtnl_unlock ...") # 4.4
Fixes: 56635a1e6ffb ("can: slcan: Fix use-after-free Read in slcan_open") # 4.9
Fixes: a1c9b23142ac ("slcan: not call free_netdev before rtnl_unlock ...") # 4.9
Cc: yangerkun <yangerkun@huawei.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/slcan.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -618,10 +618,9 @@ err_free_chan:
 	sl->tty = NULL;
 	tty->disc_data = NULL;
 	clear_bit(SLF_INUSE, &sl->flags);
-	slc_free_netdev(sl->dev);
 	/* do not call free_netdev before rtnl_unlock */
 	rtnl_unlock();
-	free_netdev(sl->dev);
+	slc_free_netdev(sl->dev);
 	return err;
 
 err_exit:


