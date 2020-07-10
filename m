Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B0FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1002F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfCwh6D5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgGJSwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgGJSwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:52:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72DBC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:52:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so2994115pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COMZHq/bmI3rW0EjkImTHb470i5dmWse5uF/Vl5NgEA=;
        b=CfCwh6D5K90eFXONnLCEs8Z0TOBhBrsGSmjTxhHVwymmgMP45D5Md0h8ScCr8cAmRR
         MJI+2bQtEX3L46HV2NDjAyJP6bB1xhG4uoadXtnelqhnHzFEf3AWrSL2LjiMVS0F+G8p
         KMMgaSvVRVgkcVo65T2kQ/Se/Uk4mHx7kvC4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COMZHq/bmI3rW0EjkImTHb470i5dmWse5uF/Vl5NgEA=;
        b=BhFASIIJ9UVSSYTCLETrYlZwooCyff8kxU0L2PtLRDlnwUggdo9iii/mQvXOiya7ZS
         1Wrs95mW8PAxHEFJM6/EP4fi76F2NRAYs/RLRH0VEhkDe61hZ+6DJ1AgFcqdPAwL5mfF
         C8EjEiHypri33y/FmdyA7lhilRI3FOcviwvjtdCXyb2rudQ8wOvLz1N9/xQTmJABTS1m
         3VTELbvA3e3UN+6UMA8/ntz3kDGXnT48roH5tYFsLaNjx4Z8IuOF/XZQ3RWQaMdlB5zJ
         JV7ph9eO1eUIlhAUCJe7Q4qy0CIQyONtyOCDif7ZVukXMrdTHY3GJwDHxa46dbmiNYP6
         AxWA==
X-Gm-Message-State: AOAM532kQ4MC+5QRbhPciPvAjNn71wBoGcQVZXDlbyRCb0WUiKOyL1w7
        AkTvVGnlIuCSBc17TGpSGM2J4w==
X-Google-Smtp-Source: ABdhPJx5N9xlRGWNi8z6V/DmZi8W5nzt/JlQuA4NL/6USl4TB9kWBjlijksjUqWJj4iPT958t5Er9w==
X-Received: by 2002:a17:902:684e:: with SMTP id f14mr32765797pln.166.1594407120493;
        Fri, 10 Jul 2020 11:52:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l16sm6415936pff.167.2020.07.10.11.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 11:51:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp 0/2] selftests/seccomp: SKIP tests requiring root
Date:   Fri, 10 Jul 2020 11:51:54 -0700
Message-Id: <20200710185156.2437687-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes the seccomp selftests to pass (with SKIPs) for regular users.

I intend to put this in for-next/seccomp (to avoid further conflicts
with the kselftest tree).

(and for those following along, this is effectively based on the -next tree)

-Kees

Kees Cook (2):
  selftests/seccomp: Add SKIPs for failed unshare()
  selftests/seccomp: Set NNP for TSYNC ESRCH flag test

 tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1

