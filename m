Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5CFC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF222070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qc2qN9c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgEFUxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728062AbgEFUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:53:01 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F297C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:53:01 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f56so3965573qte.18
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CQcbxKSUYsAHBe7Ebehk8JAKNTVPAr/UiGZDOPwaAGc=;
        b=Qc2qN9c83pfJHD8uho1tepgh5pW6tBfZF37n4CM3MD32Y0xOob1XZT1Xv+y3pZ+qx7
         dBB3TftZel2t+tBVFBd8Gmpd8I5YkwQYtydO5Ubo9P4sTrTHbdqfX4CpaxnQmWfWWvgM
         GB0IZxjFVxH21WEMvJry1tpuESxde2u8nQYSHCdadbK+JU0TiFO0kVdGrVkPTvGBJVbo
         hK0NlJTJiZMfi1lUhirdBpVEgN4skITYyCBi0AVgxXzHXTLJ47/oWq3xpYZd9ylfxUj9
         u5EyHrWqrjBvrtX8v6pNmKv7i9YRjxMyZS2xaYfpjkuEcvzXdsdCBIu7GTDszAEDs3cX
         ApSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CQcbxKSUYsAHBe7Ebehk8JAKNTVPAr/UiGZDOPwaAGc=;
        b=YFFN89qGZ2oiWuPIvaKyC+z5QjFtgdK51/cG4qQj6lxXKQm4W7baauuaOUaXuqS7iF
         PYVuZmCS8xsuNJXjgg2HdNvaJBQs7s+e04R+rd+AFdjb9J/VR/yaUhCRWA7maRT03k3g
         U0rAhLZ7irNTuKpB+ca3BxZFo1NHV8XFTPFOy+0FRnVhKvDTM6tOeQYUa8rtcAav7OoW
         ZYh8becfh2v7vTx0POWo/XdwxQKjgD6IkrMKpN7WtdrN5uqq1cyVypnugj0XlVwDha2k
         EreX3ql8y532WWCbVu7sWqsvWiryKPARHzeQqvSbnu35n+ssEq5Ljw3BEoUViVf8y6C4
         xIPw==
X-Gm-Message-State: AGi0PuYoqB8X/4hBC0nU92+f3CWjaCL1rOoN08Z4dadGyieJs5pzuboE
        GyoDAbijsr2S+VSg7nfVx9nq4vMCh0G6
X-Google-Smtp-Source: APiQypIdNrd+yYhBZP4TBZUTUJU1co/gZ+3o6Cxir236qhPBm0psRF02DA8GRECv92XUv8iiH2WZiB7LkvTh
X-Received: by 2002:a0c:fc42:: with SMTP id w2mr9758882qvp.77.1588798380452;
 Wed, 06 May 2020 13:53:00 -0700 (PDT)
Date:   Wed,  6 May 2020 13:52:55 -0700
Message-Id: <20200506205257.8964-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 0/2] lib/bpf hashmap portability and fix
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experimenting with hashmap in perf for perf events within a metric
expression. In doing this I encountered some issues with lib/bpf
hashmap. Ignoring the perf change, I think these fixes are likely
still worthwhile. Thanks!

Ian Rogers (2):
  lib/bpf hashmap: increase portability
  lib/bpf hashmap: fixes to hashmap__clear

 tools/lib/bpf/hashmap.c | 6 ++++++
 tools/lib/bpf/hashmap.h | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

