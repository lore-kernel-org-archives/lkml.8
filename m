Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6683FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CEA21532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I02lSPEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIII1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIII1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:27:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFCEC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:27:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so1964421wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QM64L3CcsMa1siJdI4dg24BqXKXYUZtDhge9L0xvdAI=;
        b=I02lSPEdBGwQrP44DPQbz+erJ4x71MpXzgrdn6BPMo3n6Iv616vbsXwuDRbIfLlys0
         Iszj1wODuFSYWrjZyE3SxY3n8QFClt3FmGQ0k51Vb/pK+Vj8ZIy4zKetEyJsJeebNNuV
         ITCGxPR+8dzABuYBNd/A/G16kAbMF0RcJHkMn1MzLH/TkBiRPjrQMzdYayAmUvcwjhRL
         Bal4YbYmDjsnu5YTOM0BD1ZXM99BCdAL8/f4vpQVWkbYWuYBzBZ1q+73J1isfAkiw/LE
         A8yOCkTQLAcuq03aKACXQkKYqBmsxVU/0IpUxaAiNb210akkICy130e561uDbwv5zIqt
         YWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QM64L3CcsMa1siJdI4dg24BqXKXYUZtDhge9L0xvdAI=;
        b=h0ei2RlFBcg6+GNY+MnjvOqxnrI0U5BaDgB6N3yDQL1+Pf/IXBWXnBjWjDqdOYHrqu
         DNoVdUA+4JDBq3ZCVn6jlBTTqnda0bmLJ3Zm1np9t/7h1J4GA+lhgbNPbJ8tHCOqNopA
         5/UnW4Ew2N7+VLZmNGluAdzY8RfQZwoq2qodMgfRocAY32Glj4W+b0zwXVscGigbSN7A
         WTo8Osw1chitin1YlrAmZ9eeYchUXY22AU7FS7ezGga3UW+5jR56OYh+ikWH4gU5VJa+
         okeBWDamWdKRWxOS9G77AGtaAI78GpFJd5LlPG4dgSELJyiLaParRYYirtRAHut9WCQ6
         uNVg==
X-Gm-Message-State: AOAM532HWdmsX60QWtjwY4UhpwnP1L9z/xDlpvTaK+uuXcNapg4skV/t
        6YRuWXws1UzBUbiHOg3yUJN1qw==
X-Google-Smtp-Source: ABdhPJwQe9jOkEvwsrTHtVYwibViPE7q3BlvaqBdPRQ8ec1kaskrGW61AkO+C7wlLNLMuhqt6ZDzZA==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr2850158wrr.105.1599640037528;
        Wed, 09 Sep 2020 01:27:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f1sm3092574wrx.75.2020.09.09.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:27:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: bus: add enumerated slave to device list
Date:   Wed,  9 Sep 2020 09:27:11 +0100
Message-Id: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently slave devices are only added either from device tree or acpi
entries. However lets say, there is wrong or no entry of a slave device
in DT that is enumerated, then there is no way for user to know all
the enumerated devices on the bus.

To fix this add slave device by default if there is no matching dt or
acpi entry, so that we can see this in sysfs entry.

In my case I had a wrong address entry in DT, However I had no way to
know what devices are actually enumerated on the bus!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/bus.c      | 1 +
 drivers/soundwire/bus.h      | 2 ++
 drivers/soundwire/bus_type.c | 6 ++++++
 drivers/soundwire/slave.c    | 4 ++--
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index e6e0fb9a81b4..55d9c22c4ec5 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -699,6 +699,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 
 		if (!found) {
 			/* TODO: Park this device in Group 13 */
+			sdw_slave_add(bus, &id, NULL);
 			dev_err(bus->dev, "Slave Entry not found\n");
 		}
 
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 82484f741168..1517d6789dff 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -19,6 +19,8 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 int sdw_of_find_slaves(struct sdw_bus *bus);
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			  u64 addr, struct sdw_slave_id *id);
+int sdw_slave_add(struct sdw_bus *bus, struct sdw_slave_id *id,
+		  struct fwnode_handle *fwnode);
 int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 			  struct fwnode_handle *fwnode);
 int sdw_master_device_del(struct sdw_bus *bus);
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 6fba55898cf0..ac036223046f 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -84,6 +84,12 @@ static int sdw_drv_probe(struct device *dev)
 	const struct sdw_device_id *id;
 	int ret;
 
+	/*
+	 * fw description is mandatory to bind
+	 */
+	if (!dev->fwnode || !dev->of_node)
+		return -ENODEV;
+
 	id = sdw_get_device_id(slave, drv);
 	if (!id)
 		return -ENODEV;
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 0839445ee07b..24a16ebf9ae2 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -20,8 +20,8 @@ struct device_type sdw_slave_type = {
 	.uevent =	sdw_slave_uevent,
 };
 
-static int sdw_slave_add(struct sdw_bus *bus,
-			 struct sdw_slave_id *id, struct fwnode_handle *fwnode)
+int sdw_slave_add(struct sdw_bus *bus,
+		  struct sdw_slave_id *id, struct fwnode_handle *fwnode)
 {
 	struct sdw_slave *slave;
 	int ret;
-- 
2.21.0

