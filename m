Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CA12071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vS56Hc9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgFOVjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgFOVjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:39:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A344C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:39:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so481324pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ZItcTsmUJVY1twtF0BYdm5bT4xBfMuVk7qv3zb6xwU=;
        b=vS56Hc9Y+6xwZb3YQIsz+3gBP4DMWH3udxI9cmVvTwYal9JveZ+ioj53UNtTWyqtKP
         GICxiLle2yTC5ifZsmqJP4NoRSPOmfP0C7YR6vDkCCDTBrUoc/4giRHzBVsH3dEU3mWi
         jhVSBmodq2+94kt7it7rFlDAL8GM0KsIiWHokWAwI9YrzZH+qWZXeh24PaHv3zrdrOg0
         JjEroQnPeLoleV2pZxR3RsF1YLSCEqkx7nlHeG1/7a0HvB4fgbVY7vjfTaiEY3NChk6b
         wjGHhffI7AESf1VCCoJlUQAydRI0L/IffAIA3LerXULbJ6yDMdPpcSCISYHFeMe91npM
         crOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZItcTsmUJVY1twtF0BYdm5bT4xBfMuVk7qv3zb6xwU=;
        b=hzgJUDASp+czUfml0Xy6Qk5FnXumCPBAKaOC1o2FL1JMgAmXts/GTNQ79A1aynUMP+
         odzE2ZwFC6K+qaitnVYVtTnJNZp5VHnRSwrlbooQn+cCsseAnEjK7zwjpYMCtJIGMkf/
         KuWY7NlHztg/xnzOt6pSzymLKlrsEfupI5ylZCTwnl1OQXuRuR1IkhetTMPmWUOcKkLv
         tGGE7f2KuTfQ958A+C1qOflAgOH7RlXTcKO4449ApNqEXPOYH7sQoQZ+h5M62U+6bw45
         sEZZocSulSgg208SoZMHV2a839hbt+fltFLgHqfP2W+BNYqpCwL9kluXtoUlEpagXxyO
         Gl+Q==
X-Gm-Message-State: AOAM533Mpm/UxUFA47F/dOw+P6C0LNajbN/C4nfchsaN0Wx3xuHhGyuQ
        yAUMeuXz78J78hwPxoGZcQ6g0Q==
X-Google-Smtp-Source: ABdhPJwU2exYO5RI0cLVuvovkkDzg9U57gAEV3V70r9DUJH3KpxpqwjpEE7VHrJgXJlQkGfYgcwVSA==
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr17196813plp.36.1592257142928;
        Mon, 15 Jun 2020 14:39:02 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o186sm8708227pgo.65.2020.06.15.14.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:39:02 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] rpmsg: core: Add support to retrieve name extension
Date:   Mon, 15 Jun 2020 15:38:58 -0600
Message-Id: <20200615213859.443152-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200615213859.443152-1-mathieu.poirier@linaro.org>
References: <20200615213859.443152-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding support for rpmsg device name extension, this patch
provides a function that returns the extension portion of an rpmsg
device name.  That way users of the name extension functionality don't
have to write the same boiler plate code to extract the information.

Suggested-by: Suman Anna <s-anna@ti.com>;
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
 drivers/rpmsg/rpmsg_core.c | 93 ++++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg.h      | 13 ++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 5e01e8dede6b..5db21f9a6816 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -439,6 +439,99 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
 	return of_driver_match_device(dev, drv);
 }
 
+/**
+ * rpmsg_device_get_name_extension() - get the name extension of a rpmsg device
+ * @rpdev: the rpmsg device to work with
+ * @skip: how many characters in the extension should be skipped over
+ *
+ * With function rpmsg_id_match() allowing for extension of the base driver name
+ * in order to differentiate services, this function returns the extension part
+ * of an rpmsg device name.  As such and with the following rpmsg driver device
+ * id table and rpmsg device names:
+ *
+ * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
+ *      { .name = "rpmsg-client-sample" },
+ *      { },
+ * }
+ *
+ * rpdev1->id.name == "rpmsg-client-sample";
+ * rpdev2->id.name == "rpmsg-client-sample_instance0";
+ *
+ * Calling rpmsg_device_get_name_extension() will yields the following:
+ *
+ * rpmsg_device_get_name_extension(rpdev1, 0) == NULL;
+ * rpmsg_device_get_name_extension(rpdev2, 0) == "_instance0";
+ * rpmsg_device_get_name_extension(rpdev2, 1) == "instance0";
+ *
+ * Return: The name extension if found, NULL if the name of the RPMSG device
+ *	   equals the name of the RPMSG driver and an error if no match is
+ *	   found or a validation problem has occurred.
+ */
+const char *rpmsg_device_get_name_extension(struct rpmsg_device *rpdev,
+					    unsigned int skip)
+{
+	const char *drv_name, *dev_name, *extension;
+	const struct rpmsg_device_id *ids;
+	struct device *dev = &rpdev->dev;
+	struct rpmsg_driver *rpdrv;
+	bool match = false;
+	unsigned int i;
+
+	if (!dev->driver)
+		return ERR_PTR(-EINVAL);
+
+	rpdrv = to_rpmsg_driver(dev->driver);
+
+	/*
+	 * No point in going further if the device doesn't have name or
+	 * the driver doesn't have a table to work with.
+	 */
+	if (!rpdev->id.name[0] || !rpdrv->id_table)
+		return ERR_PTR(-EINVAL);
+
+	ids = rpdrv->id_table;
+	dev_name = rpdev->id.name;
+
+	/*
+	 * See if any name in the driver's table match the beginning
+	 * of the rpmsg device's name.
+	 */
+	for (i = 0; ids[i].name[0]; i++) {
+		drv_name = ids[i].name;
+		if (strncmp(drv_name, dev_name, strlen(drv_name)) == 0) {
+			match = true;
+			break;
+		}
+	}
+
+	/*
+	 * A match was not found, return an error to differentiate with cases
+	 * where a match was found but the name has no extension (see below).
+	 */
+	if (!match)
+		return ERR_PTR(-ENOENT);
+
+	 /* No name extension to return if device and driver are the same */
+	if (strlen(dev_name) == strlen(drv_name))
+		return NULL;
+
+	/*
+	 * Make sure we were not requested to skip past the end
+	 * of the device name.
+	 */
+	if (strlen(drv_name) + skip >= strlen(dev_name))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Move past the base name published by the driver and
+	 * skip any extra characters if needed.
+	 */
+	extension = dev_name + strlen(drv_name) + skip;
+
+	return extension;
+}
+EXPORT_SYMBOL(rpmsg_device_get_name_extension);
+
 static int rpmsg_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d1c018..9537b95ad30a 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -135,6 +135,9 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 			poll_table *wait);
 
+const char *rpmsg_device_get_name_extension(struct rpmsg_device *dev,
+					    unsigned int skip);
+
 #else
 
 static inline int register_rpmsg_device(struct rpmsg_device *dev)
@@ -242,6 +245,16 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
 	return 0;
 }
 
+static inline
+const char *rpmsg_device_get_name_extension(struct rpmsg_device *dev,
+					    unsigned int skip)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return NULL;
+}
+
 #endif /* IS_ENABLED(CONFIG_RPMSG) */
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
-- 
2.25.1

