Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A209CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F4B206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKI/7sa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGPPUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgGPPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:20:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA52C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:20:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so7494167wrn.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvV+kZFJ+bicRAujhVqigbzFyFgwaE2AZB7+TjHL0wQ=;
        b=EKI/7sa6o0FAd3JpJEwHJfrgB5xUNL0OcbuVaKplDph58T1lYOzZjdBhP5dKoWmGYI
         sXeEjWOazGVnXWV0Yc0TQC4ZiOaCbPkx83Q9aJSunxrfALQeqcykNaJ9XSeMBNrgiRY+
         LaM/JhelnlGBhQmf+ZTb+y4UJ9M8KgBkFRlwSxlbELIRG+M229S++tv1nUvFQdZdAHVX
         Agkwi2ecorBoRct3RZvOKHVpZXe6yVQIvgaWbKVjw0KWboDskHI/7dvFkx1eaE3z5KJa
         gOzvKZkPl3QT+rAtFg+vDZqX/Fd2qbPOQpMaA2NG274TTDPe8yevyQSl8ZNcUnicKilF
         94RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvV+kZFJ+bicRAujhVqigbzFyFgwaE2AZB7+TjHL0wQ=;
        b=sIQoGGI3jHe5a+D+cQbPhv1ILBgqvQBNm/DNZ/0cSa9ABuEk4O8u/K5dF4kAV5p7RX
         L3qLQs8T8rM2XWN/6LDz2PcsyS8YfS49RY9xES7vcQOwdx1xQobQCrah3uzWWugU+cXS
         QjYkjPiRFTLltoYINR9nkVcKcAqgSp2MHZu9Jx4c0zJcJZt9u5nwcKbTbQVFyJkohP2R
         uTHUT5yWqPxTmcZRCkwMjIcb053WPHyxW5zAZpD5/q1AFpVgtuE7+e5KDXhkHMBaUoCz
         e2NYI9pZwdyzkVA3IrKZRx7OZC2BpSs2YUgShPD8jOUUPnR31hLW+3B6idYH3+57ZW7i
         k/5w==
X-Gm-Message-State: AOAM531zlyMng0trzL6JSkm6pODfv5n/jy+uTo6bliP0kP1quJjytlyx
        lg5YLVGg5NLT+AeQmZ9c5PlzaQ==
X-Google-Smtp-Source: ABdhPJyrDSufKPQY0n9MIqAfHzqEFnuWTuX77ZT7VEwVUVOGP/zuzHSlc6Ko9MMqOb5l7XR70/gnnw==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr5493759wrq.91.1594912804657;
        Thu, 16 Jul 2020 08:20:04 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u17sm9877687wrp.70.2020.07.16.08.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:20:03 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 0/3] kgdb: Honour the kprobe blacklist when setting breakpoints
Date:   Thu, 16 Jul 2020 16:19:40 +0100
Message-Id: <20200716151943.2167652-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kgdb has traditionally adopted a no safety rails approach to breakpoint
placement. If the debugger is commanded to place a breakpoint at an
address then it will do so even if that breakpoint results in kgdb
becoming inoperable.

A stop-the-world debugger with memory peek/poke intrinsically provides
its operator with the means to hose their system in all manner of
exciting ways (not least because stopping-the-world is already a DoS
attack ;-) ). Nevertheless the current no safety rail approach is
difficult to defend, especially given kprobes can provide us with plenty
of machinery to mark the parts of the kernel where breakpointing is
discouraged.

This patchset introduces some safety rails by using the existing kprobes
infrastructure and ensures this will be enabled by default on
architectures that implement kprobes. At present it does not cover
absolutely all locations where breakpoints can cause trouble but it will
block off several avenues, including the architecture specific parts
that are handled by arch_within_kprobe_blacklist().


Daniel Thompson (3):
  kgdb: Honour the kprobe blocklist when setting breakpoints
  kgdb: Use the kprobe blocklist to limit single stepping
  kgdb: Add NOKPROBE labels on the trap handler functions

 include/linux/kgdb.h        | 19 +++++++++++++++++++
 kernel/debug/debug_core.c   | 25 +++++++++++++++++++++++++
 kernel/debug/gdbstub.c      | 10 +++++++++-
 kernel/debug/kdb/kdb_bp.c   | 17 +++++++++++------
 kernel/debug/kdb/kdb_main.c | 10 ++++++++--
 lib/Kconfig.kgdb            | 14 ++++++++++++++
 6 files changed, 86 insertions(+), 9 deletions(-)

--
2.25.4

