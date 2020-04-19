Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB45C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B9521973
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6Is3stE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDSNbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:31:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E6C061A0C;
        Sun, 19 Apr 2020 06:31:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so2913811plt.2;
        Sun, 19 Apr 2020 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XeW63w2kIWVeKtwQqvg/T7rrTKTD/Vw3x02Lf0zegeU=;
        b=A6Is3stE+3bHgtyjZYV6VI11XXA/2Tpe/HGq+TZRXVjDKoieX8m1pRxFvadip/3Z59
         KwpYLB7BC9uhbFoIFAAkOiz5Z6KQ6rXkgt357r8NjYtQxAEQ6p0AOTzrl05CUIl/ui4G
         vBOXqH+gTBV6FfoZ3Ujoa0b38xkFWvxygqph17k+Av/Fr8A/Pl6K3WwTzPkGu18ux+ta
         iyzh3L8NCSElYg9wBirYtSo25fE04XXbRshoijxcdr7h8g6zZz16cd2j0NcfnrDhal1j
         3rwMvYjFDP+eDGyCedft9dwH7E9ID6lA5O40X1b43449ZtwqwEH6ADbqWIizfAk6ZNit
         dVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XeW63w2kIWVeKtwQqvg/T7rrTKTD/Vw3x02Lf0zegeU=;
        b=ocXqdokLek1Db4GmQTl6LBfIq5IYGlmyN/WEeU/CfLJ2N70o10sfg9FdCsETI55kkt
         Ydh7F+avXAsCgzsNdpoBji0Zuuf9p1nqfW4e3+UNUp/B3uTW0tVTQNJWHFtx2GWQAh97
         JzOH4sp5k1W4SdR8Wxbu9LF4qsVzgCpmDcFwxT1sDnh6RUQYB0b3SlQPkKRWTIjpERYU
         NJTetQg+xNGs/a+UbGDSGB9tFZJJ+YG74smukCptsFV/41VOtC6Urz1k++i5405uQZys
         gVPFhj51GhC0hqYSJ5o2b+jvENCKgrj2VeHSZHNOEGeNAYWTytJu3JIYmAwWPpn5Q+Ij
         d3Dw==
X-Gm-Message-State: AGi0Pubezu6t/Mk3aovg85ge4mSSvTlEDPcI1tEoHzfkNoXgVhZSuA3f
        W0iaEQMVsCtc7RmFGRn5YA38p2+PRF4=
X-Google-Smtp-Source: APiQypKMgGN+xYv+FGR7B9/jqDRQJaEKu2zzTtOWe85tWpHsEn7t6ihxrr7OtqqwxPCt8sQRNr2SvA==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr11803655plo.186.1587303062686;
        Sun, 19 Apr 2020 06:31:02 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id g14sm19289010pfh.49.2020.04.19.06.30.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 06:31:02 -0700 (PDT)
Date:   Sun, 19 Apr 2020 19:00:55 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: typec: Use the correct style for SPDX License Identifier
Message-ID: <20200419133051.GA7154@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to USB Type-C support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/typec/tcpm/fusb302_reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/fusb302_reg.h b/drivers/usb/typec/tcpm/fusb302_reg.h
index 00b39d365478..edc0e4b0f1e6 100644
--- a/drivers/usb/typec/tcpm/fusb302_reg.h
+++ b/drivers/usb/typec/tcpm/fusb302_reg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright 2016-2017 Google, Inc
  *
-- 
2.17.1

