Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A22C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F45024969
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YPDkpBkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgEBOgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgEBOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 10:36:01 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B245C061A0E
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 07:35:59 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v26so10269184qto.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KYvEz9EDAOCfmZdGdMbfD1WMIectx5I39k172/4mro=;
        b=YPDkpBkSZ4j6hI6CqxnpZANdrpJKDkyon3A6Zf3EpRqHhsl1uV+0JpQxVwVz3IHNf/
         0Ltm8o1w/Jef/c1upzBsx08W8aKeC61mvNDa3w44kn8ZFpQwnYZSPIZhGjZG9+9b9HPU
         Z2wC1rjvImEhI5ip1ZQRf/X7jqERcChc25UMVgvU4xBx0Mx3vsyFzLjS2Z7+egKG0Maq
         Hww/fFICU8SHXa3J5fwZgKH+eyj/RScR69Tz75wK4WS18GMXCiMLR7o2xNzfiWSjAFGD
         zwtbYfdPZVpF/QAndsFXx0xnz89cdzXh9+eycVPL1t3jzkHu/pKWFS8dIMs8EHKBqSdD
         LZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KYvEz9EDAOCfmZdGdMbfD1WMIectx5I39k172/4mro=;
        b=fVzCoMOfFFKsy7PT0SbVp6gg/haMunyXoju9JMfDIUXvi9VILEvuohz+CeRbuYOCIR
         RCzEXNNCD/GzVPcoraZhGD7Ooscocc5EUYn1EhhqYpVq1QAvkKQXa/p9OyHmS+GauBMf
         UohYFJJMCzFDLksvoP6bF9waI8ocuafprVAvcWFrQ49t7KtcHHRxhZBfz8XJHN1gfl/5
         HO/8FT928oehOtNRxVsVpuuC2MsA+Y+n45dNYoiTFwr8u14DsOL5HWHmKCYfLZZ4FTD+
         JnYupiFRy8qsteTRiegs0qTJxZXvwGlv9C2XjWXk7qOQsDZwfVJkuEMMsbEqAydlnPK0
         QDKQ==
X-Gm-Message-State: AGi0PuY1I+PsMPpaizyGISrIg8EoUYN0EPe8gtzVb9zuGqVHVhyPfvqR
        SHk+8mEscMzJ/+k1GHIAER+/rQ==
X-Google-Smtp-Source: APiQypKhbAlfJ3NEVQP2KSTrFaDwZOCnIkdiyU4Th81p08h8YwZlst1Jnat37JdJwJh3RNHRrjQzRw==
X-Received: by 2002:ac8:39a2:: with SMTP id v31mr8669445qte.373.1588430158626;
        Sat, 02 May 2020 07:35:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id d23sm5156894qkj.26.2020.05.02.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 07:35:57 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 0/3] allow ramoops to collect all kmesg_dump events
Date:   Sat,  2 May 2020 10:35:52 -0400
Message-Id: <20200502143555.543636-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ramoops is capable to collect dmesg buffer only during
panic and oops events. However, it is desirable for shutdown performance
analysis reasons to optionally allow collecting dmesg buffers during other
events as well: reboot, kexec, emergency reboot etc.

How to quickly test:

virtme-run --mods=auto --kdir --mods=auto --kdir . \
	-a memmap=1G$8G -a ramoops.mem_address=0x200000000 \
	-a ramoops.mem_size=0x100000 -a ramoops.record_size=32768 \
	-a ramoops.dump_all=1 -a quiet --qemu-opts -m 8G
..
# reboot -f

After VM is back:

# mount -t pstore pstore /mnt
# head /mnt/dmesg-ramoops-0 
Restart#1 Part1
...

Pavel Tatashin (3):
  printk: honor the max_reason field in kmsg_dumper
  pstore/ram: allow to dump kmesg during regular reboot
  ramoops: add dump_all optional field to ramoops DT node

 .../bindings/reserved-memory/ramoops.txt      |  3 ++
 fs/pstore/platform.c                          |  6 ++-
 fs/pstore/ram.c                               | 38 +++++++++++++------
 include/linux/kmsg_dump.h                     |  1 +
 include/linux/pstore.h                        |  1 +
 include/linux/pstore_ram.h                    |  1 +
 kernel/printk/printk.c                        | 16 ++++----
 7 files changed, 46 insertions(+), 20 deletions(-)

-- 
2.25.1

