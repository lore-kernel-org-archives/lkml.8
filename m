Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D7FC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CF5206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hucnDYjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUSHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUSHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:07:34 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D5C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:07:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l9so3848857pjq.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kEBaA/Sh9DZjU6rhJczeK9hcyL832LNh924kuJMa3Eg=;
        b=hucnDYjYLCsHVrzEZqVw+IzJqJfansfvfknmCGCfCUfqXARxTZZWgCxhy4beLvPT2e
         8xm0Z0ELOpVxfg0eFVgqxaFsTYusfQH25XzgLCuJqw8DZuAvCH5v/qm4cJUBk4kTjTYI
         GNbMEbw3VInkcdPCzDWUsydKPlYzAPDYANe6p2SmQAbDWBP1MDz6Re0JuMHvtWX0siVa
         CUwr1FxtrSCFAd5Gq/ciglKKeqTOF5ClEmznW5Etfccq+cB32mh9CsDTQ/XP8QTLsQxe
         NB1UuiJrsVNSeQVB3oR+MfwNEVEW3Jgl83QDY9DWQzDAApNc/AvSXTAcSJNyCI92HEb4
         pWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kEBaA/Sh9DZjU6rhJczeK9hcyL832LNh924kuJMa3Eg=;
        b=ErZj5GhGRj1UwJukchOR0daiJNpRTb23pdH98UbW1JSXhGNgpIc8XvuASKPTZyhu5G
         SjSnAMIduhyRHOl6fkuhtpfXeNMciqewfL4GsM1C+tdvXw/KEhE1Yfj4faqa42yrmibM
         TZYU9ICwERhmbV3QGKooIdr+kqP1MpRAC6fBR8wb25b8xbLPSJF6xzfj4zI0TkyKFQsd
         u2qGPSCykVS1LdpTm91SEcAtHVFCrr/FOsxWyQd16pO3Z2zf/lDWGIv6ull5UQ6d6dmm
         oPG8dbAXsD3WMRzsiKXdfQOEnU0Z+Lu/V0C7pockB2J2iE3IEUjuleUMZsOunl1V6vXI
         o22g==
X-Gm-Message-State: AGi0Pub+iNQvbTpcb+CwDz9Ir88BSX1w2z8hSK6ChIS/NIYrz8psf9AD
        6Q6uhkSdpGuHBYP/rEiWPzOkayAkDTexrnAZPok=
X-Google-Smtp-Source: APiQypJxrzgIk0NV3dowQVMZzYqYkacdn1aJomcM8WofRQIRFuZ7K54v4I/3jwWQj+42J2HhAJ1tOzkGq9g3LurCm80=
X-Received: by 2002:a17:90a:315:: with SMTP id 21mr6452651pje.96.1587492450843;
 Tue, 21 Apr 2020 11:07:30 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:07:21 -0700
Message-Id: <20200421180724.245410-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH 0/3] objtool: add support for >64k sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes objtool for binaries with >64k sections, and
includes optimizations to reduce the runtime for a binary with
~130k sections from >15 minutes to ~4 seconds.

Sami Tolvanen (3):
  objtool: use gelf_getsymshndx to handle >64k sections
  objtool: optimize insn_hash for split sections
  objtool: optimize add_dead_ends for split sections

 tools/objtool/check.c | 48 ++++++++++++++++++++++++++-----------------
 tools/objtool/check.h |  9 ++++++++
 tools/objtool/elf.c   | 24 +++++++++++++++-------
 tools/objtool/elf.h   |  1 +
 4 files changed, 56 insertions(+), 26 deletions(-)


base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.26.1.301.g55bc3eb7cb9-goog

