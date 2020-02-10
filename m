Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E89EC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABD520714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340291;
	bh=QLp1kilJwM9rYN1UD+VjRxyJRyHTKObrmrGVxgyj8pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zRps9QzUnkeC+3EVDKxwSMGViytAkFOdSFEjg6ydkjquh6qq1nGs8KGCPsra+oRm6
	 Im0E2NFkooOHGmz4rY+SCvzJh4AfbowaZk+topWbkPM0Re2WfDt9V76E4EJkwIigEW
	 cXon06okS3SHTTg2dDQ+l3/W/d+wMDCG9lCZbQVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgBJNL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:11:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbgBJMjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:01 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF6720842;
        Mon, 10 Feb 2020 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338341;
        bh=QLp1kilJwM9rYN1UD+VjRxyJRyHTKObrmrGVxgyj8pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hjfx1sM+UGCjS2C4mfjg8PpAFrDRzMcfiLJ+CiYwDSQIzkWvsP4ZGMvPJKaV9xpZ/
         odwZGghRYZ4IBLxTcmkjqGrjy9+G+Fx5F+YtgeJl3+4T/3IqjjDcsouS9XN4nc3Ye0
         UJLNJDMVVICO08v4dAZ5ybjpxPYm8ngiyj1EdrnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 266/309] net: dsa: b53: Always use dev->vlan_enabled in b53_configure_vlan()
Date:   Mon, 10 Feb 2020 04:33:42 -0800
Message-Id: <20200210122432.223671210@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit df373702bc0f8f2d83980ea441e71639fc1efcf8 ]

b53_configure_vlan() is called by the bcm_sf2 driver upon setup and
indirectly through resume as well. During the initial setup, we are
guaranteed that dev->vlan_enabled is false, so there is no change in
behavior, however during suspend, we may have enabled VLANs before, so we
do want to restore that setting.

Fixes: dad8d7c6452b ("net: dsa: b53: Properly account for VLAN filtering")
Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/b53/b53_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -680,7 +680,7 @@ int b53_configure_vlan(struct dsa_switch
 		b53_do_vlan_op(dev, VTA_CMD_CLEAR);
 	}
 
-	b53_enable_vlan(dev, false, ds->vlan_filtering);
+	b53_enable_vlan(dev, dev->vlan_enabled, ds->vlan_filtering);
 
 	b53_for_each_port(dev, i)
 		b53_write16(dev, B53_VLAN_PAGE,


