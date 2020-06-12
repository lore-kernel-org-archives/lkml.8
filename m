Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B55CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C87207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="REE5JD5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFLUhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:37:50 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:42322 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:37:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49kCGN6rdFz9vqtG
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 20:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UMZ47xyQLGhy for <linux-kernel@vger.kernel.org>;
        Fri, 12 Jun 2020 15:37:48 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49kCGN56Zjz9vqt8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 15:37:48 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49kCGN56Zjz9vqt8
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49kCGN56Zjz9vqt8
Received: by mail-io1-f71.google.com with SMTP id l204so6922022ioa.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPsaJy4sS+SIJullYTRWGhbvNfs6G9NRDFRhe6rMAX0=;
        b=REE5JD5caIZyAehxckQoCJgoY8DyFVRxlHvHCan3LTjFl942hafzaBCxL7hMxdYmYR
         sEjn5tQF9eWEqDWKuQvB+KOi9LUqjiXC0wLcc3HnJXIlqfFebt1Ahw0F7oPBL/9lWmrx
         J0WWW2ic1TBuihGUq1xdI6gcN8nu3kuOXR+EYC21WWsHqFmma+pNfgiuhDWW6bmokV2l
         7U7KfBa/GuBzU62oe0RmSiB1ES1J6UlaZRMeY2ZPHcvOrTGPSnBaMwzk/RzZ1eWn++14
         ZsiRh7g9h8S370iaHojJgVFRANz5zaOZfpw9Phz8IgXELDhE1qMt/nvzb+/GfTjXu7R0
         i1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPsaJy4sS+SIJullYTRWGhbvNfs6G9NRDFRhe6rMAX0=;
        b=qRNT3efZH0TQUVlbFOHTt3wA/5XF1CxpdmTagOhIuup6DfPZtD+UQwJAXDWuh6+ADT
         /6vzr3+4hqqGNkL4dE9b7YwB4VcTuZ3+pS4frybhFiEDT/cKBYtL0xP+ncqdHhlzBGo3
         RvoUIF1Jfx/O1sKh2FJGpFpSAa5fCwWLbp4bQ94PnXsM+cOmfrloV8dGMowl3DTMyKzU
         /g32mUhD2AKgI0NNFLh66UISTuoMgoZU3XWyMq+Ecl52QAwU2fbi5T15GTXgXN2pscBS
         D+LV+M41F4FmtuyqItDe3xxoCpfIRrRm+qRF4x1PL10apIW7wUVKd49WdC/f2FWQwYfN
         wU6g==
X-Gm-Message-State: AOAM530mwgYhbCgYepHY91NHk/ls+EFytmYRssCNn0ct6Eprk9mSkNkg
        GL+6Sef9wXIPDbM5PHozTsVj4hPrqvybglWu5xvC2UHPNOqh90S8LYM1oBX6A9aZnKMH66xwhHo
        MK+LuOmrVw4qf0CTXLu+p2+UgJjK+
X-Received: by 2002:a6b:249:: with SMTP id 70mr15355900ioc.146.1591994268296;
        Fri, 12 Jun 2020 13:37:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwroUcG/TxV7JnmiwS9VTx/087OQr95ZZFoBKpa6o3cAZKupx6gXa4pzHY8gQlciL0Nf2osjA==
X-Received: by 2002:a6b:249:: with SMTP id 70mr15355886ioc.146.1591994268159;
        Fri, 12 Jun 2020 13:37:48 -0700 (PDT)
Received: from piston-t1.hsd1.mn.comcast.net ([2601:445:4380:5b90:79cf:2597:a8f1:4c97])
        by smtp.googlemail.com with ESMTPSA id 199sm3774485ilb.11.2020.06.12.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 13:37:47 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: Fix a potential incorrect error handling in rawsock_connect
Date:   Fri, 12 Jun 2020 15:37:43 -0500
Message-Id: <20200612203745.58304-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rawsock_connect, the device is allocated by calling nfc_get_device.
In case of incorrect bounds index, the device should be freed by
calling nfc_put_device. The patch fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/nfc/rawsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index ba5ffd3badd3..4f0f0ea4c009 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -105,7 +105,7 @@ static int rawsock_connect(struct socket *sock, struct sockaddr *_addr,
 	if (addr->target_idx > dev->target_next_idx - 1 ||
 	    addr->target_idx < dev->target_next_idx - dev->n_targets) {
 		rc = -EINVAL;
-		goto error;
+		goto put_dev;
 	}
 
 	rc = nfc_activate_target(dev, addr->target_idx, addr->nfc_protocol);
-- 
2.25.1

