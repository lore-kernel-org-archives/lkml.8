Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B493C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEA5207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="PMV4p27q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgFND1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 23:27:10 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:41530 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFND1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:27:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49l0JC3YHLz9vYlD
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 03:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6BeRyIp4uFe7 for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 22:27:07 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49l0JC1g9Xz9vYl6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:27:07 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49l0JC1g9Xz9vYl6
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49l0JC1g9Xz9vYl6
Received: by mail-il1-f198.google.com with SMTP id k13so9454106ilh.23
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trMCJ61FldcoujsZIY8Wf46yXCeSnen3DQpQ/YLOJjY=;
        b=PMV4p27qe+K63USGyKIQ9bcGu/GsoDsDqegA8UwSQZw0sv3KC59At/WZujXLw9ZsUb
         HcJryey5zYLoFYxvzv4U5dFXYsiMRj8Nc9C/6SQYiSSLClcKkFn1PKXhXGRYHnEIODSq
         mQ3OxdnirTx75iKHaZJVJ+YacjtCKIFqgzDeMNR6OKmKA/Y+Jw1RJ4ojB7w61h/4hY+y
         tePrA21qSLdtdIx48AicGEfPBBjCnN9KwLMgJ7xX+IoTH2Tt1Xc/CodBuA/aA4mFH4Mh
         JTAkSVUIsBNAw4wjUMhfSJjlaBNDJS5phngaN5khm8wawlumTEWTRUvwOv0yAoXWeQ62
         /smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trMCJ61FldcoujsZIY8Wf46yXCeSnen3DQpQ/YLOJjY=;
        b=VAOcy9XVc3rEIbWvd4gzYE4WSbYEyFKMMjHLJDRfAlSn/Y/a9m9hgkA5DbR9cJ6Mx6
         YTizXT8KsAnezr/bygDUXrt1zfDZEI+eTGlnIIW7EzyKkL3wqy0bNHgdZTUOD+viFPbE
         DhghyKVvn9PRqD9868NRIH+pGWRT8IDz0Y0++eOv4+AA9BkkEtrvXNNckUnd7dY71c6o
         h41bBeHCn9J51nBKDOE5Ag9/RhDG2QiRJ0YNioxPHxoyDeye11460/Tx8r+TaDDjLG5n
         N696MILz/clWxC3MdbcszQuLFqpl2J4DZ6CJuzBksd/c0tjpYOveqo5g3cWhgYI3AQTw
         8ygg==
X-Gm-Message-State: AOAM532+1gVF5huL2mFMAUwyvwZSEbNJ33Q3u2ogRbpT+ZI3S1NVg/dL
        Ef31SvXSmYJBuB2WI50CohJXwzfGvAHYTMNBWvM7j+YdSUrjljw4lwKC4kJRTWzAqYyRwzXaowL
        9fpFMDO1zOnI7oLPjHjgpzUFs3dwI
X-Received: by 2002:a92:aa85:: with SMTP id p5mr21225371ill.19.1592105226915;
        Sat, 13 Jun 2020 20:27:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/2Mlse3DqnWhjkkv7/1KCD9SfYfqSen/Um715vQpYWXomgiHxEjTQtmup3MrFv0QCPVeL7Q==
X-Received: by 2002:a92:aa85:: with SMTP id p5mr21225364ill.19.1592105226772;
        Sat, 13 Jun 2020 20:27:06 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id b13sm5654007ilq.20.2020.06.13.20.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 20:27:06 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: musb: fix reference count leak in musb_irq_work
Date:   Sat, 13 Jun 2020 22:27:04 -0500
Message-Id: <20200614032704.129010-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

musb_irq_work() calls pm_runtime_get_sync() that increments
the reference counter. In case of failure, decrement the reference
count and return the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/usb/musb/musb_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 384a8039a7fd..fd36a026bef0 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2070,6 +2070,7 @@ static void musb_irq_work(struct work_struct *data)
 	error = pm_runtime_get_sync(musb->controller);
 	if (error < 0) {
 		dev_err(musb->controller, "Could not enable: %i\n", error);
+		pm_runtime_put_autosuspend(musb->controller);
 
 		return;
 	}
-- 
2.25.1

