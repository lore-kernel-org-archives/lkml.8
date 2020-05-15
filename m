Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C0A20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FepFYDdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEOSos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgEOSon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:44:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707F4C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:44:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so1400927pgg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqpEyjmRGymmAkpEVNLXc9rm3KhELEO9r/R/WZVikzc=;
        b=FepFYDduMkE+0Vc6udG9athvibh6QBvTsQoYsBFI7fTVizPHCZoDeTiA1Qh1GhyRsu
         KE65oHTsa+hmwdwO4VpPHRts+bXH6NsISs8EGjuR/EukerazV9u0Qpsi4MhsN4Odq6Wa
         +FNAlLl++yjbjgUKqAnw0ypxXMATy9BiLo+Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqpEyjmRGymmAkpEVNLXc9rm3KhELEO9r/R/WZVikzc=;
        b=ohuB89jVPGyjLYgxB1xWsy/SZTXX1g6mEt8T61morAas5Gb/PY+puYqxyQa2J6IgWR
         o4BN5IsDN/LOe1Ie5E5s5Fg2B/Jk+zzLzyBTlrtAip9sxpgQ20JcD/9Meu3TLS6ijajl
         MBEpw8cW3MNdW/JuX2JkIH4xAu4aqfUjUG/gZERYw+y2CqleezVTmdtw76eM/CZVwGQX
         STXj44Xhdk45+zztJQj9aPPQe4KR54WiAw/8HYjdCnh5b8tSbp0mgcMLgHMyXXqjtthH
         bC0ZsCAmo7gQNSFiPa9GDPPaNEQIBI4Qn51kpE3/mTIaoVJfhI3xhFNthoeru0GOHu6R
         aMPQ==
X-Gm-Message-State: AOAM532HQ8d0oQdiBkbrajj7uNIlJ/XGF+PvzOHyXTmDs4a8JK7SQsOa
        GihaFHxjjmMYOh61UxqIfe7IJA==
X-Google-Smtp-Source: ABdhPJxDRJnJDZmBecNcZ4uRgeiGUpxX7zgXYIqmKtnUH4FhAIJ11bjo7gZpRkIMVbYw1HRdWk2dWg==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr4280548pgr.201.1589568282926;
        Fri, 15 May 2020 11:44:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm2518425pfr.215.2020.05.15.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:44:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/6] allow ramoops to collect all kmesg_dump events
Date:   Fri, 15 May 2020 11:44:28 -0700
Message-Id: <20200515184434.8470-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I wanted to get the pstore tree nailed down, so here's the v4 of
Pavel's series, tweaked for the feedback during v3 review.

-Kees

v4:
- rebase on pstore tree
- collapse shutdown types into a single dump reason
  https://lore.kernel.org/lkml/CA+CK2bAPv5u1ih5y9t5FUnTyximtFCtDYXJCpuyjOyHNOkRdqw@mail.gmail.com/
- fix dump_oops vs max_reason module params
  https://lore.kernel.org/lkml/20200512233504.GA118720@sequoia/
- typos
  https://lore.kernel.org/lkml/4cdeaa2af2fe0d6cc2ca8ce3a37608340799df8a.camel@perches.com/
- rename DT parsing routines ..._size -> ..._u32
  https://lore.kernel.org/lkml/CA+CK2bCu8eFomiU+NeBjVn-o2dbuECxwRfssNjB3ys3caCbXeA@mail.gmail.com/
v3: https://lore.kernel.org/lkml/20200506211523.15077-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20200505154510.93506-1-pasha.tatashin@soleen.com
v1: https://lore.kernel.org/lkml/20200502143555.543636-1-pasha.tatashin@soleen.com

Kees Cook (3):
  printk: Collapse shutdown types into a single dump reason
  printk: Introduce kmsg_dump_reason_str()
  pstore/ram: Introduce max_reason and convert dump_oops

Pavel Tatashin (3):
  printk: honor the max_reason field in kmsg_dumper
  pstore/platform: Pass max_reason to kmesg dump
  ramoops: Add max_reason optional field to ramoops DT node

 Documentation/admin-guide/ramoops.rst         | 14 +++--
 .../bindings/reserved-memory/ramoops.txt      | 13 ++++-
 arch/powerpc/kernel/nvram_64.c                |  4 +-
 drivers/platform/chrome/chromeos_pstore.c     |  2 +-
 fs/pstore/platform.c                          | 26 ++-------
 fs/pstore/ram.c                               | 58 +++++++++++++------
 include/linux/kmsg_dump.h                     | 12 +++-
 include/linux/pstore.h                        |  7 +++
 include/linux/pstore_ram.h                    |  2 +-
 kernel/printk/printk.c                        | 32 ++++++++--
 kernel/reboot.c                               |  6 +-
 11 files changed, 114 insertions(+), 62 deletions(-)

-- 
2.20.1

