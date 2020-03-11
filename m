Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6708C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03682074F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gZsLsQ90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgCKXOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:14:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37021 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbgCKXOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:14:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id f16so1827268plj.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+l8HEEp5z/NJMl2lmZaebCPqD2oTwZcZODCagAmwBoI=;
        b=gZsLsQ905xELdiFXDuvhCY948QmOeq8hgf7WRNwFQYggf7QXDlIrRdkt6RRbcRjNRw
         wCDMWcAZnWj75TZ4WmkroiHz3XAAsw/OTa+lAVRAp2o5sCdGCFOAvvSDqJKeZEUCpmBb
         BpstVVFKwXnMIPEHqdjum/DfKDyUB92ghvYrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+l8HEEp5z/NJMl2lmZaebCPqD2oTwZcZODCagAmwBoI=;
        b=uFGtooAOSpljjNqFDltVxwbGPsp5JSUFlvjZSFfT8mIJEp824J7qTZp2rcZqKPe1m2
         bU1ztH8dKGPmjgofn6BpkENSohPk3wHwKheynwsegUyA9y7Z2lx4uc7IVRNf1i92/8vU
         Da6M5WldES6lxvMeg0JIg4PaULWdHmoo30F5HCqQQdxst46nyzSJxMwctXmYEFErWNvW
         0pKFvQyHSGKyUg/5VJ4MsuUIgrTZPSNlB8wdJX2Wc73VNHyOTAANA+LkOyCqEFUCySkH
         9Yw6QENJpdn6Ou/8d8z9TQHWMWFF2VEv9U3lPhkMvkoPBFk8fsHkhVddAjj4VsJRwEqn
         TG1g==
X-Gm-Message-State: ANhLgQ3LrPaTHqUZYRKPA1sibwsoZ6NDDbAWUExdBabZqJMxhvLLbp3X
        uZozLTbXM5yHs2lWffjYjftD5A==
X-Google-Smtp-Source: ADFU+vuyyhI1HC2LBNYvyyv/D6HXeGMLu7hKQzSZUyP6NZso3KnmgOeJay5KNjXVk2vcBMokDpLLZw==
X-Received: by 2002:a17:90a:b90a:: with SMTP id p10mr1029934pjr.81.1583968464591;
        Wed, 11 Mar 2020 16:14:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g75sm2606334pje.37.2020.03.11.16.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:14:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 10/10] drivers: qcom: rpmh-rsc: Always use -EAGAIN, never -EBUSY
Date:   Wed, 11 Mar 2020 16:13:48 -0700
Message-Id: <20200311161104.RFT.v2.10.I537337af59c51c72aac2c1625760a60519c66387@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200311231348.129254-1-dianders@chromium.org>
References: <20200311231348.129254-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some parts of rpmh-rsc returned -EAGAIN when the controller was busy
and you should try again.  Other parts returned -EBUSY when the
controller was busy and you should try again.  Typically -EAGAIN was
used when dealing with sleep/wake TCSs and -EBUSY was used when
dealing with the active TCS.

Let's standardize and just have one return code.

If we don't do this then the crossover case where we need to use a
sleep/wake TCS for an active only transfer (when there are zero active
TCSs) we need to either adapt one code to the other test for both.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Always use -EAGAIN, never -EBUSY") new for v2.

 drivers/soc/qcom/rpmh-rsc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index abbd8b158a63..8b59d07ef94e 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -497,11 +497,11 @@ static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
  *
  * This will walk through the TCSs in the group and check if any of them
  * appear to be sending to addresses referenced in the message.  If it finds
- * one it'll return -EBUSY.
+ * one it'll return -EAGAIN.
  *
  * Must be called with the drv->lock held since that protects tcs_in_use.
  *
- * Return: 0 if nothing in flight or -EBUSY if we should try again later.
+ * Return: 0 if nothing in flight or -EAGAIN if we should try again later.
  *         The caller must re-enable interrupts between tries since that's
  *         the only way tcs_is_free() will ever return true and the only way
  *         RSC_DRV_CMD_ENABLE will ever be cleared.
@@ -524,7 +524,7 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 			addr = read_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j);
 			for (k = 0; k < msg->num_cmds; k++) {
 				if (addr == msg->cmds[k].addr)
-					return -EBUSY;
+					return -EAGAIN;
 			}
 		}
 	}
@@ -550,21 +550,21 @@ static int find_free_tcs(struct tcs_group *tcs)
 			return tcs->offset + i;
 	}
 
-	return -EBUSY;
+	return -EAGAIN;
 }
 
 /**
- * tcs_write() - Store messages into a TCS right now, or return -EBUSY.
+ * tcs_write() - Store messages into a TCS right now, or return -EAGAIN.
  * @drv: The controller.
  * @msg: The data to be sent.
  *
  * Grabs a TCS for ACTIVE_ONLY transfers and writes the messages to it.
  *
  * If there are no free ACTIVE_ONLY TCSs or if a command for the same address
- * is already transferring returns -EBUSY which means the client should retry
+ * is already transferring returns -EAGAIN which means the client should retry
  * shortly.
  *
- * Return: 0 on success, -EBUSY if client should retry, or an error.
+ * Return: 0 on success, -EAGAIN if client should retry, or an error.
  *         Client should have interrupts enabled for a bit before retrying.
  */
 static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
@@ -580,7 +580,6 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 	 */
 	WARN_ON(msg->state != RPMH_ACTIVE_ONLY_STATE);
 
-	/* TODO: get_tcs_for_msg() can return -EAGAIN and nobody handles */
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
@@ -651,12 +650,12 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 
 	do {
 		ret = tcs_write(drv, msg);
-		if (ret == -EBUSY) {
+		if (ret == -EAGAIN) {
 			pr_info_ratelimited("TCS Busy, retrying RPMH message send: addr=%#x\n",
 					    msg->cmds[0].addr);
 			udelay(10);
 		}
-	} while (ret == -EBUSY);
+	} while (ret == -EAGAIN);
 
 	return ret;
 }
-- 
2.25.1.481.gfbce0eb801-goog

