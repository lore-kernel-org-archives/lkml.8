Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467C020714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443401;
	bh=6NWRsF1yEBJRDvUGcwfcNWafvDod/l6Q2SkZ5vUQ0OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RpzgjHMDTOku3oL5GN7lfCHMGhY6baGgU+j7JMtvqAzFxFRf/enoFxBvPcEK16VBi
	 wf4bX+dJV5emSvndcT1s2EYR7mtI7LJCVW1O22HPZySX5bY+M3etN0YQG4t7Idlumn
	 hvx8VHuKXXO9ymK0IfPHTOg652vraGZgHmgg138s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgCQLJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbgCQLJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:09:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5004205ED;
        Tue, 17 Mar 2020 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443396;
        bh=6NWRsF1yEBJRDvUGcwfcNWafvDod/l6Q2SkZ5vUQ0OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5XWPPgaLsiE3IIpisKnXVhnnTuMkrSoTe/ePk0fKGC6/lWNXudZ+wpKs+xZAmxGJ
         jqkg7yyWqkFoLLDG04Kn7xU5gTetEKgZHBBLAKe/d8J4aZhGnb8GvUgX0wJpA8PiGF
         H5LrA7USDcqJsr8AU3eDWjuqAmRgWBCYI9u9T6l8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 070/151] net: dsa: mv88e6xxx: Add missing mask of ATU occupancy register
Date:   Tue, 17 Mar 2020 11:54:40 +0100
Message-Id: <20200317103331.466299784@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 012fc74517b25177dfede2ed45cd108258564e4a ]

Only the bottom 12 bits contain the ATU bin occupancy statistics. The
upper bits need masking off.

Fixes: e0c69ca7dfbb ("net: dsa: mv88e6xxx: Add ATU occupancy via devlink resources")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2762,6 +2762,8 @@ static u64 mv88e6xxx_devlink_atu_bin_get
 		goto unlock;
 	}
 
+	occupancy &= MV88E6XXX_G2_ATU_STATS_MASK;
+
 unlock:
 	mv88e6xxx_reg_unlock(chip);
 


