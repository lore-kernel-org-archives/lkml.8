Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC31B207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591724892;
	bh=ps8pnlBp1WwH8dOmL2uAK8jQRRYb/JbeuNB5BmVB1l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xYCw6X+e6mwNAkchG1oFVdOqTS8k6AWT2M7wUZ1IoeqjVQg89sUAskwrnFMfPXLg0
	 PrTG1O90Ml8f8gmQPJPNV2bh40fEXTSbjq/1eCQN4f8NdrXFVoogSMZY2OU7jfFc4O
	 E/AKXmQL99ane5jAMXA/HggDGw04ddply26iKxW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbgFIRsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732190AbgFIRr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:47:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D17207ED;
        Tue,  9 Jun 2020 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724876;
        bh=ps8pnlBp1WwH8dOmL2uAK8jQRRYb/JbeuNB5BmVB1l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cU5vUCBrgxlKITgPu0i04bKduwOcDR7tpvKGf3dd4zzpH7v6LjXSc5lKDxOgygum5
         wq9zrX0qKK9TFgZHWThkSfGRdeVOzfVdD5jcXqn9iaGkG+szkoZF0kWEMS6kvmC3TA
         fwwd6wWsggvdTWvf+fksolLSzHNE5223PjSlFLTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 18/42] slcan: Fix double-free on slcan_open() error path
Date:   Tue,  9 Jun 2020 19:44:24 +0200
Message-Id: <20200609174017.456929674@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174015.379493548@linuxfoundation.org>
References: <20200609174015.379493548@linuxfoundation.org>
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


