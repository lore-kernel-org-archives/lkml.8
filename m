Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2824EC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AEC20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="rEoA/mjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCFNeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:34:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44690 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCFNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:33:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id y26so1119392pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUiajEtqHykUipUDAxZZ8PHMye5BZieG1YJoiSofP8Y=;
        b=rEoA/mjylyn+XjZnbo+FAoZbkFtWsFbkdSAQ87jZimTL1ViuqtsI33f3HZK6q697az
         mfbqVVBYgm53l4l6EQheDkVMFMs5BXNELeZBYPanIK1Ndezd/vzOmFfitvCSNaMDlove
         v4zOTwlD21ftcc6NyuLL/kbWFhIQ/PZtj9iQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUiajEtqHykUipUDAxZZ8PHMye5BZieG1YJoiSofP8Y=;
        b=LHPG3EsMuix88q1bIpUUzwnmF2NEVmRrtT7A/0lI/MFGuIElizopDjtOSNVuGaw5w+
         H2qsufvJ7nX1HkjacQSMgWAuZBKr92KrRnZmxsPRL9dibyxQuFqURNF8uTMKbtfGosF4
         XFmd4SoH97E6gN4qqVX5MbtGMfVLyZRmZIFEW1Kr13Mm7iGXZr+x3i7htqiAXfV044g3
         zZMhWdSwsBHqxiigykbe4lSsPuOI5Gme+WMRdkdsNXkjMd3iHZaCFFmq0Yoo9MWq43Ke
         w9lYjJAWTe6fPwL0kQPI5qV6y/YOYcM/dGDHZE6+MC5c0LpgLkm2vTXB2D+Z8aRi+klK
         PHRw==
X-Gm-Message-State: ANhLgQ2s227DXmh6bc6n6C07ATVY8ASx+8cRl8591yPtKaeDpz2nQx66
        KAsodtc3+geR7J18VLjHip1EWANqd3Q=
X-Google-Smtp-Source: ADFU+vvO5wzGbikRf/3JIgJ1Nd5LTOFUYoD4F69O2BvMxCf9Cq3AzzEd/joqlTHvvgzbTOzmPlJzpg==
X-Received: by 2002:a63:d845:: with SMTP id k5mr3272785pgj.183.1583501633687;
        Fri, 06 Mar 2020 05:33:53 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-b120-f113-a8cb-35fd.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b120:f113:a8cb:35fd])
        by smtp.gmail.com with ESMTPSA id w195sm33586804pfd.65.2020.03.06.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:33:52 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 0/4] KASAN for powerpc64 radix
Date:   Sat,  7 Mar 2020 00:33:36 +1100
Message-Id: <20200306133340.9181-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

This provides full inline instrumentation on radix, but does require
that you be able to specify the amount of physically contiguous memory
on the system at compile time. More details in patch 4.

One quirk that I've noticed is that detection of invalid accesses to
module globals are currently broken - everything is permitted. I'm
sure this used to work, but it doesn't atm and this is why: gcc puts
the ASAN init code in a section called '.init_array'. Powerpc64 module
loading code goes through and _renames_ any section beginning with
'.init' to begin with '_init' in order to avoid some complexities
around our 24-bit indirect jumps. This means it renames '.init_array'
to '_init_array', and the generic module loading code then fails to
recognise the section as a constructor and thus doesn't run it. This
hack dates back to 2003 and so I'm not going to try to unpick it in
this series. (I suspect this may have previously worked if the code
ended up in .ctors rather than .init_array but I don't keep my old
binaries around so I have no real way of checking.)

v8: Rejig patch 4 commit message, thanks Mikey.
    Various tweaks to patch 4: fix some potential hangs, clean up
    some code, fix a trivial bug, and also have another crack at
    correct stack-walking based on what other arches do. Some very
    minor tweaks, and a review from Christophe.

v7: Tweaks from Christophe, fix issues detected by snowpatch.

v6: Rebase on the latest changes in powerpc/merge. Minor tweaks
      to the documentation. Small tweaks to the header to work
      with the kasan_late_init() function that Christophe added
      for 32-bit kasan-vmalloc support.
    No functional change.

v5: ptdump support. More cleanups, tweaks and fixes, thanks
    Christophe. Details in patch 4.

    I have seen another stack walk splat, but I don't think it's
    related to the patch set, I think there's a bug somewhere else,
    probably in stack frame manipulation in the kernel or (more
    unlikely) in the compiler.

v4: More cleanups, split renaming out, clarify bits and bobs.
    Drop the stack walk disablement, that isn't needed. No other
    functional change.

v3: Reduce the overly ambitious scope of the MAX_PTRS change.
    Document more things, including around why some of the
    restrictions apply.
    Clean up the code more, thanks Christophe.

v2: The big change is the introduction of tree-wide(ish)
    MAX_PTRS_PER_{PTE,PMD,PUD} macros in preference to the previous
    approach, which was for the arch to override the page table array
    definitions with their own. (And I squashed the annoying
    intermittent crash!)

    Apart from that there's just a lot of cleanup. Christophe, I've
    addressed most of what you asked for and I will reply to your v1
    emails to clarify what remains unchanged.
