Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58122C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266512074A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KQEXLubh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgE3NHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 09:07:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:39271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgE3NHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 09:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590844061;
        bh=hxVU80UgWYLII4SD+dtiXn6OUhCJXcPPlfR7NAOp/Qo=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=KQEXLubhuHol3HHCCZoT3FKtaNsQI2IsJvLwvar59enRX1QQw3/KbcrKMXeizHzc3
         Dfv/YB5SMPRqAJG0qPNRQnT5i6/iki5PB+t1Oy04rNZ62Rwu67+TXYYBdvoeRP+AtE
         atcQOfJcKGU0UCVBrvfPdo935hVbBdJmEWzR4QcQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.0.170.188]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUjC-1injpv0TgY-00rUpX for
 <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:07:41 +0200
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: fatal: unable to access
 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/': SSL
 certificate problem: certificate has expired
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7d5a91f3-e5bd-8410-487d-5cbcd23b174b@gmx.de>
Date:   Sat, 30 May 2020 15:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D3EL2WDWVmfODcKjzplk7YXOAVi7VIc1ESER1Cvm6ITxtb73p6/
 60CuxZ4LuMAM+kd2UIznSNOnvl59DAv9T1ZhsJWS6LysdrBwYJu+M7qRDgRr7SgF9bABWea
 D8fvkSiBjUh6P2PHgWSeX3pObX9tMPx3KfHsCsRXHuAMk/4TKYCEeXwVwDBw9hl1OUvWxQ/
 da4Z/NjoOO7KDQ7eTNgjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+c1HBjcRxcc=:sgUm+7Q/tFrr3gAYQvwdxc
 /+meEenI+7UpO9/oo0Lx1i0XOrmBgs8ZQWScZUNrkFc1cuio7K7Ft2Kh7AZNxtALwV/hLzz+Q
 01Bt4++40cczsHRcpfakqxSbh8XRKLpHoYt+cu0gWVp0IaRXpprMPPzluonqcJFDevy+bWvmR
 BuO0K5zlH0Jy/n2pz/3rsjNrTtleZAAPxPVhVqB7BF74t1t5ZteH75ZkiynsTtAR9NWS5SKCc
 TnX5XDIDYMspMk501atkTBzj+3V97W/1lPD1wHPqirj08vX70K+Kdiqz1S1mmEfUnxJW3uxPV
 tJJAg/7+s6mw1NS7pLYch1YOws8k+quHNLj9vMozs73Cb4dXBWuCIeAegcYneTmfgRh2MpUpS
 H9LITxHnktZTVEqnBNrvmxJA7/ML/YiD/sUIhqoghbEm4aKntVfK35OJgs06T1khXMUu4r9G8
 uABNSg7YQ9H3ZLyK/xn2vwY3LXttkEIpurFTcieC3N4G5vwHt0qCXSobhQeTd+xLQ/OMXr17g
 q/V/u1Cg15+PSPGJW27DiKo2G6Z4D0bC0IPBu14TzCYsIkp/XFPutwUQmBNLWQ6fEzFRv7z+W
 hcKbcyMM6KH5Fy/gkWqWE/T+mN3A2C6PkTkdQnUpozr3leDK80kkIn3yMfyHmUAZi+1JeLcji
 zzPBfwbpbIEpInTNuQAtqemPWoTvGAqm2Ao+11zjJ1ROKBKrA9Wqzu09GsdOUiTQTKV4ce0A1
 r4sv+3QqprmVcpBQIAe8pyvqxSKDF+rrd7WEIgJQWMtOJztZSSzUgVM3Eb6RHZVIphqiMtVnD
 8SBdlc2FA5uaB/SBjLjy8kfkvSR+3XHQEsfEAwO+FfaphvNyUcNgzTx5HYxpJ7YYAuf18Y9FG
 quyVcmu7dOamA2YznyIxFhm5TVH4OtgBqRIeLryvQ9EfUJZRPPpd3aWYq7cdnyPITcLZ+WP+D
 nEPoUTLX3BKylewR0dhnuO/kQMrwrsJWeileIKHLE3O3kHtHFoznJhVDRlJPnm7x5eUMCin/6
 Tw5Kn2oaGp+dyQ8XIl21S2dad7XQc/G0DrnCYMzxUa66GNGEV9mNS/PoJzE4r4Krzju2LvroA
 3HZCPs6VWevJJkaBhmKr4Sa+Y75LFEmD6zfm5G9g5JGM5HeW07PqYk9m/dSEBm92WdiC4bhFr
 B0EFdxdcD2LWsE6EOttBA8RAl8oMYiic5R5Dids0MrHZyFXlS8ICFwBn5o09WNRWNYT3JdHDn
 wI/Q1w9izG6AaEyHTPDKkQguy7tXtldLmX7PZ2xibAqgSXycNqs8B6aFa+TY2R+202Enwqb09
 JpSrcT9vQvPbSrlNfCWMz47SSFtFEXpNKZFZ4lcENipVMmt1NBHzonazqSlLU6fkVNfyMyxM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

:-( :

$ export GIT_TRACE=3D1

$ git pull
15:07:08.488836 git.c:439               trace: built-in: git pull
15:07:08.504295 run-command.c:663       trace: run_command: git fetch --up=
date-head-ok
15:07:08.506481 git.c:439               trace: built-in: git fetch --updat=
e-head-ok
15:07:08.516608 run-command.c:663       trace: run_command: GIT_DIR=3D.git=
 git-remote-https origin https://git.kernel.org/pub/scm/linux/kernel/git/t=
orvalds/linux.git
fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git/t=
orvalds/linux.git/': SSL certificate problem: certificate has expired

$ curl https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
curl: (60) SSL certificate problem: certificate has expired
More details here: https://curl.haxx.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation an=
d
how to fix it, please visit the web page mentioned above.

=2D-
Toralf
