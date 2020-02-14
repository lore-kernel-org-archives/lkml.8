Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B00DC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E266B2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyTx6MYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgBNX2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:28:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40275 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgBNX2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:28:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so12508670wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8DAOKrUKnSTSUtrxbYUAUVprhFSWYyQ0hs2kBQzRq1M=;
        b=jyTx6MYVtdp47uQWK/BDNJE9gtuxURKjUGLEDKO0xucWGmsyzxT2B+Kr8yeQBVi0GR
         HUXSVmPY3ihugNkWw7GP9pHzbrqw5eG6rCkVxCJqtIRpj1Vy1rOb/RlS5RognJz4OOQI
         lcSb5MpFDclf0LTFre8uFWRNoGbiRdDlhTlSbsoXgLuML4tXl4PCmqoco0C4qNcgptY8
         OgZj29LhnAyVOTHMlfP+uPO/6sqDG+xSFbY4Iyw5JsraY1EkkzHglYxDK9oquSL8MMRF
         44+hA5JMCFPgxf9i0ql+NICQ/7NQjMVLFDuLz005ba3nXIr+AufpJfkSiLfm73oBNZYH
         /9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8DAOKrUKnSTSUtrxbYUAUVprhFSWYyQ0hs2kBQzRq1M=;
        b=aaD6f6ImPQY7IEVgtRYuFcD9sD9Xrw9XtWTs+Uc2M7r5ex/xr8qvUxyp6ABhMERK6F
         7IlnVbRkqAG0ek6/k0uvnI8NwAY5dB5/czzOXWZAfOkALDNEwuDF3YwO8r0jZjXGbpMA
         rVXiMRC8dmQ21DEfdbUivzWFptJH04F3YKEwbLd53CmFvdn4hEJLJzZqUwl8Wng7BWPC
         +7ZeBswe5ZRx6wIDL7W7cAYUpmVjyaH/X0/NnnqW93u98jltIpKO6irHZvCRlhilBvV2
         NwRqkDsgGOBwQHWFHBhPpC9M1K3qbWKG81FtJNxu043ts3iO7snayl6D8xyd1dKS6Y/v
         g8UA==
X-Gm-Message-State: APjAAAUGW93T5A+cBt00DU3zH9djTT6cL7d5k+SQ6n9isNqvFyJWIUCj
        RFT4zkMbEgFPlrY4uTJ2oSXyRz2O
X-Google-Smtp-Source: APXvYqwG4e23kEIuy/Z66nvJlxoeGsm3XG/rC4+MMYA2kxlfzzaagrfuYqdeTH7BBiX8bp00kprWIQ==
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr6904153wmc.188.1581722505397;
        Fri, 14 Feb 2020 15:21:45 -0800 (PST)
Received: from s-8d3a30ba.on.site.uni-stuttgart.de ([2001:7c7:212a:d400:f15d:b157:ec2d:b5e4])
        by smtp.gmail.com with ESMTPSA id n3sm8833012wrs.8.2020.02.14.15.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 15:21:44 -0800 (PST)
Date:   Sat, 15 Feb 2020 00:21:43 +0100
From:   Sandesh Kenjana Ashok <sandeshkenjanaashok@gmail.com>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: fsl-dpaa2: ethsw: ethsw.c: Fix line over 80
 characters
Message-ID: <20200214232143.GA20675@SandeshPC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue found by checkpatch.

Signed-off-by: Sandesh Kenjana Ashok <sandeshkenjanaashok@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 39c0fe347188..676d1ad1b50d 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1492,7 +1492,8 @@ static void ethsw_unregister_notifier(struct device *dev)
 	err = unregister_switchdev_blocking_notifier(nb);
 	if (err)
 		dev_err(dev,
-			"Failed to unregister switchdev blocking notifier (%d)\n", err);
+			"Failed to unregister switchdev blocking notifier (%d)\n",
+			err);
 
 	err = unregister_switchdev_notifier(&ethsw->port_switchdev_nb);
 	if (err)
-- 
2.17.1

