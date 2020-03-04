Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F463C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BF620848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583360048;
	bh=L+PmTnojJEfdHrn+v1Qfp4HJ6oT+DETDCMkAqiA6GDo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SC1nHbWzz5r3SZazcdeRR1unEnXAjWjlGyIUGzA/LNgoX4rTfmrCaCfrSJ7oaFJJ5
	 eclCtFtSOK4pQaTTG27J2T89J+Yc3YVBW/l3SnQenCX9urh9Mw2abdvvVrsY/M+KRl
	 wKlZ7iuubB26Y2aI3m4zy4hYc7yS9xx0Isot0EXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgCDWOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:14:06 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43456 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbgCDWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:06 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so4184923ioo.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RZnySPr2P+YN4LWk4hB1TPPuvNEvChvRV3l/kgeEwU=;
        b=PD9GxB+apE6cVObJRfsp5PWD0Cc8EUWjgheljvrVaHsQrwpzXyquxRPPow9txiSNwW
         sKESrBfxYVCgiMdliBnJdX7ycHA7Bs4M1W0hgJpzP+3N2FYRTi2nw2trTR8PSflwYOiG
         Oa7Fa3aBsGMCYqI9o2PM7ISkI5DyqA3CEme2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RZnySPr2P+YN4LWk4hB1TPPuvNEvChvRV3l/kgeEwU=;
        b=Tl8ABxj5BF4IOB+tH33X3VZDwC6bYT3icTDE62o+bCA9pEtucewbCZJ3HO+pIKpQAi
         iBaQXFj0Qj5g+1ajk//KP14kLfuPG9D3pXM094EjMZeJ81PCk7lrdydlly6kMWHHan1A
         aA3YqRL6GDMUZ6W7e6jDaTfMw++ZC20vP73j0nNMjOG3XJVHGL5hQ5l4jWTYCtijR8u6
         XWIx2FHuGckdcizcZqvnuZUkYLYasUwc97nv0EOBV3Ep7/4XWbfsuwPnqmDpTOX7dH1O
         Ki83uTSFNy5qWuSJs0e19v/8iSiE/aWxkfZtpk7bVwmhIi9W3mCW0DgszSg/SttGWzgP
         Z65A==
X-Gm-Message-State: ANhLgQ1LpKaUq0FoFqBdxHPtRBSiZ8DksyNjPt4Ow3Njh+ioSax1AdgJ
        io8HcX1uVqSvFXkJnqqcNtCnDA==
X-Google-Smtp-Source: ADFU+vvbVUBntaUuM+BR9AtlDvcRMDW37o/tSJ1CxI9aA+ZUljxG1XOijk2DoUbaKr8ANC+GyheLRQ==
X-Received: by 2002:a6b:6007:: with SMTP id r7mr4147160iog.223.1583360042621;
        Wed, 04 Mar 2020 14:14:02 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:01 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 0/4] Kselftest integration into Kernel CI - Part 1
Date:   Wed,  4 Mar 2020 15:13:31 -0700
Message-Id: <cover.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series consists of first round of fixes to integrate
Kselftest into Kernel CI.

You can find full list of problems in my announcement I sent out
last week:

https://lkml.org/lkml/2020/2/27/2221

These fixes to android and seccomp tests address relocatable support.
However, they will still leave the source directory dirty.

android test does headers_install in source directory. This is an easier
problem to fix. seccomp on the other hand builds fixdep scripts under
scripts/basic and installs headers in the source directory. It is linked
to solving bpf relocatable build issue which I haven't given it a lot of
thought for now.

There is no dependency on source directory for run-time which is what
we want.

I will apply these kernelci topic branch for testing 
git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git

Shuah Khan (4):
  selftests: Fix kselftest O=objdir build from cluttering top level
    objdir
  selftests: Fix seccomp to support relocatable build (O=objdir)
  selftests: android: ion: Fix ionmap_test compile error
  selftests: android: Fix custom install from skipping test progs

 tools/testing/selftests/Makefile             |  4 ++--
 tools/testing/selftests/android/Makefile     |  2 +-
 tools/testing/selftests/android/ion/Makefile |  2 +-
 tools/testing/selftests/seccomp/Makefile     | 16 +++-------------
 4 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.20.1

