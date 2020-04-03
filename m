Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD317C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5B52074D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIFtyczK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbgDCBcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:32:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37332 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgDCBcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:32:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id g23so5699406otq.4;
        Thu, 02 Apr 2020 18:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tL84JIZ9PPBKDtxjAsXoKktPkF0mAfOinDidTcxG+ZI=;
        b=BIFtyczK2wzQJIVuXDXXu1+CSY9fxuK/7yvOqlrcPXt5rRCXgAew9NVV/PltLx9Rev
         agwVJWlPyFti+xt3KXdi44NAufL6twb64gvU/EhzBctUsoFkuZUx3hrq+3P6Xv8dylFc
         EDramOmmYBIkKIcou7gmsR+NWJujkI7mi54mvTlct23WvPuFwbx3Y7c6DJJWa2UR7FBm
         befolPENSeQ99v/6G51dsZWPRjPuUgYVX8/oLuDsHnQQ25yHJVLMSgjY3j+VSbNStNSs
         VAclT8M3TEDEleZiPaOdzuRNAMjTWB/7wVED3V4DUERKUCI3UekwicG1ASW77mjqM/k3
         ztcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tL84JIZ9PPBKDtxjAsXoKktPkF0mAfOinDidTcxG+ZI=;
        b=cMn0iLilexXsbbTwCeqfsQwlo/t+2Zd/x2DJRYJKe8aFbzpgqd6XBPiN3NoOx5QkJ3
         5BB/DiUYc0kFjGWpjE3uLc3hLqJjzfmoSUZJPka9QoHHennaUZwngiENCSGCagFX3SiY
         QjKQwGnsdiUdTbIosDv3YhjgHCIOQzR1xkOMI0L8VzeoJZRwqrLCxIfFA3ogPTu2wQ8c
         kEf+TpuLHgpcYphPVn6wZJs8QJN8hI6QxCq90OqSX8/H3CAHdaeuAw29swAwElFphGiA
         IxU8lO4nnJO583bKCDz2whqZN/OItm1PPIwUcWOOWtUyh8Y9go+f0s9ZRtQSKVvrbO6z
         0t/g==
X-Gm-Message-State: AGi0PuaRYdLRqlZdavUJErCfqrDWmOQxyM/GA9Sz9GFMDLH13+hyCPNm
        q8ejxCpek/25BrbFnr7ec7U=
X-Google-Smtp-Source: APiQypJ4iphaBRpe5lJEeM4w3H4utcznK6c8v7WzM+EmpPpzRvAY4xHA3Kziib5EUJ9FwQv6lw7Tfg==
X-Received: by 2002:a9d:748e:: with SMTP id t14mr4853268otk.334.1585877523192;
        Thu, 02 Apr 2020 18:32:03 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m20sm1743494otj.37.2020.04.02.18.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 18:32:02 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] remoteproc/omap: Fix set_load call in omap_rproc_request_timer
Date:   Thu,  2 Apr 2020 18:31:35 -0700
Message-Id: <20200403013134.11407-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200402010812.GA751391@yoga>
References: <20200402010812.GA751391@yoga>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building arm allyesconfig:

drivers/remoteproc/omap_remoteproc.c:174:44: error: too many arguments
to function call, expected 2, have 3
        timer->timer_ops->set_load(timer->odt, 0, 0);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~                ^
1 error generated.

This is due to commit 02e6d546e3bd ("clocksource/drivers/timer-ti-dm:
Enable autoreload in set_pwm") in the clockevents tree interacting with
commit e28edc571925 ("remoteproc/omap: Request a timer(s) for remoteproc
usage") from the rpmsg tree.

This should have been fixed during the merge of the remoteproc tree
since it happened after the clockevents tree merge; however, it does not
look like my email was noticed by either maintainer and I did not pay
attention when the pull was sent since I was on CC.

Fixes: c6570114316f ("Merge tag 'rproc-v5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc")
Link: https://lore.kernel.org/lkml/20200327185055.GA22438@ubuntu-m2-xlarge-x86/
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/remoteproc/omap_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index cdb546f7232e..6955fab0a78b 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -171,7 +171,7 @@ static int omap_rproc_request_timer(struct device *dev, struct device_node *np,
 	}
 
 	/* clean counter, remoteproc code will set the value */
-	timer->timer_ops->set_load(timer->odt, 0, 0);
+	timer->timer_ops->set_load(timer->odt, 0);
 
 	return 0;
 }
-- 
2.26.0

