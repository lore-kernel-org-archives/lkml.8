Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA2AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 03:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8262076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 03:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPWKRMwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgE3DYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 23:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgE3DYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 23:24:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3FC03E969;
        Fri, 29 May 2020 20:24:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so1959075plb.11;
        Fri, 29 May 2020 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FdbL62wDBkj51/wZjPHO0PEcvT8Qa+4KymVTq92Y+JA=;
        b=aPWKRMwhAzA/H+38X17QTU2KRFcaK5q5nRdTvsURPl33xIsGN+hw2VXVRTJ2xRfGOY
         fqcJKIBCP2GJQFYBnA3xWVKR5wM5kOCotIOPBuax9gigjN6JdqzuY5nA92D83FwT3jFe
         SQFuBOHKMQbY8b+h9SLfjT55Izyu9GmiHUXLhlo4qgd5NldtoSokES819rkBlRa7chnU
         fiOMni3p8W4580kw+C4ZHnmdLEFs2I6R8S982fZ3nfgA6QGThiQoeRAGWKXQAI3UEqgq
         AZeTwCWT+yXlmARWaBiybrQvxJbSbRjn+Svs8ePNITQX/U92/2ZKEF/vd3ZxnFk1aRjZ
         nGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FdbL62wDBkj51/wZjPHO0PEcvT8Qa+4KymVTq92Y+JA=;
        b=fkRRzFx0HzQCgruW0tCClxONQzSOYOtxIQKfcLlF/5klMD+HgDsDDUACRNVGaj4yGc
         bL3ZuMl+Va8AftQab4Yz2UhEDu1xEkO7el7Y0AxEMnHNEbGlNaA2BPCpqJcO9eOov1jE
         w9cTrHttXJF7ZyBjwGDISfb8nK/T8H2mZ+SOMrMICp4mx70AHJusCrEhPihZMeZ2LUMW
         hny2bQ5xsSb196ZUYaAIWUK/eHaPu1mSjhc9OzFAUG0dIH4YdcblaS20NCW+a7oyFX7t
         tvbzY2nRqQpcOLgDhw4cPd72YFGlBZYLAV9YCu7SdZogM9nX7JdlEiV44Pwz7NWHqkBq
         Zh3w==
X-Gm-Message-State: AOAM533EPhi9/D7mXVTbt0Mhoaqcz7u1X3fLkOZtWXQZ4qZ+NCaLbjvT
        oALEnykspbhsA6ceSZ4DHpA=
X-Google-Smtp-Source: ABdhPJxFrT0FsXFHKwllDoEok7Dgi4SL1M1SsslivDkKDszxBXXjKxhrC+1f5K2kAKg2Dw1/IXdPHA==
X-Received: by 2002:a17:90a:ee91:: with SMTP id i17mr11269329pjz.45.1590809058312;
        Fri, 29 May 2020 20:24:18 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id b63sm8426304pfg.86.2020.05.29.20.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 20:24:17 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, balbi@kernel.org, peter.chen@nxp.com,
        pawell@cadence.com, rogerq@ti.com, colin.king@canonical.com,
        yuehaibing@huawei.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: cdns3: fix possible buffer overflow caused by bad DMA value
Date:   Sat, 30 May 2020 11:24:00 +0800
Message-Id: <20200530032400.12743-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cdns3_ep0_setup_phase():
  struct usb_ctrlrequest *ctrl = priv_dev->setup_buf;

Because priv_dev->setup_buf (allocated in cdns3_gadget_start) is stored 
in DMA memory, and thus ctrl is a DMA value.

cdns3_ep0_setup_phase()
  cdns3_ep0_standard_request(priv_dev, ctrl)
    cdns3_req_ep0_get_status(priv_dev, ctrl)
      index = cdns3_ep_addr_to_index(ctrl->wIndex);
      priv_ep = priv_dev->eps[index];

cdns3_ep0_setup_phase()
  cdns3_ep0_standard_request(priv_dev, ctrl)
    cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 0)
      cdns3_ep0_feature_handle_endpoint(priv_dev, ctrl, set)
        index = cdns3_ep_addr_to_index(ctrl->wIndex);
        priv_ep = priv_dev->eps[index];

In these cases, ctrl->wIndex can be be modified at anytime by malicious
hardware, and thus a buffer overflow can occur when the code
"priv_dev->eps[index]" is executed.

To fix these possible bugs, index is checked before being used.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/cdns3/ep0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index e71240b386b4..0a80c7ade613 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -265,6 +265,8 @@ static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
 		return cdns3_ep0_delegate_req(priv_dev, ctrl);
 	case USB_RECIP_ENDPOINT:
 		index = cdns3_ep_addr_to_index(ctrl->wIndex);
+		if (index >= CDNS3_ENDPOINTS_MAX_COUNT)
+			return -EINVAL;
 		priv_ep = priv_dev->eps[index];
 
 		/* check if endpoint is stalled or stall is pending */
@@ -388,6 +390,9 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
 		return 0;
 
 	index = cdns3_ep_addr_to_index(ctrl->wIndex);
+	if (index >= CDNS3_ENDPOINTS_MAX_COUNT)
+		return -EINVAL;
+
 	priv_ep = priv_dev->eps[index];
 
 	cdns3_select_ep(priv_dev, ctrl->wIndex);
-- 
2.17.1

