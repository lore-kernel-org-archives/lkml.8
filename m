Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950EAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE8D206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0W/A4TI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgFEVTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgFEVTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:19:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F8C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:19:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so4185489plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/DT8KaqdvTHpY2pdkwC/qpDtPEs0oqYy0DlmoYI6060=;
        b=D0W/A4TIxeMbHVU7mcGxqr9tmsLnd9fwjOIfXwwAiqDbXhQKlm82IeqQVIAKcBM3aj
         8CxseH4wDPHoMGwc86GrKxUEwfF6dr8VVVl0l1GusyAqeJqTF8M+jHpLpdsloiYHIxDo
         EXkgKHYsBGFvSZ3EQw+G1l47XUh7kJgE58QFvsGHY+uQv7EiE/9enrDAuDqIXiAUbOfS
         1J7Y7ryh6pXGHV4AagqtrHQAopBw4F3zmOa6GK3H0+DLuJMUHiMMsn+Z97CmBnEbs/sc
         7JDKhCu/EmG1hQkwct5nYnEFnw2fBNsOSPgXfqG4BaFYmx9BkUuKQqmcQe5AJuHg6aNd
         dGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/DT8KaqdvTHpY2pdkwC/qpDtPEs0oqYy0DlmoYI6060=;
        b=csZIihJIdJvnbka8Aqw6Jw4a3nugP/WEYmaKWwsJHtdTtDPKTbSGbU6T6tmgW8wvUZ
         r3XltdPqD2eg79LCOg45SYAlY9rCdn3fts3IGgfqQSS+IoZxJ+eLwlutKMZqLvNPb46Q
         9jbbjeL/riPsrI51QtO+T/vzQRvydTSAL5n88wfAi8O/1B57IoZ7OaE3ZU6tRMv9Rt2p
         dHOsBpbbu0v8lAcetcGaYnKeykZ/HCdpZYdp1da5y2d/6c/lCdXq8DzV7SlbNSS+4DS8
         pKLchmkad6CcASjFqMT4clSbZlh03Y0XIfH6IBkleRB4JK2YoRp7Htn8asR5N+zG50a3
         jNYQ==
X-Gm-Message-State: AOAM5317XX/d2ZVUHm45lcn1Kb6h67f4Vl0IqiIBCyXHYpYyuLwwYG5D
        iEavomV/NW6lYC7oF69c8+85LFG8skE=
X-Google-Smtp-Source: ABdhPJzJZXzNp787muuA7EB3j0sZ07R24oGZ7ooutcPi22eAqHT6ton+M88dLERu90HuIw9ZOFDMgA==
X-Received: by 2002:a17:90b:19ce:: with SMTP id nm14mr4929980pjb.23.1591391971562;
        Fri, 05 Jun 2020 14:19:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id k126sm472302pfd.129.2020.06.05.14.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 14:19:30 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH] slimbus: core: Set fwnode for a device when setting of_node
Date:   Fri,  5 Jun 2020 21:19:25 +0000
Message-Id: <20200605211925.87873-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

When setting the of_node for a newly created device, also set the
fwnode. This allows fw_devlink to work for slimbus devices.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/slimbus/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 526e3215d8fe..44228a5b246d 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -163,8 +163,10 @@ static int slim_add_device(struct slim_controller *ctrl,
 	INIT_LIST_HEAD(&sbdev->stream_list);
 	spin_lock_init(&sbdev->stream_list_lock);
 
-	if (node)
+	if (node) {
 		sbdev->dev.of_node = of_node_get(node);
+		sbdev->dev.fwnode = of_fwnode_handle(node);
+	}
 
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
-- 
2.17.1

