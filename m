Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C929C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007A9207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPHYleUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH2ABb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgH2ABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 20:01:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92928C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 17:01:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c15so391750plq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 17:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WP5DuUAAG+qcaTHe2FLLmzgJobs8Ub99cEAnEEBXuUY=;
        b=MPHYleUx8NXhjcAnguiZgLc8Hc6XDR5fa10bzuEXqMIdBJH8bS89r+x1MKa7c1wUpU
         ZnY2HhQkn5h2hHTqrzPsavaBqNe6hyLnIppKHgqzjbUlfw9oKloXIEnC1DK9+uaK9dyZ
         +c1Ns+MjuYF05yj8hWwZpfYLz0fMbpkX2emLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WP5DuUAAG+qcaTHe2FLLmzgJobs8Ub99cEAnEEBXuUY=;
        b=KIuXNqWS+Lp0pgcC1vF5rQBa/8IePgcXLQPRFo9rXGIZc2HT+2XseAM4NL5ERYt8M8
         GvnJsE5nSBxqLjkLaewOg11GThu2POVgLjUplAOwYEgNLPUb/QxKTrVv79fUtCFFkG31
         fRzzloGyeavZ65BkBpcgLCPAH4SoFtSrNal1HI4YtrARH0hoyQqq9LH+qmvi/mt+e2PT
         XS6u86LbP9EzDxGOrybN9mIrIJruPV/TYkQGe+61wuDRdiCnGDplgqwmG/gpzhDeaShS
         3da6hIzFcvCw+0phmhHs6Ih83qyoUKW3dGdAxoLdxavAJbXAd+1VTw6JsrpWWM8JUQLS
         bh0g==
X-Gm-Message-State: AOAM532s6278zS7b9Th2vvA9uJM7/bszs3C+DoVBC9FI0CK6JkjXFh3M
        HWex30YJXnhKiUd5ApqvAJihLA==
X-Google-Smtp-Source: ABdhPJw3m732pYyvoiDOQensvtwKdLaavSAtqO5S1Z1mo48Jk4EyhYZsvMNb5Ibun68EKUGZX/Hsyw==
X-Received: by 2002:a17:90b:40cb:: with SMTP id hj11mr1196294pjb.67.1598659283950;
        Fri, 28 Aug 2020 17:01:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id h5sm611367pfk.0.2020.08.28.17.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 17:01:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: sx9310: Prefer async probe
Date:   Fri, 28 Aug 2020 17:01:18 -0700
Message-Id: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On one board I found that:
  probe of 5-0028 returned 1 after 259547 usecs

There's no reason to block probe of all other devices on our probe.
Turn on async probe.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTE: I haven't done any analysis of the driver to see _why_ it's so
slow, only that I have measured it to be slow.  Someone could
certainly take the time to profile / optimize it, but in any case it
still won't hurt to be async.

This is a very safe flag to turn on since:

1. It's not like our probe order was defined by anything anyway.  When
we probe is at the whim of when our i2c controller probes and that can
be any time.

2. If some other driver needs us then they have to handle the fact
that we might not have probed yet anyway.

3. There may be other drivers probing at the same time as us anyway
because _they_ used async probe.

While I won't say that it's impossible to tickle a bug by turning on
async probe, I would assert that in almost all cases the bug was
already there and needed to be fixed anyway.

ALSO NOTE: measurement / testing was done on the downstream Chrome OS
5.4 tree.  I confirmed compiling on mainline.

 drivers/iio/proximity/sx9310.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index dc2e11b43431..444cafc53408 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1054,6 +1054,7 @@ static struct i2c_driver sx9310_driver = {
 		.acpi_match_table = ACPI_PTR(sx9310_acpi_match),
 		.of_match_table = of_match_ptr(sx9310_of_match),
 		.pm = &sx9310_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= sx9310_probe,
 	.id_table	= sx9310_id,
-- 
2.28.0.402.g5ffc5be6b7-goog

