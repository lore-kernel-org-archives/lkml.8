Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC2C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AF82073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dG9sYOZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgDMMOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726582AbgDMMOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:14:43 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 08:14:43 EDT
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4443BC03BC84
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 05:08:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g32so4363307pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wj+YzA/86Frd7Zd8PQVfNidgsoO9NUSMQrAh2tNMoqA=;
        b=dG9sYOZUsDVAhsdHt6BN2RGAy6u4VjKhSrkwCY7tmN9DkDCxfHjm0G04Gf7NxoN/QY
         /R89MOOvJfcw+PM4/H0w4RsO6sis/w5RWOWFSGD6n6A2spje73hMrzS5qIrPBBXcfkeI
         yeeB0J+JBRj5FXEsrguoTEQmQ7v61tCzMfR1mqOlDZ9Vp9b+3yGMDvZw63zF//CNPTgn
         /cfEqB3cFt/E6djM0copsYuxrMpl5YeOx099jlDqolposKjQhiTRxZreGsSPxWU9vl9Y
         cYbCkPy9aoQ5lHe+WUVZT5BbVGJlM9qUCamzyUhvZO8y7i5KOrVxpTdYx2TQay9QzW0T
         A/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wj+YzA/86Frd7Zd8PQVfNidgsoO9NUSMQrAh2tNMoqA=;
        b=CMRsuUara0G2TM2qGks2kYoxjMnAmb1tdUBbcuyQv2GkDk2nVrNWlblpQ3c0O293d/
         Inm/D/NZmeOyW4dj3MT4JfvWFngumeu1yaEFy7hnJ+HRkLCvRRyHiFu+CkRez2SyarJH
         kK8m6SkbN0rAmVCBmm8uYXCTpNxpGiYFbxPJojKMKqH2ZOpfTi06gQMrKsdAg/WSmrwP
         hh3zFeahl9AWGlB51/uzof8VTEHxRGs2FW7l+Xu937YwGdfjq7nL5bbvEPZ3BqhFsdD9
         E1oiDQhJKnCmhbUtXHgibPEYkvDu/zXAFRl/SEnzxWWPCRpYw8l6wYpj1Ohd8VH+Jzqx
         cmnQ==
X-Gm-Message-State: AGi0Pua7XLySl2lc8oM3k/yZ/SyeBvJ7CfWM2szC2p/3uHAeobO4Pozo
        SPTx1gAjVk3XGq4b3+zaORmcTaoaqg==
X-Google-Smtp-Source: APiQypLVbVZy3eG1BQGA3TqwQvzB8FXO6P1puwgwbPzXylzHbBtdhA9hnLrP3OJm/6/SOygpRQzHBw==
X-Received: by 2002:a63:cc45:: with SMTP id q5mr16453175pgi.270.1586779687807;
        Mon, 13 Apr 2020 05:08:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:621d:5eab:c98c:e94e:e075:c316])
        by smtp.gmail.com with ESMTPSA id i187sm8493136pfg.33.2020.04.13.05.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 05:08:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     hemantk@codeaurora.org, jhugo@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        smohanad@codeaurora.org, dan.carpenter@oracle.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] bus: mhi: core: Fix double lock of 'mhi_chan->lock'
Date:   Mon, 13 Apr 2020 17:37:41 +0530
Message-Id: <20200413120741.2832-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413120741.2832-1-manivannan.sadhasivam@linaro.org>
References: <20200413120741.2832-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mhi_queue_buf() will grab the 'mhi_chan->lock' for doing the doorbell
access. Hence the lock needs to be dropped before the call.

Fixes: 189ff97cca53 ("bus: mhi: core: Add support for data transfer")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 4165a853c189..ed995137c3a0 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -538,6 +538,11 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			 * from dropping the packet
 			 */
 			if (mhi_chan->pre_alloc) {
+				/*
+				 * mhi_queue_buf() will grab the mhi_chan->lock
+				 * so let's drop it here and grab it later
+				 */
+				read_unlock_bh(&mhi_chan->lock);
 				if (mhi_queue_buf(mhi_chan->mhi_dev,
 						  mhi_chan->dir,
 						  buf_info->cb_buf,
@@ -547,6 +552,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 						mhi_chan->chan);
 					kfree(buf_info->cb_buf);
 				}
+				read_lock_bh(&mhi_chan->lock);
 			}
 		}
 		break;
-- 
2.17.1

