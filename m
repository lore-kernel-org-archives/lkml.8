Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC710C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC4D206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6lY1hwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgF2VUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BC6C02E2D3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so15509477wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG862h2vmccOR30Zy+dEvVE74O1dfXe3tQ9ea9Wl0kU=;
        b=a6lY1hwRQfrrWwQ+wHSUIGy11GsRdeUlhhyJ0ZzZ4czs3V0mgD5NY7lzixVzuUWzlL
         akdh+Uv6PTnpAKv4iWUHoYDESL7HfZjPqk9/WM7W3w6T2yrZmrwO9FRiBuIBV0deyNo+
         zfStV9k4eSj/vx0x15mO3/VJWdg+hl3nt0cQX3K1bu+ZJurQBip0CMxhGHy0VIb6MP9b
         oxFY1I/GLar0bZxP0OGjfUvxGvX0VFDkl2k6Qd2SztjENj+Vo76dCcgV5R005s+8cfrh
         a0jr0UdpYMJ5rWgozkUzZeZLAUBB1FWNf3xP+ebdGw/sy4Es8VLllhYU0opQNaHghjNf
         y1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KG862h2vmccOR30Zy+dEvVE74O1dfXe3tQ9ea9Wl0kU=;
        b=dZU010fR7rWAjgg5VukMEOfg+kUOV27Jd/7Yb3qyuNTQTwVDh5YbeHNjN1wep6KxSR
         SWPsNzXRO5l5paLg4WslHOJrpkpy481/Q9zvxJ16tYSwZinXRcbviH4miRZf1eRLzK76
         b+PiG9eisTwQkj23HoTgWC5M3KGxoBcU6Bpy0xu9YDByuJJOK8dVc+GoF4pLdLM5mwYa
         wHLDijUQkSeYZTC7YDTKGBhDpldN2i76Asf4hgW7pZMX2KKzknjBhuqOGTDNeu6asl76
         BpiTrrqmOsF69WFfI9GTnWHl9DSPQ++hjO4qXwiPRZWdsdG7G5mSBLHgp0dfcSZxPLL2
         z+yQ==
X-Gm-Message-State: AOAM531qODXSMqjKrmJEKKouw4hwNtDSRYd5WlhdaqiLD45lzKjzuXle
        MzARXYKd/nHOc9XkLAfcTEJy3A==
X-Google-Smtp-Source: ABdhPJz/fRbJ6fyCO1SuMHt5E5sUIRbeH3s/cAZ07coPEBwFUMgIQRAVseQRxEZ6RHFD+GJq655Rlg==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr5965306wmm.82.1593439499585;
        Mon, 29 Jun 2020 07:04:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 11/20] misc: enclosure: Fix some kerneldoc anomalies
Date:   Mon, 29 Jun 2020 15:04:33 +0100
Message-Id: <20200629140442.1043957-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly some missing function argument documentation, then some
whch are present, but are incorrectly named.

Fixes the following W=1 kernel build warnings:

 drivers/misc/enclosure.c:115: warning: Function parameter or member 'name' not described in 'enclosure_register'
 drivers/misc/enclosure.c:115: warning: Function parameter or member 'cb' not described in 'enclosure_register'
 drivers/misc/enclosure.c:283: warning: Function parameter or member 'number' not described in 'enclosure_component_alloc'
 drivers/misc/enclosure.c:283: warning: Excess function parameter 'num' description in 'enclosure_component_alloc'
 drivers/misc/enclosure.c:363: warning: Function parameter or member 'component' not described in 'enclosure_add_device'
 drivers/misc/enclosure.c:363: warning: Excess function parameter 'num' description in 'enclosure_add_device'
 drivers/misc/enclosure.c:398: warning: Function parameter or member 'dev' not described in 'enclosure_remove_device'
 drivers/misc/enclosure.c:398: warning: Excess function parameter 'num' description in 'enclosure_remove_device'

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/enclosure.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 3c2d405bc79b9..e8eba52750b34 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -103,7 +103,9 @@ EXPORT_SYMBOL_GPL(enclosure_for_each_device);
  * enclosure_register - register device as an enclosure
  *
  * @dev:	device containing the enclosure
+ * @name:	chosen device name
  * @components:	number of components in the enclosure
+ * @cb:         platform call-backs
  *
  * This sets up the device for being an enclosure.  Note that @dev does
  * not have to be a dedicated enclosure device.  It may be some other type
@@ -266,7 +268,7 @@ static const struct attribute_group *enclosure_component_groups[];
 /**
  * enclosure_component_alloc - prepare a new enclosure component
  * @edev:	the enclosure to add the component
- * @num:	the device number
+ * @number:	the device number
  * @type:	the type of component being added
  * @name:	an optional name to appear in sysfs (leave NULL if none)
  *
@@ -347,7 +349,7 @@ EXPORT_SYMBOL_GPL(enclosure_component_register);
 /**
  * enclosure_add_device - add a device as being part of an enclosure
  * @edev:	the enclosure device being added to.
- * @num:	the number of the component
+ * @component:	the number of the component
  * @dev:	the device being added
  *
  * Declares a real device to reside in slot (or identifier) @num of an
-- 
2.25.1

