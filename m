Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B5C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5889420882
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HptUbo00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgDVUdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgDVUdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:33:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D230C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:33:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so1708938pfx.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xziF23XhQe6bvjwS9veYxd1lZuBR1P64JlqMkI6cAmE=;
        b=HptUbo001ZFSajtqjlDUPswimG+lWZmWjcVQiAC069qM3jQNiQyOacxbSEJDJ3cJ4G
         mtKbWGAojVCmizSMwquRoCLhszE3z6++jcZks3UQRj54YwVE7Zz1AMnxl4EhXmd4p6XB
         +dPCT8F4TXo4fxEo0TvREbSO7QSkaLVkanzaEzTnh0gIPEviZtkwjuN40VO68JvNJUeC
         C2hbz3rA8CS8yqpgA+bObSMdSNjBAL2QtlqEuieiixDE3V0TGxnyNFp1VP5g94cZBVok
         s6hF5SvEu7ON6SHGPgPwS+7wyxM2MK2NVJ3jzlcx5ac6LUu6FR/N4/vwLzmZ1uGAOtgs
         JDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xziF23XhQe6bvjwS9veYxd1lZuBR1P64JlqMkI6cAmE=;
        b=ZJ0Tfq24wLx3oUfBflC1MAazYypPI3VJYuGHe7hyXtK3LPpWNquHDwBpHoTjvL/7/J
         3qMN9iIQHQaPuteCOmP3mr4Z192QnwaIDr+hysWpddfLUY/Zz3eGWv+Q4diH0kFZsGad
         Okr/ovpD0H54SI8zfF/ONxy57/llttrN5Qo5DzZU0UOkGkNawAOIdN2Yn8J0Z6x+2El3
         c0wnkaO8e5mRoddJpWildQT092S6ppb7V1bva3pb+LOf+gf/F67cF8WNFjT4G/rGrRwL
         q4Z88r2MWR6ots7ETV6d7K285COWGBrKIQRsObNXGvycBYSn4GCjs6ZKlmeHJNPxhDFk
         Nqqw==
X-Gm-Message-State: AGi0PuYNvf4l2EfVbdj75AC1b1kGqZjiEd5rFwc4H/k4LwNieaPHx86l
        sQYbiApZt8pFH3cteMUztEQ0d/Tr6Gk=
X-Google-Smtp-Source: APiQypI1cIvO9bvDIb2+rBS+hslzcch8HwCqunDEuiMzTtSmXM7vjDtDifX/+kISDFr49NwkA5FT7w==
X-Received: by 2002:aa7:8006:: with SMTP id j6mr134553pfi.187.1587587584431;
        Wed, 22 Apr 2020 13:33:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id b24sm360292pfd.175.2020.04.22.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:33:04 -0700 (PDT)
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
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        netdev <netdev@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/3] driver core: Use dev_warn() instead of dev_WARN() for deferred_probe_timeout warnings
Date:   Wed, 22 Apr 2020 20:32:44 +0000
Message-Id: <20200422203245.83244-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422203245.83244-1-john.stultz@linaro.org>
References: <20200422203245.83244-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c8c43cee29f6 ("driver core: Fix
driver_deferred_probe_check_state() logic") and following
changes the logic was changes slightly so that if there is no
driver to match whats found in the dtb, we wait the sepcified
seconds for modules to be loaded by userland, and then timeout,
where as previously we'd print "ignoring dependency for device,
assuming no driver" and immediately return -ENODEV after
initcall_done.

However, in the timeout case (which previously existed but was
practicaly un-used without a boot argument), the timeout message
uses dev_WARN(). This means folks are now seeing a big backtrace
in their boot logs if there a entry in their dts that doesn't
have a driver.

To fix this, lets use dev_warn(), instead of dev_WARN() to match
the previous error path.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Basil Eljuse <Basil.Eljuse@arm.com>
Cc: Ferry Toth <fntoth@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: netdev <netdev@vger.kernel.org>
Cc: linux-pm@vger.kernel.org
Fixes: c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state() logic")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 908ae4d7805e..9c88afa5c74a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -258,7 +258,7 @@ int driver_deferred_probe_check_state(struct device *dev)
 	}
 
 	if (!driver_deferred_probe_timeout && initcalls_done) {
-		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
+		dev_warn(dev, "deferred probe timeout, ignoring dependency");
 		return -ETIMEDOUT;
 	}
 
-- 
2.17.1

