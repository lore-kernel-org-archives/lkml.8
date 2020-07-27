Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0E5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D957B2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px+7gUwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgG0PSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgG0PSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:18:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21768C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:18:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so12482782qtt.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oumv6DjctSmluV8Ivacc6/Q4aJir+U55bBJZDerGc5I=;
        b=Px+7gUwtxpKPDvHuoB6IlCBvk6EYS0HihLI+J0DD9Ezkc74/7XR8zWE5ozirQqLiAX
         GkTIW+1WD/9kORpCBOnAiXOdvsQplAmxjt4x9u68njVmagBRd1EPT/DkywHRiMxics9e
         g+KAmVPtsnmWT9MDCxCqrBnvLaV+shLM7I1MiYFWmRJGOJ1QK8QLcbClczKJNwMT1IVb
         5b+QaTWXQGkSWsYgGI870ieUbNiJ7NlmKpo6RigKaZKsss2an4B4b3lV5RFz7Oczzu7I
         bE5utPmhMSYKh8aNIeJoUcULYkWff3tElXuJttV6jWPZZ0P8nCREx7rS3j57zkNrQAIe
         C5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oumv6DjctSmluV8Ivacc6/Q4aJir+U55bBJZDerGc5I=;
        b=QYuVi7WtUn0fnQXfk0pAbjFWrYW1pKr3jpYU5no2OtEpN1QenLJjRbq3EMexZ33ofx
         iRzcnj+96t4A2L1KUIS9DdS2PLi2xuECCHzYZPT1edV4pggVQoCBOMXbC6yfx2U/Zm3W
         HDpMkkVVkhiq+kTAFS7OW+H+cvFL/zZndlhPwxTmKhpNaNTeQPLcAU6t0eeIVJ/fCTP8
         9VhdSwpu0M7Dyn5XL6nXbydkmnMVhv7ouLMJXBb30dMV5VcGnIlSb39+tYqwHzRQDGzu
         PH6pQ0ComfMVbz6QQE7Z4GCCFNoSaLiaKwM0R7hOf2uBG6Q0e1SsSmawtEpE55zESLeq
         SuvA==
X-Gm-Message-State: AOAM531zl4wb2Xr+E3Jfr5BR2oFd+zk2MTxbTZzblQkWrsR4fzEe5lJS
        lCFNxJDEWpj/+vdt6TW3tQ==
X-Google-Smtp-Source: ABdhPJyLTAelIjtu78jYMToVbssYjgYPk3s7pOniRfc3akQhku8vGAuGb0/YsOPPTj334y5KEiY9SA==
X-Received: by 2002:aed:2199:: with SMTP id l25mr21958744qtc.309.1595863092480;
        Mon, 27 Jul 2020 08:18:12 -0700 (PDT)
Received: from localhost.localdomain ([209.94.141.207])
        by smtp.gmail.com with ESMTPSA id o21sm3445003qkk.94.2020.07.27.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:18:12 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] firewire: Prevent kernel-infoleak in ioctl_get_info()
Date:   Mon, 27 Jul 2020 11:15:37 -0400
Message-Id: <20200727151537.315023-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioctl_get_info() is copying uninitialized stack memory to userspace due to
the compiler not initializing holes in statically allocated structures.
Fix it by initializing `event` using memset() in fill_bus_reset_event().

Cc: stable@vger.kernel.org
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/firewire/core-cdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index fb6c651214f3..2341d762df5b 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -340,6 +340,8 @@ static void fill_bus_reset_event(struct fw_cdev_event_bus_reset *event,
 {
 	struct fw_card *card = client->device->card;
 
+	memset(event, 0, sizeof(*event));
+
 	spin_lock_irq(&card->lock);
 
 	event->closure	     = client->bus_reset_closure;
-- 
2.25.1

