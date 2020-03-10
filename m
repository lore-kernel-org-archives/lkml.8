Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C76BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4615E24691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844341;
	bh=/kRuxcuHOYsDociFLkbeQUfdfObngkhGQ3sS+2p7z/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J90zH9ALCYVF2bdUzVy/Kt5I28RQ2JCilgkF2L4yhC3Ze4oFlqAvNoXxsxgzo9d+F
	 sdM2LR7/kGh1BH3VsjzUEEcBVOwVKTizky1094EJOSD4uqDN3qy3Ko+xkgnpfwGQIQ
	 EQ4nJMoja20w37rvwgtM0Z2oZ2p6xQKcnyAEW82k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCJMpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgCJMpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:45:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2102B246A6;
        Tue, 10 Mar 2020 12:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844334;
        bh=/kRuxcuHOYsDociFLkbeQUfdfObngkhGQ3sS+2p7z/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KU2y/LE7Z+M3HV30u1oaslEz6DJYM4Saq9kPW6VuZjjpfR15ZwIZbXohfE9TE+8Di
         tCUwYJpY+3k1C8c7XjV9g9ik5u7mAvhthIOQ29EgqF/idFSIK4OyuBIcNyMf5Jg03l
         1YY/j0kHNZmrxrxfxIwi6BlC+FRcXHKH/zJTY7KE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>
Subject: [PATCH 4.9 44/88] slip: stop double free sl->dev in slip_open
Date:   Tue, 10 Mar 2020 13:38:52 +0100
Message-Id: <20200310123616.884028679@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yangerkun <yangerkun@huawei.com>

After include 3b5a39979daf ("slip: Fix memory leak in slip_open error path")
and e58c19124189 ("slip: Fix use-after-free Read in slip_open") with 4.4.y/4.9.y.
We will trigger a bug since we can double free sl->dev in slip_open. Actually,
we should backport cf124db566e6 ("net: Fix inconsistent teardown and release
of private netdev state.") too since it has delete free_netdev from sl_free_netdev.
Fix it by delete free_netdev from slip_open.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/slip/slip.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -868,7 +868,6 @@ err_free_chan:
 	tty->disc_data = NULL;
 	clear_bit(SLF_INUSE, &sl->flags);
 	sl_free_netdev(sl->dev);
-	free_netdev(sl->dev);
 
 err_exit:
 	rtnl_unlock();


