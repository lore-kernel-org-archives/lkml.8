Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A247C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321412067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIkTP97L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgGBOrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgGBOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8585EC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so27103489wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuydmHRHncRiKpEKLiFPz7smS3ISdpVCQYiyoW4VCQc=;
        b=cIkTP97Ltc4F26LRPd0k0vH8rCSPhi/svFlkgm7iKd4rUBiebH/6UsCDSQMTEs+DqV
         DP49K7VEoXDEQN+3y9DARzbaESZ5W1uuHqmbciLtfPHolTD+ucYN8BVDgQfyKWGbO6HD
         756KA9mM2iutxpw1ZJI7PuolhFV1232juQjtiTlEXKWJP33njo4EmHVOVLegPykn9Pat
         y/0yk4CPL7Cso65VaaRKexs5m2cpIXhiY2futiEY2jISvBCohLLdgn/Euz4eV2lRNfKB
         qHTdgXFbJnl4A+V4gHCMnLhhvAb2xZkinyaYH5F3rAEh7Tim5eHnqwp8tci0JCnaHOvh
         saCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuydmHRHncRiKpEKLiFPz7smS3ISdpVCQYiyoW4VCQc=;
        b=dycDnroCliaGk8cvwFEx5oOERDpydHipiq/ssmUUtDkpqVj54ugqE04pfUj6dIbkCN
         +lTJABH8D7MWHREQmxwgOCgfcJ66m5M9UdLntyDH2H4nYAkq8LYIV09XJplzVebFIBz+
         Y1NS/APfEubxZ6NYvYcH0ZBSkOIxTog2D80sdv2QViXa3wCkOYgB87aeUYKFQQyNCIXa
         EHVNh0ikd9kvZp8CIf3nv0K4fQJXaTASf7QjkOi0buFAKRIP4PqKMjPbBj3K3RP9PQw3
         WpE6LxNaSbPoAB80BHeIfMQb/6lonXzTdw0NpbhD9mR1r7rKX3WGzS32TCfE+I5Q507t
         r3sQ==
X-Gm-Message-State: AOAM5330KB42uRLWHPjzOgBf5fKwyGzGnH7vmV9S/gLDi7NIomuHInRR
        a8t9l78ffBboo8leJp6jPXs8MQ==
X-Google-Smtp-Source: ABdhPJwt4BB5QN+0+VYuAyZoPm9sDJXGV16TynQZBiUxLCJhmyDebIEU0rFkq/UKkGjxIQm03YHAJA==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr20867799wmc.117.1593701213215;
        Thu, 02 Jul 2020 07:46:53 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Pawel Jez <pjez@cadence.com>, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 17/30] usb: cdns3: gadget: Fix a bunch of kernel doc issues
Date:   Thu,  2 Jul 2020 15:46:12 +0100
Message-Id: <20200702144625.2533530-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainline misspelled function argument descriptions.  Also one
formatting issue with a missing '@' identifier.

Fixes the following W=1 build warnings:

 drivers/usb/cdns3/gadget.c:653: warning: Function parameter or member 'priv_ep' not described in 'cdns3_wa2_descmissing_packet'
 drivers/usb/cdns3/gadget.c:653: warning: Excess function parameter 'priv_dev' description in 'cdns3_wa2_descmissing_packet'
 drivers/usb/cdns3/gadget.c:1088: warning: Function parameter or member 'request' not described in 'cdns3_ep_run_transfer'
 drivers/usb/cdns3/gadget.c:2574: warning: Function parameter or member 'priv_ep' not described in '__cdns3_gadget_ep_set_halt'
 drivers/usb/cdns3/gadget.c:2574: warning: Excess function parameter 'ep' description in '__cdns3_gadget_ep_set_halt'
 drivers/usb/cdns3/gadget.c:2595: warning: Function parameter or member 'priv_ep' not described in '__cdns3_gadget_ep_clear_halt'
 drivers/usb/cdns3/gadget.c:2595: warning: Excess function parameter 'ep' description in '__cdns3_gadget_ep_clear_halt'
 drivers/usb/cdns3/gadget.c:2898: warning: Function parameter or member 'priv_dev' not described in 'cdns3_init_eps'
 drivers/usb/cdns3/gadget.c:2898: warning: Excess function parameter 'cdns3' description in 'cdns3_init_eps'
 drivers/usb/cdns3/gadget.c:3210: warning: Function parameter or member 'cdns' not described in 'cdns3_gadget_init'

Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Pawel Jez <pjez@cadence.com>
Cc: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/cdns3/gadget.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 5e24c2e57c0d8..bfb1cbd492892 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -644,7 +644,7 @@ static void cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
 
 /**
  * cdns3_wa2_descmissing_packet - handles descriptor missing event.
- * @priv_dev: extended gadget object
+ * @priv_ep: extended gadget object
  *
  * This function is used only for WA2. For more information see Work around 2
  * description.
@@ -1080,6 +1080,7 @@ static int cdns3_ep_run_stream_transfer(struct cdns3_endpoint *priv_ep,
 /**
  * cdns3_ep_run_transfer - start transfer on no-default endpoint hardware
  * @priv_ep: endpoint object
+ * @request: request object
  *
  * Returns zero on success or negative value on failure
  */
@@ -2568,7 +2569,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
 /**
  * __cdns3_gadget_ep_set_halt Sets stall on selected endpoint
  * Should be called after acquiring spin_lock and selecting ep
- * @ep: endpoint object to set stall on.
+ * @priv_ep: endpoint object to set stall on.
  */
 void __cdns3_gadget_ep_set_halt(struct cdns3_endpoint *priv_ep)
 {
@@ -2589,7 +2590,7 @@ void __cdns3_gadget_ep_set_halt(struct cdns3_endpoint *priv_ep)
 /**
  * __cdns3_gadget_ep_clear_halt Clears stall on selected endpoint
  * Should be called after acquiring spin_lock and selecting ep
- * @ep: endpoint object to clear stall on
+ * @priv_ep: endpoint object to clear stall on
  */
 int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
 {
@@ -2890,7 +2891,7 @@ static void cdns3_free_all_eps(struct cdns3_device *priv_dev)
 
 /**
  * cdns3_init_eps Initializes software endpoints of gadget
- * @cdns3: extended gadget object
+ * @priv_dev: extended gadget object
  *
  * Returns 0 on success, error code elsewhere
  */
@@ -3202,7 +3203,7 @@ static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
 /**
  * cdns3_gadget_init - initialize device structure
  *
- * cdns: cdns3 instance
+ * @cdns: cdns3 instance
  *
  * This function initializes the gadget.
  */
-- 
2.25.1

