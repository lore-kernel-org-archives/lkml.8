Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68F9C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D47206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlBN1HcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgDMUnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbgDMUnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:43:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C229C008748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:43:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u65so5064938pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=11QzCAwCYyDGgMhxuZK0S/ZjR3ZzKMO2xp+a6ZMWbek=;
        b=PlBN1HcZrUiEv7MWRLQtjV6nvtJtZOdDbhfub7UlnxOnaMN0qg60iCi0wF7DA/tVTC
         HtcC8HeQqDu689LReB17jS89TYZlg89r8+9f4T99uPoZzZXVz3B95nyDn/8k18B9ZTWt
         BYiXbuyDh4oqV0PFMCr7w5aDunf3vU1yks2OCQJ9Xaxrp4hcHvf59hmzxam45XHRG7IM
         jEQLZQqWhgY1X81S9f0V1Cv3ifXnpoo0go5Wyi1Z+4tzM7hoQaODI0B9S9YQGJJHZMGY
         OaB6WGIE9Kk630+Slp8+aLxH8as8f2GI3sAd/kmBbDxuxvzIiOdx4o7GkqafWbNmVShr
         uCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=11QzCAwCYyDGgMhxuZK0S/ZjR3ZzKMO2xp+a6ZMWbek=;
        b=ooFh3nGJvv+EeLdJy055pwDXk7vsA0B3TugH1EM7lE8gjqYHzK1OS6bSWvq6fAIpp8
         ym67FX9D1DEX0PmPM2pOG4x3WhbPiiRny1KRw8PpDlQNqWflPmFwpwsCt3ddKD2civRx
         tuzeMLshQcxWkSyJKVLxAfNfvewpAZmWOcfgtBWw1vKiQqHgOjRWNKjWvH21kgVsPWAF
         TS/LQLLfZ8P77ZUzIr/SGqgEQF68bjfakcUZFv40VxE+M9MOpBWJ10nLQ3LgkJE66w56
         SBzsxyzqOKmpwq05VzrhNXLmgEtP3AvLqvdlXPYlstnPcpe/lqWlZdTOCGfImitcUsjG
         Rfhg==
X-Gm-Message-State: AGi0PuYhK4/mHU5Y/kKELoLBQjvAnyehoZbc2kFHUacr85T6jTeUobGi
        909VUclypmr3T9UuLnpJ1vZFve6rFUA=
X-Google-Smtp-Source: APiQypK0S60cHhJRzSVlendhej5naoveWnkgtP8KxMUUzly5JLU1zVS4i/ahVEhoNTqEwJlJbWWulA==
X-Received: by 2002:a63:545:: with SMTP id 66mr10926795pgf.66.1586810588308;
        Mon, 13 Apr 2020 13:43:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o21sm4763340pjr.37.2020.04.13.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 13:43:07 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev <netdev@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] driver core: Ensure wait_for_device_probe() waits until the deferred_probe_timeout fires
Date:   Mon, 13 Apr 2020 20:42:53 +0000
Message-Id: <20200413204253.84991-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413204253.84991-1-john.stultz@linaro.org>
References: <20200413204253.84991-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c8c43cee29f6 ("driver core: Fix
driver_deferred_probe_check_state() logic"), we set the default
driver_deferred_probe_timeout value to 30 seconds to allow for
drivers that are missing dependencies to have some time so that
the dependency may be loaded from userland after initcalls_done
is set.

However, Yoshihiro Shimoda reported that on his device that
expects to have unmet dependencies (due to "optional links" in
its devicetree), was failing to mount the NFS root.

In digging further, it seemed the problem was that while the
device properly probes after waiting 30 seconds for any missing
modules to load, the ip_auto_config() had already failed,
resulting in NFS to fail. This was due to ip_auto_config()
calling wait_for_device_probe() which doesn't wait for the
driver_deferred_probe_timeout to fire.

This patch tries to fix the issue by creating a waitqueue
for the driver_deferred_probe_timeout, and calling wait_event()
to make sure driver_deferred_probe_timeout is zero in
wait_for_device_probe() to make sure all the probing is
finished.

The downside to this solution is that kernel functionality that
uses wait_for_device_probe(), will block until the
driver_deferred_probe_timeout fires, regardless of if there is
any missing dependencies.

However, the previous patch reverts the default timeout value to
zero, so this side-effect will only affect users who specify a
driver_deferred_probe_timeout= value as a boot argument, where
the additional delay would be beneficial to allow modules to
load later during boot.

Thanks to Geert for chasing down that ip_auto_config was why NFS
was failing in this case!

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: netdev <netdev@vger.kernel.org>
Cc: linux-pm@vger.kernel.org
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Fixes: c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state() logic")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/base/dd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 908ae4d7805e..5e6c00176969 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -226,6 +226,7 @@ DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
 int driver_deferred_probe_timeout;
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
+static DECLARE_WAIT_QUEUE_HEAD(probe_timeout_waitqueue);
 
 static int __init deferred_probe_timeout_setup(char *str)
 {
@@ -275,6 +276,7 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 
 	list_for_each_entry_safe(private, p, &deferred_probe_pending_list, deferred_probe)
 		dev_info(private->device, "deferred probe pending");
+	wake_up(&probe_timeout_waitqueue);
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
@@ -649,6 +651,9 @@ int driver_probe_done(void)
  */
 void wait_for_device_probe(void)
 {
+	/* wait for probe timeout */
+	wait_event(probe_timeout_waitqueue, !driver_deferred_probe_timeout);
+
 	/* wait for the deferred probe workqueue to finish */
 	flush_work(&deferred_probe_work);
 
-- 
2.17.1

