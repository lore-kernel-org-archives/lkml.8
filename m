Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D214206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592484637;
	bh=z0GqeklSCl4XRNXqrQ5ZSKPQNZ2+azAdTd17NdIpJZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yoh7D4xFUlDO5TefNd8zlkd44fyQPeh0ibc4ZBz1yeMHsqNJyRUWRjwfr4pn8URTc
	 hdKGHXsdo9ZFRXCxAJDXqmlllJf34WYV3l7/i41QbS4ql5SuvezzjHnhoFXDw3a2By
	 2jNA7VdzzGi5I9tyrjBHJTdpolj/OmNRvCGoUOHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgFRMuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbgFRMud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:50:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BC6206F7;
        Thu, 18 Jun 2020 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592484633;
        bh=z0GqeklSCl4XRNXqrQ5ZSKPQNZ2+azAdTd17NdIpJZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYrd3Leo+dsY0+sB4AYN6+br+QKSOY3f0Xn5JffOhGerKkalQNNqEiJ+Kirz1caCd
         cn7M7CsovUsCexydtNI/GDKXOXZ/SYBPFmgQv9FsR3VnC5fy9OsQwxgR3UfgaNG1/L
         Fx1+mvWnNvyNN0s6KAiHrKk59tkahp2OhghZihg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.7.4
Date:   Thu, 18 Jun 2020 14:50:17 +0200
Message-Id: <1592484616133237@kroah.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <1592484616163232@kroah.com>
References: <1592484616163232@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index a2ce556f4347..64da771d4ac5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 7
-SUBLEVEL = 3
+SUBLEVEL = 4
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a2909af4b924..3bb82a6cc5aa 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,6 +38,13 @@ static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
 }
 #endif
 
+#ifndef vdso_cycles_ok
+static inline bool vdso_cycles_ok(u64 cycles)
+{
+	return true;
+}
+#endif
+
 #ifdef CONFIG_TIME_NS
 static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 			  struct __kernel_timespec *ts)
@@ -62,6 +69,8 @@ static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 			return -1;
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);
+		if (unlikely(!vdso_cycles_ok(cycles)))
+			return -1;
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
@@ -130,6 +139,8 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 			return -1;
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);
+		if (unlikely(!vdso_cycles_ok(cycles)))
+			return -1;
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
