Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77616C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57ACA20870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jn2FpAOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgGCRmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgGCRmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66926C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so32762479wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObQbMmeWDMLVhtsXWDC1B0aBD5PkI/uWeU7dXCk6FlM=;
        b=jn2FpAOUPnZM069KYrVVfbxt1St8s7u9aejs2316lLyFC8QicNEuaQpIqyiqJJoy6C
         O4vsFZ6bk3aach7toVLh8omoClMF7OLDlCzPYK4eWBpCVKSUQlWr5i1G/rLt2i8/VweZ
         sSg80UU1XpFSFVcxfOxDpnl/9ztoRoZmbt6zAOJ2u3FhcuWqSgpehMIFMtWHfBUA0xXX
         ikyr40G5+YBJtgJcJXPwZzwN9sk6THJMUK1RommOcPasQY+6xFoT5k9uRBU1A0uAVrAg
         g7qf2oq6gxZeeX09UgLWhVJ/wmtYGjB6Qg8WuTAh9AXezXcLDgyH62NaLTcw/cIpj1yF
         1MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObQbMmeWDMLVhtsXWDC1B0aBD5PkI/uWeU7dXCk6FlM=;
        b=oWlH23ntcOJnbntPbK9bniWhqwVzgp5y7X0R/DtB9UrrDUtkNkqivt3po/G+0bzk1E
         yxXudemW6jGR0XYrU3SAwy38Da+Bytkt1DN20c4DFrURi0hc1yReaMfYKPPfiQPsSkqs
         LIH7CK32Qc0L8mgVJf8bwFkci8bclsCSL2oxs6UDP42mhKsFVpFrbsdoTauPDbfG5yus
         eU3qnMFCQVfNlVntjnjWHs3JSiXKa3TptDuNVNLgFhjB2/D0DH+26swc+BdaCrv/b1Dv
         WUG2fz7nHGhc80/2nFNb4dhjHZN86Vk3f2EAuof/zph+vcCABX7s15+1e+4JP9tYDhuo
         qjpw==
X-Gm-Message-State: AOAM531asLMLCpQsIPJ9v0LAQAY6LQeaAP7GoIx3MbuWbHabfk4WYCGz
        A51QqkhO/TQQeYqi/gt/4DsgiA==
X-Google-Smtp-Source: ABdhPJztrlr52atDjF3/+UOTLHYOF7+PmOGAz6sBBDjCc2z9cg29j3l9cqY7+6NiEdsJROG6JiGr7w==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr8729231wme.16.1593798162149;
        Fri, 03 Jul 2020 10:42:42 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>
Subject: [PATCH 17/30] usb: chipidea: udc: Fix a few kerneldoc issues
Date:   Fri,  3 Jul 2020 18:41:35 +0100
Message-Id: <20200703174148.2749969-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Descriptions were missing for 'ci' almost throughout.  There was
one instance of over-documenting.  Finally one function argument
was incorrectly documented (probably down to bitrot).

Fixes the following W=1 kernel build warning(s):

 drivers/usb/chipidea/udc.c:245: warning: Function parameter or member 'ci' not described in 'hw_port_is_high_speed'
 drivers/usb/chipidea/udc.c:271: warning: Function parameter or member 'ci' not described in 'hw_test_and_clear_intr_active'
 drivers/usb/chipidea/udc.c:285: warning: Function parameter or member 'ci' not described in 'hw_test_and_clear_setup_guard'
 drivers/usb/chipidea/udc.c:296: warning: Function parameter or member 'ci' not described in 'hw_test_and_set_setup_guard'
 drivers/usb/chipidea/udc.c:321: warning: Function parameter or member 'ci' not described in 'hw_usb_reset'
 drivers/usb/chipidea/udc.c:628: warning: Excess function parameter 'ci' description in 'free_pending_td'
 drivers/usb/chipidea/udc.c:655: warning: Function parameter or member 'hwep' not described in '_hardware_dequeue'
 drivers/usb/chipidea/udc.c:655: warning: Excess function parameter 'gadget' description in '_hardware_dequeue'

Cc: Peter Chen <Peter.Chen@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/chipidea/udc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 0dfbc31843fc8..6a20ef396543b 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -238,6 +238,7 @@ static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
 
 /**
  * hw_is_port_high_speed: test if port is high speed
+ * @ci: the controller
  *
  * This function returns true if high speed port
  */
@@ -264,6 +265,7 @@ static int hw_test_and_clear_complete(struct ci_hdrc *ci, int n)
 /**
  * hw_test_and_clear_intr_active: test & clear active interrupts (execute
  *                                without interruption)
+ * @ci: the controller
  *
  * This function returns active interrutps
  */
@@ -278,6 +280,7 @@ static u32 hw_test_and_clear_intr_active(struct ci_hdrc *ci)
 /**
  * hw_test_and_clear_setup_guard: test & clear setup guard (execute without
  *                                interruption)
+ * @ci: the controller
  *
  * This function returns guard value
  */
@@ -289,6 +292,7 @@ static int hw_test_and_clear_setup_guard(struct ci_hdrc *ci)
 /**
  * hw_test_and_set_setup_guard: test & set setup guard (execute without
  *                              interruption)
+ * @ci: the controller
  *
  * This function returns guard value
  */
@@ -314,6 +318,7 @@ static void hw_usb_set_address(struct ci_hdrc *ci, u8 value)
 /**
  * hw_usb_reset: restart device after a bus reset (execute without
  *               interruption)
+ * @ci: the controller
  *
  * This function returns an error code
  */
@@ -621,7 +626,6 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 
 /**
  * free_pending_td: remove a pending request for the endpoint
- * @ci: the controller
  * @hwep: endpoint
  */
 static void free_pending_td(struct ci_hw_ep *hwep)
@@ -646,7 +650,7 @@ static int reprime_dtd(struct ci_hdrc *ci, struct ci_hw_ep *hwep,
 
 /**
  * _hardware_dequeue: handles a request at hardware level
- * @gadget: gadget
+ * @hwep: endpoint
  * @hwreq:  request
  *
  * This function returns an error code
-- 
2.25.1

