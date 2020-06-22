Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A728FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4CA2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwidX3Ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgFVLMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgFVLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:12:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE12C061794;
        Mon, 22 Jun 2020 04:12:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so8250661pfa.12;
        Mon, 22 Jun 2020 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYAXPW7DT0kbvzrQebyhhIbPbS864IccOljK5pvAni0=;
        b=AwidX3ZexkpxDTHKyTCGp46jSNW2xMBBWhPBN56AWN4n6wEVZfIQfLnHUtbsVPC/+q
         vHSkQ68iyNPUheHNKCpbOSIbouDo4Fb6Cq4jawLnxgXqYfSUFwy7Bhlj2B5DaPx/hoOz
         XmQGM7H/6M7XbjcOe9abIhMO/hLNUvoEF+EqPw7Y/Ju89+cXXG54N1oIAcwtiAbSb7mz
         +vrTrj2CmD2oqV5dvdp7w2d6m1zhtiGdtm2ECq2Hya31fWGr4QScfV6dtp34YYx8KiLa
         Kmu1m1VrnvCOas6ZRsUU69J0vlNoZJo8g/qxNJIVmOCbRzrejzbYO7qevtEAHO5zNTqY
         LtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYAXPW7DT0kbvzrQebyhhIbPbS864IccOljK5pvAni0=;
        b=DUIaGT1G8SdwQOgSZwDmhZM2QV/ZU3h8VH5fX8YE+e5xVo1R/7OsC5QLJfe1NZ3y0/
         cd7EOrxp+U8RqtRupF8E+tK6Lu+RSSU5130zLoU0yTJ0r7jRxORUnIZCga3w/2bTAvy0
         c1FsBfd1ZCkH0Z32MuFDb65FZSSxARQOpL47OEf8z6gSdsAkP5eGq9owj2+7wGI0ts0K
         vVe6YQq2LphL+30jG9d1KOQwKRQNznpIZ16klEqnzzPDUhoof0AcAStdHSYM1pl8qAPq
         ex8sqEaXOkw05dPl6qNdJl82Sh5Oxna3W9usemRuYGGG6Jf4szKAXiIo4JpLge8WnLzM
         6qyg==
X-Gm-Message-State: AOAM531es+ECUI6RMthq4KGgKvObVB5Dq/1DTFXm39hju9kW5ivekz1V
        gSLpSZZxaTkTZI3JQ+xaYYE=
X-Google-Smtp-Source: ABdhPJxdh9WVIqHVXa/wZqGd4y+AAcv+Apip4Y9P8JN/SwkmLrq/IJHMqUL7J0kc15kn0dVK0K9DKg==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr21122392pfa.124.1592824352780;
        Mon, 22 Jun 2020 04:12:32 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id f205sm13467355pfa.218.2020.06.22.04.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 04:12:32 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Don Fry <pcnet32@frontier.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 0/3] ethernet: amd: Convert to generic power management
Date:   Mon, 22 Jun 2020 16:41:06 +0530
Message-Id: <20200622111109.55674-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to remove legacy power management callbacks
from amd ethernet drivers.

The callbacks performing suspend() and resume() operations are still calling
pci_save_state(), pci_set_power_state(), etc. and handling the power management
themselves, which is not recommended.

The conversion requires the removal of the those function calls and change the
callback definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

Vaibhav Gupta (3):
  pcnet32: Convert to generic power management
  amd8111e: Convert to generic power management
  amd-xgbe: Convert to generic power management

 drivers/net/ethernet/amd/amd8111e.c      | 30 +++++++++---------------
 drivers/net/ethernet/amd/pcnet32.c       | 22 ++++++++---------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 19 +++++++--------
 3 files changed, 31 insertions(+), 40 deletions(-)

-- 
2.27.0

