Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3637C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B111A20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wu8YZlRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgDXNU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:20:27 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C17C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:20:25 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id r20so4494650uah.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r9H1IW1LgtEkP8qLWkbs6oOL83C0+GpU8c93D2C8O+E=;
        b=Wu8YZlRMt98XgKmsACE1XV5n+dabvH9NmisOPAUZ0ezGdXqMT7BBGBOb9Ng2O42kj+
         hibERO+zT/JA3JGDhq+Bu5OKltmrKOmEyKCDtM7Tc3Cr9oOT98JfCGMYuFtiEzuRbgFt
         vFJtVM1griYhhIpH0n94Z+GLXyzlHtzbwDu0ytT8GiF0bkDL7vEogBQMPThOkApOTGeG
         tQgdpm06Hf37atZMj4s22ubXfS+RR85cE05v4M/sqCfBwJl+z3T45KEEnZIU2K+3rrjW
         AUrs1UOTnH18pm/f62KclP3ZifYgNYYaLROml0hWiVTtddpsNq4L9ho9lbWp3MCVyn3C
         1e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r9H1IW1LgtEkP8qLWkbs6oOL83C0+GpU8c93D2C8O+E=;
        b=PG7e+EPsNPpIxbvPuWKcjYWA9L0GetKpdZ4L5SeCQNa3zI2eTH3ZuKIBnjhmf4mgIr
         WCdQ1XokrVk7JPk8A3a4enw8lXjQ19oMYbbUFkbTpPxUrazpfvX4a2Su9aTs4U1b9h4L
         K3+08QgZ+4V0r4CRfhJkkieTrBT5mLOn6MIS6HYiTDncIbQh1UouSLa4JLQ+TYZ2tgi6
         rvzBcR+nzm1dBCQTYAJhEMx7ucksZDYJoXPVdQ0JDF+BM553asy4lUKDNZWscwngG8VT
         R9w0WGj+633niBV7sV3G9XkeNNLdD6/p/lGFoWtZUmsvAd/wQ34dfPuSpdyXsrhkJwlM
         b6DQ==
X-Gm-Message-State: AGi0PuY713Evh6K2sBhyuBQVuQdU9k68y3eRR3jHiVFQfXG0KVG06aJe
        f6/qpPMA7dG2ua2DPihu+lca4YMZaBgHqSXw
X-Google-Smtp-Source: APiQypLElWOC/iqIxBReE7LPkVfCCE0t6xjkTcKjVSJ7azxEWLCUiTVOs3OH+UJQG5OnKKEI8yAUeQAHcW20bhPU
X-Received: by 2002:a1f:99d1:: with SMTP id b200mr7899519vke.95.1587734424795;
 Fri, 24 Apr 2020 06:20:24 -0700 (PDT)
Date:   Fri, 24 Apr 2020 15:20:19 +0200
Message-Id: <9c99c508da044822baf53db5e3fccd4f21b0f8d3.1587734346.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH USB v2 1/2] usb: raw-gadget: fix return value of ep read ioctls
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They must return the number of bytes transferred during the data stage.

Fixes: 068fbff4f860 ("usb: raw-gadget: Fix copy_to/from_user() checks")
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes in v2:
- Added Fixes tags.

---
 drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index ca7d95bf7397..7b241992ad5a 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -669,12 +669,14 @@ static int raw_ioctl_ep0_read(struct raw_dev *dev, unsigned long value)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 	ret = raw_process_ep0_io(dev, &io, data, false);
-	if (ret)
+	if (ret < 0)
 		goto free;
 
 	length = min(io.length, (unsigned int)ret);
 	if (copy_to_user((void __user *)(value + sizeof(io)), data, length))
 		ret = -EFAULT;
+	else
+		ret = length;
 free:
 	kfree(data);
 	return ret;
@@ -964,12 +966,14 @@ static int raw_ioctl_ep_read(struct raw_dev *dev, unsigned long value)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 	ret = raw_process_ep_io(dev, &io, data, false);
-	if (ret)
+	if (ret < 0)
 		goto free;
 
 	length = min(io.length, (unsigned int)ret);
 	if (copy_to_user((void __user *)(value + sizeof(io)), data, length))
 		ret = -EFAULT;
+	else
+		ret = length;
 free:
 	kfree(data);
 	return ret;
-- 
2.26.2.303.gf8c07b1a785-goog

