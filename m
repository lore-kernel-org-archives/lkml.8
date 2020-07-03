Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7220D20BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDvabmQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGCNU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:20:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B16C08C5C1;
        Fri,  3 Jul 2020 06:20:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so32000095wmi.3;
        Fri, 03 Jul 2020 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition;
        bh=UDQLMHGmElupBntrGo71j+LQRE1M2bBG0QfaH5u/2UI=;
        b=PDvabmQH/TlzYDBZji9UhzOObimUx+VkJypuKVoBh4raJtzRvi7f4iFJaPq+gKIk0o
         VJxotdmzIvE4R2/ImCePqMPyp8AHHMPVrumTDxoSQrT8pGi8FWnhUG6RiqeT5LWlY4Y1
         J/zmXkbjAwOHpCt0RXOWttb+zWGYzWWsrN3P9oJLi8ZWtbsR1O45yEn545oIs6OGZi6h
         WFtBJEISVIIM4vwsJEbPwl9/Vaul6qFoqXE5oxspjTVerSidYkWMni5ubc5caoc4CDCZ
         TQhAzXo5kuS55XCqFHnKPXYmAxdcN7yoQDuWj+NX3aWUN8hVfLa4OOiNDhmiZCrAlBE2
         lrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=UDQLMHGmElupBntrGo71j+LQRE1M2bBG0QfaH5u/2UI=;
        b=gXQNiufu1UBpzvik8S9XjMs/CJo6252DGBYtyo/4E+O4fWMQe2HyXNxNuoXOZxsE6P
         4XjLEftZVbYsrST2b1FsSZ3ED06wsNYXCOh6UfCRCJYlqtgxwcBc9LCL6imw/mcwglkt
         oQr4JolQVX57+XcRtrS7pYEsCt4d6MH1w9X/x2r3NZT2IiwJcYKUjHxPzOueYQU27EF+
         jhnJLtTkLRXo6IdzJW0rfhM66q5roXclz1lar+G/Dx7iT2kNbUVLJL6T0vdHUmqYuGHE
         9TKtX0KWY2T/VgqwfsIdyZA1Yxbh0EnE64g34ham5Nt/Qf6WMpXpeboQvozespzQAQ+7
         a3RQ==
X-Gm-Message-State: AOAM533+qd26B5a1gU98NekMS0jD0lScLBo+wgSizZQ7ibwRdBrm24f/
        HPHEPvH32HioQaV3DsIPRLM=
X-Google-Smtp-Source: ABdhPJzUDArRZ0Z1kmAO2j6Dvh+OV4ibFKpmrj0wOyLq4RKklloeRCVsmLBNBd4sQzgxrlwvt9T1uA==
X-Received: by 2002:a1c:a90d:: with SMTP id s13mr34755774wme.184.1593782455635;
        Fri, 03 Jul 2020 06:20:55 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id e5sm14476552wrs.33.2020.07.03.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 06:20:55 -0700 (PDT)
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
X-Google-Original-From: Willy Wolff <willy.mh.wolff.mh@gmail.com>
Date:   Fri, 3 Jul 2020 15:20:54 +0200
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com
Subject: [RFC PATCH] ARM: dts: exynos: partial revert of Adjust bus related
 OPPs to the values correct for Exynos5422 Odroids
Message-ID: <20200703132054.re3kcgxrb7rciidy@macmini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Odroid XU3/4 board, since 5.6 with 1019fe2c728003f89ee11482cf8ec81dbd8f15ba,
the network is not working properly.

After properly booting, when trying to connect to the board via ssh, the board
hang for a while and this message happen:

[  211.111967] ------------[ cut here ]------------
[  211.117520] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:443 dev_watchdog+0x3ac/0x3e0
[  211.125636] NETDEV WATCHDOG: eth0 (smsc95xx): transmit queue 0 timed out
[  211.132058] Modules linked in:
[  211.134815] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-rc3-00082-gcdd3bb54332f-dirty #1
[  211.143518] Hardware name: Samsung Exynos (Flattened Device Tree)
[  211.149458] [<c0112290>] (unwind_backtrace) from [<c010d1ac>] (show_stack+0x10/0x14)
[  211.157287] [<c010d1ac>] (show_stack) from [<c051b93c>] (dump_stack+0xac/0xd8)
[  211.164416] [<c051b93c>] (dump_stack) from [<c0127a50>] (__warn+0xd0/0x108)
[  211.171301] [<c0127a50>] (__warn) from [<c0127e60>] (warn_slowpath_fmt+0x94/0xb8)
[  211.178824] [<c0127e60>] (warn_slowpath_fmt) from [<c0929b38>] (dev_watchdog+0x3ac/0x3e0)
[  211.187043] [<c0929b38>] (dev_watchdog) from [<c01c791c>] (call_timer_fn+0xd4/0x420)
[  211.194698] [<c01c791c>] (call_timer_fn) from [<c01c86ec>] (run_timer_softirq+0x620/0x784)
[  211.202980] [<c01c86ec>] (run_timer_softirq) from [<c0101408>] (__do_softirq+0x1e0/0x664)
[  211.211123] [<c0101408>] (__do_softirq) from [<c0130924>] (irq_exit+0x158/0x16c)
[  211.218467] [<c0130924>] (irq_exit) from [<c01a1ef0>] (__handle_domain_irq+0x80/0xec)
[  211.226304] [<c01a1ef0>] (__handle_domain_irq) from [<c0536eac>] (gic_handle_irq+0x58/0x9c)
[  211.234626] [<c0536eac>] (gic_handle_irq) from [<c0100af0>] (__irq_svc+0x70/0xb0)
[  211.241982] Exception stack(0xc1101f10 to 0xc1101f58)
[  211.246789] 1f00:                                     ffffffff ffffffff 00000001 0008f0bd
[  211.255230] 1f20: ffffe000 c1108eec c1108f30 00000001 00000000 c0df311c 00000000 c1076028
[  211.262303] exynos5-hsi2c 12ca0000.i2c: tx timeout
[  211.263351] 1f40: 00000000 c1101f60 c01097f8 c01097fc 600f0113 ffffffff
[  211.263649] [<c0100af0>] (__irq_svc) from [<c01097fc>] (arch_cpu_idle+0x24/0x44)
[  211.263771] [<c01097fc>] (arch_cpu_idle) from [<c01640c8>] (do_idle+0x214/0x2c0)
[  211.289414] [<c01640c8>] (do_idle) from [<c0164528>] (cpu_startup_entry+0x18/0x1c)
[  211.296999] [<c0164528>] (cpu_startup_entry) from [<c1000e54>] (start_kernel+0x4e8/0x520)
[  211.305822] irq event stamp: 585972
[  211.308637] hardirqs last  enabled at (585984): [<c0100b0c>] __irq_svc+0x8c/0xb0
[  211.316470] hardirqs last disabled at (585993): [<c019ed9c>] console_unlock+0xd4/0x654
[  211.324282] softirqs last  enabled at (585920): [<c0130640>] irq_enter_rcu+0x7c/0x84
[  211.332072] softirqs last disabled at (585921): [<c0130924>] irq_exit+0x158/0x16c
[  211.339329] ---[ end trace 5726ca773f159ae9 ]---

After that, the board continue working from serial console only, but the board
doesn't pong anymore.

Reverting some change fix the issue.

Best Regards,
Willy

Signed-off-by: Willy Wolff <willy.mh.wolff.mh@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index ab27ff8bc3dc..6f7807e82035 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -81,6 +81,7 @@
 
 	bus_fsys_apb_opp_table: opp_table4 {
 		compatible = "operating-points-v2";
+		opp-shared;
 
 		/* derived from 666MHz CPLL */
 		opp00 {
@@ -412,7 +413,8 @@
 };
 
 &bus_fsys {
-	operating-points-v2 = <&bus_fsys2_opp_table>;
+	// operating-points-v2 = <&bus_fsys2_opp_table>;
+	operating-points-v2 = <&bus_fsys_apb_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
-- 
2.20.1

