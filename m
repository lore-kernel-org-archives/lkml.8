Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC2DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B7020730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAPNjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:39:11 -0500
Received: from ns.iliad.fr ([212.27.33.1]:33696 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgAPNjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:39:11 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 4331C201FB;
        Thu, 16 Jan 2020 14:39:09 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 2D6D1200B9;
        Thu, 16 Jan 2020 14:39:09 +0100 (CET)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Writing a robust core-dump handling script (wrt PID namespaces)
To:     Eric Biederman <ebiederm@xmission.com>,
        Stephane Graber <stgraber@ubuntu.com>,
        Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Message-ID: <4309685e-476c-7505-4fd4-fec7095c581d@free.fr>
Date:   Thu, 16 Jan 2020 14:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jan 16 14:39:09 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to write a robust core-dump handling script -- which eventually
sends minidumps remotely for analysis, like Mozilla Socorro[1] but for any
crashing process in the system.

I read 'man 5 core' several times, but I'm confused about "PID namespaces".

           %p  PID of dumped process, as seen in the PID namespace in which
               the process resides
           %P  PID of dumped process, as seen in the initial PID namespace
               (since Linux 3.12)

For now, I've set up :

    echo 5 > /proc/sys/kernel/core_pipe_limit
    echo "|/usr/sbin/coredump %P" > /proc/sys/kernel/core_pattern

I used %P but I'm not sure why.
(I used 5 somewhat at random too.)

The coredump script is supposed to access /proc/$PID

Should I use %P or %p or something else?

For my own reference:
commit 65aafb1e7484b7434a0c1d4c593191ebe5776a2f

Regards.


[1] https://crash-stats.mozilla.com/
[2] http://man7.org/linux/man-pages/man5/core.5.html
