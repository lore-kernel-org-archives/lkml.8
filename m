Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E333AC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36A520768
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gHFALgYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgDJAIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:08:01 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:36978 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgDJAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:08:00 -0400
Received: by mail-pf1-f179.google.com with SMTP id u65so314857pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Tjv9zMJn2YHc3izqrZKgOj37Bk9MfHeVEZyetQC/ao=;
        b=gHFALgYjav/vbnoQF2YkYu+ryTWTVwNZcLgm3OsA5FeGP8GpfcWMkMPYlGjJUH/xkl
         yJQ08SZQ6J2Nnf7cVBk4ebNFtLuGVaAZgkHBX4POy98+BGZHc0P00xTaj0Yiqv9sge3Z
         TiXKNczlyLHFAQg3KNKVgE4ozrcifuVrlShqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Tjv9zMJn2YHc3izqrZKgOj37Bk9MfHeVEZyetQC/ao=;
        b=O+HEYiGVlgklY25v6I1A0bJA3UdtU+N3Uut+Q4d5vNlPmSNFCbV7jwPeKagsTtl1eI
         MZcNTWAX6yLg4hdaC421Lcv+MFjsdAC/fUC7Qj72AO146w5P+72Wqu57QreoL3h6JbhR
         zPr1/PvqYaVWWFuKwlJ4+/i2MoISQRJAzhSobNbnrFY2m/4Kjllo9cHY9DY06xRnZecA
         whnW2iVhi+PHEcn3padbfnC3Ze4DcXGz2zFTq7/+gfO9hwHRtUIm0ot9ea17d4LQWrxP
         JcMtIgJukUOJe5cT0f2ajUDfZyZZVreoYwM3FbiKVGWrKY4Yen7VJDTNwFnwUBKeOPwE
         FBmA==
X-Gm-Message-State: AGi0PuY+EFQaAdiPuEzxaaSQrFrHomyvMms3ZSA1ObhUfYbq/j8a3pcO
        OOFzm+ZTfNTlsXM208I6DKnIPwEzwfg=
X-Google-Smtp-Source: APiQypLU7m9JrnjTCxUOK4EKnRUmfLLLGQN6QLsgzp5iMS6cRlWoYHZWuFyeEEpaYOTpz9rIsi8T9A==
X-Received: by 2002:a62:b603:: with SMTP id j3mr2165017pff.208.1586477279421;
        Thu, 09 Apr 2020 17:07:59 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id x188sm218686pfx.198.2020.04.09.17.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:07:58 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 0/3] platform/chrome: typec: Add port partner registration
Date:   Thu,  9 Apr 2020 17:07:50 -0700
Message-Id: <20200410000753.198507-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds port-partner registration when
connects/disconnects are detected. In order to do that, we also register
a listener for the cros-usbpd-notifier, which will inform the driver of
EC PD events. While we are here, separate out the Type C port data
objects into a separate struct.

v1: https://lkml.org/lkml/2020/4/6/1155

Changes in v2:
- Added Kconfig dependency.
- Fixed style comments.
- Removed unnecessary devm_kfree() call.
- Fixed incorrect error pointer return.

Prashant Malani (3):
  platform/chrome: typec: Use notifier for updates
  platform/chrome: typec: Add struct for port data
  platform/chrome: typec: Register port partner

 drivers/platform/chrome/Kconfig         |   1 +
 drivers/platform/chrome/cros_ec_typec.c | 119 ++++++++++++++++++++----
 2 files changed, 103 insertions(+), 17 deletions(-)

-- 
2.26.0.110.g2183baf09c-goog

