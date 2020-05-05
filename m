Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028EAC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7260206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iBJKRHaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgEEPpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgEEPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:45:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799DAC0610D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:45:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so2712356qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iMmFoNfXYuSj6Qt050Es4e1yzInoELShzYaFIRCBs0E=;
        b=iBJKRHaSbh+OQFNjGqU4rN6pd6hBER3oQdogcX0Ir8S1YSsdS75epglNZCctPu8paR
         PmB6GBMokAs1Hf9vcX8A+ClfNGdJjhSKYHanfdoihgdeaDmLkkkSv/EuO+BTkqjAP3oS
         LgJU+QEqSSpMaS2Wwjpo2DYXOMDyqIi78ibmzahHYXv2wE4WejTNBTIDz+xfozXPf3Cw
         2y29g2uk2yDKPrb7Mv+9qNmg33sACR/nhRXS9CXjlpIFE8Ew23b35Wbi0mRSYo7yhzdK
         coRg3VA18H4WNup3chKxebqQd1qIYbwIaRXryhm+AN5O7x0AgQIbA/qS32BhVcI3Es1F
         9hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iMmFoNfXYuSj6Qt050Es4e1yzInoELShzYaFIRCBs0E=;
        b=Txl54GFvEypgMe1ceO5Tohv2OHkuw8YFHr6ExUI2epdmravkWv/npjaTOp4cy/2im7
         zTJ9iX7SPrebuMn7nYkrKC+Xz0VX5dQ6svAI8Vq/a8OA9wrcc4HOaJ2iHAHexLjMUMUf
         ylW4YscoBRIwF/FoEhuO5i5jrlnn1ZByhhr0KldGludvsnJsz/f6ml4dsRDPHnInzA0f
         RfbjYFQ37hoVM6Aeq3zv5pqGn+7mRQsibxNbcnVGG84Cd7YGsTDsHHJXA3HYb8/yeiIF
         yOvOHZvpLgRf8fPsmgR1W1SiR3U70qUOfUm4qJFiTUZRhuF7BGPWyRH8LsdRb7pNjwod
         xlsw==
X-Gm-Message-State: AGi0PuY440Xn60e7MAHCLGB3NhIIcLwiXMMmJcQVYwJZCA9sXLV4X8rt
        9KHfWkOeCtpaYyqc8zFdTLxCJg==
X-Google-Smtp-Source: APiQypKP+bgpF8ht21oVH7rGLUkGkGtifesHS0oFmm8qZ17AgYqECPhd2o8bIfiWwyerTtKIqyqsoA==
X-Received: by 2002:a37:3d7:: with SMTP id 206mr3831180qkd.89.1588693512610;
        Tue, 05 May 2020 08:45:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x7sm2122407qkx.36.2020.05.05.08.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:45:11 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] allow ramoops to collect all kmesg_dump events
Date:   Tue,  5 May 2020 11:45:05 -0400
Message-Id: <20200505154510.93506-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore /mnt/console-ramoops-0 outputs only messages below the console
loglevel, and our console loglevel is set to 3 due to slowness of
serial console. Which means only errors and worse types of messages
are recorded. There is no way to have different log levels for
different consoles.

This patch series adds a new option to ramoops: max_reason that enables
it to collect kmdesg dumps for other reasons beside oops and panics.

How to quickly test:

virtme-run --mods=auto --kdir --mods=auto --kdir . \
	-a memmap=1G$8G -a ramoops.mem_address=0x200000000 \
	-a ramoops.mem_size=0x100000 -a ramoops.record_size=32768 \
	-a ramoops.max_reason=5 -a quiet --qemu-opts -m 8G
..
# reboot -f

After VM is back:

# mount -t pstore pstore /mnt
# head /mnt/dmesg-ramoops-0 
Restart#1 Part1
...

Changelog:

v1:
https://lore.kernel.org/lkml/20200502143555.543636-1-pasha.tatashin@soleen.com

v2:
Addressed comments from Kees Cook, Steven Rostedt, and Sergey Senozhatsky
 - Replaced dump_all with max_reason
 - removed duplicated enum value
 - moved always_kmsg_dump logic back to kmsg_dump().

Pavel Tatashin (5):
  printk: honor the max_reason field in kmsg_dumper
  pstore/platform: pass max_reason to kmesg dump
  pstore/ram: in ramoops_platform_data convert dump_oops to max_reason
  pstore/ram: allow to dump kmesg during regular reboot
  ramoops: add max_reason optional field to ramoops DT node

 Documentation/admin-guide/ramoops.rst         | 11 +++---
 .../bindings/reserved-memory/ramoops.txt      | 10 ++++--
 drivers/platform/chrome/chromeos_pstore.c     |  2 +-
 fs/pstore/platform.c                          |  4 ++-
 fs/pstore/ram.c                               | 35 +++++++++----------
 include/linux/kmsg_dump.h                     |  1 +
 include/linux/pstore.h                        |  3 ++
 include/linux/pstore_ram.h                    |  2 +-
 kernel/printk/printk.c                        | 15 +++++---
 9 files changed, 51 insertions(+), 32 deletions(-)

-- 
2.25.1

