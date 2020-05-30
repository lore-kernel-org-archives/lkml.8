Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E94EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 04:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018D020810
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 04:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v12LqxgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgE3ECE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 00:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgE3ECD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 00:02:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C39C08C5CA
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 21:02:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so2244653pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8wOzwyvVgzyZKR9GGg2zllSp9qD/mnxhMdRu73NI63Y=;
        b=v12LqxgKfJC2jsmxi01gXIlmZga5Kjq7jmK34g4/VOZ0BrXXWfE/7k7YdhSzhrfo6U
         KZwCig0chuSdJoTxFRIeoPT/a1KTucMJt6ubY1znecABSPZ2c57Ln9Tuz0tU7Vfxsi/b
         uzo4sirt7JJ7OwziI2Owxd3+BgcOc+dM0UDq5iADFBUb/KkEI7nDARmZCue0PePecRDi
         ZkZZ2yPTFRk8YEo2Z17+ih07ev2fodHM71WD1BIFnJLAEaE+8vof6H9X5M2p9hACDqBQ
         4PRGqAPfWUAZpr/MlmLISJnywKr8hQlJqFJhgIEqvywXo7lJ5pNXKak8EeOZsqZNijW6
         aj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8wOzwyvVgzyZKR9GGg2zllSp9qD/mnxhMdRu73NI63Y=;
        b=i36YwTqySglSYnshwrLXvs990l8JCrRGFpX55jY0HYbXGAqeL4zu3sTuOv5FZzNszT
         E+rvI/3+oP9tp1APK8O2jD38QGHUbsXstiY/GdJZhUyoOTShKwU4WNl6BWsV/1koL71x
         0mUxnz3cApQAaDK84HIibxrcIpeDqYgJXJUwMeUa3b/J+OlugTfWrFvI13w997qNYWzF
         BU8Zk4IJ5j39A2FuPcwXsdhuyKpAvKjH2fgxwQJ0vqYqbbTxy49ff7r6HPK+lUWNTM0t
         ZlJJ8qi0+Dfazx2ipHHoubjg2YvmLRrgL+vlLzR4/NIR8W3ni9KQzNRPzVT1dONhZguH
         iyiQ==
X-Gm-Message-State: AOAM5314Qp687xgRrsMhI7Y2k6n2gJlrhPuIZT/4ErOw/+/9klaaCe44
        /igii3hNzwRQJ6lLmN1gyU3mwj4+uA8=
X-Google-Smtp-Source: ABdhPJwk2z18kbSHM2nFTpnyw8/PLZm8hbzk2UPkIolenD3B+g/wzpArXov97hQm8W/mnj/9jYqVOA==
X-Received: by 2002:a17:90a:3d49:: with SMTP id o9mr11640117pjf.26.1590811322374;
        Fri, 29 May 2020 21:02:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j13sm8533603pfe.48.2020.05.29.21.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 21:02:01 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YongQin Liu <yongqin.liu@linaro.org>, linux-usb@vger.kernel.org
Subject: [RFC][PATCH] usb: typec: tcpci_rt1711h: Try to avoid screaming irq causing boot hangs
Date:   Sat, 30 May 2020 04:01:57 +0000
Message-Id: <20200530040157.31038-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently (since 5.7-rc1) started noticing very rare hangs
pretty early in bootup on my HiKey960 board.

They have been particularly difficult to debug, as the system
seems to not respond at all to sysrq- commands. However, the
system is alive as I'll occaionally see firmware loading timeout
errors after awhile. Adding changes like initcall_debug and
lockdep weren't informative, as it tended to cause the problem
to hide.

I finally tried to dig in a bit more on this today, and noticed
that the last dmesg output before the hang was usually:
  "random: crng init done"

So I dumped the stack at that point, and saw it was being called
from the pl061 gpio irq, and the hang always occurred when the
crng init finished on cpu 0. Instrumenting that more I could see
that when the issue triggered, we were getting a stream of irqs.

Chasing further, I found the screaming irq was for the rt1711h,
and narrowed down that we were hitting the !chip->tcpci check
which immediately returns IRQ_HANDLED, but does not stop the
irq from triggering immediately afterwards.

This patch slightly reworks the logic, so if we hit the irq
before the chip->tcpci has been assigned, we still read and
write the alert register, but just skip calling tcpci_irq().

With this change, I haven't managed to trip over the problem
(though it hasn't been super long - but I did confirm I hit
the error case and it didn't hang the system).

I still have some concern that I don't know why this cropped
up since 5.7-rc, as there haven't been any changes to the
driver since 5.4 (or before). It may just be the initialization
timing has changed due to something else, and its just exposed
this issue? I'm not sure, and that's not super re-assuring.

Anyway, I'd love to hear your thoughts if this looks like a sane
fix or not.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 017389021b96..530fd2c111ad 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -159,9 +159,6 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
 	u8 status;
 	struct rt1711h_chip *chip = dev_id;
 
-	if (!chip->tcpci)
-		return IRQ_HANDLED;
-
 	ret = rt1711h_read16(chip, TCPC_ALERT, &alert);
 	if (ret < 0)
 		goto out;
@@ -176,6 +173,9 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
 	}
 
 out:
+	if (!chip->tcpci)
+		return IRQ_HANDLED;
+
 	return tcpci_irq(chip->tcpci);
 }
 
-- 
2.17.1

