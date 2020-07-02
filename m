Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06DBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A44206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7b80WgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgGBX12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgGBX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:26:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45606C08C5E2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:26:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so6702188pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dT6/5SMac3wtXA/ljYFQAKilCRwIlUvqkRFcx76hVLY=;
        b=l7b80WgP/9KVetj24VmgUT9DOBWaOm2zCIwYx6IuwWZ6c2fVCdsyBRS5aYxy0GewrX
         tKhLt5bxkJVIBNNyRvbc77SE7w3PAbsT5iDtCHwscAY1foF9ukY/uLANrAV4m+twMA+p
         Dyf5+m5g0uBTdpM8+M7uS1MDAovBBbCn8FkUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dT6/5SMac3wtXA/ljYFQAKilCRwIlUvqkRFcx76hVLY=;
        b=g4aGAyocmxjudiYQrDLKyAcHv0glR3W4WnYL1kg9Iw6CfHZEAnhGx+Vnv3NmcP9ZWv
         2hUysOv5iaClRsaybu6x2HIdAFofcI5MXpjFHEsKTLGyiMNz8HyqAG/e27ymSTgMK5U2
         48YEifsL9BT+DKwIG0HXGxki1r4pLpxQ0tOfp7gcBepJRkfzJVVn8p0wGcSDxL+czBfh
         Hsj8FwT5iJHYFKBvHe3uo/VhDXAwKq1mOpR/mtTjvj0O/dbfDpfJXK2PsFLP8OqfKmyh
         Y6frEfBgyXKuRkbNIk52N7eUZwxtWHo87CZC0XMQPys/oQmG89IvvoD/l76BtcJ7r+D4
         I0Vw==
X-Gm-Message-State: AOAM531ZvRXXzcOiSA6Spad5tLVCCPiGrHxC1wubK2LnvvDj+wOUq3b5
        JKbunmFvFoFq9PdIgPQ9iHGgGQ==
X-Google-Smtp-Source: ABdhPJw33nr5S79BxxRlF82vDbMAVkEgPdFtkwFxNrR2snkoy7WQHNOxVKjahspezQFiRSUaOG4PGw==
X-Received: by 2002:a17:90b:488:: with SMTP id bh8mr33638518pjb.49.1593732402767;
        Thu, 02 Jul 2020 16:26:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm9418640pfi.68.2020.07.02.16.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:26:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dominik Czarnota <dominik.czarnota@trailofbits.com>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matteo Croce <mcroce@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Refactor kallsyms_show_value() users for correct cred
Date:   Thu,  2 Jul 2020 16:26:33 -0700
Message-Id: <20200702232638.2946421-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not sure who should carry this tree (me? Greg? akpm? Linus?), but
it fixes a kernel address exposure bug reported by Dominik Czarnota,
where /sys/modules/*/sections/* contents were visible to uid-0 without
CAP_SYSLOG (e.g. in containers):

This is correct, with CAP_SYSLOG:
 # cat /sys/module/*/sections/.*text
 0xffffffffc0458000
 ...

This is broken:
 # capsh --drop=CAP_SYSLOG -- -c "cat /sys/module/*/sections/.*text"
 0xffffffffc0458000
 ...

Fixing this required refactoring of several internals, and in the process
uncovered other users of kallsyms_show_value() that were doing checks
during "read" context instead of "open" context. This fixes all of these
cases by plumbing the file->f_cred through to their ultimate checks via
kallsyms_show_value()'s new cred argument.

Testing, reviews, and acks appreciated. :)

Thanks!

-Kees


Kees Cook (5):
  kallsyms: Refactor kallsyms_show_value() to take cred
  module: Refactor section attr into bin attribute
  module: Do not expose section addresses to non-CAP_SYSLOG
  kprobes: Do not expose probe addresses to non-CAP_SYSLOG
  bpf: Check correct cred for CAP_SYSLOG in bpf_dump_raw_ok()

 include/linux/filter.h     |  4 +--
 include/linux/kallsyms.h   |  5 ++--
 kernel/bpf/syscall.c       | 37 +++++++++++++++------------
 kernel/kallsyms.c          | 17 ++++++++-----
 kernel/kprobes.c           |  4 +--
 kernel/module.c            | 51 ++++++++++++++++++++------------------
 net/core/sysctl_net_core.c |  2 +-
 7 files changed, 67 insertions(+), 53 deletions(-)

-- 
2.25.1

