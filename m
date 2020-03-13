Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718EBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479912074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kkqs3BLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgCMXNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:13:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39537 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCMXM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:12:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id w65so6185302pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2JbZxMCwj9yygU/wyDgBKZMbpIm9EC3h34COxFARqI=;
        b=Kkqs3BLuKJ3D6MBEWIMmzbsZsRKqE7w7T7wwPjwk3xFWEUOjqvHR025GoCMbDW6eM1
         eQMYGMtHgnODYRLvpte18+iNvz69QZDX1ciukmpF8PyPxs1AemNi7GFWwpb1JtmuRQfa
         iBZLZqY/+f9z51hptUJUq7aPJKBZi1dRothXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2JbZxMCwj9yygU/wyDgBKZMbpIm9EC3h34COxFARqI=;
        b=GmlMIZRpt3YY9gAzWZcatxPjt2Zef2LWvuuLI+pGE9C3J2E+QW1t3SZP/kMifh6yWf
         t2GRsqBRif8SBD0tXe2OAYjR/7vwKy+8zFILzce/Z8r0cDOy5JV9fhTNyhrqi2QSxBlf
         hX/ZYs+zRrxN/O5clsDQZ0QRM/DgUFMAe9FMo4s1H5TCAY3oD7nbIOumNnJBDeGDG7uT
         F2ZfSfXj9AamZMTtB2UJUx35km04E9HPbeeiDvBoRbZXBGN8ABetNbEId76uTVs7hhWI
         rnpY8MPKMTsGEkvFEgPmmu65yqnqC1IVoPvwOriVGmTV8+LDKnd1kPr476skQ5oX7vmA
         6Vxg==
X-Gm-Message-State: ANhLgQ3VkfDyQvnDTEp/vW7JBs1mJJfdnYPju4chzvhWHy3FYW10zruE
        vcFfVqiReVVpjxDtub/IZ4MXDg==
X-Google-Smtp-Source: ADFU+vsOPRsmmYcwqJ4TRGhHMQesl1WVSQjt29N6D6DzjeWdpqjtSPwAhRNDk2n87LF8Vzp21Y10dQ==
X-Received: by 2002:a62:e409:: with SMTP id r9mr11685548pfh.119.1584141177491;
        Fri, 13 Mar 2020 16:12:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i4sm1422000pfq.82.2020.03.13.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:12:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] selftests/harness: Handle timeouts cleanly
Date:   Fri, 13 Mar 2020 16:12:50 -0700
Message-Id: <20200313231252.64999-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repeating patch 2/2's commit log:

When a selftest would timeout before, the program would just fall over
and no accounting of failures would be reported (i.e. it would result in
an incomplete TAP report). Instead, add an explicit SIGALRM handler to
cleanly catch and report the timeout.

Before:

	[==========] Running 2 tests from 2 test cases.
	[ RUN      ] timeout.finish
	[       OK ] timeout.finish
	[ RUN      ] timeout.too_long
	Alarm clock

After:

	[==========] Running 2 tests from 2 test cases.
	[ RUN      ] timeout.finish
	[       OK ] timeout.finish
	[ RUN      ] timeout.too_long
	timeout.too_long: Test terminated by timeout
	[     FAIL ] timeout.too_long
	[==========] 1 / 2 tests passed.
	[  FAILED  ]


Thanks!

-Kees

v2:
- fix typo in subject prefix
v1: https://lore.kernel.org/lkml/20200311211733.21211-1-keescook@chromium.org

Kees Cook (2):
  selftests/harness: Move test child waiting logic
  selftests/harness: Handle timeouts cleanly

 tools/testing/selftests/kselftest_harness.h | 144 ++++++++++++++------
 1 file changed, 99 insertions(+), 45 deletions(-)

-- 
2.20.1

