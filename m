Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC92C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2D42168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+QNAx4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgBMMxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:53:32 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:52325 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbgBMMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:53:32 -0500
Received: by mail-pj1-f53.google.com with SMTP id ep11so2360386pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=o8zEb9mG2Y3P6v3oJOK0eTiooqYu+ji3YHmVQM8w9HI=;
        b=m+QNAx4sJzpz4W5nnyxQwscfbeVrzJj+E2Q6dm5TFnGv65/Nl1JbbvJJ0XJkUW3DY2
         1IYkqf5sGmcx5t096Em1oLdgJGcSOmjbPfwEPoyEDbSH8iLLFLy2WTFryNcKJGaHxRLU
         Ls+pMP8N3uQgz+rRLfnzrpZNhqr+840I+rZxS5o3gy+LEcT3x4+TrDO6TccO4OABr9iO
         qZPWJndGiLGgGjv0HnU1RbFELTKRxwlqi6WrdZD9UsUO+C+mL69wkO0hxrdmaIoVI8AP
         JOW4gV791yTjaMpz8+NfraMJJVkjThu7l5j2qVlLcODuFszQz51STIulkoFLIuM0FwDU
         p1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o8zEb9mG2Y3P6v3oJOK0eTiooqYu+ji3YHmVQM8w9HI=;
        b=PlTH+joGirciuXiJ3c2XrHXara7vNKYAQ+heNs/egP27wFx7Ksqcstw65bOgKF5K1y
         J192GAAEkbyp7s8z48s9b/rmJBBTdxqwkIFdZlthrkIStmJjrishf6oakfDJbl4YMiWV
         ErE1No4waRACE36JaDEqyFjyjQ7P/WGvCk/jI6mDmFjCmCqqXpoAN0oDh05+BB7OvY2T
         YT+lqa9uYUX4OTRRik61RkIqwvu+KbdTPQgY7mBqVyQn+ys31Udy1jZIyCp9Nx7/NZVC
         W84dpN3OHBx09W/LftyPhVePw/mHYFuMgfLHJz2ly7TjU0Ac8MoNSXLm8SCQqo2wAxa4
         flPw==
X-Gm-Message-State: APjAAAW6xnnPW2U/U1o/EGINHBGE4HCaCyMjMvOmMOphDOyP3WkYiO7Y
        RojqCcmBikMPoFsiY/J+lzWL
X-Google-Smtp-Source: APXvYqwOVc3Qa+xpA9FhMuvlruavX1Bntnwnlc60/Le7U3TUUYrhhLjOu0SdMABKhDu+zUgiufHQxA==
X-Received: by 2002:a17:90a:fb45:: with SMTP id iq5mr4977157pjb.93.1581598410238;
        Thu, 13 Feb 2020 04:53:30 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id u11sm2633944pjn.2.2020.02.13.04.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 04:53:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] docs: kref: Clarify the use of two kref_put() in example code
Date:   Thu, 13 Feb 2020 18:23:11 +0530
Message-Id: <20200213125311.21256-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eventhough the current documentation explains that the reference count
gets incremented by both kref_init() and kref_get(), it is often
misunderstood that only one instance of kref_put() is needed in the
example code. So let's clarify that a bit.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/kref.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/kref.txt b/Documentation/kref.txt
index 3af384156d7e..c61eea6f1bf2 100644
--- a/Documentation/kref.txt
+++ b/Documentation/kref.txt
@@ -128,6 +128,10 @@ since we already have a valid pointer that we own a refcount for.  The
 put needs no lock because nothing tries to get the data without
 already holding a pointer.
 
+In the above example, kref_put() will be called 2 times in both success
+and error paths. This is necessary because the reference count got
+incremented 2 times by kref_init() and kref_get().
+
 Note that the "before" in rule 1 is very important.  You should never
 do something like::
 
-- 
2.17.1

