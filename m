Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0396C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961792084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2SU5Y10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGCRmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGCRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94AC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so33570571wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6U6du2cLEW6hsEFJ/YlMHhYAq991XScHIIikwh94ck=;
        b=Y2SU5Y10snNBVm4aLkU7fk0EzfCxFtMtC2t6XTYj/cZvEvyIk4JHi4IzvP1Q84NMJb
         wp3/StQ4VnPEvn10ZvSQjYAQoaEXHwEQT4aUyHcryjLofn34gYEQYBX9KR5uIygZqkN6
         c8U7oJkzVqsT/LFEegC/GHVUwFXrl2/ZhWuLrxRxPNjIUcCh5M1zV79xpQ30M6cB6ga7
         QWgSinALKbHXOtbxbW8M3V/Iiah/Cu+ACH7HTP3WaFgoG4gBY45UTg5GU2giIEBzvnLg
         iBZ1Uq8pwToe0JQnN0zwI96iPtfuryHBRuGoe5iyK5uIGgRfcs1vA3hqc87ZlrAGsbuR
         pCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6U6du2cLEW6hsEFJ/YlMHhYAq991XScHIIikwh94ck=;
        b=lbgJgIh58wNXh+XcQteRuJrl02w14Qs8UjgOrJ1gbyVBFW0olY1FYASNb9r41LxvXA
         DsKfVIOYiOT84C262PEZoheLLUJ9p76QLplAsu9Dtvu9AazU1u7OtCPQ1seRr9s+auHM
         E0Nuhn7tT7pjm5ebFxnlXZRky8ku+cqhkVIK4eUd1Yrwy6BWWM5GYONdI5jb+BRr0Xgd
         PypeEZePxK75Zvkw4KrLCPFbs7a7iFu4rbVmjMMFQRFyUb3yVJaQIfD1MYVWOZlOPUcX
         VHC3lw4GxBGHrdSINOHIcUHqkiX+zcb76gcUvlEgPk8L5q8Ja+aRI7jmItoOp83opBz1
         dp6Q==
X-Gm-Message-State: AOAM533gbpHsRSSwg5qOl8mEFWRuLLXrcGCPOlly03hr3NZwSwxG3URi
        Di5pvNh8wiNLZv3Ah2NqtkzsEA==
X-Google-Smtp-Source: ABdhPJzRUz7YIJkc5rXRh4EaTG+LenxNZrmqTf7CVLD+POjSpAcpZFSCLy+UvmQirb+yuYnlUSpq1g==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr41966929wrs.60.1593798126416;
        Fri, 03 Jul 2020 10:42:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        David Glance <davidgsf@sourceforge.net>,
        Juergen Stuber <stuber@loria.fr>
Subject: [PATCH 06/30] usb: misc: adutux: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri,  3 Jul 2020 18:41:24 +0100
Message-Id: <20200703174148.2749969-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/misc/adutux.c:117: warning: Function parameter or member 'dev' not described in 'adu_abort_transfers'
 drivers/usb/misc/adutux.c:653: warning: Function parameter or member 'interface' not described in 'adu_probe'
 drivers/usb/misc/adutux.c:653: warning: Function parameter or member 'id' not described in 'adu_probe'
 drivers/usb/misc/adutux.c:762: warning: Function parameter or member 'interface' not described in 'adu_disconnect'

Cc: Johan Hovold <johan@kernel.org>
Cc: David Glance <davidgsf@sourceforge.net>
Cc: Juergen Stuber <stuber@loria.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/misc/adutux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index d8d157c4c271d..a7eefe11f31aa 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -109,7 +109,7 @@ static inline void adu_debug_data(struct device *dev, const char *function,
 		function, size, size, data);
 }
 
-/**
+/*
  * adu_abort_transfers
  *      aborts transfers and frees associated data structures
  */
@@ -642,7 +642,7 @@ static struct usb_class_driver adu_class = {
 	.minor_base = ADU_MINOR_BASE,
 };
 
-/**
+/*
  * adu_probe
  *
  * Called by the usb core when a new device is connected that it thinks
@@ -753,7 +753,7 @@ static int adu_probe(struct usb_interface *interface,
 	return retval;
 }
 
-/**
+/*
  * adu_disconnect
  *
  * Called by the usb core when the device is removed from the system.
-- 
2.25.1

