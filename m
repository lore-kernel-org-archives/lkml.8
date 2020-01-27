Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA0AC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E78C20661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgA0Kyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:54:53 -0500
Received: from ns.iliad.fr ([212.27.33.1]:36612 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgA0Kyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:54:52 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 125492013C;
        Mon, 27 Jan 2020 11:54:51 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id F098C20014;
        Mon, 27 Jan 2020 11:54:50 +0100 (CET)
Subject: Re: Writing a robust core-dump handling script (wrt PID namespaces)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Eric Biederman <ebiederm@xmission.com>,
        Stephane Graber <stgraber@ubuntu.com>,
        Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <4309685e-476c-7505-4fd4-fec7095c581d@free.fr>
Message-ID: <bb897307-b5fc-eb1c-5fa6-2be92bb0fc9d@free.fr>
Date:   Mon, 27 Jan 2020 11:54:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4309685e-476c-7505-4fd4-fec7095c581d@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Jan 27 11:54:51 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2020 14:39, Marc Gonzalez wrote:

> I'm trying to write a robust core-dump handling script -- which eventually
> sends minidumps remotely for analysis, like Mozilla Socorro[1] but for any
> crashing process in the system.
> 
> I read 'man 5 core' several times, but I'm confused about "PID namespaces".
> 
>            %p  PID of dumped process, as seen in the PID namespace in which
>                the process resides
>            %P  PID of dumped process, as seen in the initial PID namespace
>                (since Linux 3.12)
> 
> For now, I've set up :
> 
>     echo 5 > /proc/sys/kernel/core_pipe_limit
>     echo "|/usr/sbin/coredump %P" > /proc/sys/kernel/core_pattern
> 
> I used %P but I'm not sure why.
> (I used 5 somewhat at random too.)
> 
> The coredump script is supposed to access /proc/$PID
> 
> Should I use %P or %p or something else?

I /think/ %P is the proper option, because the /usr/sbin/coredump process
should (??) be created in the initial PID namespace.

Tangent: if a process is created in a different PID namespace, does it also
have a "global" PID, or is it "invisible" in the "root" PID namespace?

http://man7.org/linux/man-pages/man7/pid_namespaces.7.html

>        A process is visible to other processes in its PID namespace, and to
>        the processes in each direct ancestor PID namespace going back to the
>        root PID namespace.  In this context, "visible" means that one
>        process can be the target of operations by another process using
>        system calls that specify a process ID.  Conversely, the processes in
>        a child PID namespace can't see processes in the parent and further
>        removed ancestor namespaces.  More succinctly: a process can see
>        (e.g., send signals with kill(2), set nice values with
>        setpriority(2), etc.) only processes contained in its own PID
>        namespace and in descendants of that namespace.

What about /proc/[pid] ? (breakpad needs these bits)

I'm still not 100% sure about how to access the /proc/[pid] directory of
a process that crashed in a new PID namespace FROM a coredump analyzer
in the root PID namespace.

Regards.
