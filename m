Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FBCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395BD20722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3JufE1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbgF3NxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbgF3NvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBE4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so18190878wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zimOoN2kqyjp0StchByfx/9jGDhP6/dApme8q5aFBgg=;
        b=C3JufE1Vbw703iYTl6sZac2o77v/HxfiLUxfLsvV7rf63VdFwoY8pZRLVXzmFORdiP
         tnIsWGaURHCqIdQWcy2O/ujeJUPkWtg9KM2i50TVu04acdEVD6YhMrv63V596iYirxpW
         8aPANMM6SZqICnuKyCCV1BBYzbEv2gRX4A9nxB384FenhAFSBg7YuXubRgcDV293nK3S
         JDEHR1xB0VkC3vFYwM1sIuI+Z8VdjtWiR2aqO1+IVoXiNDIEeFDObePM0b3ousVgsu2g
         aLM05GkJa08x2XJ/KUFghTV+6cdM78kxQUwHXmTO94P/5TAriG4BTtKSi7YRpni66COw
         uxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zimOoN2kqyjp0StchByfx/9jGDhP6/dApme8q5aFBgg=;
        b=Vgkzhb3k6iBmpEcTV+B8xQLyH6LtvDzVuJrb+LKi/2nb067cL5kdYqAoVPHr4iNYT+
         TjaCamdGnNeGJeV/JGNUStLueVMBYRyLTD0rT5rNrdks75PA9cR/tIp43e6W0t5L3sIw
         7cKClCjbalWwTdVeFwsuN/hUAhEe7AIFUSvTNk3n4qA5TJyM2/gAkrCP2SKhUdohMnhe
         ABAkR9PSOwaHJcJVqiBH/tfnW63WsX84TgXHJR/R9PnMA9c8HFjU3A2ungPknsUnc+48
         5I6cCm/OyH+6xI7ThkFCyLJNp1MWtqg4qILPyRKFuH0udA+9CD88j5kc2jwUwUDy6MW1
         8DOw==
X-Gm-Message-State: AOAM533DZxHCoqM128OgAYxwWw/t/LuGKu7KrWB3MFJ7WAbkPhsSJSZy
        GUI9K8aAPZJdElzEHHHDs1rucw==
X-Google-Smtp-Source: ABdhPJztSC+qO8Bs60jiFpwOyAyS3D8NxgvpHTcxkBciCImutF2lsX+GPC6MWhWkOcraBY8wceqZLw==
X-Received: by 2002:a1c:e209:: with SMTP id z9mr21891607wmg.153.1593525079340;
        Tue, 30 Jun 2020 06:51:19 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Max=20Asb=C3=B6ck?= <amax@us.ibm.com>
Subject: [PATCH 05/30] misc: ibmasm: event: Demote function headers from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:45 +0100
Message-Id: <20200630135110.2236389-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
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

