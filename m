Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E20C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EC6208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrqQLqk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgH1Ozc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:55:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59932 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726322AbgH1Oz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598626527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=dY8soZQxplpIr5t025W/ct4MI2YimaV2y2Pnl5LKJQQ=;
        b=WrqQLqk8kwiCebrVl1JnQmdtRNoHFAbvjSSzhUCh8nZCi1iXxUhafC7rvcvTNlTXhntA2c
        J/r7UnfBOfaiD6/35hjrbQi13oKjf7wPkoh5S6Nq67dc2i4bCamDI09yDXzFtt9SSDhAMK
        iwXSLn3xNMMB03mepGx1VR8KiElzzxE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-25-A4znLNYyWhwQ1xSwK4Q-1; Fri, 28 Aug 2020 10:55:25 -0400
X-MC-Unique: 25-A4znLNYyWhwQ1xSwK4Q-1
Received: by mail-qk1-f198.google.com with SMTP id 1so1124166qki.22
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dY8soZQxplpIr5t025W/ct4MI2YimaV2y2Pnl5LKJQQ=;
        b=Lrl8BU3tTyqL/+JfuYMYPKenn1aLja8mEsZp5iQUEkV7ApYH/z+gwoWdUQ0gcI6CAO
         HWpFT6jLdZsDDTD3YFheP8dHU0YThStlUAI3akLpPuMa9/8AmUAZOSgN+HKxq5JEYiR5
         T6MVm2y610MVdNCkRpRD7gc3ZPr6MXe1q3cVZio4usa8f+0Ikf7LL0L+001qZhTZ+8LW
         lC8vwJ093pqHScCgSiOaOhaXA3MufJ9i/HQUMvbTHQs1TJw2YxmgYGkz+BT2JY9qphw+
         BbIF0xWKfm+XhvGryJlGDmcFx/gXd4RkfL9UE4ErjYIVN0W740dPto8wZt20G/fRtdEY
         RXmQ==
X-Gm-Message-State: AOAM5305NzHsg8zdsYE/04hVCN3v4F1iHoiWcnWXAmUeHlD7yla3FHQC
        rmLT+FuCgGW1UkN/qBwvJ/Htai0wAnNk4w9iYGSzGqPsy981WYd5eCQK6tmGhv+nIIVkHQCVWVu
        1P66maszoQoSDPoo0yKUDKryg
X-Received: by 2002:ac8:3836:: with SMTP id q51mr1875667qtb.41.1598626525326;
        Fri, 28 Aug 2020 07:55:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTyv6Dcvf7JIMnb6Tl0QbVqispJtEs2IxGCkvKAa5tM3L596s/Au8e2J9bLRlyfSveblr7UA==
X-Received: by 2002:ac8:3836:: with SMTP id q51mr1875649qtb.41.1598626525042;
        Fri, 28 Aug 2020 07:55:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w36sm1206414qtc.48.2020.08.28.07.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:55:24 -0700 (PDT)
From:   trix@redhat.com
To:     corbet@lwn.net, mchehab@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: ov7670: check status of ov7670_read
Date:   Fri, 28 Aug 2020 07:55:18 -0700
Message-Id: <20200828145518.26324-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this representative problem

drivers/media/i2c/ov7670.c:1463:9: warning: Assigned
  value is garbage or undefined
        *value = gain;
               ^ ~~~~

gain is set by a successful call to ov7670_read()

So check that ov7670_read() is successful.

The remaining static analysis problems are false positives.
There appears to be a limitation with checking the
aggregated returns.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/i2c/ov7670.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index b42b289faaef..001d4b09db72 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -929,6 +929,8 @@ static int ov7670_set_hw(struct v4l2_subdev *sd, int hstart, int hstop,
 	ret =  ov7670_write(sd, REG_HSTART, (hstart >> 3) & 0xff);
 	ret += ov7670_write(sd, REG_HSTOP, (hstop >> 3) & 0xff);
 	ret += ov7670_read(sd, REG_HREF, &v);
+	if (ret)
+		return ret;
 	v = (v & 0xc0) | ((hstop & 0x7) << 3) | (hstart & 0x7);
 	msleep(10);
 	ret += ov7670_write(sd, REG_HREF, v);
@@ -938,6 +940,8 @@ static int ov7670_set_hw(struct v4l2_subdev *sd, int hstart, int hstop,
 	ret += ov7670_write(sd, REG_VSTART, (vstart >> 2) & 0xff);
 	ret += ov7670_write(sd, REG_VSTOP, (vstop >> 2) & 0xff);
 	ret += ov7670_read(sd, REG_VREF, &v);
+	if (ret)
+		return ret;
 	v = (v & 0xf0) | ((vstop & 0x3) << 2) | (vstart & 0x3);
 	msleep(10);
 	ret += ov7670_write(sd, REG_VREF, v);
@@ -1460,6 +1464,8 @@ static int ov7670_g_gain(struct v4l2_subdev *sd, __s32 *value)
 	unsigned char gain;
 
 	ret = ov7670_read(sd, REG_GAIN, &gain);
+	if (ret)
+		return ret;
 	*value = gain;
 	return ret;
 }
@@ -1470,11 +1476,14 @@ static int ov7670_s_gain(struct v4l2_subdev *sd, int value)
 	unsigned char com8;
 
 	ret = ov7670_write(sd, REG_GAIN, value & 0xff);
+	if (ret)
+		return ret;
 	/* Have to turn off AGC as well */
-	if (ret == 0) {
-		ret = ov7670_read(sd, REG_COM8, &com8);
-		ret = ov7670_write(sd, REG_COM8, com8 & ~COM8_AGC);
-	}
+	ret = ov7670_read(sd, REG_COM8, &com8);
+	if (ret)
+		return ret;
+	ret = ov7670_write(sd, REG_COM8, com8 & ~COM8_AGC);
+
 	return ret;
 }
 
-- 
2.18.1

