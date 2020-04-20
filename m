Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F84CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213932071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="W9dyIxKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgDTSdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDTSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:33:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4DCC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so5359605pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jaDL/puqB6ANeV24702wI3uHWSnXB41AfHizP29nEHo=;
        b=W9dyIxKQTa70Vn7YomQVmbYniwy7jo+xa3cY2y6jneJ3MivS7nbCUuoNWGt0h3kLNV
         WnjyETfv7NPEFX4iXSgntfp0WWtzcJvNljG+3fMkGq94tX30RgSEpnuF6cSefAnEMG6g
         PJ0xrFnSafue5sDV5SKZRmsxuensnJun1tt6fyvvWg/hG2jE9I+r2TwDVLTZN5PD6Ozo
         e+OAJd8IObG/K8xVzaHkq21pHxWQsry67N7N9rTB1q8nMSD44AiKACX42ACTmqdVErvw
         szrWKRQfrSvgOpgcxy1M0N5Ezc28h32KNraJZDNaBeqexe7nYKDNkL6NYkfXr4XunOhQ
         mEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jaDL/puqB6ANeV24702wI3uHWSnXB41AfHizP29nEHo=;
        b=SlIwKyerGW2ld2Qq0kfdd8ZG5ODzI/79LoId/iTVXNyLcwpOemi7vUKV3LrEHgpl8y
         t3scB5ri9r2H5ikq/QYwh3EfSeVoWczhE6YCii3t8yZ7dKvSZUbjBVNGGY2dD9jw7/7O
         Xan5o/yCrEhsyFTrJIkx7+DrHcGVxhFP7F/SXsYfZATNUvzURMtEHRSRSqaL1+n8EtgM
         NpdgLcDVWh68umdRqqOamtWjl9jAwf/T7ztinRPzshFp1qDnRHVbiC9B5ZwFx0iVxYtM
         ERlsfPxVbAyPZbKALNtuZOzsfn+r6+jwZ3IAizo3nUYIjCjFASf4YZLhLQmfk7icbI0+
         QoKA==
X-Gm-Message-State: AGi0Pubs7KCnEURXGUgDROKwbnUz/cZAwNUiVsR8YPMYWIQkhGmFh7+C
        Xs/xelPVYPhi4vvJRxDHvitOsbTqVwDjLQ==
X-Google-Smtp-Source: APiQypLeMnijxRSxHOcJtfbT9Ie8e5au5SbL8GmQ47VhClRk2BWu4+A7nLoFIIXnwUJc9X/ufaBXNQ==
X-Received: by 2002:a62:ce82:: with SMTP id y124mr18270108pfg.69.1587407581606;
        Mon, 20 Apr 2020 11:33:01 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l185sm172536pfl.104.2020.04.20.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:33:00 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCH 0/3] x86/vdso: Little clean-ups
Date:   Mon, 20 Apr 2020 19:32:52 +0100
Message-Id: <20200420183256.660371-1-dima@arista.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending some patches those weren't needed after timens series evolved,
but still make sense. Nothing really important, just 3 nits here and
there.

Cc: Andrei Vagin <avagin@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: x86@kernel.org

Dmitry Safonov (3):
  x86/vdso2c: Correct err messages on file opening
  x86/vdso2c: Convert iterators to unsigned
  x86/vdso/Makefile: Add vobjs32

 arch/x86/entry/vdso/Makefile | 15 +++++----------
 arch/x86/entry/vdso/vdso2c.c |  4 ++--
 arch/x86/entry/vdso/vdso2c.h | 16 +++++++---------
 3 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.26.0

