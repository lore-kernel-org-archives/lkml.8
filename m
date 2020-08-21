Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5193C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10ED20720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKFCMB1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgHUN4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:56:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgHUN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598018169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=iYHZ9rEeh+4mirTCdwtBo4QZdb8y4a+LohJ/ODv3tOY=;
        b=TKFCMB1yh2oS5NCM2UAW9ACq0HtNvO3WfTTyJA3+p0JzQOL6TnMEJk7t/q5EYd116owqDI
        EBAmMtDA/tKf0GeD4+3vmAvsnoy4C6iEtRdtctpc5u1/v98MuBY+ydYCLGVnP7+66lvWH9
        WrLhXkz+Fct79WQs95Mc29JzCwz6Qu8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-3aGZY51gMVKsHFOUmIm4mA-1; Fri, 21 Aug 2020 09:56:07 -0400
X-MC-Unique: 3aGZY51gMVKsHFOUmIm4mA-1
Received: by mail-qv1-f71.google.com with SMTP id n5so1273185qvx.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iYHZ9rEeh+4mirTCdwtBo4QZdb8y4a+LohJ/ODv3tOY=;
        b=BOdqHt4Sn6AA4TePKQHaWF66Tp4S2CyubZJjzCUKm5DRr7LZjIm5+/e2YecNkwGdDv
         eoOfXT2K4ARKnU00Kvq6iwi5KBxDsMfxvkzRLNfHA8ekJJU55/ax4krjpAg3DYsrKYDG
         lLezcnwMZQSRH3N94zzO2hRYooBhLYoS+ZhFq1D+mQ585jzpinK26k0YZZ75XQ6a/qn3
         QDgi5Kf23afgRA922sVbzXQPOZ0hfC+x1haJp7wD+kjJ9dJu0fE1xWiBxh4LqMJZxGwn
         n4qzM9JbY9khkctcXrD2LQatSYq8a7sDy8ORq6e+6B9htRgIFRvFnmC+qP7gsUY3QgmL
         OAMA==
X-Gm-Message-State: AOAM5322HDE0n6xaz4NkkPSR/gkwTU0mhT33TqO1TpJ4wvaUMkIYVkbY
        G6QkNIKhIlmfpbiRJ0noBpDc9zoyTPIJquslxaSWI1biNZw2n4Y4XLHxkOlUhidW8Ge1BQEsFa8
        ljFeYaxQy1Pf0X8LOYJSAGywf
X-Received: by 2002:a37:a797:: with SMTP id q145mr2612664qke.13.1598018167020;
        Fri, 21 Aug 2020 06:56:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1o7ZF4qH1t8r6ITbYV6KemBEtJ5AJ+GkcUjHtK9cXYSjNa2zcI8bL6ZWuEDg1nNcYpIvT6w==
X-Received: by 2002:a37:a797:: with SMTP id q145mr2612640qke.13.1598018166747;
        Fri, 21 Aug 2020 06:56:06 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a67sm1717700qkd.40.2020.08.21.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:56:06 -0700 (PDT)
From:   trix@redhat.com
To:     f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: dsa: b53: check for timeout
Date:   Fri, 21 Aug 2020 06:56:00 -0700
Message-Id: <20200821135600.18017-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

b53_common.c:1583:13: warning: The left expression of the compound
  assignment is an uninitialized value. The computed value will
  also be garbage
        ent.port &= ~BIT(port);
        ~~~~~~~~ ^

ent is set by a successful call to b53_arl_read().  Unsuccessful
calls are caught by an switch statement handling specific returns.
b32_arl_read() calls b53_arl_op_wait() which fails with the
unhandled -ETIMEDOUT.

So add -ETIMEDOUT to the switch statement.  Because
b53_arl_op_wait() already prints out a message, do not add another
one.

Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/dsa/b53/b53_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index abe0a3e20648..e731db900ee0 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1554,6 +1554,8 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 		return ret;
 
 	switch (ret) {
+	case -ETIMEDOUT:
+		return ret;
 	case -ENOSPC:
 		dev_dbg(dev->dev, "{%pM,%.4d} no space left in ARL\n",
 			addr, vid);
-- 
2.18.1

