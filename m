Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095C9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D774B20870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMQ8eZA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGCRmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGCRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218AC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so31132999wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7eNVLa4hjk02Jz2SQUwzwLQ41aN0q3Km5pJHjYU/rio=;
        b=vMQ8eZA1CVkGFvX8S60GAhdmZPsB9rQNsmkoQFo2oYnXndISyZCgsg+4zxHt6jdFwd
         +Jr9x7VcoLu8QL2a+ksPn6/BHqcB/BxvRdM7XeF5wlOqwC465GuHkedkU/DomxW3+G9g
         o8M4UHC7PgYI9IHEbJRrXkZRFEyibaCx5yj1L1IjA34jJhLJmOEFoWL5TSZB9xbQzti0
         n0hAtXHU95HcmA/LY31X2Wyr44VjZSdGjf22nMg2VaDPHj5pSMR0+rol5lpSmMDnkS6R
         L5lDo/RWgKUglug4pXnH6NcSkbqZmTV19sMvhpBHX+0z3HunhrUo4tR+y7awHGLQuWd5
         icMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7eNVLa4hjk02Jz2SQUwzwLQ41aN0q3Km5pJHjYU/rio=;
        b=pjauhACRSvH+Q5QwlbfcZUbglr6R0L6Vu4RtK0RkglEGNy7FLb47MbrVysq7joIUeM
         CdZ24UIgdqE2kcjTjSFAL6lgBJKkH+NAivrCjL4hwHon4lZ+rSKV6ii3NxM+6Q9Wef39
         mHeHP1S4joXlKRM+2tSONiRNRFtsXJXZCYySetpNM2PJ6GBuaw4pvmZ/maRpeh36so9P
         PbKclwjrWgWwzu/Sk06Dqz2XFD1x9w35HH6KmLX7zmPmXilPiOJ9ENTaP1KJ8+OLV17d
         u3M9vwR4sH57ddaDHeZ49w2GEDNQD3O2i4vX48z8vJGN14ulDnEkGChN+09VZxk4WPG7
         Rdlg==
X-Gm-Message-State: AOAM531vK4tXyp1YHvq5mBe5qkRdQxyNzblW+zeeEf+OoLIgh4WmUEnA
        panl1Y35MBzdX6Cx9WlJYnu8jA==
X-Google-Smtp-Source: ABdhPJx2o0YkTTmj44f3mUJGFAhlHMkc6BactSo26Kbv16QRGRZrY63SVbxt7C9PpaVBYfWIgzuQSg==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr40298877wrm.71.1593798157484;
        Fri, 03 Jul 2020 10:42:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH 14/30] usb: host: xhci-mem: Demote obvious misuse of kerneldoc to standard comment block
Date:   Fri,  3 Jul 2020 18:41:32 +0100
Message-Id: <20200703174148.2749969-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the demoted function here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/xhci-mem.c:365: warning: Function parameter or member 'xhci' not described in 'xhci_ring_alloc'
 drivers/usb/host/xhci-mem.c:365: warning: Function parameter or member 'num_segs' not described in 'xhci_ring_alloc'
 drivers/usb/host/xhci-mem.c:365: warning: Function parameter or member 'cycle_state' not described in 'xhci_ring_alloc'
 drivers/usb/host/xhci-mem.c:365: warning: Function parameter or member 'type' not described in 'xhci_ring_alloc'
 drivers/usb/host/xhci-mem.c:365: warning: Function parameter or member 'max_packet' not described in 'xhci_ring_alloc'
 drivers/usb/host/xhci-mem.c:365: warning: Function parameter or member 'flags' not described in 'xhci_ring_alloc'

Cc: Mathias Nyman <mathias.nyman@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 9764122c9cdf2..fb221c0914780 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -352,7 +352,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	return 0;
 }
 
-/**
+/*
  * Create a new ring with zero or more segments.
  *
  * Link each segment together into a ring.
-- 
2.25.1

