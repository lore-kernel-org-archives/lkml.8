Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02D3C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B321420733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnQ8dPfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBIUJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 15:09:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33801 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbgBIUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:09:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id s144so6977943wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DJWsNj8oKGKTYPoTiif+dSza7m7vZ8AVTWBtS/RZGxo=;
        b=dnQ8dPfUKKoIZyaoj7jZAYVbzvdYMQvmHnjCiU1rKPlYhAZnypRJN1rnwnSjcs1cKg
         7M+YwpslZXxUJ2l7o1AscsmgrSe78DZJOFxj/G5vV4dqQjXKYRZ0F2CKToUpJ3PkkhIm
         Iwt7KtqjfjJuJVrSPdMwqdBIdOkyK00X4lr43QcPdzcNErDZiJQZJyrfJVCM6tyV9kEG
         Uc09FNwBy1sw9Se1N+rNk5Mbuw5cU7TxL8nna0AvwSPghFuMiPGcubspNdqtKFFKWUaz
         n6G0Sc2b5DUZI9jP8E5dNa86ILj+xBcFhDSrJQiT1PF5d0zrjz3ESsGDkc8HXwmBvAMO
         qwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DJWsNj8oKGKTYPoTiif+dSza7m7vZ8AVTWBtS/RZGxo=;
        b=XjuuN554F6YM3FOLGDgCXZIpccbjOW4L5OmjwAdPPR3TC2EoNGK7TiYBADcmVeaErZ
         Sr6vCeSkUQhJ+ff6CkKJEaJqYwII2cziPgtp2x6mfCluLIFoKQV/o2BIvsC0EhkGo3T+
         aSTk0mEwp7VMIbBHPyzt8Evlu03dPzr8nSP2azGtjEbjS++GugNIMSubY3bgqz5hSU7b
         YdwVxqCEUozjaFZTDxul3I5ocW7xCa1QkRAlz67F2YUy1pRPQ45Mpxgi13KQc1xkCRHJ
         HTaX7MadhzRMfL8RrBranwsfy3hOBfr+KfSYSdGiMMrzsQJzdu4JLH2KUii8S9MxYeSk
         B7eA==
X-Gm-Message-State: APjAAAXNrHJEQl1hKPByHGFbpBEkUupJJh5UrIEGVp2KUXNbcrMUUkyP
        KUCYnKSuYFA3dV0qEndIMv/OFTYA
X-Google-Smtp-Source: APXvYqxwezl8Piw9by8kU6xL9KqG0aCIbdEfFJyHIy/NWW7U5Ql7XJzr+RA4WTQ8nwX6f+MntAYN8w==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr10347934wml.47.1581278985633;
        Sun, 09 Feb 2020 12:09:45 -0800 (PST)
Received: from ?IPv6:2001:a61:251f:d701:c8c9:6ecf:205c:abb7? ([2001:a61:251f:d701:c8c9:6ecf:205c:abb7])
        by smtp.gmail.com with ESMTPSA id m21sm12359009wmi.27.2020.02.09.12.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 12:09:45 -0800 (PST)
Cc:     mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-5.05 is released
Message-ID: <fa58ca78-cbb7-6e37-ba1e-76f8e9b5c7de@gmail.com>
Date:   Sun, 9 Feb 2020 21:09:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
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

    man-pages-5.05 - man pages for Linux

This release resulted from patches, bug reports, reviews, and
comments from 40 people, with around 110 commits making changes
to around 50 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_5.05

A (very) short summary of the release is blogged at:
https://linux-man-pages.blogspot.com/2020/02/man-pages-505-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael==================== Changes in man-pages-5.05 ====================

Released: 2020-02-09, Munich



Newly documented interfaces in existing pages
---------------------------------------------

clone.2
    Adrian Reber  [Christian Brauner, Michael Kerrisk]
        Add clone3() set_tid information
    Michael Kerrisk
        Document CLONE_CLEAR_SIGHAND

fcntl.2
    Joel Fernandes  [Michael Kerrisk]
        Update manpage with new memfd F_SEAL_FUTURE_WRITE seal

memfd_create.2
    Joel Fernandes
        Update manpage with new memfd F_SEAL_FUTURE_WRITE seal

loop.4
    Yang Xu
        Document LOOP_SET_BLOCK_SIZE
    Yang Xu
        Document LOOP_SET_DIRECT_IO

proc.5
    Michael Kerrisk
        Document /proc/sys/vm/unprivileged_userfaultfd


Changes to individual pages
---------------------------

clone.2
    Michael Kerrisk
        Note that CLONE_THREAD causes similar behavior to CLONE_PARENT
            The introductory paragraphs note that "the calling process" is
            normally synonymous with the "the parent process", except in the
            case of CLONE_PARENT. The same is also true of CLONE_THREAD.
    Christian Brauner  [Michael Kerrisk]
        Mention that CLONE_PARENT is off-limits for inits

listen.2
    Michael Kerrisk  [Peter Gajdos]
        The 'somaxconn' default value has increased to 4096

open.2
    Adam Borowski
        No need for /proc to make an O_TMPFILE file permanent
            In the example snippet, we already have the fd, thus there's no
            need to refer to the file by name.  And, /proc/ might be not
            mounted or not accessible.
    Michael Kerrisk  [Joseph C. Sible]
        In O_TMPFILE example, describe alternative linkat() call
            This was already shown in an earlier version of the page,
            but Adam Borowski's patch replaced it with an alternative.
            Probably, it is better to show both possibilities.

ptrace.2
    Denys Vlasenko
        PTRACE_EVENT_STOP does not always report SIGTRAP

stime.2
    Michael Kerrisk
        Note that stime() is deprecated

sysctl.2
    Michael Kerrisk
        This system call was removed in Linux 5.5; adjust the page accordingly

cmsg.3
    Rich Felker
        Clarify alignment issues and correct method of accessing CMSG_DATA()
console_codes.4
    Adam Borowski
        Document \e[90m to 97, 100 to 107
    Adam Borowski
        \e[21m is now underline
    Adam Borowski
        Update \e[38m and \e[48m

cgroups.7
    Michael Kerrisk
        The v2 freezer controller was added in Linux 5.2
    Michael Kerrisk
        Split discussion of cgroups.events file and v2 release notification
            In preparation for adding a description of the "frozen" key.
    Michael Kerrisk
        Describe the cgroup.events "frozen" key
    Michael Kerrisk
        Improve the discussion of the advantages of v2 release notification

unix.7
    Michael Kerrisk
        The PID sent with SCM_CREDENTIALS must match an existing process

ldconfig.8
    DJ Delorie
        Document file filter and symlink pattern expectations

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
