Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3EAC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A629E20658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624381;
	bh=M3tpY7xARF8p9JJiyj/NDGxEIXft6hv4AOv3H5Ace84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U6s6LrEd5XA7zxIWap28UO5kDp76epr9NHdfT5tlIG8Uai/dlCWFtrGChrU0wmOja
	 gvQuCh9uHtMj7YAPm1zxLgxDUpqF6JtotJE+GHKkuzCmYv5LvQooglc+g1M1Fcg0da
	 oDYPGKO3fWbjwpxGv0Vuw83JNA1I2YSfbydHXax0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgCSN0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbgCSN0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:26:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD392080C;
        Thu, 19 Mar 2020 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624375;
        bh=M3tpY7xARF8p9JJiyj/NDGxEIXft6hv4AOv3H5Ace84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SG6Uv7vOvnzsIGtLJ8ums6m4VmVnrdDee+c+GEHqmxx3LkrADOLWKOkyWV7qrKtIK
         fv/0K06hwG2hVfb6WjcENFIgZG6APywSkWlJUKKLUxj6q+dsCGQhRGifltTV9g5PSN
         tOLgUX6uaGqnC70VuLY4kR89wKILG9ofyomWuPPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 41/65] slip: not call free_netdev before rtnl_unlock in slip_open
Date:   Thu, 19 Mar 2020 14:04:23 +0100
Message-Id: <20200319123939.479037568@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yangerkun <yangerkun@huawei.com>

[ Upstream commit f596c87005f7b1baeb7d62d9a9e25d68c3dfae10 ]

As the description before netdev_run_todo, we cannot call free_netdev
before rtnl_unlock, fix it by reorder the code.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/slip/slip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 61d7e0d1d77db..8e56a41dd7585 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -863,7 +863,10 @@ static int slip_open(struct tty_struct *tty)
 	tty->disc_data = NULL;
 	clear_bit(SLF_INUSE, &sl->flags);
 	sl_free_netdev(sl->dev);
+	/* do not call free_netdev before rtnl_unlock */
+	rtnl_unlock();
 	free_netdev(sl->dev);
+	return err;
 
 err_exit:
 	rtnl_unlock();
-- 
2.20.1



