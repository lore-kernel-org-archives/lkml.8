Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3616AC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B0120767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSiquivy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCRP4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:56:16 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:46027 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:56:15 -0400
Received: by mail-lf1-f45.google.com with SMTP id x143so4611011lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DzOdrsW97KdLqXTxd9ksU9+GnyXc9/hhsBl/C1xbNT0=;
        b=XSiquivyhfl3GaGYHiw+zEMxuIxvv0pXuF5G2LuCQRXPuaJSiOiGLR5p9S35kt+NI/
         +NiUotKn6JvlxeHYeixqtObYKvAOMTpcfyLS+NqcjGnHbul/V2TZKdyhSXsGIF6rvLMQ
         13+ZvUJwth3SezRXe8/flOko56JkqJlOEsygfvNhojFJhgXs+Auh1xAGPLiSc1q4V6Xx
         Wqyl/D3E2ufsthHTXO+s0prGcolWaOIw1poDePkAp7WH7Tb3USbubsmH+CtNFN5P5t/J
         MagQf9CZYtUlQq1NZ97mQxSwF+8C7Kzj/zreTyMH4UdPUCE8+PzlFAtpe7VnqCrvdACT
         YSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DzOdrsW97KdLqXTxd9ksU9+GnyXc9/hhsBl/C1xbNT0=;
        b=cl6YXZmxYtKOOIl2RtkSVi4Sf6Qqb93rtvMA1dgc4gY/hydzlu9NlAjK7FShwSPOpw
         9zIvj/ooCmCLbcQHGvPxY55NXmtkhtdRLqQDGE3i3U4MqN8AlUFWhrPc+O0Be62sRshY
         eoIm1eqkykO1pHurtI1rv0u3C5lzY3oMACREYLBOX0rNJCMjjZMVeJ0yqzlJwQ0cNhwE
         UVnz6c5uCUz0AQerekAhmsQIjaEzOs0O2G4+iJyM50ac7/v0l3yaMqlWPdxhGHyhUl1E
         6bRl/T2SSFV/OGpBEFEdMTMKH7RgEnzUU7jUNB4oT2nqJnRGLN3OVZtQBIzhfSzoOlTI
         1FDQ==
X-Gm-Message-State: ANhLgQ3gofrDDBj258tOgEEJ9tRutLVLMsr0867TVQbFcf2N8ndSrnLK
        2EqU/5rqySW7blJ0f1wREgYrS4W0fH72f6bGzNGefA==
X-Google-Smtp-Source: ADFU+vsDZbF18oB7HRyBSPzjs+IYS5tBn4pxKjv50NIP6u4ac+UT6Jp6ZtijUK5QhY8lAy9TtQ9x3BpoCJ4/RiHzx4M=
X-Received: by 2002:ac2:5de1:: with SMTP id z1mr3225019lfq.95.1584546972965;
 Wed, 18 Mar 2020 08:56:12 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 Mar 2020 21:26:01 +0530
Message-ID: <CA+G9fYsT2B0WFPV0uohH=QT+CU09OscZvsUV3pnhG-xjPF+OqA@mail.gmail.com>
Subject: =?UTF-8?B?a2VybmVsL3JjdS90YXNrcy5oOjEwNzA6Mzc6IGVycm9yOiDigJhyY3VfdGFza3NfcnVkZQ==?=
        =?UTF-8?B?4oCZIHVuZGVjbGFyZWQ=?=
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        rcu@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, Joel Fernandes <joel@joelfernandes.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 build failed on linux-next master branch.

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild Image

In file included from ../kernel/rcu/update.c:562:
 ../kernel/rcu/tasks.h: In function =E2=80=98show_rcu_tasks_gp_kthreads=E2=
=80=99:
 ../kernel/rcu/tasks.h:1070:37: error: =E2=80=98rcu_tasks_rude=E2=80=99 und=
eclared
(first use in this function); did you mean =E2=80=98rcu_tasks_qs=E2=80=99?
  1070 |  show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
       |                                     ^~~~~~~~~~~~~~
       |                                     rcu_tasks_qs
 ../kernel/rcu/tasks.h:1070:37: note: each undeclared identifier is
reported only once for each function it appears in

Ref:
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/476084417

--=20
Linaro LKFT
https://lkft.linaro.org
