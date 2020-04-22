Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99CEC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34EE20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550254;
	bh=a3khiwbXj9vLnBMCrBQtFdH8pevxEFZcUyptAjZFPsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0DweXJhZxA8R3j9NpfzIp5EKFYx20MZruvgGHBjtpvgpSs9m9fK+Z4EJd317dX4KG
	 qEDPo0+vFSf5RkvpPJ+4CUKYIc/1VRnVYoB5pg97V0MCtgVOerZri/Dv6hCXWJn0BW
	 yDP+0JiYpwY0EMyHRz3OWmTx1iVOGpM04rv8WuKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgDVKKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbgDVKKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:10:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F192D2076E;
        Wed, 22 Apr 2020 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550241;
        bh=a3khiwbXj9vLnBMCrBQtFdH8pevxEFZcUyptAjZFPsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iV/vuCeK9ECeuh4xDpg90uxJs/i1Mhzzq5FN3kcCFz/07zbYvpX9XEd3HuHpBDW4x
         VCcWGwGHgBFtZPBEwFCspsqn8DTjhLAcQoXFdZBEOEeM8UVn2r77D928msu7fzpucr
         UGhnElAkCdcqJ2Qe5IktMguLpQ+q5+IkviAGiDZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liam mcbirnie <liam.mcbirnie@boeing.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 067/199] net: rtnl_configure_link: fix dev flags changes arg to __dev_notify_flags
Date:   Wed, 22 Apr 2020 11:56:33 +0200
Message-Id: <20200422095104.917614826@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roopa Prabhu <roopa@cumulusnetworks.com>

commit 56a49d7048703f5ffdb84d3a0ee034108fba6850 upstream.

This fix addresses https://bugzilla.kernel.org/show_bug.cgi?id=201071

Commit 5025f7f7d506 wrongly relied on __dev_change_flags to notify users of
dev flag changes in the case when dev->rtnl_link_state = RTNL_LINK_INITIALIZED.
Fix it by indicating flag changes explicitly to __dev_notify_flags.

Fixes: 5025f7f7d506 ("rtnetlink: add rtnl_link_state check in rtnl_configure_link")
Reported-By: Liam mcbirnie <liam.mcbirnie@boeing.com>
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/rtnetlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2424,7 +2424,7 @@ int rtnl_configure_link(struct net_devic
 	}
 
 	if (dev->rtnl_link_state == RTNL_LINK_INITIALIZED) {
-		__dev_notify_flags(dev, old_flags, 0U);
+		__dev_notify_flags(dev, old_flags, (old_flags ^ dev->flags));
 	} else {
 		dev->rtnl_link_state = RTNL_LINK_INITIALIZED;
 		__dev_notify_flags(dev, old_flags, ~0U);


