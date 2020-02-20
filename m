Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B648DC11D40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB4824654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIncW3q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgBTGGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:06:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51602 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBTGGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:06:22 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so416112pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FwVgCncLbVot4SV9ouCUOJjc6U+mADi+9P9iseWgOPI=;
        b=FIncW3q427jUrJc76Y5wnHtilxkDdRipTd9Z0W6sQzjmc+I7zTxLGoIyw5+dU7OBr6
         xrVqqX8ncq4AKJ6CL6Qmo+cGKPU73ueOlos1tpypHNlQ9M/EvpgTzwpB9AaEnQI8ck2v
         ms4ipHKtI5c1iTbQd9nEPS6BnFc4XgsIZlFyZd02dzlB9ONFilIOqF7K7KyGkZohLd8/
         ewQy5rduuyxd99ICYAUd8gFtrG5NWZav4DTMTYEYj5gKuL5jCuiCM2t8XBn8CnbTCSvN
         niBFIKoC72wYfwWxxcYjLuo+3jO1dQPeLMcexsDoxjb9MfY0Cgz96/d2bqLFVL/D9jPv
         W/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FwVgCncLbVot4SV9ouCUOJjc6U+mADi+9P9iseWgOPI=;
        b=TDY4nVOUCi499Xsi00l0bBE++Be1C3ypg8gfUIEUjdmgy4Lug2hWNS3LlIPIvgLOG1
         y4HfllLzdQqcTuv7GzaQqZgeasDyaka+3iFs4hkvnqgyTH/VjjstNiSzvucMXj8iLcgX
         m79AIv2wxiSqFEYOWyxZh+eRHPrU8SvIU4l6XKkYwnPVOU77wmpRCWryUakI1B7737M8
         aDCt1fsTF/DRm/xgBwVTXnzDVJUVjkIaezltJrpYdpm9LX8YncRu6Qt07OIMCZ9ysc3v
         nuRKfMGa9SQAIM9WoLIVuh2XwRCvGKrrgSb1ZytXrE+0mZj6jVd+EVCZGYDQRVClpB8a
         1IgA==
X-Gm-Message-State: APjAAAVYAPcPY9H4FO3xYviq+heFYJ+TasFJ6kCCnfeehRJ/a7LdizvH
        q6XdNtxCdYSigUCbNQjEmuS2W5Q8qeg=
X-Google-Smtp-Source: APXvYqwnon8ICd/yoj8ge5wkuOIkItWJbqBTJlG7DQJMrVrVL6k/BZq66xnHxJjvkgHYIn2qovfoQA==
X-Received: by 2002:a17:902:d20f:: with SMTP id t15mr30941281ply.55.1582178781449;
        Wed, 19 Feb 2020 22:06:21 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v5sm1747887pgc.11.2020.02.19.22.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:06:20 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Pratham Pratap <prathampratap@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>, Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2] usb: dwc3: gadget: Update chain bit correctly when using sg list
Date:   Thu, 20 Feb 2020 06:06:16 +0000
Message-Id: <20200220060616.54389-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratham Pratap <prathampratap@codeaurora.org>

If scatter-gather operation is allowed, a large USB request is split
into multiple TRBs. For preparing TRBs for sg list, driver iterates
over the list and creates TRB for each sg and mark the chain bit to
false for the last sg. The current IOMMU driver is clubbing the list
of sgs which shares a page boundary into one and giving it to USB driver.
With this the number of sgs mapped it not equal to the the number of sgs
passed. Because of this USB driver is not marking the chain bit to false
since it couldn't iterate to the last sg. This patch addresses this issue
by marking the chain bit to false if it is the last mapped sg.

At a practical level, this patch resolves USB transfer stalls
seen with adb on dwc3 based db845c, pixel3 and other qcom
hardware after functionfs gadget added scatter-gather support
around v4.20.

Credit also to Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
who implemented a very similar fix to this issue.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Yang Fei <fei.yang@intel.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux USB List <linux-usb@vger.kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Pratham Pratap <prathampratap@codeaurora.org>
[jstultz: Slight tweak to remove sg_is_last() usage, reworked
          commit message, minor comment tweak]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Fix typeos and unnecssary parens as suggested by Jack
---
 drivers/usb/dwc3/gadget.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1b8014ab0b25..721d897fef94 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1071,7 +1071,14 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		unsigned int rem = length % maxp;
 		unsigned chain = true;
 
-		if (sg_is_last(s))
+		/*
+		 * IOMMU driver is coalescing the list of sgs which shares a
+		 * page boundary into one and giving it to USB driver. With
+		 * this the number of sgs mapped is not equal to the number of
+		 * sgs passed. So mark the chain bit to false if it isthe last
+		 * mapped sg.
+		 */
+		if (i == remaining - 1)
 			chain = false;
 
 		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
-- 
2.17.1

