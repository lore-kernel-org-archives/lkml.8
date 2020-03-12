Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C11C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DE5206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6LjyIQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgCLKBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:01:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54350 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgCLKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:01:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so5355547wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37Lf+bsQVN2R82jF31L64+HZkWkQ8O4yUOQJhHVjoWQ=;
        b=P6LjyIQphSa///CYVi66m3AtkFhIVjNwaO+ppt664/mHCIk8BrVUFecR7dtX1OAbxM
         j9tCmCw/UkRia/Bh5gFwH68MCf07hCYA71ytUlGL+XVYdtUyS8Vr3EVeMaNJrY+1fqfC
         DqR1p0crSsax67xGqu0pn1++v4VBue8+FQujM2v4CV6JUbWsnQkALOZm52M9J/8EGOh4
         fGn9m/wSeNQMhf5ippEai1zIqG9LDf6FOS+y11BQ9Ajv78IsvXRgRGR5iEJfGvf26ugF
         cwjRdf90NRY3O/3JZfQ4gknFVTjXS4GS0BABIV9YylqWRZmymStXzE4wJHaUZ8uGgsNE
         kihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37Lf+bsQVN2R82jF31L64+HZkWkQ8O4yUOQJhHVjoWQ=;
        b=aobObUx1BJm/4AeHdGe9sY5JMsHpavzpp9c+NLc9myH4Ly/vg8pjsKUIaDoc7OQUy4
         /FQYM8EElzUL/O0YwMjQa1pL7CODJxKk4XJNLtsOMJly/5u1k6Vp1VJ+2j9lajIHov+w
         /sRdKo1gAXnwwYoYdkrpEoHpiXL62TkY0+DQHTlTWLCa60uhcZTt4Q4ekw+7PLX/a1Er
         Gl8iMXPaYnJfSwuQKYM6MD1VekGHN4qEbPHvt8zTYrhfBF8DEk3RqpUVgAZuGc+u5zvq
         nFVevff5OBd6l/n8WEgmAngzAhX8vEFtfsTEN7SSC73/WCuIZzJwMZFh+2V7C3CvozQ5
         I8Dw==
X-Gm-Message-State: ANhLgQ1+oVkR27LnC4cPKIOb4WCntxLy+TcjPpeoYIKRcp8O1HO/aivE
        dm/dAHzQQomS9Te9nxe8dw1B2g==
X-Google-Smtp-Source: ADFU+vusgtSoMtov30GQT3tj+aY6RnUcVmcqV8+vs/QPI0Klxsxj1Dzh9dy/w/xeOJ9E0j8rBotkyQ==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr3985968wmc.18.1584007273297;
        Thu, 12 Mar 2020 03:01:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m11sm27568999wrn.92.2020.03.12.03.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:01:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: stream: use sdw_write instead of update
Date:   Thu, 12 Mar 2020 10:01:05 +0000
Message-Id: <20200312100105.5293-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in using update for registers with write mask
as 0xFF, this adds unecessary traffic on the bus.
Just use sdw_write directly.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 00348d1fc606..1b43d03c79ea 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -313,9 +313,9 @@ static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
 	 * it is safe to reset this register
 	 */
 	if (en)
-		ret = sdw_update(s_rt->slave, addr, 0xFF, p_rt->ch_mask);
+		ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
 	else
-		ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
+		ret = sdw_write(s_rt->slave, addr, 0x0);
 
 	if (ret < 0)
 		dev_err(&s_rt->slave->dev,
@@ -464,10 +464,9 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 		addr = SDW_DPN_PREPARECTRL(p_rt->num);
 
 		if (prep)
-			ret = sdw_update(s_rt->slave, addr,
-					 0xFF, p_rt->ch_mask);
+			ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
 		else
-			ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
+			ret = sdw_write(s_rt->slave, addr, 0x0);
 
 		if (ret < 0) {
 			dev_err(&s_rt->slave->dev,
-- 
2.21.0

