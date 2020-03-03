Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E28214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUKKRcg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgCCJMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:12:52 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:44012 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:12:52 -0500
Received: by mail-lf1-f41.google.com with SMTP id s23so2034770lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=webVfTVndS6XThgPyAVNFpl5tOTAYBInHLTGeWuHKJE=;
        b=uUKKRcg67lNfduX3RpLlDWfBNHJ2GjUKgQGBgGOuRqYuV5zNYTC73UfjUWCPuHfu1G
         lh4SfX4IzRtPvlYju4MQNP3JF549ulHmxvxEvOc5EC2nc3tayIO6nnc4tKBG6ge9vURA
         NkVT4blZB1EYc7B+h6GrL5KQc79epj6O5SL5kIUi9mhF9gu7Dq2sDCM+/wb3ZeAmWdzo
         ygNQT2H7pV0qDNffs2mqfBDdhzSjEk73pzIXxNfQ3j3VG7+mbLX2gqANl+qsJZe2qlqf
         RzLKHgAqk0eptTUAsbUy0XKdvxKH12ho3Zwc636ubpLk+ojWO//vsA5d+I6GU/aGcbYl
         fwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=webVfTVndS6XThgPyAVNFpl5tOTAYBInHLTGeWuHKJE=;
        b=innL5wQcp9HTrjL5P5NnKeg0lSofH3r1Ap7adsHTubn12F8o8asJEuepSe+Suve2zu
         44GRy9XH+AaCJDm4Rq3g9SAfepPgE9Ry3FD3459gZO3kxdlDPe9/x5PgfP+rlp8OZbBr
         q3wa2tgNwTzqjRMSYvThKEaf9lwlqJE8ZwY8SUr2i/LChBs5PjMeQWVIInrN11Yx5Iq+
         MZkczpvE7lWbAcs2evxKYNvjSZ/qhbuYJMXDn1R9EwwlATPF00KqW2OMMeu6XDnvnmAm
         3OBKCnM67YI42+X5PgAdWkGp+KCYodCJJ7K9Tj2A50RlvkwpsMksTH25zenZhh6kFOcu
         VMdQ==
X-Gm-Message-State: ANhLgQ0NvHPUaWPg7CDUjPA2kd0tRMUly9pLcTn3JWUJPfjosAQC+Sat
        kbGsTD8fyx5MGlEoc62mLxsSDc6QYNetb+eyKc8qHAZHeOf+fw==
X-Google-Smtp-Source: ADFU+vtDnSaefSMWVwHNRwxZEkgVSJ9QanzxkS5eGQPCCT38mUZH/XF7un5tlWGwHdhjyFe7fZeHWHL3J5WX6OJDOs8=
X-Received: by 2002:ac2:4d16:: with SMTP id r22mr2053410lfi.74.1583226769821;
 Tue, 03 Mar 2020 01:12:49 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 3 Mar 2020 14:42:38 +0530
Message-ID: <CA+G9fYtE-=odd9OLrGim-D1hqgrMaoxqpGSvXCNLfAicdxS8jA@mail.gmail.com>
Subject: =?UTF-8?B?a2VybmVsL3NjaGVkL2ZhaXIuYzoxNTI0OjIwOiB3YXJuaW5nOiDigJh0ZXN0X2lkbGVfYw==?=
        =?UTF-8?B?b3Jlc+KAmSBkZWNsYXJlZCDigJhzdGF0aWPigJkgYnV0IG5ldmVyIGRlZmluZWQ=?=
To:     open list <linux-kernel@vger.kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        lkft-triage@lists.linaro.org, anshuman.khandual@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next-20200303 arm64 build warnings
Please refer below links for more information.

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild Image

../kernel/sched/fair.c:1524:20: warning: =E2=80=98test_idle_cores=E2=80=99 =
declared
=E2=80=98static=E2=80=99 but never defined [-Wunused-function]
 1524 | static inline bool test_idle_cores(int cpu, bool def);
      |                    ^~~~~~~~~~~~~~~

ref:
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/457079061
http://builds.tuxbuild.com/fBmL_h3chXb8rMVt7r0aFg/build.log
http://builds.tuxbuild.com/fBmL_h3chXb8rMVt7r0aFg/kernel.config
http://builds.tuxbuild.com/fBmL_h3chXb8rMVt7r0aFg/bmeta.json

--=20
Linaro LKFT
https://lkft.linaro.org
