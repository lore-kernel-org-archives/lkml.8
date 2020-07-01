Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E84C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E7E20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EO2/wK4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgGAIbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgGAIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4A8C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so22891060wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zimOoN2kqyjp0StchByfx/9jGDhP6/dApme8q5aFBgg=;
        b=EO2/wK4PRSyboLgDsq/WNh959+FgXLZsxqngzbTbLNkvgz9w3l9BgjL1vPqb6RizP/
         MRC2pLxcWnDuCdtZc8JdBWgBns3DnibDOJHkiMPeGc6TQSBx1qWaH541Y31RSlpZ945t
         VjPaLfaQsJUESwaLGE5/YFm7BAYeKFyqTvnuGo62pEPHeAu/9H7Vu1MPGITYC/usXinq
         qPgjVRqPjSaZ/bXdjPNl2Mgj6O6nGon0h9Jnsr/c3j8Ji2cSX9fMpYxjzAlocxBe//3u
         STEOM+Jzy8tGR9y2v24MyuVg9fWsLgUR3GHOR1pbdL0oVsrXzE055CAhJBiz2x1WG9bP
         4ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zimOoN2kqyjp0StchByfx/9jGDhP6/dApme8q5aFBgg=;
        b=CX3D5tPpkvXE2CXsyC2Ft5juUpUEndC437Rq1hFBS0tDR1XMqCz0BgWovq50V2MQyN
         kZZqpau/mZmM+97W16dpxw4MSBnMcRJWxoemnJm/zWYZQeJi6WoXI67SZQrY/sVpp8eJ
         DpAaZcv9nFYGPZb0aDMwP7FcpbORP6w1sIVaJS/wRxCsmimKDaTVup6vq0z8YwX2MtUQ
         L9DJ7uQ/gKAlhDHenF+8HIPWyhGViql3GRBdcBKJ2MhXemvFsbh06CELuEb+5daWqJx3
         vEmWmGHNIv/4MkmIWvpHKe/DqQJqYKTV3DLsdREf+86oQkKYWOp6WhZIZ/5jaU1TMx3C
         PcaQ==
X-Gm-Message-State: AOAM531RQDNtasxumkr8kGWVFSokQ+Vz11ZRzMAhq4S6h7BhhyM7tIhF
        Q9PsY2OXxJJYY/eG2tLD/XVc2Q==
X-Google-Smtp-Source: ABdhPJyJeY9cDJBeXV2JRCgxMZtUeeVgYIjZaXwm6EMlTMOt/rQJ2CUo+FeQqWNoVvd9KBqVtP6GeQ==
X-Received: by 2002:adf:8024:: with SMTP id 33mr27473683wrk.117.1593592290190;
        Wed, 01 Jul 2020 01:31:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Max=20Asb=C3=B6ck?= <amax@us.ibm.com>
Subject: [PATCH v2 05/30] misc: ibmasm: event: Demote function headers from kerneldoc
Date:   Wed,  1 Jul 2020 09:30:53 +0100
Message-Id: <20200701083118.45744-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/ibmasm/event.c:44: warning: Function parameter or member 'sp' not described in 'ibmasm_receive_event'
 drivers/misc/ibmasm/event.c:44: warning: Function parameter or member 'data' not described in 'ibmasm_receive_event'
 drivers/misc/ibmasm/event.c:44: warning: Function parameter or member 'data_size' not described in 'ibmasm_receive_event'
 drivers/misc/ibmasm/event.c:78: warning: Function parameter or member 'sp' not described in 'ibmasm_get_next_event'
 drivers/misc/ibmasm/event.c:78: warning: Function parameter or member 'reader' not described in 'ibmasm_get_next_event'

Cc: "Max Asböck" <amax@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ibmasm/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ibmasm/event.c b/drivers/misc/ibmasm/event.c
index 974d63f5a4dda..40ce75f8970c1 100644
--- a/drivers/misc/ibmasm/event.c
+++ b/drivers/misc/ibmasm/event.c
@@ -31,7 +31,7 @@ static void wake_up_event_readers(struct service_processor *sp)
                 wake_up_interruptible(&reader->wait);
 }
 
-/**
+/*
  * receive_event
  * Called by the interrupt handler when a dot command of type sp_event is
  * received.
@@ -68,7 +68,7 @@ static inline int event_available(struct event_buffer *b, struct event_reader *r
 	return (r->next_serial_number < b->next_serial_number);
 }
 
-/**
+/*
  * get_next_event
  * Called by event readers (initiated from user space through the file
  * system).
-- 
2.25.1

