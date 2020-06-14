Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85801C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615302080D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="RobdjC7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgFNDeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 23:34:01 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:53564 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgFNDeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:34:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49l0S72z87z9vYTv
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 03:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2W5xXfq-IQJy for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 22:33:59 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49l0S71GyBz9vYTj
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:33:59 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49l0S71GyBz9vYTj
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49l0S71GyBz9vYTj
Received: by mail-io1-f71.google.com with SMTP id 5so9009833iou.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FySxf3tuC7inUbFdRrnqlCjs2f799IH8urJt6EX7/xk=;
        b=RobdjC7BI9oSeEZz3+a/H55JwjJmB6QuBXEclDdafqqtrEhTehWky6u+IwqCYVPEIr
         gGVgfJtPLMAL5MnZ9PLf+QBo7RNp9rvWI68hCRSah0fRmd4i9QXSvNkHwkxwtJtJytxl
         p7wYH12Kng40SW8CFVDWLydDDMtfRo/A7E8rSHoeIdf5URdEFID4wOzmosURBb8M3qqN
         NEP5W6p7HRvAfGhO0zdRk81N/gdeXHb0WHi4lMZasVMV63ZQP4yflh0DRJCTPJPQsKVG
         w0p/M3gBglv4rQCM6A/cWDlOXeJ7aFqsM+H7mD89FXgWbelpreqKafkoxyYW/MMXrk3S
         S8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FySxf3tuC7inUbFdRrnqlCjs2f799IH8urJt6EX7/xk=;
        b=YM0fJ7FZl0naYKZdQW41of+qFcrzDssuLedcRKq03qz9LcDtmtGAZ0aK6KFK+C5l8I
         CHEm/Tb7MXl3M6vk/6rjJju3NBPq6OQwdxqgxJSc1eqgvZal9qntr7SnhxqeFP4ry5WC
         VN/hMwsH9zqm1FT2utOBlKURF+w1hAhOMnHfN2K9GHIbzFDdnZ2AaT+OmC2LOOEov2M+
         xTW62NoiNfqVEDrRcrsQW4zdz9Qro+Jhu4Oga+QCD2qR1TIw2QmxlDDkFgI3CEB8wpcd
         tEJeL5ZPqaVB1czW5xl43Uw+3Q+d+jBa5cgFBErUV9Et93ZBj6jF7MRbN29NM/xQzj0c
         00fA==
X-Gm-Message-State: AOAM533p4ewDNXp00z81pcXUrGuzAJUjdav7w3+WSLB7XY8xUdswCKrA
        DYHk2tDw4d5cLXoblBUHtnQFOBMims3FWZrd5VDhUDWvQn7EYrFRUDQnRe+1v7khV4uxADRntj6
        F2t813LQPsY8duGrYi4QK6th43R1D
X-Received: by 2002:a92:9142:: with SMTP id t63mr19380943ild.191.1592105638818;
        Sat, 13 Jun 2020 20:33:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhY2fLTWyTL8+6HNSQtJlCbrEvVMcF9fyDtrSg1B8kJs5C8Hn0oHEC/O97di8LxiTg7tm7ag==
X-Received: by 2002:a92:9142:: with SMTP id t63mr19380934ild.191.1592105638665;
        Sat, 13 Jun 2020 20:33:58 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id v2sm5590818iol.36.2020.06.13.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 20:33:58 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Lee, Chiasheng" <chiasheng.lee@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: fix reference count leak in usb_port_resume
Date:   Sat, 13 Jun 2020 22:33:53 -0500
Message-Id: <20200614033355.129442-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_port_resume() calls pm_runtime_get_sync() that increments
the reference counter. In case of failure, decrement the reference
count and return the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/usb/core/hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b1e14beaac5f..a9231f27144e 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3542,6 +3542,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 		if (status < 0) {
 			dev_dbg(&udev->dev, "can't resume usb port, status %d\n",
 					status);
+			pm_runtime_put_sync(&port_dev->dev);
 			return status;
 		}
 	}
-- 
2.25.1

