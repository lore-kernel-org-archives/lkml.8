Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370DDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C03A206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037669;
	bh=xC9hJYuRSl5pnTM9TMOSwz7SgPWF7neADVLAEPjyJ74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gRjdpRJD2LDr+aya8+aB9srftxhNuo9YhRV7jBWr6gDWLO8ziuYZBR1Xt1ANmaedy
	 9V1OlkmJXpI/AjVoCVof7koOFrYetAsDa2JbJI3yXuPPelw+CBnfMQS2jzOQtaP0nj
	 bkpWMbua0c7LXjGd1Mox5nkEhQK0znPuzmOjOAAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgFASy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgFASCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:02:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24FA2065C;
        Mon,  1 Jun 2020 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034521;
        bh=xC9hJYuRSl5pnTM9TMOSwz7SgPWF7neADVLAEPjyJ74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XuAu44y8IVszvTeCx4kOTQGMRXVqS0W5QxvY0/jLrB6okRSb91G+8tYaMxKuix0NI
         aeivGFMSm/zFyyNyGB9q/g7TPydx667mgM8dlBmZwV5Z8s2Ca662jWVLe4jXIFlsCQ
         Z6z+s62vG794RavSCPrg/wQKqNl/2y8aa/6JAgFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 69/77] bonding: Fix reference count leak in bond_sysfs_slave_add.
Date:   Mon,  1 Jun 2020 19:54:14 +0200
Message-Id: <20200601174028.225991942@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174016.396817032@linuxfoundation.org>
References: <20200601174016.396817032@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

commit a068aab42258e25094bc2c159948d263ed7d7a77 upstream.

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 07699f9a7c8d ("bonding: add sysfs /slave dir for bond slave devices.")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/bonding/bond_sysfs_slave.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_sysfs_slave.c
+++ b/drivers/net/bonding/bond_sysfs_slave.c
@@ -153,8 +153,10 @@ int bond_sysfs_slave_add(struct slave *s
 
 	err = kobject_init_and_add(&slave->kobj, &slave_ktype,
 				   &(slave->dev->dev.kobj), "bonding_slave");
-	if (err)
+	if (err) {
+		kobject_put(&slave->kobj);
 		return err;
+	}
 
 	for (a = slave_attrs; *a; ++a) {
 		err = sysfs_create_file(&slave->kobj, &((*a)->attr));


