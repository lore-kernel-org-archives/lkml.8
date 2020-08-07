Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71538221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="i4lMLHig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHGO5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:57:22 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:16247 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgHGO5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:57:21 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2020 10:57:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596812239;
        s=strato-dkim-0002; d=xenosoft.de;
        h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=etPxG83tkMXiJ/hnA1T72V+lMvSf2k090VPDeSw1U3I=;
        b=i4lMLHigxmSRgkCjW5JyTJKOftY5we0zpq89EAXRzjG20hXeIS3TCi00p8G7/6uRi7
        hZkI4lOqc9GFy1/UEQ91+OtACqoiVn1OmrsjcUy8O3P+nGO+elYihb813kpsrtMrRk93
        rQV4WIZmAxkOEjsVSdnY/d0GwggJBzV+WDUplUcVKP52mgKnGlcQM8+sBJRU0+bxvhuJ
        HpY+OTZotZlRjFCI30EoS/EQG/EFi7fNtkBh5UqxybTbythCCtzG89lOx1HXuEB+Fbve
        5SSefifMUk9kjBuNR13NyQmC63rAQ2ZtHuf0HbcIuxFJ4U0ZiWR7omM7vKObRLgvBrHA
        QPIA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSI1Vi9hdbute3wuvmUTfEdg9AyQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:15f9:f3ba:c3bc:6875]
        by smtp.strato.de (RZmta 46.10.5 AUTH)
        with ESMTPSA id 60686ew77EjEQ1K
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 7 Aug 2020 16:45:14 +0200 (CEST)
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        keescook@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [Latest Git kernel/Linux-next kernel] Xorg doesn't start after the
 seccomp updates v5.9-rc1
Message-ID: <67cd9693-10bc-5aa5-0898-ff2ac1f9c725@xenosoft.de>
Date:   Fri, 7 Aug 2020 16:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Xorg doesn't start with the latest Git kernel anymore on some Linux 
distributions after the seccomp updates v5.9-rc1 [1]. For example on 
Fienix (Debian Sid PowerPC 32-bit) and on ubuntu MATE 16.04.6 (PowerPC 
32-bit). I tested these distributions on the A-EON AmigaOne X1000 [2], 
A-EON AmigaOne X5000 [3], and in a virtual e5500 QEMU machine with a 
virtio_gpu.

Error messages:

systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Connection refused
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected
systemd-journald[2238]: Failed to send WATCHDOG-1 notification message: 
Transport endpoint is not connected

---

But Xorg works on Ubuntu 10.04.4 (PowerPC 32-bit), openSUSE Tumbleweed 
20190722 PPC64 and on Fedora 27 PPC64 with the latest Git kernel.

I bisected today [4].

Result: net/scm: Regularize compat handling of scm_detach_fds() 
(c0029de50982c1fb215330a5f9d433cec0cfd8cc) [5] is the first bad commit.

This commit has been merged with the seccomp updates v5.9-rc1 on 
2020-08-04 14:11:08 -0700 [1]. Since these updates, Xorg doesn't start 
anymore on some Linux distributions.

Unfortunately I wasn't able to revert the first bad commit. The first 
bad commit depends on many other commits, which unfortunately I don't 
know. I tried to remove the modifications of the files from the first 
bad commit but without any success. There are just too many dependencies.

Additionally I compiled a linux-next kernel because of the issue with 
the lastest Git kernel. Unfortunately this kernel doesn't boot. It can't 
initialize the graphics card.

Could you please test Xorg with the latest Git kernel on some Linux 
distributions?

Thanks,
Christian


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9ecc6ea491f0c0531ad81ef9466284df260b2227
[2] https://en.wikipedia.org/wiki/AmigaOne_X1000
[3] http://wiki.amiga.org/index.php?title=X5000
[4] https://forum.hyperion-entertainment.com/viewtopic.php?p=51317#p51317
[5] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c0029de50982c1fb215330a5f9d433cec0cfd8cc


