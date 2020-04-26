Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF521C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70762070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZKji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDZKjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:39:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8507AC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 03:39:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jSehB-0002IN-2p; Sun, 26 Apr 2020 12:39:33 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 81251100605; Sun, 26 Apr 2020 12:39:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Holger Schurig <holger.schurig@advantech.de>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: BUG 5.5.6, from patch "cpu/SMT: Fix x86 link error without CONFIG_SYSFS"
In-Reply-To: <SG2PR02MB4299E161745C7938E32D4B70F7D30@SG2PR02MB4299.apcprd02.prod.outlook.com>
References: <SG2PR02MB4299E161745C7938E32D4B70F7D30@SG2PR02MB4299.apcprd02.prod.outlook.com>
Date:   Sun, 26 Apr 2020 12:39:32 +0200
Message-ID: <875zdmttsr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holger,

Holger Schurig <holger.schurig@advantech.de> writes:

> if one compiled kernel 5.6.6 with CONFIG_HOTPLUG_CPU=n, then the
> compilation will fail. The reason is your patch, which introduces
> this:

> +int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)

It would have been more helpful to provide the actual commit SHA instead
of copying tons of patch code.

> It happens that cpu_down_maps_locked is only defined when
> CONFIG_HOTPLUG_CPU=y, but not otherwise.

Right.

> On my embedded target I so far had the CPU hotplugging off. After all,
> the CPU is physically soldered, there will never be a hotplugging
> happen.

CPU hotplug is used for far more than physical hotplug.

SMT control depends on it in order to apply speculation mitigations,
hibernation requires working CPU hotplug as well.

As the speculation mess requires SMT control we more or less have to
make CPU hotplug mandatory on x86...

Thanks,

        tglx
