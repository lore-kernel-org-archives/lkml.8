Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF1CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31416206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnZvvgii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbgFISDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731293AbgFISDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:03:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECD7C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:03:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so22361330wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=d6cxHTmdrdOq4Ucn3BENkk/pbpHBFRRtoaHfiRuVtaQ=;
        b=tnZvvgiij9toa2JqU0CnhBKocC9OjJBlwY2UuY+Omzu/z8T7DSk63DpaitVA2KcIlI
         qQKLRjmmHm23AbGCaOFVe+e520SAbaRHRAC0T69dpoeuprAbdaAv0doFzcHK19i4zxEh
         k8J+zIR6MH+KMYq5rVBwDi8N++P2JHeOsNGsTxF8lgpG4+Y4miH7Y8TaIEJEe4blYhu8
         I/1h2wZyyhxOV0FBjjfoBtWQdbm9cCh/+rq8A7Q3agiWxYbHx+yBTNDYLZWanz4v2+g8
         pbbv+pzbNLaxy+VV52r8hiuFT/kjpzoefXk8dzb04D0hSGcKbFpl1Lgx2hr0PNNXYaNK
         sndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=d6cxHTmdrdOq4Ucn3BENkk/pbpHBFRRtoaHfiRuVtaQ=;
        b=nVG8KbcBqPckUl8NFK2FkBXa2rd7ls1GVqscIzmo3GvedXcoC6MP9g368I/D+EQpmc
         ZMEcrqHGzfhSVnXSgwi8Du3raq4qeVmAfOWP1Eu7IyPd/i1mLfns0KryVh/vyNBNxl2V
         ZPvKOi6Hh2MuBX+USsnrFsfcjrnS+/zAGGzC5s8ZIQqNL5Mu+nCgJjILvpQ+NlkSC+ZF
         4yh4jemzNYNS/wSi0KFjpXvja/mzIH21xLq357ZB5xc8iuq1wL/5ZCL81qYN1l7JI/fH
         znfgMmGE+ewyzwwcR/U+LF+rVeItPk7YsWMJFDvp01oIQptQoThhtNzOGZUDsj45tAI5
         kpZA==
X-Gm-Message-State: AOAM533UKBH2dVMf7KfhEVMcmYLngt1MP6V29jNlyfmel8ZJzAD6TeIz
        YotaBMcE/mYB0GoQqxpE0CUpQKdEm9w=
X-Google-Smtp-Source: ABdhPJx3bCLwIxfR6ZBngX8KUZyDgfayVhw+Hz1VfY54bpQggDQY5d5G2ue544UgSlloi++PFP2GSQ==
X-Received: by 2002:adf:f4d2:: with SMTP id h18mr5865848wrp.370.1591725825854;
        Tue, 09 Jun 2020 11:03:45 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id u130sm3739637wmg.32.2020.06.09.11.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:03:45 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-5.07 is released
To:     lkml <linux-kernel@vger.kernel.org>
Message-ID: <23954765-c7f2-db61-32c0-47edb7c73f58@gmail.com>
Date:   Tue, 9 Jun 2020 20:03:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-5.07 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from over 80 people, with over 380 commits making changes
to more than 380 pages. One new page was added in this
release, and one page was removed.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.07

A short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2020/06/man-pages-507-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-5.07 ====================

New and rewritten pages
-----------------------

ioctl_fslabel.2
    Eric Sandeen
        New page documenting filesystem get/set label ioctl(2) operations


Removed pages
-------------

ioctl_list.2
    Michael Kerrisk  [Heinrich Schuchardt, Eugene Syromyatnikov]
        This page was first added more than 20 years ago. Since
        that time it has seen hardly any update, and is by now
        very much out of date, as reported by Heinrich Schuchardt
        and confirmed by Eugene Syromyatnikov.

        As Heinrich says:

            Man-pages like netdevices.7 or ioctl_fat.2 are what is
            needed to help a user who does not want to read through the
            kernel code.

            If ioctl_list.2 has not been reasonably maintained since
            Linux 1.3.27 and hence is not a reliable source of
            information, shouldn't it be dropped?

        My answer is, yes (but let's move a little info into ioctl(2)).


Newly documented interfaces in existing pages
---------------------------------------------

adjtimex.2
    Arnd Bergmann  [Richard Cochran, Michael Kerrisk]
        Document clock_adjtime(2)

clock_getres.2
    Richard Cochran  [Michael Kerrisk]
        Explain dynamic clocks

clone.2
    Christian Brauner, Michael Kerrisk
        Document the clone3() CLONE_INTO_CGROUP flag

mremap.2
    Brian Geffon, Michael Kerrisk  [Lokesh Gidra]
        Document MREMAP_DONTUNMAP

open.2
    Joseph C. Sible  [Michael Kerrisk]
        Document fs.protected_fifos and fs.protected_regular

prctl.2
    Dave Martin
        Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
    Dave Martin
        Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
    Dave Martin
        Add PR_PAC_RESET_KEYS (arm64)

ptrace.2
    Joseph C. Sible
        Document PTRACE_SET_SYSCALL

proc.5
    Michael Kerrisk
        Document /proc/sys/fs/protected_regular
    Michael Kerrisk
        Document /proc/sys/fs/protected_fifos
    Michael Kerrisk
        Document /proc/sys/fs/aio-max-nr and /proc/sys/fs/aio-nr


Changes to individual pages
---------------------------

bpf.2
    Peter Wu
        Update enum bpf_map_type and enum bpf_prog_type
    Richard Palethorpe
        Change note on unprivileged access
            The kernel now allows calls to bpf() without CAP_SYS_ADMIN
            under some circumstances.

close.2
    Michael Kerrisk  [Lukas Czerner, Peter Schiffer, Thierry Lelegard]
        Note behavior when close() happens in a parallel thread
            If one thread is blocked in an I/O system call on a file descriptor
            that is closed in another thread, then the blocking system call
            does not return immediately, but rather when the I/O operation
            completes. This surprises some people, but is longstanding
            behavior.

execve.2
    Michael Kerrisk  [Eric Hopper]
        Changes to the "dumpable" flag may change ownership of /proc/PID files
    Nikola Forró
        Clarify signal sent to the process on late failure

fanotify_init.2
    Amir Goldstein  [Jan Kara, Matthew Bobrowski]
        Clarification about FAN_EVENT_ON_CHILD and new events
    Amir Goldstein  [Jan Kara, Matthew Bobrowski]
        Clarification about FAN_MARK_MOUNT and FAN_REPORT_FID

mbind.2
    Li Xinhai  [Michael Kerrisk]
        Remove note about MPOL_MF_STRICT been ignored

move_pages.2
    Yang Shi  [Michal Hocko]
        Returning positive value is a new error case

prctl.2
    Dave Martin
        Clarify that prctl can apply to threads
            The current synopsis for prctl(2) misleadingly claims that prctl
            operates on a process.  Rather, some (in fact, most) prctls operate
    Dave Martin  [Dave Hansen]
        Document removal of Intel MPX prctls
    Dave Martin  [Michael Kerrisk]
        Add health warning

syscall.2
    Dave Martin  [Will Deacon]
        arm64: Fix syscall number register size
    Dave Martin  [Russell King]
        arm: Use real register names for arm/OABI

core.5
    Michael Kerrisk  [Jonny Grant]
        Mention 'sysctl -w' as a way of changing core_pattern setting
    Michael Kerrisk  [Jonny Grant]
        Explain that core_pattern %e is process/thread 'comm' value
            The 'comm' value is typically the same as the (possibly
            truncated) executable name, but may be something different.

proc.5
    Michael Kerrisk
        Note kernel version for /proc/PID/smaps VmFlags "wf" flag
    Michael Kerrisk
        Add "um" and "uw" to VmFlags in /proc/[pid]/smaps
    Michael Kerrisk
        Add "mp" to VmFlags in /proc/[pid]/smaps
    Michael Kerrisk
        Note kernel version that removed /proc/PID/smaps VmFlags "nl" flag
    Ian Rogers
        Add "wf" to VmFlags in /proc/[pid]/smaps
    Michael Kerrisk
        Note kernel version for /proc/PID/smaps VmFlags "dd" flag
    Michael Kerrisk
        Add "sf" to VmFlags in /proc/[pid]/smaps
    Michael Kerrisk  [Kirill A. Shutemov]
        Remove "mp" under VmFlags in /proc/[pid]/smaps
    Michael Kerrisk  [Eric Hopper]
        Alert the reader that UID/GID changes can reset the "dumpable" attribute
    Keno Fischer
        Fix an outdated note about map_files
            The restriction to CAP_SYS_ADMIN was removed from map_files in 2015.
    Michael Kerrisk  [Helge Kreutzmann]
        Better explanation of some /proc/ide fields
    Michael Kerrisk
        TASK_COMM_LEN limit includes the terminating '\0'
            Clarify this detail in the discussion of /proc/[pid]/comm.
    Michael Kerrisk
        Add a detail to /proc/[pid]/comm
            Note the connection to the "%e" specifier in
            /proc/sys/kernel/core_pattern.

bpf-helpers.7
    Michael Kerrisk
        Resync against kernel 5.7

cgroups.7
    Marcus Gelderie
        Mention cgroup.sane_behavior file
            The cgroup.sane_behavior file returns the hard-coded value "0" and
            is kept for legacy purposes. Mention this in the man-page.

credentials.7
    Michael Kerrisk
        Alert reader that UID/GID changes can affect process capabilities
    Michael Kerrisk
        Changes to process UIDs/GIDs can effect the "dumpable" attribute

fanotify.7
fanotify_mark.2
    Amir Goldstein  [Matthew Bobrowski]
        Clarify FAN_ONDIR in output mask
            FAN_ONDIR was an input only flag before introducing
            FAN_REPORT_FID.  Since the introduction of FAN_REPORT_FID, it can
            also be in output mask.

namespaces.7
    Michael Kerrisk
        Document /proc/sys/user/max_time_namespaces

pid_namespaces.7
    Michael Kerrisk
        Note that /proc/sys/kernel/ns_last_pid is virtualized per PID NS
    Michael Kerrisk
        Correct capability requirements for write to /proc/sys/kernel/ns_last_pid
            CAP_SYS_ADMIN is needed in the user NS that owns the PID NS.

symlink.7
    Michael Kerrisk
        Describe differences in the treatment of symlinks in the dirname
            Describe differences in the treatment of symlinks in the dirname
            part of pathname.

tcp.7
    Michael Kerrisk  [vrafaeli@msn.com]
        Update info on tcp_syn_retries default value
            See https://bugzilla.kernel.org/show_bug.cgi?id=202885.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
