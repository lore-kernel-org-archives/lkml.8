Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62052C54FD7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723F020BED
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTQF38v8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCYHGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:06:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35423 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCYHGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:06:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id g6so460943plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 00:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6r1fskoo/rPmpewNG6WhrwCKIyAjmrIb2vy6uT5S69U=;
        b=DTQF38v8YnBWHsl+9ixYzJ0xE5YKQXH3zpAzq2Ik1ShxuiVRINdaYH9dBwijCtOroQ
         3+bJ2xAPc5VaDA11dqtrpJHkvl2g25DEN/HoP72Zvp4zrPitEaZEO3GgxtbGYcoG66Vu
         EdnSrhIP4ftAurqTKZZJ7W9HTsvahZYe802K9KgJsM8KaKL0QNEOw5oweg0j4TbdtkCy
         +KwF+vV9UP+JXfVlwd8BoxCaqfb6ZHiRRlx/KXy3BWAmSeMJW+zTJsfMRhLXHLSY4vsT
         8fDAFj8kcnfZmc2UtH2/2NoiZ7635e7I2ReOPqJ9sptT10N36AKnETXUWvnCGnd1V+HI
         6vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6r1fskoo/rPmpewNG6WhrwCKIyAjmrIb2vy6uT5S69U=;
        b=nSj2CrFqJW4no8PRSl59M5BmL0AGWQm939DyP9WqFvgcp6WJiacw6u00I2YlDppEJK
         ydYqlAOZcZc/d0BMK+cMO7rD9QNyJ4hYKQjUBpei5Hx+3nc/b0Bi/RPDy0Kn/fT7rboY
         AdUsIGwdikCxMuSpZvl6Bsm8YNw/9QMSrSiwWwqQP2JvgHoK5c0w6boGCkJXf5xeUfee
         0EgAgfBiQouPrThbMiPcB5+19XbY5/+DTHKRH0TEzDfwpUDQLEGCcLPGcoUjziHIC25V
         7lYYpKzQPvPmb2aw+rQaIyo6CdVJ6z3XJudQVIRK4bE8ls30z7F5d6QsKfamUj7TTTny
         KLag==
X-Gm-Message-State: ANhLgQ2B0QLFuzVVzemIbIVH3BPHI2f3Jrp/43QAO4Vh6wr+0K/C99Ln
        qYYWjcsKC4j9ojQDzZh00N9Esq8O1FE=
X-Google-Smtp-Source: ADFU+vs3isqopxoifQh7lOOmzhO/2YTv6RkIdXU2LOyuhtT4JCjGoCUyAY7MU+HCk6mc1DTVt8GYWA==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29mr1876294plj.246.1585120010514;
        Wed, 25 Mar 2020 00:06:50 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id y207sm18172916pfb.189.2020.03.25.00.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 00:06:50 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     gregkh@linuxfoundation.org, osdevtc@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] staging: wlan-ng: fix ODEBUG bug in prism2sta_disconnect_usb
Date:   Wed, 25 Mar 2020 15:06:46 +0800
Message-Id: <1585120006-30042-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should cancel hw->usb_work before kfree(hw).

Reported-by: syzbot+6d2e7f6fa90e27be9d62@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/staging/wlan-ng/prism2usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 352556f..4689b21 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -180,6 +180,7 @@ static void prism2sta_disconnect_usb(struct usb_interface *interface)
 
 		cancel_work_sync(&hw->link_bh);
 		cancel_work_sync(&hw->commsqual_bh);
+		cancel_work_sync(&hw->usb_work);
 
 		/* Now we complete any outstanding commands
 		 * and tell everyone who is waiting for their
-- 
1.8.3.1

