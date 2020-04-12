Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC79C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:11:23 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D64B20656
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdqFIbVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgDLULV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:11:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4EFC0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:11:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w4so7877283edv.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xVoFy5prvKV31pJ2Xw6jO7vr4DzZOqRzuwySyEyap1w=;
        b=CdqFIbVA8zdrhadBSMdnbHTdVYECnGJFNfF95qrXCJfSD0zjSZsJLLJFoL8sYKR2RZ
         Mphf/TZxLswlvJPlYGAXIVe2PPZgakecDnfKsE4F29aPiHYXx8xsdJ2xXM7KUCNfjUDp
         qmtOAiUNff6+kKlwpPozZm9h51WJNUM8c4glLohJK1VvdWoDQQcuOPXTS5G8gZvmB7GA
         TLmTeq82QVrWeTiuYHJIW7i0/c4M71bd4lNtx8cfyB5kMTyY+ypFIguO+gpDj1rSIEC6
         2BzyZpSv2sl1hZk+JYC1rKZl8A5hyBtlNSlkjm69rZDPGUDpMPQfo1u48LZD0lLAW8JT
         RvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xVoFy5prvKV31pJ2Xw6jO7vr4DzZOqRzuwySyEyap1w=;
        b=A/Q5AkwCT5A37WUoA4M1rycc3k7/0be+kYds1bRTL07RZ9eLec1YAJII9uh+76RPkS
         kUZW1UtBRfJcGcSzSSco/13YzxX1or1rRGWs7GbuDEorbnVLNCINswlpJUX+o/YqxmBO
         AVbzyr5+1tEK7GtQt2wAzY9/uZuFh6fZOGT4uZikZ1c66YiQ6eav0mt+f98nttGwDPth
         TlPRDU7cL4pzJucr9SN7UKaFyZURknEVVIpqz+PQHHfiE2LATaU222Pnls2ZUq5i2Kk/
         YF6DQeW/Oud2mMnkeGmij1SCzDBGN8FYXv4+F7M9qEgqYn0OTdiP3nLAWUdKsT56WY7Q
         VO1g==
X-Gm-Message-State: AGi0PuYXw3ZIwOkJVqsbzeW7egtIZrg51pHfNo/OhHWiuWt9gOgFlXPF
        GuLDdaluFlvOx9U1rWp6gpM9J1NlEYCEwiWVaE9SWA==
X-Google-Smtp-Source: APiQypLhOLcaZ+/VK/nbtE3aYw+nKyFCUuKaU2/i4T7+O1pmbRnsb1CcWeVsIE1TEQZLDLaOlHNU3LPFbYu99daVF2k=
X-Received: by 2002:a17:906:fc18:: with SMTP id ov24mr12407159ejb.189.1586722276868;
 Sun, 12 Apr 2020 13:11:16 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Geffon <bgeffon@google.com>
Date:   Sun, 12 Apr 2020 13:10:40 -0700
Message-ID: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
Subject: Userfaultfd doesn't seem to break out of poll on fd close
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
It seems that userfaultfd isn't woken from a poll when the file
descriptor is closed. It seems that it should be from the code in
userfault_ctx_release, but it appears that's not actually called
immediately. I have a simple standalone example that shows this
behavior. It's straight forward: one thread creates a userfaultfd and
then closes it after a second thread has entered a poll syscall, some
abbreviated strace output is below showing this and the code can be
seen here: https://gist.github.com/bgaff/9a8fbbe8af79c0e18502430d416df77e

Given that it's probably very common to have a dedicated thread remain
blocked indefinitely in a poll(2) waiting for faults there must be a
way to break it out early when it's closed. Am I missing something?

Thanks,
Brian

// Open a userfaultfd from Thread 1.
12:55:27.611942 userfaultfd(O_NONBLOCK) = 3
12:55:27.612007 ioctl(3, UFFDIO_API, {api=0xaa, features=0 =>
features=UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_EVENT_REMAP|UFFD_FEATURE_EVENT_REMOVE|UFFD_FEATURE_MISSING_HUGETLBFS|UFFD_FEATURE_MISSING_SHMEM|UFFD_FEATURE_EVENT_UNMAP|UFFD_FEATURE_SIGBUS|UFFD_FEATURE_THREAD_ID,
ioctls=1<<_UFFDIO_REGISTER|1<<_UFFDIO_UNREGISTER|1<<_UFFDIO_API}) = 0

// Create a second thread (Thread 2) to poll.
12:55:27.612447 clone(strace: Process 72730 attached
child_stack=0x7f30efa9ffb0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f30efaa09d0, tls=0x7f30efaa0700,
child_tidptr=0x7f30efaa09d0) = 72730

// Thread 2 will poll on the userfaultfd for up to 2000ms.
[pid 72730] 12:55:27.612676 poll([{fd=3, events=POLLIN}], 1, 2000
<unfinished ...>

// Thread 1 closes the userfaultfd and fcntl confirms it's closed:
[pid 72729] 12:55:28.612945 close(3)    = 0
[pid 72729] 12:55:28.613039 fcntl(3, F_GETFD) = -1 EBADF (Bad file descriptor)

// Poll technically times out and while loop back in do_poll it gets a POLLNVAL.
[pid 72730] 12:55:29.614906 <... poll resumed> ) = 1 ([{fd=3,
revents=POLLNVAL}])
