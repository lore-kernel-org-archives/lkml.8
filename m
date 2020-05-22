Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11389C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69AA20776
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="vSUfxM0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgEVQCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgEVQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:02:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7B6C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:02:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f13so9102625wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=auDBBRDeoQ7ncKxn2sVDb90pJtkYniz0ggmBqoHliMg=;
        b=vSUfxM0My7gYZ6kxNlK2KkGUr36aupmG5w7xaWQQ/14HqGVv2n8ecDrBEtgTep8Mlp
         pyIt2YbAu4FuYbMTCC4uK+1Ji2yHPxdppsJvOzty1En3uOKh+UQ6c+71yogAnKmNIlW8
         kfy8/Fc6BUIewtu3DeNDPM5OlaYqjvJLeU6Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=auDBBRDeoQ7ncKxn2sVDb90pJtkYniz0ggmBqoHliMg=;
        b=GNe5wYjrwnGm27dF1q/rpwowl1YND55IwRsXqy6TJ76DCZj1ndQ2hKg8XPlg/QE4Ag
         0Cfag34EZPDD2cKzCvamoT53kKj9Vq3uYFBb+kfrj3WxhNtMEj36Ockw2vWlQMI6k2xz
         wHWQoANBrNClELsVZVR3VN58KHKBYZBM0Ue3x9PLCRA1NQoShFCWYwlw5DQH6arWV6Ft
         Tn0ALYhuc47aiBaVShoCI0+zPWyCIfg6A8SC+no+4YS65bQT6ImxiCQh3LvxSTycaXuQ
         9FDUL0+rlYaFTVVxDEv3XZE54O9yDA+dKTKpsesyRv0OUMGs8JixWJnC4/rON0nmNXip
         dZBQ==
X-Gm-Message-State: AOAM532qjVjeWstJ7uhU0TNmN5MKWFo1ZZWjhMl3H2Pi9o43pZBpoV0b
        FoUbJcEg4m0o4LpJrEwkdid/uQ==
X-Google-Smtp-Source: ABdhPJwqQ/GpClq47yzcuBRsd+d0w1MnbPWVdAjS9zI6cftkXS4iQBZ0uHDXYO127vwVdVc4gWIZkg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr14490141wmi.41.1590163355730;
        Fri, 22 May 2020 09:02:35 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id s67sm10078440wmf.3.2020.05.22.09.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 09:02:35 -0700 (PDT)
Date:   Fri, 22 May 2020 17:02:34 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] init: Allow distribution configuration of default init
Message-ID: <20200522160234.GA1487022@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.1 (2020-05-03)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some init systems (eg. systemd) have init at their own paths, for
example, /usr/lib/systemd/systemd. A compatibility symlink to one of the
hardcoded init paths is provided by another package, usually named
something like systemd-sysvcompat or similar.

Currently distro maintainers who are hands-off on the bootloader are
more or less required to include those compatibility links as part of
their base distribution, because it's hard to migrate away from them
since there's a risk some users will not get the message to set init= on
the kernel command line appropriately.

Moreover, for distributions where the init system is something the
distribution itself is opinionated about (eg. Arch, which has systemd in
the required `base` package), we could usually reasonably configure this
ahead of time when building the distribution kernel. However, we
currently simply don't have any way to configure the kernel to do this.
Here's an example discussion where removing sysvcompat was discussed by
distro maintainers[0].

This patch adds a new Kconfig tunable, CONFIG_DEFAULT_INIT, which if set
is tried before the hardcoded fallback list. So the order of precedence
is now thus:

1. init= on command line (on failure: panic)
2. CONFIG_DEFAULT_INIT (on failure: try #3)
3. Hardcoded fallback list (on failure: panic)

This new config parameter will allow distribution maintainers to move
away from these compatibility links safely, without having to worry that
their users might not have the right init=.

There are also two other benefits of this over having the distribution
maintain a symlink:

1. One of the value propositions over simply having distributions
   maintain a /sbin/init symlink via a package is that it also frees
   distributions which have a preferred default, but not mandatory, init
   system from having their package manager fight with their users for
   control of /{s,}bin/init.  Instead, the distribution simply makes
   their preference known in CONFIG_DEFAULT_INIT, and if the user
   installs another init system and uninstalls the default one they can
   still make use of /{s,}bin/init and friends for their own uses. This
   makes more cases Just Work(tm) without the user having to perform
   extra configuration via init=.
2. Since before this we don't know which path the distribution actually
   _intends_ to serve init from, we don't pr_err if it is simply
   missing, and usually will just silently put the user in a /bin/sh
   shell. Now that the distribution can make a declaration of intent, we
   can be more vocal when this init system fails to launch for any
   reason, even if it's simply because no file exists at that location,
   speeding up the palaver of init/mount dependency/etc debugging a bit.

0: https://lists.archlinux.org/pipermail/arch-dev-public/2019-January/029435.html

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/Kconfig | 10 ++++++++++
 init/main.c  | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index bff51e542353..a8136131c108 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -284,6 +284,16 @@ config KERNEL_UNCOMPRESSED
 
 endchoice
 
+config DEFAULT_INIT
+	string "Default init path"
+	default ""
+	help
+	  This option determines the default init for the system if no init=
+	  option is passed on the kernel command line. If the requested path is
+	  not present, we will still then move on to attempting further
+	  locations (e.g. /sbin/init, etc). If this is empty, we will just use
+	  the fallback list when init= is not passed.
+
 config DEFAULT_HOSTNAME
 	string "Default hostname"
 	default "(none)"
diff --git a/init/main.c b/init/main.c
index eb7e0d16e958..0ead83e86b5a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1437,6 +1437,16 @@ static int __ref kernel_init(void *unused)
 		panic("Requested init %s failed (error %d).",
 		      execute_command, ret);
 	}
+
+	if (CONFIG_DEFAULT_INIT[0] != '\0') {
+		ret = run_init_process(CONFIG_DEFAULT_INIT);
+		if (ret)
+			pr_err("Default init %s failed (error %d)\n",
+			       CONFIG_DEFAULT_INIT, ret);
+		else
+			return 0;
+	}
+
 	if (!try_to_run_init_process("/sbin/init") ||
 	    !try_to_run_init_process("/etc/init") ||
 	    !try_to_run_init_process("/bin/init") ||
-- 
2.26.2

