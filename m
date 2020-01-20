Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E71C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3552073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="W0L2jdRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgATEyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 23:54:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45603 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgATEya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:54:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so15193066pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 20:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN3Z4EtUvjD28efJ92xKpoRYufScEeM5MB1/Qfws810=;
        b=W0L2jdRQ6MREKzDtBfeqsFqnHKSHfF7Sb0eeF/NO+1tO1ak2JirozIT8ho0P748UC9
         v4qHLYd83CfoETl2RH3lHI86fgn7phaWJtD2sN+sibKTOv/Q5NMU8XhsujL/2ad6Z4y/
         dfI+HuzKHI86RmSdmNVVEy0X3+DDCG3/jSsa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN3Z4EtUvjD28efJ92xKpoRYufScEeM5MB1/Qfws810=;
        b=p5GKa2KoxvVB4LFYpnCxH5o/uWQidoXQOj5pl7dPrIG3nq+YS14n8ZYw1LjtXrjDpU
         QuMH+gd+2gZ3xg7ygkt+1ooxdkPD4UcaoD2JcWGkTNztklNTEbEG7Fm1a3Ev1YeNMRw1
         qn4gFxthcO2IQZqG6NO0GDeEJ4gKNFAk2bIkn7VnBPjUwuTURMX83O0dJwGIxdSI3KER
         vZWMq+MwCkbCzDyAgeFsvLVwNve7+ntk4WrQBdnmqVwxZlxtqrtERnxlo6t+kXV/mQM2
         siaygdct9RfbXCzf5LINtGN4vUe3ZNIioD1mrDVTPD25i/nhEQ5KpU1u2MQtMlrgy6hE
         KAfA==
X-Gm-Message-State: APjAAAVFLaB+qpdS+V9DOJBeauQqB7ok1xSyP50nxJsZ5M2X/mpjS/L5
        72NJo3dKfWwJqLD0Ze3LoNhkCQ==
X-Google-Smtp-Source: APXvYqxbURRFxgJ90M08NbktU6NV4cTwTLt4WEZcRDxlNQeK+6mOpbIca82m89cBJLFfn4kJ+VH1eA==
X-Received: by 2002:a63:642:: with SMTP id 63mr56653726pgg.73.1579496069997;
        Sun, 19 Jan 2020 20:54:29 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-4064-d910-a710-f29a.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4064:d910:a710:f29a])
        by smtp.gmail.com with ESMTPSA id i2sm35693066pgi.94.2020.01.19.20.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 20:54:29 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kernel-hardening@lists.openwall.com, akpm@linux-foundation.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 0/2] FORTIFY_SOURCE: detect intra-object overflow in string functions
Date:   Mon, 20 Jan 2020 15:54:22 +1100
Message-Id: <20200120045424.16147-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the fortify feature was first introduced in commit 6974f0c4555e
("include/linux/string.h: add the option of fortified string.h functions"),
Daniel Micay observed:

  * It should be possible to optionally use __builtin_object_size(x, 1) for
    some functions (C strings) to detect intra-object overflows (like
    glibc's _FORTIFY_SOURCE=2), but for now this takes the conservative
    approach to avoid likely compatibility issues.

This patch set:

 - converts a number of string functions to use __builtin_object_size(x, 1)

 - adds LKDTM tests for both types of fortified function.

This change passes an allyesconfig on powerpc and x86, and an x86 kernel
built with it survives running with syz-stress from syzkaller, so it seems
safe so far.

Daniel Axtens (2):
  string.h: detect intra-object overflow in fortified string functions
  lkdtm: tests for FORTIFY_SOURCE

 drivers/misc/lkdtm/bugs.c  | 51 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  2 ++
 drivers/misc/lkdtm/lkdtm.h |  2 ++
 include/linux/string.h     | 27 ++++++++++++--------
 4 files changed, 71 insertions(+), 11 deletions(-)

-- 
2.20.1

