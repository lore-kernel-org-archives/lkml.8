Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB82CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2993D207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="KNzE2sql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgHDNLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgHDNLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:11:14 -0400
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Aug 2020 06:11:13 PDT
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B487DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 06:11:13 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4BLZk31hH5zKm6T
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 15:05:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1596546330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=URVnzukKS+P2nWYrtw5dp7rwGBO9XtEHJXqL8SP6zO8=;
        b=KNzE2sqlvnuz77ErAj4S35CFSwz7UN2ImtNaX49D3Ulj04l+OasRm8fTE4QEeqK/HUlnlv
        QpvMgiBcqSrpdjBRqXse2GglEYkCb7NgtB1EApxmzAO8r3xCwMdOJ+POhUcfDsIxUL4vH6
        lt4IgS2bcqKzFcNnPYvpaN8BFPTtPOv390TgMFgsDED3vSJMMCMfmd0e39dNo1gBqNVvup
        HB2GFunwsdnaT+2ottltmcI1TRUyaS2/kztsj5tIsqY8Ou6h/SOx9cFRfWmVjb3V7L1j9Q
        hY9jfrRW7pAML952j+nGhZ9rhlBN7/scU686UApMKJcWbmLhJxFgz0eajxc37Q==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id d2tN0njdRyVX for <linux-kernel@vger.kernel.org>;
        Tue,  4 Aug 2020 15:05:28 +0200 (CEST)
From:   Devin Bayer <dev@doubly.so>
Subject: setsid2(sid) proposal - assign current process to existing session
To:     linux-kernel@vger.kernel.org
Message-ID: <dd606c6b-eb2e-3069-59d1-4db5b2dc7d69@doubly.so>
Date:   Tue, 4 Aug 2020 15:05:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -2.55 / 15.00 / 15.00
X-Rspamd-Queue-Id: 41E5D17BA
X-Rspamd-UID: dce495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm wondering about the possibility of introducing a new system call for 
moving a process to an existing session. If `sid` is an existing session 
with the same owner as the current process, one could call:

	setsid2(sid)

This would have similar behavior to setpgid(), and would probably 
effectively call setpgid() internally too.

The use case is for something like `flatpak-spawn --host`, which allows 
you to launch a program in an outer namespace from an inner namespace. 
It behaves as a child of the caller but is actually a child of an 
external daemon.

It works by connecting stdin/out/err to those of the caller, for example 
a PTY for xterm running in the inner namespace. This works fine for 
non-interactive programs, but it's impossible for the spawned task to 
share the controlling TTY with the shell running in xterm.

I can't see where the problems are, though I'm surprised such 
functionally doesn't yet exist. Because it deals with such basic 
concepts, I'm wondering if such a change will even be considered.

There is a workaround; one can create a new PTY on the host and copy the 
I/O streams manually. Not ideal, but okay.

Any comments welcome.

Cheers
~ dev
