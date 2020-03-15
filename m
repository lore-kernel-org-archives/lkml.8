Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10659C18E5B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97C7206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4yLSbp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgCOTQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:16:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40836 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgCOTQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 15:16:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so6891994plk.7;
        Sun, 15 Mar 2020 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CN9k9v/8yanEjvR23mTlz7kA9CFHoWHmloWkKBS3Xfc=;
        b=S4yLSbp0ndcNFd6XrNeRW3x72H5xjX1PGggO6RKE2KMhHWTPIOarIaOzSnkPqdkmmu
         3KcSCod7vNk9ClFu4pv4qhzNy3vKgg+BoMvzpq//eBCfQQW4355FWsYReXn5WsJVK5UZ
         R3JbLN8UQ3esw79Bpw6sVrXK7shFgDQUUVdlss81RJfudRMrz6W6dHMkJfNdYJvemb1q
         URIMNQzOx73yinju9GRZId5tQAtB19vJryHOAxpXzVsJZ7JnU42zFeBNiSIoOOIsstCQ
         0YYBxYBdtaxX66HCSplM2ksq7Ba4JTzDHkDMQN2EAUjbzmYlqyPbA+sDYRo1NmMqaEAl
         W9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CN9k9v/8yanEjvR23mTlz7kA9CFHoWHmloWkKBS3Xfc=;
        b=KQqkaXxj7D8a21xgtbXSe9JTlKC3GV/Sux8VISIn6LrQzh/dlXD4ceYEcUoCGXNgzB
         jAG2J4WEV3qwiG7RWg4mFYMtGJEk6kRjEjEN/xSPQnjTgDXaxPXAGyUGsScrgyij+qUM
         3R0mIVTgdgyEiYWD51UYHHgibNHXnkvj1U6TitZ5lHY/8ks7mqzNRp02FncphCyH28yf
         O4QxX7f6jttBZ1s8DEJr8aXEV0AUC+qUJGIyjq5thdiOlHrvtVRc74JttxCHRH6UjyOc
         y/b8DJMuVkA1URu3f4PErJwAZXQejAqNgwSIVm7xqn3G+mSH6MSD2VJvyizLRSIrL3Xr
         iC3Q==
X-Gm-Message-State: ANhLgQ2VbFII1MLHyy08a4djkNxwMPhislMNDUzxNSsaaEMrO3xT5VE4
        4QEOosuFPivmGKY//wz8cEI=
X-Google-Smtp-Source: ADFU+vsjhDVjjDl11WUJvFRigf5KGVcQfKwnZ9/KJdInHA9LulswWg4d2VO7LJ3xsEd9l0h9798aqQ==
X-Received: by 2002:a17:90a:191:: with SMTP id 17mr20937506pjc.88.1584299799816;
        Sun, 15 Mar 2020 12:16:39 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id 13sm61431882pgo.13.2020.03.15.12.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 12:16:39 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 0/6] usb: gadget: aspeed: allow to customize vhub device
Date:   Sun, 15 Mar 2020 12:16:26 -0700
Message-Id: <20200315191632.12536-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch series allows people to customize aspeed-usb-vhub device IDs
and strings via device tree.

Patch #1 converts the single "usb_gadget_strings" instance to a list of
"usb_gadget_strings" so it's more convenient to support miltiple
languages.

Patch #2 moves LANGID validation code from configfs.c to usbstring.c so
it can be used by aspeed-vhub driver.

Patch #3 initializes aspeed-vhub strings with default, or from device
tree if according device tree properties are defined.

Patch #4 overrides aspeed-vhub's device IDs if according properties are
defined in device tree.

Patch #5 moves fixup-usb1-dev-desc logic from get-descriptor handler to
vhub-init time so the descriptor is patched only once.

Patch #6 documents new device tree properties in dt-binding document.

Tao Ren (6):
  usb: gadget: aspeed: support multiple language strings
  usb: gadget: add "usb_validate_langid" function
  usb: gadget: aspeed: allow to set usb strings in device tree
  usb: gadget: aspeed: allow to set device IDs in device tree
  usb: gadget: aspeed: fixup usb1 device descriptor at init time
  dt-bindings: usb: document aspeed vhub device ID/string properties

 .../bindings/usb/aspeed,usb-vhub.yaml         |  68 +++++
 drivers/usb/gadget/configfs.c                 |  14 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c     |   4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c      | 236 ++++++++++++++++--
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h     |   4 +-
 drivers/usb/gadget/usbstring.c                |  24 ++
 include/linux/usb/gadget.h                    |   3 +
 7 files changed, 312 insertions(+), 41 deletions(-)

-- 
2.17.1

