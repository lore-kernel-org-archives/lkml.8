Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC14207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q08xgXke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbgIAThC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgIAThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:37:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9CC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 12:36:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a65so2245973wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=O2iJRR4OKeHAb6jv2bwhPWRgDUQ9wMFNJM7HFliyOmY=;
        b=Q08xgXkeXEKahKP6l7/1rnYg7KGX69bfdOr/JMqvIHXk/TG7X1DPI6ps2VHjIufS4R
         2wOUKyepSxA/r47de0n+2jv1mHfKGbj66UeMfgJPPGR+Oxd96kulB8GL0sCYwacofWpq
         Jo71rZjtJuy5nupi4lsKtVs2VFiCXPoWhAyU8duGUJT7nM510OIN3oNVUUEGFc4yvC55
         tFHdYLU1FtzRWgv6HsKhgIFvNikT24Hfow5qi2UxrCO74Luv6bnESxxDHrcxhwRuIBJ+
         VDtvc5OFH/GCwyHK5DhDBJZEIuQkGd6GXJHBbEeNEkqSCWHzE/cnOwHY9ocE1Ax6YzLS
         FxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=O2iJRR4OKeHAb6jv2bwhPWRgDUQ9wMFNJM7HFliyOmY=;
        b=FxCeI+npUEzmO1T7vXzdtk4z7aqDyZ3oCi5y0DZyE7FH9WVGZ9kmeucURzxuugwTEP
         zVPtwRMH0FI4+40YQfFXV02UF08fxRGOBLRMWgUUIUtU7LTpy95bmnDbqLjedpPzHKLs
         QPZsYY69U3cyXvDGV/d2axJ8fQTjPE4mRvZ2sxHaPJwUCRUNsSF3o61UNjyc+GGUEEnX
         lY2aYQ1V9LzQhoLdftcLMH3B4JG9Tx2nYFS6ZW+/j8IrNi/NDbGyENkBf8E06+GMhRmH
         oLNQIPGupqHdFpyq7xRGMPrX0WTnvn7pZRDBrIvAh0dq5gIEV2EHXS+jJawKI0OOJ+Gf
         GSIg==
X-Gm-Message-State: AOAM530LWafRsV9L1wvuDzFRG4/taKxhFKoG4COzBaKd2Vcy3JxxnujF
        72o4C3mfy1wV9SiY2XBbw0iHhXkzSUY=
X-Google-Smtp-Source: ABdhPJze6AIt7kEor+tMGeNBmb03/4egikDtIRnQAWOfOpowjr+8xIq1qg2qaLKsY3mRBr/TucU0/A==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr3445497wma.13.1598989015656;
        Tue, 01 Sep 2020 12:36:55 -0700 (PDT)
Received: from localhost ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id n11sm3561639wrx.91.2020.09.01.12.36.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 12:36:54 -0700 (PDT)
From:   Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3652.0.5.2.1\))
Subject: PPPd Bug with kernel 5.8.5 : task pppd:6009 blocked for more than 122
 seconds.
Message-Id: <2F54B131-CEAD-4119-B9A0-703B1E6FC936@gmail.com>
Date:   Tue, 1 Sep 2020 22:36:53 +0300
To:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3652.0.5.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI all kernel team

We detect bug in kernel with pppd server=20
When disconnect and connect 1000+ users after many time kernel have lock =
 please see debug log :


Aug 30 05:34:55 10.20.22.1 [139221.203949][  T817] INFO: task pppd:6009 =
blocked for more than 122 seconds.
Aug 30 05:34:55 10.20.22.1 [139221.231206][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:34:55 10.20.22.1 [139221.257538][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:34:55 10.20.22.1 [139221.309257][  T817] pppd            D    =
0  6009      1 0x80004006
Aug 30 05:34:55 10.20.22.1 [139221.335289][  T817] Call Trace:
Aug 30 05:34:55 10.20.22.1 [139221.360927][  T817]  =
__schedule+0x374/0x750
Aug 30 05:34:55 10.20.22.1 [139221.386660][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:34:55 10.20.22.1 [139221.412825][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:34:55 10.20.22.1 [139221.439154][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:34:55 10.20.22.1 [139221.465557][  T817]  __fput+0xc8/0x220
Aug 30 05:34:55 10.20.22.1 [139221.491144][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:34:55 10.20.22.1 [139221.516457][  T817]  do_exit+0x317/0xa60
Aug 30 05:34:55 10.20.22.1 [139221.541571][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:34:55 10.20.22.1 [139221.566159][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:34:55 10.20.22.1 [139221.590102][  T817]  do_signal+0x25/0x1f0
Aug 30 05:34:55 10.20.22.1 [139221.613380][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:34:55 10.20.22.1 [139221.636164][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:34:55 10.20.22.1 [139221.658333][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:34:55 10.20.22.1 [139221.680230][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:34:55 10.20.22.1 [139221.701469][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:34:55 10.20.22.1 [139221.722554][  T817] RIP: =
0033:0x7f8387041ae6
Aug 30 05:34:55 10.20.22.1 [139221.743000][  T817] Code: Bad RIP value.
Aug 30 05:34:55 10.20.22.1 [139221.762781][  T817] RSP: =
002b:00007ffcee1e4fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:34:55 10.20.22.1 [139221.802079][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007f8387041ae6
Aug 30 05:34:56 10.20.22.1 [139221.841537][  T817] RDX: 0000000000000000 =
RSI: 00007ffcee1e50b0 RDI: 000000000000000d
Aug 30 05:34:56 10.20.22.1 [139221.882678][  T817] RBP: 00007ffcee1e50b0 =
R08: 00007ffcee1e5030 R09: 0000000000000010
Aug 30 05:34:56 10.20.22.1 [139221.924623][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:34:56 10.20.22.1 [139221.967198][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007ffcee1e7130
Aug 30 05:34:56 10.20.22.1 [139222.011266][  T817] INFO: task pppd:6092 =
blocked for more than 123 seconds.
Aug 30 05:34:56 10.20.22.1 [139222.036779][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:34:56 10.20.22.1 [139222.060127][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:34:56 10.20.22.1 [139222.107395][  T817] pppd            D    =
0  6092      1 0x80004006
Aug 30 05:34:56 10.20.22.1 [139222.131680][  T817] Call Trace:
Aug 30 05:34:56 10.20.22.1 [139222.155515][  T817]  =
__schedule+0x374/0x750
Aug 30 05:34:56 10.20.22.1 [139222.179548][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:34:56 10.20.22.1 [139222.203987][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:34:56 10.20.22.1 [139222.228677][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:34:56 10.20.22.1 [139222.253507][  T817]  __fput+0xc8/0x220
Aug 30 05:34:56 10.20.22.1 [139222.278100][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:34:56 10.20.22.1 [139222.302749][  T817]  do_exit+0x317/0xa60
Aug 30 05:34:56 10.20.22.1 [139222.327154][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:34:56 10.20.22.1 [139222.351352][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:34:56 10.20.22.1 [139222.375277][  T817]  ? =
set_next_entity+0xcd/0x340
Aug 30 05:34:56 10.20.22.1 [139222.399090][  T817]  do_signal+0x25/0x1f0
Aug 30 05:34:56 10.20.22.1 [139222.422846][  T817]  ? =
__schedule+0x1af/0x750
Aug 30 05:34:56 10.20.22.1 [139222.446246][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:34:56 10.20.22.1 [139222.469384][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:34:56 10.20.22.1 [139222.491919][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:34:56 10.20.22.1 [139222.514294][  T817] RIP: =
0033:0x7f5850cafae6
Aug 30 05:34:56 10.20.22.1 [139222.536053][  T817] Code: Bad RIP value.
Aug 30 05:34:56 10.20.22.1 [139222.557135][  T817] RSP: =
002b:00007fff80131af8 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:34:56 10.20.22.1 [139222.598929][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007f5850cafae6
Aug 30 05:34:56 10.20.22.1 [139222.640656][  T817] RDX: 0000000000000000 =
RSI: 00007fff80131c00 RDI: 000000000000000d
Aug 30 05:34:56 10.20.22.1 [139222.682379][  T817] RBP: 00007fff80131c00 =
R08: 00007fff80131b80 R09: 0000000000000010
Aug 30 05:34:56 10.20.22.1 [139222.724620][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:34:56 10.20.22.1 [139222.767406][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007fff80133c80
Aug 30 05:34:56 10.20.22.1 [139222.811661][  T817] INFO: task pppd:6118 =
blocked for more than 124 seconds.
Aug 30 05:34:56 10.20.22.1 [139222.835684][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:34:57 10.20.22.1 [139222.859138][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:34:57 10.20.22.1 [139222.906975][  T817] pppd            D    =
0  6118      1 0x80004006
Aug 30 05:34:57 10.20.22.1 [139222.931411][  T817] Call Trace:
Aug 30 05:34:57 10.20.22.1 [139222.955401][  T817]  =
__schedule+0x374/0x750
Aug 30 05:34:57 10.20.22.1 [139222.979553][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:34:57 10.20.22.1 [139223.004125][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:34:57 10.20.22.1 [139223.028880][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:34:57 10.20.22.1 [139223.053766][  T817]  __fput+0xc8/0x220
Aug 30 05:34:57 10.20.22.1 [139223.078453][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:34:57 10.20.22.1 [139223.103231][  T817]  do_exit+0x317/0xa60
Aug 30 05:34:57 10.20.22.1 [139223.127744][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:34:57 10.20.22.1 [139223.152031][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:34:57 10.20.22.1 [139223.176074][  T817]  do_signal+0x25/0x1f0
Aug 30 05:34:57 10.20.22.1 [139223.199803][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:34:57 10.20.22.1 [139223.223658][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:34:57 10.20.22.1 [139223.247097][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:34:57 10.20.22.1 [139223.270212][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:34:57 10.20.22.1 [139223.292925][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:34:57 10.20.22.1 [139223.315277][  T817] RIP: =
0033:0x7fb106724ae6
Aug 30 05:34:57 10.20.22.1 [139223.337009][  T817] Code: Bad RIP value.
Aug 30 05:34:57 10.20.22.1 [139223.358072][  T817] RSP: =
002b:00007ffdff00f868 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:34:57 10.20.22.1 [139223.399784][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007fb106724ae6
Aug 30 05:34:57 10.20.22.1 [139223.441393][  T817] RDX: 0000000000000000 =
RSI: 00007ffdff00f970 RDI: 000000000000000d
Aug 30 05:34:57 10.20.22.1 [139223.482950][  T817] RBP: 00007ffdff00f970 =
R08: 00007ffdff00f8f0 R09: 0000000000000010
Aug 30 05:34:57 10.20.22.1 [139223.524917][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:34:57 10.20.22.1 [139223.567542][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007ffdff0119f0
Aug 30 05:34:57 10.20.22.1 [139223.611543][  T817] INFO: task pppd:6203 =
blocked for more than 125 seconds.
Aug 30 05:34:57 10.20.22.1 [139223.634963][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:34:57 10.20.22.1 [139223.658341][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:34:57 10.20.22.1 [139223.705668][  T817] pppd            D    =
0  6203      1 0x80004006
Aug 30 05:34:57 10.20.22.1 [139223.729970][  T817] Call Trace:
Aug 30 05:34:57 10.20.22.1 [139223.753831][  T817]  =
__schedule+0x374/0x750
Aug 30 05:34:57 10.20.22.1 [139223.777870][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:34:57 10.20.22.1 [139223.802339][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:34:57 10.20.22.1 [139223.826958][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:34:58 10.20.22.1 [139223.851972][  T817]  __fput+0xc8/0x220
Aug 30 05:34:58 10.20.22.1 [139223.876641][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:34:58 10.20.22.1 [139223.901344][  T817]  do_exit+0x317/0xa60
Aug 30 05:34:58 10.20.22.1 [139223.925770][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:34:58 10.20.22.1 [139223.949994][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:34:58 10.20.22.1 [139223.973957][  T817]  do_signal+0x25/0x1f0
Aug 30 05:34:58 10.20.22.1 [139223.997589][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:34:58 10.20.22.1 [139224.021326][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:34:58 10.20.22.1 [139224.044700][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:34:58 10.20.22.1 [139224.067829][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:34:58 10.20.22.1 [139224.090303][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:34:58 10.20.22.1 [139224.112648][  T817] RIP: =
0033:0x7f0e600fbae6
Aug 30 05:34:58 10.20.22.1 [139224.134352][  T817] Code: Bad RIP value.
Aug 30 05:34:58 10.20.22.1 [139224.155416][  T817] RSP: =
002b:00007ffefc5fd1b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:34:58 10.20.22.1 [139224.197075][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007f0e600fbae6
Aug 30 05:34:58 10.20.22.1 [139224.238630][  T817] RDX: 0000000000000000 =
RSI: 00007ffefc5fd2c0 RDI: 000000000000000d
Aug 30 05:34:58 10.20.22.1 [139224.280193][  T817] RBP: 00007ffefc5fd2c0 =
R08: 00007ffefc5fd240 R09: 0000000000000010
Aug 30 05:34:58 10.20.22.1 [139224.322186][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:34:58 10.20.22.1 [139224.364777][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007ffefc5ff340
Aug 30 05:34:58 10.20.22.1 [139224.408779][  T817] INFO: task pppd:6214 =
blocked for more than 126 seconds.
Aug 30 05:34:58 10.20.22.1 [139224.434346][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:34:58 10.20.22.1 [139224.457748][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:34:58 10.20.22.1 [139224.505077][  T817] pppd            D    =
0  6214      1 0x80004006
Aug 30 05:34:58 10.20.22.1 [139224.529414][  T817] Call Trace:
Aug 30 05:34:58 10.20.22.1 [139224.553311][  T817]  =
__schedule+0x374/0x750
Aug 30 05:34:58 10.20.22.1 [139224.577372][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:34:58 10.20.22.1 [139224.601876][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:34:58 10.20.22.1 [139224.626518][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:34:58 10.20.22.1 [139224.651377][  T817]  __fput+0xc8/0x220
Aug 30 05:34:58 10.20.22.1 [139224.676025][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:34:58 10.20.22.1 [139224.700727][  T817]  do_exit+0x317/0xa60
Aug 30 05:34:58 10.20.22.1 [139224.725179][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:34:58 10.20.22.1 [139224.749407][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:34:58 10.20.22.1 [139224.773395][  T817]  do_signal+0x25/0x1f0
Aug 30 05:34:58 10.20.22.1 [139224.797066][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:34:58 10.20.22.1 [139224.820858][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:34:59 10.20.22.1 [139224.844225][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:34:59 10.20.22.1 [139224.867338][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:34:59 10.20.22.1 [139224.889858][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:34:59 10.20.22.1 [139224.912213][  T817] RIP: =
0033:0x7f123bb69ae6
Aug 30 05:34:59 10.20.22.1 [139224.933910][  T817] Code: Bad RIP value.
Aug 30 05:34:59 10.20.22.1 [139224.954915][  T817] RSP: =
002b:00007ffcc1d86778 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:34:59 10.20.22.1 [139224.996494][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007f123bb69ae6
Aug 30 05:34:59 10.20.22.1 [139225.038094][  T817] RDX: 0000000000000000 =
RSI: 00007ffcc1d86880 RDI: 000000000000000d
Aug 30 05:34:59 10.20.22.1 [139225.079629][  T817] RBP: 00007ffcc1d86880 =
R08: 00007ffcc1d86800 R09: 0000000000000010
Aug 30 05:34:59 10.20.22.1 [139225.121528][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:34:59 10.20.22.1 [139225.164061][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007ffcc1d88900
Aug 30 05:34:59 10.20.22.1 [139225.207935][  T817] INFO: task pppd:6345 =
blocked for more than 126 seconds.
Aug 30 05:34:59 10.20.22.1 [139225.231494][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:34:59 10.20.22.1 [139225.254943][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:34:59 10.20.22.1 [139225.302255][  T817] pppd            D    =
0  6345      1 0x80004006
Aug 30 05:34:59 10.20.22.1 [139225.326549][  T817] Call Trace:
Aug 30 05:34:59 10.20.22.1 [139225.350395][  T817]  =
__schedule+0x374/0x750
Aug 30 05:34:59 10.20.22.1 [139225.374457][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:34:59 10.20.22.1 [139225.398941][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:34:59 10.20.22.1 [139225.423563][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:34:59 10.20.22.1 [139225.448356][  T817]  __fput+0xc8/0x220
Aug 30 05:34:59 10.20.22.1 [139225.473009][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:34:59 10.20.22.1 [139225.497728][  T817]  do_exit+0x317/0xa60
Aug 30 05:34:59 10.20.22.1 [139225.522193][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:34:59 10.20.22.1 [139225.546433][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:34:59 10.20.22.1 [139225.570432][  T817]  do_signal+0x25/0x1f0
Aug 30 05:34:59 10.20.22.1 [139225.594077][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:34:59 10.20.22.1 [139225.617860][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:34:59 10.20.22.1 [139225.641243][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:34:59 10.20.22.1 [139225.664364][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:34:59 10.20.22.1 [139225.686859][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:34:59 10.20.22.1 [139225.709186][  T817] RIP: =
0033:0x7fc1b8b04ae6
Aug 30 05:34:59 10.20.22.1 [139225.730924][  T817] Code: Bad RIP value.
Aug 30 05:34:59 10.20.22.1 [139225.752035][  T817] RSP: =
002b:00007ffdcc0eb328 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:34:59 10.20.22.1 [139225.793799][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007fc1b8b04ae6
Aug 30 05:35:00 10.20.22.1 [139225.835450][  T817] RDX: 0000000000000000 =
RSI: 00007ffdcc0eb430 RDI: 000000000000000d
Aug 30 05:35:00 10.20.22.1 [139225.877103][  T817] RBP: 00007ffdcc0eb430 =
R08: 00007ffdcc0eb3b0 R09: 0000000000000010
Aug 30 05:35:00 10.20.22.1 [139225.919224][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:35:00 10.20.22.1 [139225.961873][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007ffdcc0ed4b0
Aug 30 05:35:00 10.20.22.1 [139226.008832][  T817] INFO: task pppd:6356 =
blocked for more than 127 seconds.
Aug 30 05:35:00 10.20.22.1 [139226.032430][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:35:00 10.20.22.1 [139226.055831][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:35:00 10.20.22.1 [139226.103136][  T817] pppd            D    =
0  6356      1 0x80004006
Aug 30 05:35:00 10.20.22.1 [139226.127461][  T817] Call Trace:
Aug 30 05:35:00 10.20.22.1 [139226.151344][  T817]  =
__schedule+0x374/0x750
Aug 30 05:35:00 10.20.22.1 [139226.175415][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:35:00 10.20.22.1 [139226.199929][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:35:00 10.20.22.1 [139226.224583][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:35:00 10.20.22.1 [139226.249432][  T817]  __fput+0xc8/0x220
Aug 30 05:35:00 10.20.22.1 [139226.274123][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:35:00 10.20.22.1 [139226.298876][  T817]  do_exit+0x317/0xa60
Aug 30 05:35:00 10.20.22.1 [139226.323378][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:35:00 10.20.22.1 [139226.347679][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:35:00 10.20.22.1 [139226.371717][  T817]  do_signal+0x25/0x1f0
Aug 30 05:35:00 10.20.22.1 [139226.395603][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:35:00 10.20.22.1 [139226.419418][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:35:00 10.20.22.1 [139226.442808][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:35:00 10.20.22.1 [139226.465925][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:35:00 10.20.22.1 [139226.488417][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:35:00 10.20.22.1 [139226.510748][  T817] RIP: =
0033:0x7ff7a56e3ae6
Aug 30 05:35:00 10.20.22.1 [139226.532459][  T817] Code: Bad RIP value.
Aug 30 05:35:00 10.20.22.1 [139226.553489][  T817] RSP: =
002b:00007fff0552cc88 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:35:00 10.20.22.1 [139226.595108][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007ff7a56e3ae6
Aug 30 05:35:00 10.20.22.1 [139226.636659][  T817] RDX: 0000000000000000 =
RSI: 00007fff0552cd90 RDI: 000000000000000d
Aug 30 05:35:00 10.20.22.1 [139226.678206][  T817] RBP: 00007fff0552cd90 =
R08: 00007fff0552cd10 R09: 0000000000000010
Aug 30 05:35:00 10.20.22.1 [139226.720194][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:35:00 10.20.22.1 [139226.762823][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007fff0552ee10
Aug 30 05:35:00 10.20.22.1 [139226.806936][  T817] INFO: task pppd:6469 =
blocked for more than 128 seconds.
Aug 30 05:35:00 10.20.22.1 [139226.830316][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:35:01 10.20.22.1 [139226.853643][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:35:01 10.20.22.1 [139226.900867][  T817] pppd            D    =
0  6469      1 0x80004006
Aug 30 05:35:01 10.20.22.1 [139226.925126][  T817] Call Trace:
Aug 30 05:35:01 10.20.22.1 [139226.948997][  T817]  =
__schedule+0x374/0x750
Aug 30 05:35:01 10.20.22.1 [139226.973041][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:35:01 10.20.22.1 [139226.997529][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:35:01 10.20.22.1 [139227.022136][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:35:01 10.20.22.1 [139227.046960][  T817]  __fput+0xc8/0x220
Aug 30 05:35:01 10.20.22.1 [139227.071614][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:35:01 10.20.22.1 [139227.096345][  T817]  do_exit+0x317/0xa60
Aug 30 05:35:01 10.20.22.1 [139227.120807][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:35:01 10.20.22.1 [139227.145092][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:35:01 10.20.22.1 [139227.169108][  T817]  do_signal+0x25/0x1f0
Aug 30 05:35:01 10.20.22.1 [139227.192851][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:35:01 10.20.22.1 [139227.216651][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:35:01 10.20.22.1 [139227.240077][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:35:01 10.20.22.1 [139227.263177][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:35:01 10.20.22.1 [139227.285657][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:35:01 10.20.22.1 [139227.307939][  T817] RIP: =
0033:0x7f71cb0aeae6
Aug 30 05:35:01 10.20.22.1 [139227.329635][  T817] Code: Bad RIP value.
Aug 30 05:35:01 10.20.22.1 [139227.350619][  T817] RSP: =
002b:00007ffc18254558 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:35:01 10.20.22.1 [139227.392206][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007f71cb0aeae6
Aug 30 05:35:01 10.20.22.1 [139227.433686][  T817] RDX: 0000000000000000 =
RSI: 00007ffc18254660 RDI: 000000000000000d
Aug 30 05:35:01 10.20.22.1 [139227.475140][  T817] RBP: 00007ffc18254660 =
R08: 00007ffc182545e0 R09: 0000000000000010
Aug 30 05:35:01 10.20.22.1 [139227.517049][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:35:01 10.20.22.1 [139227.559595][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007ffc182566e0
Aug 30 05:35:01 10.20.22.1 [139227.603538][  T817] INFO: task pppd:6515 =
blocked for more than 129 seconds.
Aug 30 05:35:01 10.20.22.1 [139227.631097][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:35:01 10.20.22.1 [139227.659116][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:35:01 10.20.22.1 [139227.708693][  T817] pppd            D    =
0  6515      1 0x80004006
Aug 30 05:35:01 10.20.22.1 [139227.732967][  T817] Call Trace:
Aug 30 05:35:01 10.20.22.1 [139227.756775][  T817]  =
__schedule+0x374/0x750
Aug 30 05:35:01 10.20.22.1 [139227.780769][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:35:01 10.20.22.1 [139227.805180][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:35:01 10.20.22.1 [139227.829734][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:35:02 10.20.22.1 [139227.854477][  T817]  __fput+0xc8/0x220
Aug 30 05:35:02 10.20.22.1 [139227.879048][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:35:02 10.20.22.1 [139227.903738][  T817]  do_exit+0x317/0xa60
Aug 30 05:35:02 10.20.22.1 [139227.928124][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:35:02 10.20.22.1 [139227.952332][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:35:02 10.20.22.1 [139227.976328][  T817]  do_signal+0x25/0x1f0
Aug 30 05:35:02 10.20.22.1 [139228.000006][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:35:02 10.20.22.1 [139228.024080][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:35:02 10.20.22.1 [139228.047440][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:35:02 10.20.22.1 [139228.070543][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:35:02 10.20.22.1 [139228.093001][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:35:02 10.20.22.1 [139228.115295][  T817] RIP: =
0033:0x7f9efd834ae6
Aug 30 05:35:02 10.20.22.1 [139228.136973][  T817] Code: Bad RIP value.
Aug 30 05:35:02 10.20.22.1 [139228.157989][  T817] RSP: =
002b:00007ffd3f872648 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:35:02 10.20.22.1 [139228.199633][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007f9efd834ae6
Aug 30 05:35:02 10.20.22.1 [139228.241193][  T817] RDX: 0000000000000000 =
RSI: 00007ffd3f872750 RDI: 000000000000000d
Aug 30 05:35:02 10.20.22.1 [139228.282785][  T817] RBP: 00007ffd3f872750 =
R08: 00007ffd3f8726d0 R09: 0000000000000010
Aug 30 05:35:02 10.20.22.1 [139228.324770][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:35:02 10.20.22.1 [139228.367369][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007ffd3f8747d0
Aug 30 05:35:02 10.20.22.1 [139228.411501][  T817] INFO: task pppd:6518 =
blocked for more than 130 seconds.
Aug 30 05:35:02 10.20.22.1 [139228.439682][  T817]       Tainted: G      =
     O      5.8.5 #1
Aug 30 05:35:02 10.20.22.1 [139228.463079][  T817] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 30 05:35:02 10.20.22.1 [139228.510400][  T817] pppd            D    =
0  6518      1 0x80004006
Aug 30 05:35:02 10.20.22.1 [139228.534720][  T817] Call Trace:
Aug 30 05:35:02 10.20.22.1 [139228.558603][  T817]  =
__schedule+0x374/0x750
Aug 30 05:35:02 10.20.22.1 [139228.582648][  T817]  =
schedule_preempt_disabled+0x50/0xc0
Aug 30 05:35:02 10.20.22.1 [139228.607138][  T817]  =
__mutex_lock.constprop.0+0x15d/0x490
Aug 30 05:35:02 10.20.22.1 [139228.631765][  T817]  =
ppp_release+0xa8/0xe0 [ppp_generic]
Aug 30 05:35:02 10.20.22.1 [139228.656590][  T817]  __fput+0xc8/0x220
Aug 30 05:35:02 10.20.22.1 [139228.681210][  T817]  =
task_work_run+0x57/0x90
Aug 30 05:35:02 10.20.22.1 [139228.705908][  T817]  do_exit+0x317/0xa60
Aug 30 05:35:02 10.20.22.1 [139228.730378][  T817]  =
do_group_exit+0x2e/0x90
Aug 30 05:35:02 10.20.22.1 [139228.754737][  T817]  =
get_signal+0x11b/0x7a0
Aug 30 05:35:02 10.20.22.1 [139228.778756][  T817]  do_signal+0x25/0x1f0
Aug 30 05:35:02 10.20.22.1 [139228.802429][  T817]  ? =
ktime_get_ts64+0x3e/0xe0
Aug 30 05:35:02 10.20.22.1 [139228.826213][  T817]  ? =
_copy_to_user+0x22/0x30
Aug 30 05:35:03 10.20.22.1 [139228.849579][  T817]  =
__prepare_exit_to_usermode+0xd6/0x140
Aug 30 05:35:03 10.20.22.1 [139228.872687][  T817]  =
do_syscall_64+0x50/0x120
Aug 30 05:35:03 10.20.22.1 [139228.895197][  T817]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 30 05:35:03 10.20.22.1 [139228.917506][  T817] RIP: =
0033:0x7f24f2125ae6
Aug 30 05:35:03 10.20.22.1 [139228.939181][  T817] Code: Bad RIP value.
Aug 30 05:35:03 10.20.22.1 [139228.960199][  T817] RSP: =
002b:00007fff2581e1c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
Aug 30 05:35:03 10.20.22.1 [139229.001783][  T817] RAX: fffffffffffffdfe =
RBX: 0000000000000000 RCX: 00007f24f2125ae6
Aug 30 05:35:03 10.20.22.1 [139229.043314][  T817] RDX: 0000000000000000 =
RSI: 00007fff2581e2d0 RDI: 000000000000000d
Aug 30 05:35:03 10.20.22.1 [139229.084704][  T817] RBP: 00007fff2581e2d0 =
R08: 00007fff2581e250 R09: 0000000000000010
Aug 30 05:35:03 10.20.22.1 [139229.126477][  T817] R10: 0000000000000000 =
R11: 0000000000000246 R12: 0000000000001000
Aug 30 05:35:03 10.20.22.1 [139229.168852][  T817] R13: 000000000000000c =
R14: 0000000000000000 R15: 00007fff25820350


Best regards,
Martin=
