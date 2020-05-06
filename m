Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91AAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6512075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LJ17gtKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgEFVPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729688AbgEFVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:15:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675E8C03C1A7
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 14:15:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so1764185pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/XCL1fsewz1wv+0YN1B6q5DwndvHtJ46IG2XGKxKkc=;
        b=LJ17gtKZ5RCiSk4FFPSrLts9kY+6gVoaJHhHAK4elrJ5HYs7Re8PekuMrTMDTbowO/
         SSluTHjRjYjytzyAq6hHqEC1n5fB2I22oH2gq4YFrhQCpZnhRo1qDJK3q5787DBLZiUz
         R62JQc4JS07Vmp2QpY7YmwMyVoRd5SXQcqqIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/XCL1fsewz1wv+0YN1B6q5DwndvHtJ46IG2XGKxKkc=;
        b=Qjby5jIfp9kgqCV4gSP6Nh4zoQu95xhC3h4L9vBwM0gkj8LncH0AUXrfh/o/mdXZmm
         JpvOK/TY1DXi2+PrmabzWuxRPxHtFziCQB84CJvjLxF4GqEjzQtVxP/rQhbeYWcrzeZz
         qIGuqnrxbM1VNt2VlFvRFP8Tu5tU0pDCatISxmFFX4MYU5XTZJMbYs93ZsIsLLuIdDPk
         xIgXBjLiQ4qwVU6TkBhU2MjY/lXEN8tCWqt4hmJrEE6hKMMjnR7cPlH734FHhQXsuxld
         cth4zADZeAE7Tl5skl5CCYYNOletRByqJqsNykTro+E41yqlLl1Oc26oeJHJBLgj+fU1
         Qzkw==
X-Gm-Message-State: AGi0PubWBRwzKP5Z+PcUOH/cpe1objM9+yxJfbytPKJFI0+7jnjBfXm7
        89aPRR/9GQfi8Zy34GcW2CQxiQ==
X-Google-Smtp-Source: APiQypI/pTh6kOO0ohxDbY5vssPPtVaFSIZETH0t6dPMEwVl4GH4h+EMDj98Y0NsEBc9c6g4zYaF4w==
X-Received: by 2002:a62:a11c:: with SMTP id b28mr2765864pff.180.1588799732927;
        Wed, 06 May 2020 14:15:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm2752547pfc.7.2020.05.06.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 14:15:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, jmorris@namei.org,
        sashal@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/6] allow ramoops to collect all kmesg_dump events
Date:   Wed,  6 May 2020 14:15:17 -0700
Message-Id: <20200506211523.15077-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is my stab at rearranging a few things based on Pavel's series. Most
things remain the same; I just tweaked how defaults are arranged and
detected and expanded the wording in a few places. Pavel, how does this
v3 look to you?

Pavel's original cover letter:

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

v3:
 - expanded several comments and commit logs
 - move max_reason member earlier in the structure
 - refactored DT parsing to allow setting defaults
 - changed how deprecated dump_oops fields are detected and parsed
 - cleaned up some module param permissions
v2: https://lore.kernel.org/lkml/20200505154510.93506-1-pasha.tatashin@soleen.com
v1: https://lore.kernel.org/lkml/20200502143555.543636-1-pasha.tatashin@soleen.com


Thanks!

-Kees


Kees Cook (2):
  pstore/ram: Refactor DT size parsing
  pstore/ram: Adjust module param permissions to reflect reality

Pavel Tatashin (4):
  printk: honor the max_reason field in kmsg_dumper
  pstore/platform: Pass max_reason to kmesg dump
  pstore/ram: Introduce max_reason and convert dump_oops
  ramoops: Add max_reason optional field to ramoops DT node

 Documentation/admin-guide/ramoops.rst         | 14 +++-
 .../bindings/reserved-memory/ramoops.txt      | 13 ++-
 drivers/platform/chrome/chromeos_pstore.c     |  2 +-
 fs/pstore/platform.c                          |  4 +-
 fs/pstore/ram.c                               | 83 ++++++++++++-------
 include/linux/kmsg_dump.h                     |  1 +
 include/linux/pstore.h                        |  7 ++
 include/linux/pstore_ram.h                    |  2 +-
 kernel/printk/printk.c                        | 15 +++-
 9 files changed, 97 insertions(+), 44 deletions(-)

-- 
2.20.1

