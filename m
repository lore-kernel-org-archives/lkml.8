Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A688D2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j++rmjLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGCRmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgGCRmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDC8C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so33568673wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LyTKYUD/bNIDavfKIyBUK2+LGfEs6fHGIsN/epbMTo=;
        b=j++rmjLVKGE8pJOki7KEkXap+ttuF0IaSJ6R4tm+0X3EML73Vhjgu0DH7+NuuLNCCD
         JyEYJgF4AJO9OF9F+dXlSbcsZ4hfZmufRZ7mHKpB0uGilNC44Gf015+rpII0D+viBkxj
         th5S9AKZbZ8/b3gT9djqWXTdE7pZIsUj4216ALlqOzZpsBv6E58rP1JsDo+zuz9pejHN
         838vbI10run4HOjp04xPaHKpJehh2FowRbeqDSSxGX/WpviiO0Cp2cyDOOqvHiaAasyk
         c14zkprb8zMmm9IuQ1yiY5UF103BP4+ILRruwvIcyNUtvwFlonPCnBrjhZIEnLf/lL0S
         2AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LyTKYUD/bNIDavfKIyBUK2+LGfEs6fHGIsN/epbMTo=;
        b=Efpd3iUlnDtZ9xue1HUW+agTzvv3BvYSVnLSUmOIADGjrj9tqwhaKqURT5g9iAGbri
         KzZIOGxaOjyusanXuVelHkkWaemTmr+ZT5KpHwa2d3y+zGwVAeFJBFyhFxibUJlfmbiE
         fyFaBov1rfaHeIupVBsiiOrJxGoV+vCRyKLSi5E1DyVVNfXyKhlh3fn481MA7yFlt6d0
         xFVIpRuTYu6EBmjknbWwn5qXNO55ZiFidolStAWatC85Ci67nx+2AShgNbwvV6jCltWX
         mra/5FJy5iKQZWv0FIvd2uzcQQtyNgRnzdyNaChF/xClEF8cKwv98Kk9FxvGmOK5bVBd
         pAaw==
X-Gm-Message-State: AOAM530Cuw/v644HGR+3yKF/AfXBSkxmNXFLhAYq+6HKwaVoLhPnvL6s
        epNzMyVXEX1zL06mBIrKEHruXs0TXEI=
X-Google-Smtp-Source: ABdhPJwDyJ5bpWGdeInLOmwfSiVTjWV3CNpmNKaDGXCbrJXjPxmjv+Mf9nL5utsePleC77WQ0REJMw==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr37170423wro.214.1593798156340;
        Fri, 03 Jul 2020 10:42:36 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH 13/30] usb: host: xhci: Demote obvious misuse of kerneldoc to standard comment block
Date:   Fri,  3 Jul 2020 18:41:31 +0100
Message-Id: <20200703174148.2749969-14-lee.jones@linaro.org>
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

 drivers/usb/host/xhci.c:1285: warning: Function parameter or member 'desc' not described in 'xhci_get_endpoint_index'

Cc: Mathias Nyman <mathias.nyman@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bee5deccc83d8..b90d61bb84144 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1271,7 +1271,7 @@ static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	return usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
 }
 
-/**
+/*
  * xhci_get_endpoint_index - Used for passing endpoint bitmasks between the core and
  * HCDs.  Find the index for an endpoint given its descriptor.  Use the return
  * value to right shift 1 for the bitmask.
-- 
2.25.1

