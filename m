Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD3FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A75C2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XC6J2i/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCZFp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:45:27 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:43659 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgCZFpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:45:24 -0400
Received: by mail-pf1-f176.google.com with SMTP id f206so2226582pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bP9A1YZQDo91LDYo/6KoY0c2wBmpDuHg+6Vks+B9y90=;
        b=XC6J2i/F0WRhw9aQeuGQ/abxXmpETM+76JaP3zU0LH2dA8EVb4SkfS5+OE7Y9X3UhO
         13DhHAikYxzxifdgGQE/6pidn+E3YVBHiYs4iWfF/HzeULzHQvAEGIqcd+sAVIm20Ymb
         0X/YTYTrhpFgddL0Serq3mb7y/GuPQYa7f0M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bP9A1YZQDo91LDYo/6KoY0c2wBmpDuHg+6Vks+B9y90=;
        b=GntewVBMmqE5O4PC0N3T2Ff/OTXowsCiMQeGVV9lOKt5jeSDNcqXponUnt1pK+28q/
         /PTFGWoq4KmFn2xHErMdMDxNL3l7Sfm5W29uacsKb3v21Wz2je1uzKL9hPcA9z6TRZeN
         b7Y4PGo6j1tWFIH/K6BQKIFGp6UvXdj2jtnzuNU8YwO/AXxYCttFT5QjApAebhOAWjqx
         KzPE13oli6ph0+spXU8SHIlJsSFI8nt7PxcPc6K1eDwo6SN1ech+6Tj8hqPMR9qWC7Yv
         2aL0xoGjQMH51iUm/DY4caHDRL+2i1ZVrN0V5wRpeGXK+rP9bVEplwZwB0ZoWQ0MYfIJ
         FTJw==
X-Gm-Message-State: ANhLgQ03U3E+sqm5MiVOWzZbndSleIKvqIjM2Gn4Tt5ukCUIsuyYBUJA
        HyLgZoZpC7gd5blM9pKqiPb7FaiXwcs=
X-Google-Smtp-Source: ADFU+vv4lcfr85S/TT7MJ8OdAlRUFTZHdQtIftkjB93CEHoO5lWO6VZjKfVhvupSb7NpHwtm6iwGmg==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr6947155pgi.63.1585201521752;
        Wed, 25 Mar 2020 22:45:21 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id d1sm727302pfc.3.2020.03.25.22.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 22:45:21 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 0/1] Bluetooth: Add actions to set wakeable in add device
Date:   Wed, 25 Mar 2020 22:45:16 -0700
Message-Id: <20200326054517.71462-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel,

As suggested, I've updated add device to accept action 0x3 and 0x4 to
set and remove the wakeable property.

Thanks
Abhishek


Changes in v2:
* Added missing goto unlock

Abhishek Pandit-Subedi (1):
  Bluetooth: Update add_device with wakeable actions

 net/bluetooth/mgmt.c | 57 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

