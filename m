Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F97C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE12206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTFr/Jhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbgF3NxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388431AbgF3Nvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE65C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so17829271wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk9/DzLGRf8KDCzfvt/GOgByrJsxT/fIOxcZPlWq/CY=;
        b=YTFr/Jhv0IxMRjGJfO5vfcAWzDDEhJZD1S9kEdXHCGlHd/6sUL1vsEErzCACCcBSFZ
         u9zv/VeGKVgLS7CL/GgMyWr+1k2OoHi3Qi/KMvnIfmHQY11q3i/qb/Ya2PfwKSxM0MvQ
         7MET2nVm3HQiCnM1TKCWe4be8nmhxtDblN53F96eJHD4KUFAszWEBwfOFiBDyFH83Rpm
         BwbKrOCzmPjfD0ZcjdF8HnYbO5GQWMBJVexLMX+zq3SrVUPZPEIXRjFVQW/Djc8XleSB
         kVaBGlxwFPf+nsWc+In+cyqgu62pjiTY2num8107Z0kEYZ4UGRhZEnG3z4xKrocL0IpZ
         xhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk9/DzLGRf8KDCzfvt/GOgByrJsxT/fIOxcZPlWq/CY=;
        b=aPitzfVBineXZcqdpFqxu39pBNxsBTMFWj9iiRwHmTofoWnyZO3/LAQd7uH4BK1Pus
         82BowV1i2iyfplXsI1CFaEJQGGKk0yr9rxJd/pCG7f0G/o8tO7ZyFiKr4j//daNrfTyB
         1Es/MHFGml4XmqNXc24AtFZZEsGVc5trK5AtLZEvWRAFeeyvJ/7FzDptJipzi+qG2xt2
         txaxW5OhBn6GPTSYB4oZdINQBz8MXw3QF+6wpWwYuEijsGdupDxjzzKm/XfIA48L1sct
         oTbGgA6xCYxI/yv9OOZ0/QgKqi5erweJmYMuRwFVVdvJROkNPyjRklNJhUKZW5Pk1wi/
         +jsA==
X-Gm-Message-State: AOAM532005js+rzAqK2n43ib+ku5ab1W6BXk6mjD9gRLhsoMalmsaOaq
        fKl3wSwb+e9u5DwFy6II+iV2iQ==
X-Google-Smtp-Source: ABdhPJy+tsRYfnowp6Jy74IXc5vBXoUVMYXIcAJJ6qCYOHFM4FMkD6FU1i2uxa+KqN5jXoQvqqo3FQ==
X-Received: by 2002:a05:6000:128c:: with SMTP id f12mr22618875wrx.67.1593525091335;
        Tue, 30 Jun 2020 06:51:31 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 16/30] misc: mic: scif: scif_ports: Fix copy 'n' paste error
Date:   Tue, 30 Jun 2020 14:50:56 +0100
Message-Id: <20200630135110.2236389-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__scif_get_port() has never taken 'port' as an argument since
its inception back in 2015.  Probably document the proper arguments
expected 'start' and 'end'.

Fixes the following W=1 kernel build warnings:

 drivers/misc/mic/scif/scif_ports.c:36: warning: Function parameter or member 'start' not described in '__scif_get_port
 drivers/misc/mic/scif/scif_ports.c:36: warning: Function parameter or member 'end' not described in '__scif_get_port'
 drivers/misc/mic/scif/scif_ports.c:36: warning: Excess function parameter 'port' description in '__scif_get_port'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_ports.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_ports.c b/drivers/misc/mic/scif/scif_ports.c
index 547a71285069a..4bdb5ef9a1399 100644
--- a/drivers/misc/mic/scif/scif_ports.c
+++ b/drivers/misc/mic/scif/scif_ports.c
@@ -14,11 +14,11 @@
 
 struct idr scif_ports;
 
-/*
+/**
  * struct scif_port - SCIF port information
  *
- * @ref_cnt - Reference count since there can be multiple endpoints
- *		created via scif_accept(..) simultaneously using a port.
+ * @ref_cnt:  Reference count since there can be multiple endpoints
+ *	      created via scif_accept(..) simultaneously using a port.
  */
 struct scif_port {
 	int ref_cnt;
@@ -27,7 +27,8 @@ struct scif_port {
 /**
  * __scif_get_port - Reserve a specified port # for SCIF and add it
  * to the global list.
- * @port : port # to be reserved.
+ * @start: lowest port # to be reserved (inclusive).
+ * @end:   highest port # to be reserved (exclusive).
  *
  * @return : Allocated SCIF port #, or -ENOSPC if port unavailable.
  *		On memory allocation failure, returns -ENOMEM.
-- 
2.25.1

