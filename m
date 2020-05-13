Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933C2C2D0FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665EF20718
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589340516;
	bh=oXOtkflP/lPwOvtUdJ6IKZzypvTPv0rmUjbVn27O7IU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=gJhwi1qP2f3XFxWMp+iUE+pOF2jN2/0Awaa6XablrDWOHIybgNpYl1gGl6M/5mn2U
	 1kmQYXkDGquh1TPkdsWGNkmkS9qqa8koFNXTCGKwSL0A+c+aWrqXhB7HYJ3VzvP3bi
	 zw+42J6Dsc1GqBTmbJCISatAUQ3A0KF+rFB0m6xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgEMD2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 23:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEMD2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 23:28:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243E1206E5;
        Wed, 13 May 2020 03:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589340515;
        bh=oXOtkflP/lPwOvtUdJ6IKZzypvTPv0rmUjbVn27O7IU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=zlEH/FDD2RinraGixKSClRPcGfnSjghSk4v4R+4B+ZAXmghBlRTyvsmmXtbc0G6BQ
         ZB+vfBe8S+5Za+ybXFkKvurp2uqtvqi6CAxJYWHr+hOIVt4lWKKDxIS4PSe3cciItL
         MELXkF96N8Ia0QNckxFQN9SU3YZF26oIQgesSv38=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200511105556.5b13a4b4@canb.auug.org.au>
References: <20200511105556.5b13a4b4@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the clk tree
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue, 12 May 2020 20:28:34 -0700
Message-ID: <158934051438.215346.17117203400874095019@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2020-05-10 17:55:56)
> Hi all,
>=20
> After merging the clk tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> arch/arm/mach-mmp/time.c:37:10: fatal error: clock.h: No such file or dir=
ectory
>    37 | #include "clock.h"
>       |          ^~~~~~~~~
>=20
> Caused by commit
>=20
>   e4d1fdf89751 ("ARM: mmp: Remove legacy clk code")
>=20
> I have disabled CONFIG_ARCH_MPP for today.  (For some reason, this
> build error did not show up until several more trees had been merged
> ...)
>=20

Ok yeah I removed that clock.h file and then forgot to find any users of
the header file.

---8<----
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index b642e900727a..1e9389245d0e 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -19,7 +19,6 @@
 #include <asm/system_misc.h>
=20
 #include "addr-map.h"
-#include "clock.h"
 #include "common.h"
 #include <linux/soc/mmp/cputype.h>
 #include "devices.h"
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 049a65f47b42..41b2e8abc9e6 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -34,7 +34,6 @@
 #include "regs-apbc.h"
 #include "irqs.h"
 #include <linux/soc/mmp/cputype.h>
-#include "clock.h"
=20
 #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
