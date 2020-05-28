Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F04C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F382088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Mohgw2y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405791AbgE1SU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:20:59 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49234 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405733AbgE1SUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:20:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49XwxL154zz9vC7g
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MuhEvbije3co for <linux-kernel@vger.kernel.org>;
        Thu, 28 May 2020 13:20:54 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49XwxK6XDPz9vBtd
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:20:53 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49XwxK6XDPz9vBtd
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49XwxK6XDPz9vBtd
Received: by mail-io1-f72.google.com with SMTP id w4so19991533iol.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z0PvIbGDn0Z17RYgI3zBJ0aJdEFVtvocF0jkm247rpg=;
        b=Mohgw2y48p+edoFuDPTzW7a8j/cRZLBMiAO8TEnkzQI7jCQjkiJhnSRUVG952Twn+j
         tG3NSymdVCNKe+CJj3GS4lnZ4rR62sT9lpiilIWUBgiFtJFqf5HbK2pqZvUxj9RgGK3E
         z/ye9hnqt6X95fgEb6lc5ITDvm2QAK2olG8hOL9cBCrv1TTKYTaLIpFzDMbFH7Pw53Rh
         z3EYRsgj/4n1Ch8sZDHdfbak7/O44D9BkLrprOpnU+vCvI0CXVh3d3KQb/RITdWbzljR
         tqnqGgvOuxJvxqweGWlOE/xwIf2cImibd6+wd28+Azq/qpNOzJJ37+QnYDsJttqyFNlr
         69XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z0PvIbGDn0Z17RYgI3zBJ0aJdEFVtvocF0jkm247rpg=;
        b=PbE9rVig+T5xdrjYulb6jywAbL/IUJLd3+V5sQRgailW9VzkuXWW1++wlOTB6xJCke
         oFZPHMU7DEKBgqRTJtLYNP+biPyHNxACdoCbskcyTQsNB8JEAHpb8LPpFk4bEo6Okyn3
         tiPg7ZVAh5muN7oJ/9oAEJtuHC6Id1V6Z8zDwuZCApZVkrDvBsq3D6dOj7tGHI2Paik6
         yssWLH0n1ZFgwNY8acaoZsxzVPV37hIiLoUnnAmAx87mYfOuoqV6t2okRcPKi9x/pG6H
         DOzyjTetzGByov5iPvXepyN4KwdtDV7HOoX1zEIFeM/6Kcsk3HLSXAttOZA4onUW92AU
         lIeA==
X-Gm-Message-State: AOAM530QMm8+ZHy+eqOvWWrnYnJn5RVVQFMvomTIkDFkf6nkVMqXNjbT
        p2i0VrA5dZf2OM6e0TCgIFCZpUM7ThRcjaLKUOdv7KsgkQco7qyuLpBTVU6YrCUHZY8a7PLn8NI
        Mvi2yRlVsv1DS+jUTyRlYd5Rg2ZnY
X-Received: by 2002:a02:93a1:: with SMTP id z30mr3660277jah.25.1590690053169;
        Thu, 28 May 2020 11:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/jnO9EhpMdxptmG1zZKzrF5o5zH+5CTWhvnVk4DfYgYLm5zOPh3QA1ohplbxSUObSl5kaOg==
X-Received: by 2002:a02:93a1:: with SMTP id z30mr3660245jah.25.1590690052738;
        Thu, 28 May 2020 11:20:52 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id f66sm3628149ilf.63.2020.05.28.11.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:20:52 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: Fix several reference count leaks.
Date:   Thu, 28 May 2020 13:20:46 -0500
Message-Id: <20200528182046.845-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/cpuidle/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index cdeedbf02646..55107565b319 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -515,7 +515,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 		ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle,
 					   &kdev->kobj, "state%d", i);
 		if (ret) {
-			kfree(kobj);
+			kobject_put(&kobj->kobj);
 			goto error_state;
 		}
 		cpuidle_add_s2idle_attr_group(kobj);
@@ -646,7 +646,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 	ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
 				   &kdev->kobj, "driver");
 	if (ret) {
-		kfree(kdrv);
+		kobject_put(&kdrv->kobj);
 		return ret;
 	}
 
@@ -740,7 +740,7 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 	error = kobject_init_and_add(&kdev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
 				   "cpuidle");
 	if (error) {
-		kfree(kdev);
+		kobject_put(&kdev->kobj);
 		return error;
 	}
 
-- 
2.17.1

