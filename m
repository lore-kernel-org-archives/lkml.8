Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4FEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F9A207D8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgFCP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:27:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46160 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:27:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id z9so3227833ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 08:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TI71EQkgRiykB9cwyrszJwVo6ai3Du0dG7EYNU5AcZI=;
        b=M4uIXDVUSdq5ANUfBKmVm5ocnE8liOVPEmFPGw//8jRngmx8jFHniYOecZFXQmlMyH
         UOFwlcpXy/gHd/Nac58Tc/VAQwk6UaR1CREccbFFl3iiINrcMozfFxoL3jtwVHYeEqRO
         ILiskEAHxeTVvYjaSK1OOVr/N2/o32meJOpguhZ4SZDvvwE6bVYed+z2jWZZuLJkBSD2
         eaCEXmAbGyF2wd9UleI3PYvPFjA8s2vi2O8LjLiLuCET2LKJv4bDv9Kq21SchO645jJM
         6A1r5lIFJOH+BF5fqpPR1WtMLtp7u3YoFNpMs8WESZ/8WvJHoeHrN7b/iXeuso6+3d2p
         mp7Q==
X-Gm-Message-State: AOAM531zYp2yPGWBWh4VBw7Ar42o/hRIMJicClxLAVJsGEomO1zFTxBM
        BZDyz19NwPDraoJ9VGf77vk=
X-Google-Smtp-Source: ABdhPJwfYTS9uPM/HnqTboQLV6Ltg2RwfZqWlLMLltkoaHufYDdfd//e3kI/YThjJUvVF6uDszv/jw==
X-Received: by 2002:a2e:b8ce:: with SMTP id s14mr2196638ljp.89.1591198028574;
        Wed, 03 Jun 2020 08:27:08 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id e21sm631714ljb.135.2020.06.03.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 08:27:07 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Denis Efremov <efremov@linux.com>, Paul Durrant <paul@xen.org>,
        Wei Liu <wei.liu@kernel.org>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xen-netback: use kstrdup() in connect_data_rings()
Date:   Wed,  3 Jun 2020 18:26:43 +0300
Message-Id: <20200603152643.18215-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kstrdup() instead of opencoded alloc and copy. kzalloc() is
excessive here.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/net/xen-netback/xenbus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index 286054b60d47..69352154a51b 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -839,13 +839,12 @@ static int connect_data_rings(struct backend_info *be,
 	 * queue-N.
 	 */
 	if (num_queues == 1) {
-		xspath = kzalloc(strlen(dev->otherend) + 1, GFP_KERNEL);
+		xspath = kstrdup(dev->otherend, GFP_KERNEL);
 		if (!xspath) {
 			xenbus_dev_fatal(dev, -ENOMEM,
 					 "reading ring references");
 			return -ENOMEM;
 		}
-		strcpy(xspath, dev->otherend);
 	} else {
 		xspathsize = strlen(dev->otherend) + xenstore_path_ext_size;
 		xspath = kzalloc(xspathsize, GFP_KERNEL);
-- 
2.26.2

