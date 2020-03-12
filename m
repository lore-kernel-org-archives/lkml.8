Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAA4C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D2520724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hNW4qRq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCLKI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:08:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36042 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLKI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:08:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so3037566pfe.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgvqXXtuVCXza7WjWjw6+XX4FgR73HjTkow7gBP8Ln4=;
        b=hNW4qRq7M5dkGWjJBppSPGNZCqy5yZeMbnaC207QXuY1mCaJUgs8n0ihw1K5Wctm+L
         VklHg9Ogbkx114ZJenGrSri4k9tM6p+7hHe78gnJCyTbwJkveZ5YEhoJo05KZBmJrQkT
         +LH/buQ0oGttIKQX60Fj+rq1Y/A73DzkLPiRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgvqXXtuVCXza7WjWjw6+XX4FgR73HjTkow7gBP8Ln4=;
        b=aIyefGAD67jHxqsSuQYSft+Sq+JX6ljDKC3pFayXzOGNLETjzM6G0kLYl4lArIlACA
         bdQQXLebhPPvv7BSLmewkoc1Jf+7+o7PFXJXHdkFyTSyzYS8hca9emT9HP/45JB8gR4t
         WiBszFIYwLQ2NLehYr5GfzMi/aNVWQfN2/k7DJaO451XV+r+hhm0ijHIRk9L63Fft34k
         LoYScl/wb08N/id2imNdE61c27X4ZzMTIzv3gJmQz7GKlKWDfl6IGGqEgfCA7HDvF24N
         qZFb7qEh+v5JcHkMjTwtJ1H3h7OyXL4qWt4FHqL5TsyN+p4f+OrJfEQow/B6NqXxhrwi
         S9TQ==
X-Gm-Message-State: ANhLgQ2KLvySUqi5LRkfOyg3+1Cp2Piqq5dtq/QPV4b3FOmVRQpR6k85
        LlGP0YXUhF73EKJyKk1ZU2ZNWXP/vOc=
X-Google-Smtp-Source: ADFU+vscPdzmHpcIYSPMS+Oz0RXIgrc4naI2a2eOxoeWR4s5/pBhAXM3hxViX6P0NS9NALuj/ouUwg==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr7495632pfh.124.1584007705996;
        Thu, 12 Mar 2020 03:08:25 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s19sm3678368pfh.218.2020.03.12.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:08:22 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     furquan@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 0/3] platform/chrome: notify: Use PD_HOST_EVENT_STATUS
Date:   Thu, 12 Mar 2020 03:08:05 -0700
Message-Id: <20200312100809.21153-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the PD notifier driver to get the
EC_CMD_PD_HOST_EVENT_STATUS bits from the Chrome EC, and send those to
the notifier listeners. Earlier, the "event" param of the notifier was
always being hard-coded to a single value (corresponding to PD_MCU
events on ACPI and DT platforms) which wasn't of much use to the
listeners.

Prashant Malani (3):
  platform/chrome: notify: Add driver data struct
  platform/chrome: notify: Amend ACPI driver to plat
  platform/chrome: notify: Pull PD_HOST_EVENT status

 drivers/platform/chrome/cros_usbpd_notify.c | 197 +++++++++++++++++---
 1 file changed, 174 insertions(+), 23 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

