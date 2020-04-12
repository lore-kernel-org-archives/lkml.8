Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8559C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A804C206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 10:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXe3tyhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDLKH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 06:07:56 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38388 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgDLKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 06:07:55 -0400
Received: by mail-wr1-f53.google.com with SMTP id k11so6648250wrp.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=u1+egOFKlwXP6oMThEgDQ38Uzyyw1P/CdopqK3EDEdY=;
        b=FXe3tyheSluhb1M626067NlYAQjir/Ip/pY52Va9weUak/FbfknL9gz1y7GoIUkigN
         XtOIiYgWrYZvBLxicPAVRlXUCWx8pTwfbE1TNNabiPpBJNT0yTImhpS8Oqv2ssaFPUvI
         lVV24kJrIz9ED+MhtBgaqPJZdO6jRg3+p7DGGYSiZ8GbP08yJWtLmMyyhOp//YjPvM7u
         aYHdi8eNFBCknD4feA0UmARIE2oYpf183wabr89NW0hEjKonswYk4MTiuOwHtUkqD165
         zfdvKc79JshTAnt9136HCG6F4Vs0BEZiCWhGK7/zhD2r3+FIzCOGu9UWhOQux3AG30Gp
         H4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=u1+egOFKlwXP6oMThEgDQ38Uzyyw1P/CdopqK3EDEdY=;
        b=jzMXNWpdPo+2VMagC1ADYmVb4tbCGu3S3gHg6QtgGAKt6m0O0lwUCzztO/f2ftAvpx
         nreLafgKWzchTcAkNSeB64b5ubmrjaw1OmV4WWL0mHZmP6mVOssUtxfGINhstMhOWYAL
         4fHmQz4O5YAZpfeYU2vG+NG8m7o4SXmAGAykYfr4a9/hhtwxC7mkrp6TEeMLw+KwjjgK
         L5cnf8zAcyFCDlKgOYWYbeI0xTsVlxY9j1OasPahAG9ZDoZL4ZnElRq1l7flPzFtRag3
         0Akua9uM+wE7y4lolwY61Fc6vcxyoiwCR5NMNuhfhkBq/qYy+S4V0yzHesvQuRRILDrl
         nQhA==
X-Gm-Message-State: AGi0PuYuiJ7bcZoHyYQlJO6W97k1lj+i7uPB36+XsxMidxTSOhKo78v4
        U+fFXNlnz+iC5U/ccyKm2uo=
X-Google-Smtp-Source: APiQypL2jfRjNfxIipaMEa8Sc1VCwZUTcR7+R2vaLywtWlVWjZ/fOi7AFioN6JtxU7a16JvvkplGVg==
X-Received: by 2002:adf:97c5:: with SMTP id t5mr795648wrb.300.1586686072529;
        Sun, 12 Apr 2020 03:07:52 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id n18sm9599756wmk.6.2020.04.12.03.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 03:07:52 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.06 is released
To:     lkml <linux-kernel@vger.kernel.org>
Message-ID: <0d7a8763-37a3-e2b2-2012-33ba79c4079b@gmail.com>
Date:   Sun, 12 Apr 2020 12:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-5.06 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from 39 people, with over 250 commits making changes
to more than 120 pages. Three new pages were added in this
release.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.06

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2020/04/man-pages-506-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.06 ====================

Released: 2020-04-11, Munich


New and rewritten pages
-----------------------

openat2.2
    Aleksa Sarai  [Michael Kerrisk]
        Document new openat2(2) syscall

pidfd_getfd.2
    Michael Kerrisk  [Christian Brauner]
        New manual page documenting the pidfd_getfd() system call

select.2
    Michael Kerrisk
        Rewrite DESCRIPTION
            Improve structure and readability, at the same time incorporating
            text and details that were formerly in select_tut(2). Also
            move a few details in other parts of the page into DESCRIPTION.

select_tut.2
    Michael Kerrisk
        Eliminate duplication of info across select_tut.2 and select2
            There was a lot of a duplication of info in SYNOPSIS, DESCRIPTION
            RETURN VALUE, and SEE ALSO. Move all of the info to one place:
            the select(2) page.

sysvipc.7
    Michael Kerrisk
        Rewrite this page as just a summary of the System V IPC APIs
            All of the other details in this page have by now been moved into
            the relevant *ctl(2) pages.

time_namespaces.7
    Michael Kerrisk  [Andrei Vagin, Dmitry Safonov, Thomas Gleixner]
        New page documenting time namespaces


Newly documented interfaces in existing pages
---------------------------------------------

arch_prctl.2
    Keno Fischer
        Add ARCH_SET_CPUID subcommand

clock_getres.2
    Benjamin Peterson
        Document CLOCK_TAI
    Michael Kerrisk
        Add CLOCK_REALTIME_ALARM and CLOCK_BOOTTIME_ALARM

prctl.2
    Mike Christie  [Michal Hocko, Michael Kerrisk, Bart Van Assche]
        Document PR_SETIO_FLUSHER/GET_IO_FLUSHER

setns.2
    Michael Kerrisk
        Document CLONE_NEWTIME

statx.2
    Eric Biggers
        Document STATX_ATTR_VERITY

unshare.2
    Michael Kerrisk
        Document CLONE_NEWTIME

socket.7
    Ricardo Biehl Pasquali, Michael Kerrisk
        Add description of SO_SELECT_ERR_QUEUE
    Alejandro Colomar  [Michael Kerrisk]
        Document SO_TIMESTAMPNS


Global changes
--------------

Various pages
    Michael Kerrisk
        Remove a few mentions of the ancient "Linux libc"


Changes to individual pages
---------------------------

clock_getres.2
    Helge Deller  [Michael Kerrisk]
        Consecutive calls for CLOCK_MONOTONIC may return same value
            Consecutive calls to clock_gettime(CLOCK_MONOTONIC) are guaranteed
            to return MONOTONIC values, which means that they either return
            the *SAME* time value like the last call, or a later (higher) time
            value.
    Eric Rannaud
        Dynamic POSIX clock devices can return other errors
    Michael Kerrisk
        Improve description of CPU-time clocks
    Michael Kerrisk
        Add an example program
    Michael Kerrisk
        CLOCK_REALTIME_COARSE is not settable
    Michael Kerrisk
        Note that CPU-time clocks are not settable.
            Explicitly note that CLOCK_PROCESS_CPUTIME_ID and
            CLOCK_PROCESS_CPUTIME_ID are not settable.
    Michael Kerrisk
        Clarify that CLOCK_TAI is nonsettable
    Michael Kerrisk
        Clarify that CLOCK_MONOTONIC is system-wide

clock_nanosleep.2
    Michael Kerrisk
        clock_nanosleep() can also sleep against CLOCK_TAI
    Michael Kerrisk
        clock_nanosleep() also supports CLOCK_BOOTTIME

clock_nanosleep.2
timer_create.2
timerfd_create.2
    Michael Kerrisk
        Add various missing errors
            Mostly verified by testing and reading the code.

            There is unfortunately quite a bit of inconsistency across API~s:

                              clock_gettime  clock_settime  clock_nanosleep  timer_create  timerfd_create

            CLOCK_BOOTTIME            y        n (EINVAL)     y                y             y
            CLOCK_BOOTTIME_ALARM      y        n (EINVAL)     y [1]            y [1]         y [1]
            CLOCK_MONOTONIC           y        n (EINVAL)     y                y             y
            CLOCK_MONOTONIC_COARSE    y        n (EINVAL)     n (ENOTSUP)      n (ENOTSUP)   n (EINVAL)
            CLOCK_MONOTONIC_RAW       y        n (EINVAL)     n (ENOTSUP)      n (ENOTSUP)   n (EINVAL)
            CLOCK_REALTIME            y        y              y                y             y
            CLOCK_REALTIME_ALARM      y        n (EINVAL)     y [1]            y [1]         y [1]
            CLOCK_REALTIME_COARSE     y        n (EINVAL)     n (ENOTSUP)      n (ENOTSUP)   n (EINVAL)
            CLOCK_TAI                 y        n (EINVAL)     y                y             n (EINVAL)
            CLOCK_PROCESS_CPUTIME_ID  y        n (EINVAL)     y                y             n (EINVAL)
            CLOCK_THREAD_CPUTIME_ID   y        n (EINVAL)     n (EINVAL [2])   y             n (EINVAL)
            pthread_getcpuclockid()   y        n (EINVAL)     y                y             n (EINVAL)

            [1] The caller must have CAP_WAKE_ALARM, or the error EPERM results.

            [2] This error is generated in the glibc wrapper.

connect.2
    Michael Kerrisk  [Eric Dumazet]
        Update the details on AF_UNSPEC
            Update the details on AF_UNSPEC and circumstances in which
            socket can be reconnected.

execve.2
    Michael Kerrisk
        Explicitly note that argv[argc] == NULL in the new program
    Michael Kerrisk
        ERRORS: ENOENT does not occur for missing shared libraries
            See http://sourceware.org/bugzilla/show_bug.cgi?id=12241.

_exit.2
    Michael Kerrisk
        Clarify that raw _exit() system call terminates only the calling thread

io_submit.2
    Julia Suvorova
        Add IOCB_CMD_POLL opcode

lseek.2
    Michael Kerrisk  [Matthew Wilcox]
        ERRORS: ENXIO can also occur for SEEK_DATA in middle of hole at end of file

madvise.2
    Michael Kerrisk  [Andrea Arcangeli]
        Incorporate some (ancient) comments about MADV_HUGEPAGE
            Back in 2011, a mail from Andrea Arcangeli noted some details
            that I never got round to incorporating into the manual page.

msgctl.2
    Michael Kerrisk
        Add information on permission bits (based on sysvipc(7) text)
    Michael Kerrisk
        Copy information on 'msqid_ds' fields from sysvipc(7)

open.2
    Michael Kerrisk
        Clarify that O_NOFOLLOW is relevant (only) for basename of 'pathname'

poll.2
    Michael Kerrisk
        Add an example program

semctl.2
    Michael Kerrisk
        Copy information on 'semid_ds' fields from sysvipc(7)
    Michael Kerrisk
        Add information on permission bits (based on sysvipc(7) text)

semget.2
    Michael Kerrisk
        EXAMPLE: add an example program

shmctl.2
    Michael Kerrisk
        Add information on permission bits (based on sysvipc(7) text)
    Michael Kerrisk
        Note that execute permission is not needed for shmat() SHM_EXEC
    Michael Kerrisk
        Copy information on 'shmid_ds' fields from sysvipc(7)

shmop.2
    Michael Kerrisk
        EXAMPLE: add a pair of example programs
            Add example programs demonstrating usage of shmget(2), shmat(2),
            semget(2), semctl(2), and semop(2).

sigaction.2
signal.7
    Zack Weinberg
        Document kernel bugs in delivery of signals from CPU exceptions

stat.2
    Michael Kerrisk
        Clarify definitions of timestamp fields
            In particular, make it clear that atime and mtime relate to the
            file *data*.

syscalls.2
    Michael Kerrisk
        Add new Linux 5.6 system calls
    Michael Kerrisk
        Note that the 5.x series followed 4.20

timer_create.2
    Michael Kerrisk
        timer_create(2) also supports CLOCK_TAI
    Michael Kerrisk
        Mention clock_getres(2) for further details on the various clocks

timerfd_create.2
    Michael Kerrisk  [Thomas Gleixner]
        Note a case where timerfd_settime() can fail with ECANCELED
    Michael Kerrisk  [devi R.K, Thomas Gleixner]
        Negative changes to CLOCK_REALTIME may cause read() to return 0
    Michael Kerrisk
        Refer reader to clock_getres(2) for further details on the clocks

unshare.2
    Michael Kerrisk
        Add CLONE_NEWCGROUP and CLONE_NEWTIME to example program

shm_open.3
    Michael Kerrisk
        EXAMPLE: add some example programs

proc.5
    Mike Frysinger
        Clarify /proc/[pid]/cmdline mutability

cgroups.7
    Michael Kerrisk
        Update list of cgroups v2 controllers
            Update the list of cgroups v2 controllers (several controllers
            were missing).
    Michael Kerrisk
        Add a subsection on cgroup v2 mount options and include 'nsdelegate'
    Michael Kerrisk
        Document the cgroups v2 'memory_localevents' mount option

path_resolution.7
    Aleksa Sarai
        Update to mention openat2(2) features

socket.7
    Michael Kerrisk
        Note SCM message types for SO_TIMESTAMP and SO_TIMESTAMPNS
vsock.7
    Stefano Garzarella  [Jorgen Hansen, Stefan Hajnoczi]
        Add VMADDR_CID_LOCAL description


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
