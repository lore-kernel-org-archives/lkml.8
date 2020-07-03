Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D7CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8E3204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593796243;
	bh=eSLxwCsrnjTN1e/eMh6nr/qbzVVZVXbOT9m3hRAwgUY=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=ZEgZGCg4dAds9ESl+QMwhAAXaIU00q60SNWsyks0WJ/gwjaav2OoDQE9SBv6/EGus
	 rtmWNTKtbqOjfwiyu+n77Ncy4eoOEGAPPMtAQovDL7CJEI3his3fZoT5t8ts+VqXSY
	 /2KgTu7Rl3sFobLXg4R66SzhB+C9Rn7YP21ftWcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgGCRKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGCRKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:10:41 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F7420899
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593796241;
        bh=eSLxwCsrnjTN1e/eMh6nr/qbzVVZVXbOT9m3hRAwgUY=;
        h=From:Date:Subject:To:Cc:From;
        b=pHjE8pN36o+e/YKNzwG1ysSGr2KqQURQ5A7ukoqZCvAeM1u7QOU8KseOSXJXzkpAT
         PQOIWf348pJihiEl9qg2Hi497UH6KQNOrs3zlmjR9M1StahTZyL1dHxeA5VAccfvoU
         10GIlFJGhmfIeXAQX/vByyDFlLGgiXthQ7kZwzDw=
Received: by mail-wr1-f47.google.com with SMTP id q5so33453219wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:10:40 -0700 (PDT)
X-Gm-Message-State: AOAM5305SZ/QwWeUTHZkt5lcNRSEirytxnYLcmMrnvlO6buPexld2TBm
        0v3U76BUTXkejDw/e66sxSIOkygzFr9TbQCQMmJ7Lg==
X-Google-Smtp-Source: ABdhPJxAdrtZOxCWu77L4TeW9SEziwQ1Q79FxUmVvDBqK30QeKHVkoNZP7TaDcgSwTQuWVtqX6NTUmygzsDDwM6qVdA=
X-Received: by 2002:adf:8104:: with SMTP id 4mr38344164wrm.18.1593796239481;
 Fri, 03 Jul 2020 10:10:39 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 3 Jul 2020 10:10:28 -0700
X-Gmail-Original-Message-ID: <CALCETrVfi1Rnt5nnrHNivdxE7MqRPiLXvon4-engqo=LCKiojA@mail.gmail.com>
Message-ID: <CALCETrVfi1Rnt5nnrHNivdxE7MqRPiLXvon4-engqo=LCKiojA@mail.gmail.com>
Subject: FSGSBASE seems to be busted on Xen PV
To:     xen-devel <xen-devel@lists.xenproject.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xen folks-

I did some testing of the upcoming Linux FSGSBASE support on Xen PV,
and I found what appears to be some significant bugs in the Xen
context switching code.  These bugs are causing Linux selftest
failures, and they could easily cause random and hard-to-debug
failures of user programs that use the new instructions in a Xen PV
guest.

The bugs seem to boil down to the context switching code in Xen being
clever and trying to guess that a nonzero FS or GS means that the
segment base must match the in-memory descriptor.  This is simply not
true if CR4.FSGSBASE is set -- the bases can have any canonical value,
under the full control of the guest, and Xen has absolutely no way of
knowing whether the values are expected to be in sync with the
selectors.  (The same is true of FSGSBASE except that guest funny
business either requires MSR accesses or some descriptor table
fiddling, and guests are perhaps less likely to care)

Having written a bunch of the corresponding Linux code, I don't
there's any way around just independently saving and restoring the
selectors and the bases.  At least it's relatively fast with FSGSBASE
enabled.

If you can't get this fixed in upstream Xen reasonably quickly, we may
need to disable FSGSBASE in a Xen PV guest in Linux.

--Andy
