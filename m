Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884BAC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DAC206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBBGEhSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbgDMVHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388760AbgDMVG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:06:57 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5044BC0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:06:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y84so9785677pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HSxjufempazlx5EL6Oqz0WzuegPQO1JBIjf6VYFe9Lg=;
        b=eBBGEhSwmUtbM/28R1jPRtSlGoaZjrh5Iw30aQEybCW1f1TsI2w2+Qy0VWPC2m97ZO
         JMok85CQUNXRhH+16KHF/vM6RGhmirRuYun9Moz78tVUxpMP6OxQrbRd2btFZrBIXtre
         xqlCj9t3+qlmQzeYstPxszQwbROImI5htMdCYhSNzR24TbaK8Bokor57AJm0sv1ChxMv
         a9XyUjj6+JoGQvkzN3FWOYrPaWYhWptZreUxY1axoCVDImtsibhIxuG6eEkNUn7XUVLC
         s4dJ7/i/7OxBLcqYZtmApixSQe85DAB0mzV5Cu2Fm3c/c/+5FFJcij5Ja/nYnzL9kJKG
         QJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HSxjufempazlx5EL6Oqz0WzuegPQO1JBIjf6VYFe9Lg=;
        b=NSBQ6QmdyI0TIBA9wffSHJvLXv1DhL4UqOtLznR3lcLGce6bMh8YExa3QaSaqALLud
         70eIWwl+us+El69k/Rmp9K15qKrClw7u7xFZ0HaGKYjWN4/JK0b9hFTV6mO8glET9bLm
         1lXsn6fo8aOx7Rz5VxhKyBIZgDx8WsNWOG6vYJagPFxouk7kcWlY8Khtkz396vxx+C3+
         dG/2MPBn1gVbmp8+F4vydTrY7U7lTmQQStYmn+x0jNzzqz9LcgTw9fq5VpvXHOeAYgta
         HO0gjoqkNwRnMHMzDrl+eCSEXWaGC8oGwAbiK9uIRrNlqpLSYr3Vhm0b2chtkPQW7yep
         gLsg==
X-Gm-Message-State: AGi0PuYpBTXHWurOLDRPXa1fFtAXlQQNxG55sJfzACAJ5ryU2sgGSoNj
        Lf1K787O7kvaM7o7F4+qgoqJV0ZKLjfhq0MIbSWSONPBq14AQw1AjjaQ2X2Zqi6vrLUqO+OAytt
        yAsyV45PWZoH5P5WWbOiuaWjamxYHbatueDnYT4nP6xcPBXA34250KbdQ2AeMxJ3R0WlA2aXq17
        luEIj+zadjohH4E24=
X-Google-Smtp-Source: APiQypLj2wxTeXWWD/akXvUHZhHVqCJxN8UAQy1avGH0RwTxLR0YBDSDF0srfJAh7ctMWC0hfTGONqJkcAD2wa1lC0/KAg==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr21257991pjn.178.1586812016579;
 Mon, 13 Apr 2020 14:06:56 -0700 (PDT)
Date:   Mon, 13 Apr 2020 14:06:44 -0700
In-Reply-To: <20200413210644.201801-1-matthewgarrett@google.com>
Message-Id: <20200413210644.201801-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20200413210644.201801-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 3/3] thermal/int340x_thermal: Don't require IDSP to exist
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com,
        nisha.aram@intel.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

The IDSP method doesn't appear to exist on the most recent Intel platforms:
instead, the IDSP data is included in the GDDV blob. Since we probably don't
want to decompress and parse that in-kernel, just allow any UUID to be
written if IDSP is missing.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index f36e3e9d246ea..bece011451e17 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -96,6 +96,9 @@ static ssize_t available_uuids_show(struct device *dev,
 	int i;
 	int length = 0;
 
+	if (!priv->uuid_bitmap)
+		return sprintf(buf, "UNKNOWN\n");
+
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
 		if (priv->uuid_bitmap & (1 << i))
 			if (PAGE_SIZE - length > 0)
@@ -113,11 +116,11 @@ static ssize_t current_uuid_show(struct device *dev,
 {
 	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
 
-	if (priv->uuid_bitmap & (1 << priv->current_uuid_index))
-		return sprintf(buf, "%s\n",
-			       int3400_thermal_uuids[priv->current_uuid_index]);
-	else
+	if (priv->current_uuid_index == -1)
 		return sprintf(buf, "INVALID\n");
+
+	return sprintf(buf, "%s\n",
+		       int3400_thermal_uuids[priv->current_uuid_index]);
 }
 
 static ssize_t current_uuid_store(struct device *dev,
@@ -128,9 +131,16 @@ static ssize_t current_uuid_store(struct device *dev,
 	int i;
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
-		if ((priv->uuid_bitmap & (1 << i)) &&
-		    !(strncmp(buf, int3400_thermal_uuids[i],
-			      sizeof(int3400_thermal_uuids[i]) - 1))) {
+		if (!strncmp(buf, int3400_thermal_uuids[i],
+			     sizeof(int3400_thermal_uuids[i]) - 1)) {
+			/*
+			 * If we have a list of supported UUIDs, make sure
+			 * this one is supported.
+			 */
+			if (priv->uuid_bitmap &&
+			    !(priv->uuid_bitmap & (1 << i)))
+				return -EINVAL;
+
 			priv->current_uuid_index = i;
 			return count;
 		}
@@ -462,9 +472,13 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	priv->adev = adev;
 
 	result = int3400_thermal_get_uuids(priv);
-	if (result)
+
+	/* Missing IDSP isn't fatal */
+	if (result && result != -ENODEV)
 		goto free_priv;
 
+	priv->current_uuid_index = -1;
+
 	result = acpi_parse_art(priv->adev->handle, &priv->art_count,
 				&priv->arts, true);
 	if (result)
-- 
2.26.0.110.g2183baf09c-goog

