Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E272C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4EE20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlWukAqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgDMSBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387519AbgDMSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:01:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52159C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:01:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so11083929wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtIFW64tqyzoS91eUJxx5MhAP/GYnVTnLiFyemtk0AQ=;
        b=GlWukAqWN4kKrCdSoNvWoOv0MNGWjyr5PFiB5lTZEXPTICJntkpwhQuYwok2YROgGr
         4Y8symHxEqddLpJvxZvp2Jn8cGZQuz3m03x+cI4WHBWceNZeKtmtpUxkvd5q8ea/Hj7A
         WCDhsU9R1ryHIFhMVVdrdUalEBqy07aQUSHewxbe9oX6IYAUiiq/3umQgr0tcZO+dYvr
         3O55YMWocL8PZ7OWS5Uf8tqjWkM2SewXnVbUlEQH7I0aJQmYQxBA2nWvB/dS761Uh+pC
         zP9BcuEwFD3TZ0N+ULgsKHrmZprsi00Vn1jTQ3mJBGpENxJ897tXH3kGYN7B//ipaOy0
         F8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtIFW64tqyzoS91eUJxx5MhAP/GYnVTnLiFyemtk0AQ=;
        b=XBlluqviWBBzWL5qL814NpXOQp04MWIv8+gHlPAE248wCHhax01n1a7Y0WJDwTenzt
         IQBq8JkZXw3MCGwMJnVxr2DxzIDN+Uw/p1MuZ2P5u/dIDwY87vmEauuPdC9egmJwCGbY
         NYmZoTHKqgSY34Y39yWayhocNuiHXfMXBLkGYxYYS+BxL8jlysXv+QExHMo/Eg3XRkWl
         eEPY37jRgSnntmvZ9N2/2eBi0L6cF+zUOQjQFXuKMDClTG0+C8qcptfwZIOyghfNhX3h
         1GoQK9Af3sDy7F5mI9kg2aFs3zZhmG1XtPwv0/vPnYvTKLSRf7T85HX1rvwsn9xX4VwL
         tzeg==
X-Gm-Message-State: AGi0Pub9GELgJKX9s9WSW2QeWIENQyFOJIewfdrrq57ek5srE9UMVCG+
        HTXinkYBgwHrm+HSzL39hgA=
X-Google-Smtp-Source: APiQypL5lttZkoc5Kc3BNlqZPngoyBZqQ3DXc9NyXD93WP0QxbKEUwrJFJpfwwg32FBCWdi9w00CcQ==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr10527368wrr.10.1586800898120;
        Mon, 13 Apr 2020 11:01:38 -0700 (PDT)
Received: from localhost.localdomain (dslb-092-073-054-241.092.073.pools.vodafone-ip.de. [92.73.54.241])
        by smtp.gmail.com with ESMTPSA id u3sm6476181wrt.93.2020.04.13.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 11:01:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: rtl8188eu: checkpatch cleanups in hal/fw.c
Date:   Mon, 13 Apr 2020 19:59:54 +0200
Message-Id: <20200413175957.30165-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series clears the last remaining checkpatch issues in the file
hal/fw.c.

Michael Straube (3):
  staging: rtl8188eu: rename define to upper case
  staging: rtl8188eu: cleanup long line in fw.c
  staging: rtl8188eu: make const char array static

 drivers/staging/rtl8188eu/hal/fw.c                | 7 ++++---
 drivers/staging/rtl8188eu/include/rtl8188e_spec.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.26.0

