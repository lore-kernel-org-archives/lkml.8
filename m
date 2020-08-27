Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A54C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316B920786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyJ/7/Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgH0TC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgH0TC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:02:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B45C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:02:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so2588802wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MgXI5yT9M2YWoB1R2sbphZ1sVTEoxpYWlpWN7CbOJSk=;
        b=XyJ/7/BoPNCfJ0MQYJI0iky23KAAV2uS0cvfQUbK8RpgWlt9Uj1bekzgAZj2n4SnE1
         YTfedPDthy7DL7hjbKgg3rXP4lf9r0+bXeNfP7Mu/LRF8Rm8sC1q3X7dCNqJs99+Sns0
         sBtaQNKEfOtZopEzaEq5c5dEwHkX1O0VfCJdmgCaJitGDX85jdKyzCvisMPHxLXAoPJD
         pku+pheVQ0jLbESmti22xZOCMWQdgX8UUBBbNq67gdGkOnB7EHV7JaivcmKzL6z3ADf9
         vLIoHRtgTObPq/IBAmvduiOIX5SJlVZmHnOKdg9NzR/XHRz6oYWkwYh70XjXMfW7J5Hu
         CxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MgXI5yT9M2YWoB1R2sbphZ1sVTEoxpYWlpWN7CbOJSk=;
        b=a2qDeJyewPBBGB6/iDbmXuXdwW7VNPqnmaZpbxz/J5ifjFlnEkd1JV0tS6kYN0uwiL
         1GL1pVQPXTZGuzGc8HoxrfvdSO52R+NzO4h5lXC9yGebJiIpfpQooEpa6acUCT9gQUQC
         liavy5Ibjov1BNeo3cXHkRhhkQ+05euvRnxI1fLtt6Nu5BwGdyQDsKZ3fv7NkuQk4d3p
         zp9S7SeFbJqg2OUxO6i2AbAxdftRXU8cOsX9gH0IOW3Hyu3z+pwFUjwTdy/yqr9edhwf
         VFW1RlPnGJV+iub2979I3vhIjvSFn0SIKZvra1s+1MNK/UPo8K97Il8h3zEx3PbiZd3J
         NJeg==
X-Gm-Message-State: AOAM5326lJbhsw8gexXLd1fCAwUQhkX+jbDHpmmdKrZbC6n9zPByVQDy
        A50pDmZEHfzb4T5o45Evuhzhtg==
X-Google-Smtp-Source: ABdhPJyY11Ufw8MVMxw2onLL6SR4vXs9cUjMPeWRwSknou5a2/DPHhxZ5wVc/NWTE+LKcTIYhteo1w==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr5200602wrr.27.1598554944300;
        Thu, 27 Aug 2020 12:02:24 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id c6sm7187094wrr.15.2020.08.27.12.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:02:23 -0700 (PDT)
Date:   Thu, 27 Aug 2020 21:02:17 +0200
From:   Marco Elver <elver@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
Message-ID: <20200827190217.GA3610840@elver.google.com>
References: <20200826201420.3414123-1-ndesaulniers@google.com>
 <20200826214228.GB1005132@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200826214228.GB1005132@ubuntu-n2-xlarge-x86>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 02:42PM -0700, Nathan Chancellor wrote:
> On Wed, Aug 26, 2020 at 01:14:19PM -0700, Nick Desaulniers wrote:
> > During Plumbers 2020, we voted to just support the latest release of
> > Clang for now.  Add a compile time check for this.
> >=20
> > Older clang's may work, but we will likely drop workarounds for older
> > versions.
>=20
> I think this part of the commit message is a little wishy-washy. If we
> are breaking the build for clang < 10.0.1, we are not saying "may work",
> we are saying "won't work". Because of this, we should take the
> opportunity to clean up behind us and revert/remove parts of:
>=20
> 87e0d4f0f37f ("kbuild: disable clang's default use of -fmerge-all-constan=
ts")
> b0fe66cf0950 ("ARM: 8905/1: Emit __gnu_mcount_nc when using Clang 10.0.0 =
or newer")
> b9249cba25a5 ("arm64: bti: Require clang >=3D 10.0.1 for in-kernel BTI su=
pport")
> 3acf4be23528 ("arm64: vdso: Fix compilation with clang older than 8")
>=20
> This could be a series or a part of this commit, I do not have a
> strong preference. If we are not going to clean up behind us, this
> should be a warning and not an error.

There are also some other documentation that would go stale. We probably
have to change KASAN docs to look something like the below.

I wish we could also remove the "but detection of out-of-bounds accesses
for global variables is only supported since Clang 11", but Clang 10 is
a vast improvement so I'm not complaining. :-)

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

------ >8 ------

=46rom 13d03b55c69dec813d94c1481dcb294971f164ef Mon Sep 17 00:00:00 2001
=46rom: Marco Elver <elver@google.com>
Date: Thu, 27 Aug 2020 20:56:34 +0200
Subject: [PATCH] kasan: Remove mentions of unsupported Clang versions

Since the kernel now requires at least Clang 10.0.1, remove any mention
of old Clang versions and simplify the documentation.

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kasan.rst | 4 ++--
 lib/Kconfig.kasan                 | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/ka=
san.rst
index 38fd5681fade..4abc84b1798c 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -13,10 +13,10 @@ KASAN uses compile-time instrumentation to insert valid=
ity checks before every
 memory access, and therefore requires a compiler version that supports tha=
t.
=20
 Generic KASAN is supported in both GCC and Clang. With GCC it requires ver=
sion
-8.3.0 or later. With Clang it requires version 7.0.0 or later, but detecti=
on of
+8.3.0 or later. Any supported Clang version is compatible, but detection of
 out-of-bounds accesses for global variables is only supported since Clang =
11.
=20
-Tag-based KASAN is only supported in Clang and requires version 7.0.0 or l=
ater.
+Tag-based KASAN is only supported in Clang.
=20
 Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 a=
nd
 riscv architectures, and tag-based KASAN is supported only for arm64.
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 047b53dbfd58..033a5bc67ac4 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -54,9 +54,9 @@ config KASAN_GENERIC
 	  Enables generic KASAN mode.
=20
 	  This mode is supported in both GCC and Clang. With GCC it requires
-	  version 8.3.0 or later. With Clang it requires version 7.0.0 or
-	  later, but detection of out-of-bounds accesses for global variables
-	  is supported only since Clang 11.
+	  version 8.3.0 or later. Any supported Clang version is compatible,
+	  but detection of out-of-bounds accesses for global variables is
+	  supported only since Clang 11.
=20
 	  This mode consumes about 1/8th of available memory at kernel start
 	  and introduces an overhead of ~x1.5 for the rest of the allocations.
@@ -78,8 +78,7 @@ config KASAN_SW_TAGS
 	  Enables software tag-based KASAN mode.
=20
 	  This mode requires Top Byte Ignore support by the CPU and therefore
-	  is only supported for arm64. This mode requires Clang version 7.0.0
-	  or later.
+	  is only supported for arm64. This mode requires Clang.
=20
 	  This mode consumes about 1/16th of available memory at kernel start
 	  and introduces an overhead of ~20% for the rest of the allocations.
--=20
2.28.0.297.g1956fa8f8d-goog

