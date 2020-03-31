Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80765C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560E6208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645419;
	bh=mcXDqjTxnjRA1lBbrZNJiG7HSQjwELrJEtMA0Nod9s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qjBW/nAzG5wh/6Mq1WWaf32HdWQXPXU0UPPwAj4E4nxywZpK0vfmbNhG1csZLg4Yj
	 AFN/inrjd8czHJbbWpMBoFUPcsKIZiyzo0taLfDxzfIYcQ4+hQ2udKXBqkox82+HKe
	 ZzfS5JVkXWeStSQzxMFFjjM1MBeKaIk6LEig7a3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgCaJDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730567AbgCaJDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:03:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988A7208E0;
        Tue, 31 Mar 2020 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645415;
        bh=mcXDqjTxnjRA1lBbrZNJiG7HSQjwELrJEtMA0Nod9s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoQrO7+Vhhxexu9wFauAMrRun8PYm9h6PtJv9LjtQuMGwaP+jzQvaxcaYXQYO7G88
         V17ZIJYBVCSf41hV/ZFBh3hWTiLfJS8gb7c7gLEqppyii2njx5GVo0NRg0q09OH27r
         Z+c7fTYVBnd4TLuRT3OxnwxkWo8CwmrDW/NCcGng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 046/170] bnxt_en: Reset rings if ring reservation fails during open()
Date:   Tue, 31 Mar 2020 10:57:40 +0200
Message-Id: <20200331085429.342764632@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 5d765a5e4bd7c368e564e11402bba74cf7f03ac1 ]

If ring counts are not reset when ring reservation fails,
bnxt_init_dflt_ring_mode() will not be called again to reinitialise
IRQs when open() is called and results in system crash as napi will
also be not initialised. This patch fixes it by resetting the ring
counts.

Fixes: 47558acd56a7 ("bnxt_en: Reserve rings at driver open if none was reserved at probe time.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11666,6 +11666,10 @@ static int bnxt_set_dflt_rings(struct bn
 		bp->rx_nr_rings++;
 		bp->cp_nr_rings++;
 	}
+	if (rc) {
+		bp->tx_nr_rings = 0;
+		bp->rx_nr_rings = 0;
+	}
 	return rc;
 }
 


