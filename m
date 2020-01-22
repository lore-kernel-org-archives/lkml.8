Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327A6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DD224688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699314;
	bh=Xkh8dqi9IgszcM913+Hd84sm2TxVAB8sa97eLZmvaec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jaeIwK/+Dig8cv6A5RhB89q86bCc4VaU/lY33Nr94p0cP7DF0YNEyQvMGITg1JWHR
	 2X2uptX3WImS5xnG19ugw+aODddx0Y+AHhsAfhFCkWEaIMhLWoT1wNjr/uIrf0Y/Bw
	 jiC/oIaJU1RhtnFrhDilgf+2gaeGv++DALmSBUCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgAVNVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbgAVNVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:51 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA85A205F4;
        Wed, 22 Jan 2020 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699310;
        bh=Xkh8dqi9IgszcM913+Hd84sm2TxVAB8sa97eLZmvaec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BW2LtglTSlNDenm+qT1b7EWfdmrJ9EZMRUuLqgO0hQJCSpjQ9NNPLD065RQ/8YAU2
         0aF0FErJQ56lLnNuvXNf8C+2PG5kzNGV4VO57J2nso6n8XJ5Rz7esq3Z3MTgvayn78
         Ykrd4aNEOOmiKSrMiI3ynZz/lIHyR3jyKzC+cuNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 104/222] net: fix kernel-doc warning in <linux/netdevice.h>
Date:   Wed, 22 Jan 2020 10:28:10 +0100
Message-Id: <20200122092841.186379638@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

commit 1f26c0d3d24125992ab0026b0dab16c08df947c7 upstream.

Fix missing '*' kernel-doc notation that causes this warning:

../include/linux/netdevice.h:1779: warning: bad line:                                 spinlock

Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netdevice.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1761,7 +1761,7 @@ enum netdev_priv_flags {
  *			for hardware timestamping
  *	@sfp_bus:	attached &struct sfp_bus structure.
  *	@qdisc_tx_busylock_key: lockdep class annotating Qdisc->busylock
-				spinlock
+ *				spinlock
  *	@qdisc_running_key:	lockdep class annotating Qdisc->running seqcount
  *	@qdisc_xmit_lock_key:	lockdep class annotating
  *				netdev_queue->_xmit_lock spinlock


