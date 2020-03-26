Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F086AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84732076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7rfAJNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgCZOoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:44:44 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:54133 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgCZOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:44:38 -0400
Received: by mail-wr1-f73.google.com with SMTP id c8so1259868wru.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BlSTEEJDHJm2U/4O7K2LlSQNpyzxY2AHmNeqxBMGqLE=;
        b=T7rfAJNouLP3QFbM7TjP2jKWn6OXe65PojXJkkX0Qk8dDkngAXWRVnPYsr8VxL1ujL
         +c6h+Q2mhiAEGAZzGrjdL5kHYOFN3oHTyYRbTbzsD1HOOF9s1L3ZXQ5WQgk0ugjvhzoT
         RglWzWjx+LDQPZRsXCDn6CJBZD5VRg4q+irS+8ww6cO54kjukjRDPxQBtYWdF+LXxx6g
         Rr5R7U4IG8Z6F2v9gHuUdr/x+/7NDk0OpSI5FzKBZBkAKtIVzl2M4cGxT61BGgV1ILzd
         jxr1PH63vVfKFE1rWp6cPQ13CoQTvQqOIPdfbAwgWZN/xAZudV1B7iWOy9z+iQuGcsVH
         Kxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BlSTEEJDHJm2U/4O7K2LlSQNpyzxY2AHmNeqxBMGqLE=;
        b=Skv5viRi7GJVIyjk+nD90Zk+mow2429nHmzRyllpfg6rJXWF9zsBb0C5KRLX28aZ36
         Cs/6rF6o4LKL8AtgTNfn4KrHTRlRnXuJQZDoqU2A8nO5gacM9wzwc6+6BjUOjYlgfbvh
         I8SXGuf7jCTGHFFAiMoiDWylw5w3uP6oFgY3w/6uT2FQcXi82TutwXJ42pXR/K1ypWyc
         0uImqj4cbGKMYzhxXn1u/NSeaKg19GiGTsKvnp+YOtfO2Vos1O0gsUtArOKD3ZRGtbiU
         H6oI2H9f4pC+qyhMXvT40wKA6OrDDBl9WAJxvRoflBR0dS7JNxi60jjGTZzed5A25Inv
         5AGA==
X-Gm-Message-State: ANhLgQ0JqRebot9yWo5iea4FptDoWQ87+gV0nJU3462VZXz9d63duxY6
        0wDZwNbLriFy1fNr+ui2sjchq08c7isDDWsb
X-Google-Smtp-Source: ADFU+vu4Wmk3bo0iTn0SCfakv1wwE8avBfBttA5grmmbe01DRbQuLXjTHB3LsyiFQwggR2UX3CWXHn0Kedt0netC
X-Received: by 2002:adf:db0a:: with SMTP id s10mr6783005wri.361.1585233874611;
 Thu, 26 Mar 2020 07:44:34 -0700 (PDT)
Date:   Thu, 26 Mar 2020 15:44:06 +0100
In-Reply-To: <cover.1585233617.git.andreyknvl@google.com>
Message-Id: <4520671eeb604adbc2432c248b0c07fbaa5519ef.1585233617.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v4 7/7] usb: core: kcov: collect coverage from usb complete callback
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kcov_remote_start/stop() callbacks around the urb
complete() callback that is executed in softirq context when dummy_hcd
is in use. As the result, kcov can be used to collect coverage from those
callbacks, which is used to facilitate coverage-guided fuzzing with
syzkaller.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/core/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index aa45840d8273..de624c47e190 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/genalloc.h>
 #include <linux/io.h>
+#include <linux/kcov.h>
 
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
@@ -1645,7 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 	/* pass ownership to the completion handler */
 	urb->status = status;
+	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
+	kcov_remote_stop();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
-- 
2.26.0.rc2.310.g2932bb562d-goog

