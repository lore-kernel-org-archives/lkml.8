Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C59C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA8A206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+5EH2tP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgDPU7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726474AbgDPU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:58:49 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B6BC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 13:58:48 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id k28so18317795qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=HqZDwf9Q7C67M/mDRl+pQv0rP1w37UTSZ4kbAHBt66Q=;
        b=Q+5EH2tPZsSLAErwg1IspceG+J61zlJdooxXpvm+MCgII/FqHm3TK71amylmcYc81E
         gAFWt3RwNcD9ANYF1lGGDwPFLDvNU8I05y+c32s+MZMppFovDfk0zt0q3onqFxPrGrWh
         8oWvRoMmHfgijEgT8fP911VtFZdtK809EKhcrWRQ56cbCjDHgzeNPCI6/eF05YSTgraa
         1TlZLlAcr1NHnKy9mUuL/AvUjBqWjBE83uqEjNjYMjc9/4jdiudKup/qav+Dk3uQE5FJ
         R3fMgfXtI0ecmS/1Gq47TZOj11vFyb6Q8B/JkAAXV935Ivibwxm3tnmKAzkvdgiG9P/i
         rJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=HqZDwf9Q7C67M/mDRl+pQv0rP1w37UTSZ4kbAHBt66Q=;
        b=N4u6Kj1OIAPMLacHrkQSAJ9hPdgyWFQfzvcitNcuQ97a8xgCE0fXyCytHVkI04ifJ/
         6cEpFOlBNxZRlQgv8CTz4RcL5aiJ8xTH9LU2w+p/E/ApN/m5eP92oRj8pqRf+9vj5P7t
         PW1CJKHETen6DLft54cX9GnunEtJ/6qQWYrwYSntBjR57J7DDKTG3x/pbJ5wbVlMHibB
         IVCDekMTuydtRvSHwHNA9GDNE7dkPQecPB7oefZxEK6AiHb+WgxbffUGl2SHnbTZZDnC
         yQDNVuJYA0Jn7aqUiNHyzfvYTGJrOHwKDt8+zbfVbCkAEZ047BWHVW+96QW0aedl/hli
         8sCA==
X-Gm-Message-State: AGi0Pua9xT8Cm9YfYqtcy9+gIMEndeU6F9gj90dDjcU+cZTMr4pZwKhO
        WuWvFIZVcYOLNb9c1YuG+yEvEkgqNf1gy6k=
X-Google-Smtp-Source: APiQypI6kmzfdqdUBhHY3FyAluii9jxd30OtvsbuQwt35VUya6k56Nxe6Byxot+OqIm2luH3L29mv4Kf+gFk+aQ=
X-Received: by 2002:a05:620a:7e8:: with SMTP id k8mr22217820qkk.183.1587070727685;
 Thu, 16 Apr 2020 13:58:47 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:58:38 -0700
In-Reply-To: <c48a3baef99f3d74e7904498c4054221ec384b36.camel@suse.de>
Message-Id: <20200416205838.161894-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v1] of: property: Don't retry device_link_add() upon failure
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When of_link_to_phandle() was implemented initially, there was no way to
tell if device_link_add() was failing because the supplier device hasn't
been parsed yet, hasn't been added yet, the links were creating a cycle,
etc. Some of these were transient errors that'd go away at a later
point.

However, with the current set of improved checks, if device_link_add()
fails, it'll only be for permanent errors like cycles or out-of-memory
errors.

Also, with the addition of DL_FLAG_SYNC_STATE_ONLY flag [1] to device
links, all the valid dependency cycles due to "proxy" device links
(needed for correctness of sync_state() device callback) will never fail
device_link_add() due to cycles.

So, continuing to retry failing device links (by returning -EAGAIN) is
no longer useful. At worst, it prevents platforms from setting
fw_devlink=on (or better) because it prevents proper boot up. So, let's
not do that anymore.

[1] - https://lore.kernel.org/lkml/20191028220027.251605-1-saravanak@google.com/
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 252e4f600155..ee1bc267f975 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1074,7 +1074,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 		return -EAGAIN;
 	}
 	if (!device_link_add(dev, sup_dev, dl_flags))
-		ret = -EAGAIN;
+		ret = -EINVAL;
 	put_device(sup_dev);
 	return ret;
 }
-- 
2.26.1.301.g55bc3eb7cb9-goog

