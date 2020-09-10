Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA97C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BB820BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="jKjG0D48";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IsiCXqAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgIJCSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:18:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36745 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730699AbgIJCMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:12:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 37C485C00DB;
        Wed,  9 Sep 2020 22:11:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Sep 2020 22:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=7OJIUNnPof5fmS9W9OyrAXXYxm
        fDhwOyhBDHLSmMoF4=; b=jKjG0D483XpbWMCqQqhQ62Pws1McbdPwT4Y13IHGT8
        8t97bt99NNL+Kyttrc1f17CLRmxsuKZR1c3PV1E8Drv9zUkGNUoSq/uzMYVoKyEu
        16TuYcXoLhfQDBKWuU5vqXjlN9k5wTAdfbq8FMIxX3nYslzaaW9ZeNbhZPM+iASg
        ZvS5Byb5ToxOT2iM3Tl1zRiollkyxoj3avqIYE857+u405omFJqMpuysQBFgHlb0
        GM5repbCpLBk4XNUHILwY9DJR0Di/mEUDcMRUxUZHLAGvE8JVigwc3bhVNkHmmMx
        FL0qU9eD8sJJ2y56NAUB1NtgUSVwm4vMhPujQwi2Kehw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7OJIUNnPof5fmS9W9
        OyrAXXYxmfDhwOyhBDHLSmMoF4=; b=IsiCXqALfyi3KjRzWkdG++rytARB47IZ7
        +4kW2+1T9GhFEVIIoFRebiKTLIV2rhBxwTqNomu34vRkHRXJfC44u/eUMbifUdMe
        lCKoQ92Apepcge6RrLLv3mchSs47euk1iSIiTUYo5RHVG2qgfelrqmrTpfSkGf4N
        0uNESTQ8Rx4mUU78eNLA4U6p4X6iNihipmWzZPaq95gZKPQrzucj9EL/faznhF72
        HGGPxtKfC0hiCmX5ozRehFQc+7bjREvf40/ifTZB1dN7qcFg6onvX44GeSf/QPZb
        Xvp6ZWAr6+iQTzlNaVnk1rcchPoNqbHfAh7C62rgC2cBzGNTDKW6A==
X-ME-Sender: <xms:V4tZX623OP3Wqg1ROXmmU5Rhmoo81SNwofosRv6V8qsMbqQZaZNwYA>
    <xme:V4tZX9G-nWfTflmTH8Ac6EqPaEs6slpJBUVTi8JRGBDlObaRzDgKPp4qjvtk80N0r
    hjJyEOQFFDrqKrlBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepkefhieffjeevfeevhedtieeihfefvdejle
    dvvddthefftedujeethfeuueelfedtnecukfhppedugedrvddruddtledrkeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifse
    grjhdrihgurdgruh
X-ME-Proxy: <xmx:V4tZXy5dpvVK5nECQbpXcFTv_EYNaeBY1S2dj1DWB7ftqVJNvaki_A>
    <xmx:V4tZX71s2B5VR9pXDGiubUzkNUIZZWgEPouPP9GXfx4XHVB9lYufNA>
    <xmx:V4tZX9HeV_TBLKKV32f6jfhXX8jAnM-YCCDPPBnvXYHCfmyF7Bt9xw>
    <xmx:WItZX7NyF5vWI4yXswxvVqB5VkxoCPLUB5JQ3O_3ln1ED0ZgqTTZXQ>
Received: from mistburn.lan (ppp14-2-109-85.adl-apt-pir-bras32.tpg.internode.on.net [14.2.109.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id 093AB328005D;
        Wed,  9 Sep 2020 22:11:33 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-hwmon@vger.kernel.org
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (pmbus) Expose PEC debugfs attribute
Date:   Thu, 10 Sep 2020 11:41:06 +0930
Message-Id: <20200910021106.2958382-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable runtime debug control of whether the PEC byte is exchanged with
the PMBus device.

Some manufacturers have asked for the PEC to be disabled as part of
debugging driver communication issues with devices.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/hwmon/pmbus/pmbus_core.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 44535add3a4a..9e7d5f7f0cd0 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2346,6 +2346,42 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_status,
 			 NULL, "0x%04llx\n");
 
+static int pmbus_debugfs_get_pec(void *data, u64 *val)
+{
+	struct i2c_client *client = data;
+
+	*val = !!(client->flags & I2C_CLIENT_PEC);
+
+	return 0;
+}
+
+static int pmbus_debugfs_set_pec(void *data, u64 val)
+{
+	int rc;
+	struct i2c_client *client = data;
+
+	if (!val) {
+		client->flags &= ~I2C_CLIENT_PEC;
+		return 0;
+	}
+
+	if (val != 1)
+		return -EINVAL;
+
+	rc = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
+	if (rc < 0)
+		return rc;
+
+	if (!(rc & PB_CAPABILITY_ERROR_CHECK))
+		return -EOPNOTSUPP;
+
+	client->flags |= I2C_CLIENT_PEC;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_pec, pmbus_debugfs_get_pec,
+			 pmbus_debugfs_set_pec, "%1llu\n");
+
 static int pmbus_init_debugfs(struct i2c_client *client,
 			      struct pmbus_data *data)
 {
@@ -2374,6 +2410,9 @@ static int pmbus_init_debugfs(struct i2c_client *client,
 	if (!entries)
 		return -ENOMEM;
 
+	debugfs_create_file("pec", 0664, data->debugfs, client,
+			    &pmbus_debugfs_ops_pec);
+
 	for (i = 0; i < data->info->pages; ++i) {
 		/* Check accessibility of status register if it's not page 0 */
 		if (!i || pmbus_check_status_register(client, i)) {
-- 
2.25.1

