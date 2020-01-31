Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1EC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46602067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJJwM1k6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgAaF2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:28:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39287 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaF2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:28:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id 4so2847006pgd.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 21:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIJuIwx+uZ/XMXNLR2EZ8VQQbkYP9Jl3B/FlYJ52chg=;
        b=GJJwM1k6h2uFAG4zQaZSh1S+M3GK+TaUphjkvARINrHAOfmtfMFiax8e1B5NhmNtJX
         xzK6NlbLBaIHKgdIupYB2YcrvXo+68BSBsX91XcQL6D1xFfz3ubiE3A6Y5Pd8+tnz8VC
         GOjDs8B+yBBt6BtSdSJgvbrAsMDxn9+UlWmnvDJ0jKI7iwWpLlCXCuc22LkNGPY6teoC
         9TPRtGtgQWP7kSBLB8+RZGQ2uDTQbtO7WJrlvgcxzRQWN54v3NRRJV99Yfzq/DQnPjIw
         mJg3WgMY2BZBSWYRasB67e+kr4MwHdxKbVMVwTpAj90FKhmwojV5O6jNYmZiWyLYvG/S
         qNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIJuIwx+uZ/XMXNLR2EZ8VQQbkYP9Jl3B/FlYJ52chg=;
        b=lPIvB6a6gpvIq4AFifzRJ0D+bWaGcOKeWdyazsKqCuZM+P+p/kimjpO0++uQAugF1x
         tBBDIKkbQ+C9zNRel2l+L6pcURibx5jJl6S4shL74qiCd8U9BMww6Wy6CBpYr/QkvKis
         0iQJiGCNXIppqIGFd9+ptiXB3egPVhEqwK3rMBILSkoUQpyVVpCJ/q/TDBWSygzQVkzI
         M8ZG8Dlp7LRzHP3JN7UzNnj1pYLxaeOBnSmejpajL/U2cOIFN+1wcLbANCsQ0DQhG+67
         iXl3w3NP4ZVrnk4xUDnuIEk6Md/8pDTG8kIUwbLm+iMXFwurOHWefZUJ49GjkLX0WZeE
         IC7w==
X-Gm-Message-State: APjAAAV3ov2cM3LWg8nYGS9i+1Zlhm9IdbIMrZnyDlP9JLQ+fvJh2ZKZ
        uc78jbYlFlZRprQhGfVF3T4xZw==
X-Google-Smtp-Source: APXvYqxBoLAqbWna8B4QXmmmJlTHUuV1LGOaIEXyLauNT0LaUZKXbj4uqg4+VVdUd23y8KmCw/+n3g==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr8493620pfn.232.1580448499304;
        Thu, 30 Jan 2020 21:28:19 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id x8sm8694689pfr.104.2020.01.30.21.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 21:28:18 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     arnd@arndb.de, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, jassisinghbrar@gmail.com,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        peter.hilber@opensynergy.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 0/3] firmware: arm_scmi: Make scmi core independent of the transport type
Date:   Fri, 31 Jan 2020 10:58:10 +0530
Message-Id: <cover.1580448239.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset makes the scmi core (driver.c) independent of mailbox
transport.

V5->V6:
- Divide the patchset into multiple logical patches.
- Create shmem.c to separate out shared mem related helpers.
- Make mark_txdone() optional.
- Drop inclusion of stddef.h.

V4->V5:
- struct scmi_shared_mem is moved to mailbox.c and it is completely
  handled by transport layer now.
- And so lots of ops change due to this.
- Fixed a bug from previous version where wrong dev structure was
  getting passed to devm_kzalloc().

V3->V4:
- Rebased on top of linux-next.

V2->V3:
- Added more ops to the structure to read/write/memcpy data
- Payload is moved to mailbox.c and is handled in transport specific way
  now. This resulted in lots of changes.

V1->V2:
- Dropped __iomem from payload data.
- Moved transport ops to scmi_desc, and that has a per transport
  instance now which is differentiated using the compatible string.
- Converted IS_ERR_OR_NULL to IS_ERR.

Viresh Kumar (3):
  firmware: arm_scmi: Update doc style comments
  firmware: arm_scmi: Move macros and helpers to common.h
  firmware: arm_scmi: Make scmi core independent of the transport type

 drivers/firmware/arm_scmi/Makefile  |   3 +-
 drivers/firmware/arm_scmi/common.h  | 112 ++++++++++-
 drivers/firmware/arm_scmi/driver.c  | 293 ++++------------------------
 drivers/firmware/arm_scmi/mailbox.c | 184 +++++++++++++++++
 drivers/firmware/arm_scmi/shmem.c   |  82 ++++++++
 5 files changed, 412 insertions(+), 262 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/mailbox.c
 create mode 100644 drivers/firmware/arm_scmi/shmem.c

-- 
2.21.0.rc0.269.g1a574e7a288b

