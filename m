Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5516C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684742067C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iGRitEWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgBARw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 12:52:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:35819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgBARw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 12:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580579546;
        bh=G0meMjw7IlDsf67nGNkjIezCLILaWKlvplcMNMWdfd8=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=iGRitEWozY/kxIKngASmUJb8Z92kbfYyyVtBWBkNfJJ8/T4R9rEdmO8CmxVwZbpix
         LKpv3OiDNZh8xGyxexDqexFu3rl3QawRkOOGDr6xhvp5FUSWKs+ZfJpp85d4WGjebD
         1ma5VxSVypiwxQsNXd9bn4n+xPlpv2KJPwc1KmOQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([77.10.56.158]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1jfqKg2XUe-00zjg8 for
 <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 18:52:26 +0100
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Subject: why does "mem auto-init: clearing system memory may take some
 time..." takes about 14 sec under 5.4.17 but only few msec under 5.5.1?
Message-ID: <c7a23250-6b23-2a9e-88c8-924c34fb9139@gmx.de>
Date:   Sat, 1 Feb 2020 18:52:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3442LzscHbWnAZ8JqMDv6GK7DpTREpM0+PvKFTOyLlsolLYK8gz
 lZ6gRxi1+RLljFkEuP4aYxzrGR0Caub8M1/sKt1nBjTDkVT5wYmx4V6bA7ioZUegnwjZvgH
 8Q1dIcgxUoGceH5EBrDpdW7IWT0EcdAw1kzX+Jt022sC24q2Se2tKNJ2dc5lzScB872t0N3
 ZlPCNh3C22WWV6Bg4vIiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WRXFYShErNM=:ElK2sb4drWJukZ6UQKXluH
 +EiRR8kaozlF6YgNIS37Qo5y/RgnMwxZwkKcqeJaN20faca9/s2e4bTy05d6rfyS7CpNbaf5p
 jxkRIIS1+c3kM2uej8TH0OzLadkK2AgMehnPUxUEXnyYTj5qOlTfvv4nQSRNuS9ubkHVBrPnj
 Yder5sJoXSAMiOjTv4U7EDdrviQqALoYOqk/YWoCLxDE6srgaODr15lA23uMpO8BrkRpXOMR3
 Qa28aAKmCKATWuUlhqzhJ6jeiNhKa40yLd7ei8Spr0I4odJVD5fGU56IMoAYkwFYqwP3pX8Fd
 OzUiSrF/LgwiUfwgWDP8Zn2Sy9TucSTPjodZL4eREfGNdkY6TVXs5MC/uieR2dukVqBjCpyYF
 R3FThqRyVkXrfQ/ZGNF3U5cqnfsaT3xNHMVtou3c2MVydOVCmgPHaf+sBp+WEeouU+ffGjCZo
 EuxTKOhD6b42EXjfWRaLDoRy+Tda/JzJ306VKFmEMPFN1ecb+ofr3CBa1Ym9oo5ExTfnPkF6f
 MwDmXMZFED2abgzZErZKOlrBYy+xh/yIwm78hK14Uqg7iIF5ob2j2nWnPl6nZQp4Ce7qBB4R9
 AhuD2rGo6TuMcE1+prfuUFgDAS1yEd+9s0IbqmdgnQK5Ea+ja3dPpU+OdGhzJY4yd/FE8UQV/
 huPYhff50Mq5DC/rBCAQV9aXQqC3op0Gq+cWb/kDt6HTvswIEhsLbTXeTTdJMYFP38i3+eMDa
 D6yXuKKwKIzXrW+ec4lWDGqntMMuC7MH0KZGpbnQ0RJMhTftRvEYjHIQyZ7o77RPq8hYOctjr
 ZbzvJLRC/q+kZUAmjTsNTlZA3WpvPlCzFdKEWxRX3S0bR7aorTAR4W9OzniQ8BNqyRznOcemk
 p/7weCu1LvWMFPgibGFYHTJFAvRaSssv51ovK5b4VHepYNJLi9fqChlUpgmS/46uE3TS7G6Dp
 WsFkLwYbt80JFjJai9wLvTl7RiwkpeCYkSCWNKzoSrKmJ/pXD5td++/BGIjGF2JTyCsg5dXPG
 NZ4378DY0FgtKRweOI9A1fvbFlc0DxqVwy6M/LuIuzvseAPAMofR1fTExR03Kb81S0cKcIOTm
 DSOHWUe0hrpXp7HeV8Fvq0h9+2warR7cIS3ZO02WOXwTqfmGifrzW9oW2fGrZjq5FQrBm0QJI
 lg/K6GDhU4qIvjxCtPG+HFO1qEpO5OFvbndK8dQlRguzJkUEQA9lKyTfIPDkhcVrfNZ2nT5jX
 kGijHIwIR/utoEo4z
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do wonder (and I'm surprised) about increased boot speed according to dm=
esg for thi9s hardend Gentoo Linux system:
Linux mr-fox 5.5.1 #1 SMP Sat Feb 1 18:25:21 CET 2020 x86_64 Intel(R) Xeon=
(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux

Under 5.4.17 I do have usually 14 sec to wait:

[    0.497171] mem auto-init: stack:byref_all, heap alloc:on, heap free:on
[    0.497171] mem auto-init: clearing system memory may take some time...
[    0.501549] Calgary: detecting Calgary via BIOS EBDA area
[    0.501550] Calgary: Unable to locate Rio Grande table in EBDA - bailin=
g!
[   14.083235] Memory: 131812972K/134101088K available (12291K kernel code=
, 1400K rwdata, 1912K rodata, 1272K init, 2040K bss, 2288116K reserved, 0K=
 cma-reserved)
[   14.083342] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12,=
 Nodes=3D1
[   14.083350] Kernel/User page tables isolation: enabled
[   14.083403] rcu: Hierarchical RCU implementation.
[   14.083404] rcu: RCU calculated value of scheduler-enlistment delay is =
25 jiffies.
[   14.083414] NR_IRQS: 4352, nr_irqs: 928, preallocated irqs: 16

but with 5.5.1 there's no wait?:

[    0.000000] mem auto-init: stack:byref_all, heap alloc:on, heap free:on
[    0.000000] mem auto-init: clearing system memory may take some time...
[    0.000000] Memory: 131812876K/134101088K available (12291K kernel code=
, 1412K rwdata, 1936K rodata, 1260K init, 2012K bss, 2288212K reserved, 0K=
 cma-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12,=
 Nodes=3D1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is =
25 jiffies.
[    0.000000] NR_IRQS: 4352, nr_irqs: 928, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x4a8/0x6=
59 with crng_init=3D0

Do I miss something? (The kernel config was derived via "make oldconfig").

=2D-
Toralf
