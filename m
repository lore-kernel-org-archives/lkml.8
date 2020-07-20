Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EA6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8071F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261781;
	bh=xNAtOKLExuskyl6B4Nrmj0rAa9QDqrNJ1JNraiiA75Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RhJeD3TKcGNW+ScV22mPboWyCKY4BCcl55qbc6oTG+9NLZbtTCtRDh2L1mK6e//Nk
	 1xk7iNdm936JdwPGnDDKJIJuGwnOFjt2BizMw+BUwYqFaxcVx/mG/KciF5PnmDFrvL
	 jZ5VpWvnZSwwyu9iel3Dbpox6MDvqpoxTHXaGg/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbgGTQQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730844AbgGTQQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:16:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 645F8206E9;
        Mon, 20 Jul 2020 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261774;
        bh=xNAtOKLExuskyl6B4Nrmj0rAa9QDqrNJ1JNraiiA75Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=odl4sBG/1gwnUhgFV5ppGc8OEjAHhjSU5PJuyT7Z+zzSpdJ3Qs6ejQXjssCEefUBZ
         ESJrUmi6Zxrg2UfzyooS0IOGYQS623fX3GyDwsNi6L6kF8FKxxHIYvCQF2UsIEMlEE
         ushmQfMzxdMTwF/aTi+98Sos5o1BrpaLsrF2qJ6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
        Jonathan Toppins <jtoppins@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 236/244] ionic: no link check while resetting queues
Date:   Mon, 20 Jul 2020 17:38:27 +0200
Message-Id: <20200720152837.064215527@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

commit 3103b6feb4454646558eedc50ece728bc469f341 upstream.

If the driver is busy resetting queues after a change in
MTU or queue parameters, don't bother checking the link,
wait until the next watchdog cycle.

Fixes: 987c0871e8ae ("ionic: check for linkup in watchdog")
Signed-off-by: Shannon Nelson <snelson@pensando.io>
Acked-by: Jonathan Toppins <jtoppins@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -85,7 +85,8 @@ static void ionic_link_status_check(stru
 	u16 link_status;
 	bool link_up;
 
-	if (!test_bit(IONIC_LIF_F_LINK_CHECK_REQUESTED, lif->state))
+	if (!test_bit(IONIC_LIF_F_LINK_CHECK_REQUESTED, lif->state) ||
+	    test_bit(IONIC_LIF_F_QUEUE_RESET, lif->state))
 		return;
 
 	if (lif->ionic->is_mgmt_nic)


