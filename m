Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32EFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA38206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261125;
	bh=eBe0QDJL2Y0eDA0AKKFsk8hilV+Ik/d9FRnP60tpqNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y/OQorJJIFR1q6ET3lCnecywm+fIzWDI78fwoA4amVJ482nGRZPyPKD7mXsYTdGBl
	 YdY9reY0bfN9f+5n9dMTi9qBzsQCM9ekxQTs2X21ZLp4KXgD94pbwA5xMQginLcyYj
	 or6U5we23Hv/kkVOOUhv4LfjBSYko3GKBvR3NkDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbgGTQFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732520AbgGTQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:05:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7FE22CF7;
        Mon, 20 Jul 2020 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261106;
        bh=eBe0QDJL2Y0eDA0AKKFsk8hilV+Ik/d9FRnP60tpqNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSBuiD095JJfsddmkmgpHHmDJPzNyejJqsJ0e2mAEwlcPC2FZ4Jc53YxXkJx+0LyU
         VlYejoet7wyopVYvVpXcj049VViAkFVPZVkHiGXlm7csEYNAyghNrLQYrbscCFsx6p
         NUBN8Zd9SF03EfoB0atGL42t9o/k/VYC8dyYIEYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
        Jonathan Toppins <jtoppins@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 212/215] ionic: export features for vlans to use
Date:   Mon, 20 Jul 2020 17:38:14 +0200
Message-Id: <20200720152830.232717027@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

commit ef7232da6bcd4294cbb2d424bc35885721570f01 upstream.

Set up vlan_features for use by any vlans above us.

Fixes: beead698b173 ("ionic: Add the basic NDO callbacks for netdev support")
Signed-off-by: Shannon Nelson <snelson@pensando.io>
Acked-by: Jonathan Toppins <jtoppins@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1187,6 +1187,7 @@ static int ionic_init_nic_features(struc
 
 	netdev->hw_features |= netdev->hw_enc_features;
 	netdev->features |= netdev->hw_features;
+	netdev->vlan_features |= netdev->features & ~NETIF_F_VLAN_FEATURES;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 


