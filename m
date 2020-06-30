Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05136C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D909F20774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJwiWX8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbgF3RtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgF3RtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:49:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15A3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:49:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so9795761pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0nUrGiUjexkgTjbObRwhZnqCGv//XrYLqiXL9DqI6n0=;
        b=oJwiWX8YK+9bf2WRtly6zpZAMEumScCqL08kbgZgXpgN0it2aGlRmlfOEUtLvXeuzL
         71cn/CUemuQRtTm5ukFtxf0wwmRZ4s0V5dZ7vpcOjbPxNh0Vmqwy5nvBKegaxMKf9jS4
         N+eyhAp8Uwa4hTric+6fZGZ1q8b381Ufecd+mRoFRqGLAKPKv7z299gESxitGtdHnG49
         MZ32HmpWb7aZtDBxBgmzv/G28wjBY4Nr2KPOUGkW+npW13mnl+Rk7CR+Ta1thHrVHn4M
         pWDwv8NIEfrIEF9Eqf1C0MJTs4vsyGmp6IMGkCS4lu1Z6wcr/Nr3ee5jp0ToTxtDujcr
         OJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0nUrGiUjexkgTjbObRwhZnqCGv//XrYLqiXL9DqI6n0=;
        b=FAByDhQzI2WRL87/yBFwtYmhr8B2gxL/6duQz/PfDqbdcMjN7It72DZIO1k6vW6JF8
         zQOB6oD3fBw7o4rFpQ0qIng0GA0qp9g6hlspyZ/lCLj8mg7soLZ3W3oqvH2zhlTQTmZY
         HN4CqJ8Rue6koMufsUME977Tlk3lqiWwv0ivbWFYD/P5b+ReGvmZBe590oQwcjDvvUtm
         YnVdIHX1nHXi8UgPhVoZapp+3KrHxsctELee0bLcceJLkBOAic7W4q4JRFq+w4ENDcFs
         2uLZ2ML0mna/L39g72jl+Y4xfJxsFmEZ5bAmViJn8ouJdw7BVb/1dQ9omSG3VVTHVRrY
         1D9Q==
X-Gm-Message-State: AOAM532CX4+4P8buVThvdEch80iH9quwZOdIxxoJWWlBmjqsGaBxaHX5
        HSwdYnF0sl9ztRIyq+c0CHyOJyZeflj4nWzttY92ig==
X-Google-Smtp-Source: ABdhPJzJNfOck99CUCFRcyYg2T1YlkQfR6eKwzFu2R2KuXy2scReiDiWH05bbRDynNZzsdy3+oAlM4k3wVbm27TM3kM=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr23503177pjb.32.1593539355035;
 Tue, 30 Jun 2020 10:49:15 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Jun 2020 10:49:03 -0700
Message-ID: <CAKwvOdmu2Yi=SdR+ftnnfX_HNTfri-MPmzA7kxNzjwuuk=5R3w@mail.gmail.com>
Subject: Clang Build Linux presentations + demos
To:     clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Mathieu Acher <mathieu.acher@irisa.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(bcc a few lists)

Hello,
For tomorrow's bi-weekly meeting [0][1], we have two guest presentations:

Prof. Mathieu Acher, an associate professor from the University of
Rennes, will be discussing with us about the Linux kernel's
configuration space.  A common question we get is "does the kernel
build with Clang?"  "Depends on the config" is just the tip of the
iceberg.  For a sneak peak of his and his team's work, please see
[2][3][4][5].

Nathan Huckleberry is a Comp. Sci. undergrad at the University of
Texas at Austin and a Google summer intern.  Nathan is working on
instrumenting Clang and LLVM in order for us to start measuring,
investigating, and improving compile time performance.  Nathan will be
demoing an RFC he plans to send out later that day.

[0] https://calendar.google.com/calendar/embed?src=google.com_bbf8m6m4n8nq5p2bfjpele0n5s%40group.calendar.google.com
[1] https://meet.google.com/yjf-jyqk-iaz
[2] https://www.youtube.com/watch?v=UBghs-cwQX4
[3] https://hal.inria.fr/hal-02147012v2/document
[4] https://hal.inria.fr/hal-02314830/document
[5] https://www.mathieuacher.com/
-- 
Thanks,
~Nick Desaulniers
