Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C766DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D7C22B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS+33gy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgHDKPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHDKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:15:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9A6C06174A;
        Tue,  4 Aug 2020 03:15:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so36873385wra.5;
        Tue, 04 Aug 2020 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H5j9+8nmnJdMppGosOvhVeg5yrEmi0eTTjC4+FGQAik=;
        b=BS+33gy1+UWjVpsrRC0ldxaeHxg/C4gBtng4EeueLwXw0sy2QDce6cJpcgyoxY/vkp
         a9ZTANWhYBqIHwlfjTZ4lF/R/2O2HpoD6kbltM7DaXlig3417ljr7sp4CIh63ayDLZoD
         txUvmJ3I298UXaWq1VDrpIviq6O/D3fVSSSyEZIPXG1ZdppUtAVSkvgsnvSWhs3Slz2U
         5f/51V5eq4JUauN/FVlsaLjHM7xF0rSlEy8BzOGnZ3sZfvHBXJbv8+2w3x33bQZVuD0N
         RdV6HC720pOV2wUyCxGhR2W6iXJYkABHqXXhhC1O/MG9HsYqTliaRqz3MceI1bTmcJ08
         OYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H5j9+8nmnJdMppGosOvhVeg5yrEmi0eTTjC4+FGQAik=;
        b=VYMZsf8ej5QrZ/wEfG6+8Oef4m8SUAO3438T1oqOenWw/XTQwEyeaVrZupozvdZ0SF
         7XlHltmUrR2embDS1AyTHNW9TcSwCCjZQdFkhUh/RbU1NLLNZgYNwA4wY1mJdWquP0LW
         si9whf0n8U6PVYM4yPH7HsfqARhw7gORYDOZXDMDg5AGwUcWgoFuaLh5x9n3xq0IgVQ6
         2yJ+N4b46K8rE/y+ZeNnqIeiFpLn99RHZOl5Bd4mQH1epXiGYfC0ynVh+8//SYqkywTw
         J0xVO2eyRtBiZ0eeGBNGoF0BmvtUKeNn4n0yIG+mFFgy5S/hlb+WR3U6lVhCYwCJ06om
         ic7g==
X-Gm-Message-State: AOAM533llEPpS/P+dcie2JXzVfXmedPXx9V7mxZBXnfzknA/iOJGx/Ko
        MOj3j1nSKzHnm+i/i0iJoGEibN/5
X-Google-Smtp-Source: ABdhPJyLndcJDNVINUqMwrCG8DEJ+692FT0GVMQnAm9+wiAJLeWnjQL2AtfSV0+Ychlnc9EXD5J+Kg==
X-Received: by 2002:adf:e68f:: with SMTP id r15mr18465693wrm.196.1596536135580;
        Tue, 04 Aug 2020 03:15:35 -0700 (PDT)
Received: from myhost.home ([2a01:110f:b59:fd00:14b7:411e:74a4:708d])
        by smtp.gmail.com with ESMTPSA id 111sm30428728wrc.53.2020.08.04.03.15.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 03:15:35 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pavel@ucw.cz,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH] MAINTAINERS: Remove myself as LED subsystem maintainer
Date:   Tue,  4 Aug 2020 12:15:25 +0200
Message-Id: <20200804101525.7235-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It don't have enough time for reviewing patches and thus don't
want to be listed as regular LED maintainer. Nonetheless I may still
give a review from time to time.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2698cc7e23..71e16ba36048 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9681,12 +9681,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
 F:	scripts/leaking_addresses.pl
 
 LED SUBSYSTEM
-M:	Jacek Anaszewski <jacek.anaszewski@gmail.com>
 M:	Pavel Machek <pavel@ucw.cz>
 R:	Dan Murphy <dmurphy@ti.com>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
 F:	Documentation/devicetree/bindings/leds/
 F:	drivers/leds/
-- 
2.11.0

