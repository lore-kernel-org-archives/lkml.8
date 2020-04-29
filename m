Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F93C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C834020757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cS07YRd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgD2VwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:52:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29841 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726481AbgD2VwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588197128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bojb283LbZjvKIHJt1clVMBEgqpvP3QKnksXiKnl240=;
        b=cS07YRd6Gyt6TQsa0t7hwmo41oXCglWwqHVzH81JV6OeM6Di9vk/vudhnBpFG51b1OvYsg
        h1CflGZTMFXxtSp99ZBa7RyGsLXW09PCHwsFTb5gcRiVJuBkQtCWFV01lr9p3ja8+Kkh1B
        6hcFsO7ELkHXtCv9E/0zV7ZiedeNS90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-4JVByMLlPVWUrj8Bs74wCw-1; Wed, 29 Apr 2020 17:52:04 -0400
X-MC-Unique: 4JVByMLlPVWUrj8Bs74wCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3707107ACCA;
        Wed, 29 Apr 2020 21:52:02 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C27579B6;
        Wed, 29 Apr 2020 21:52:01 +0000 (UTC)
Date:   Wed, 29 Apr 2020 16:51:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, ast@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: BPF vs objtool again
Message-ID: <20200429215159.eah6ksnxq6g5adpx@treble>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
 <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:14:08PM -0700, tip-bot for Josh Poimboeuf wrote:
> Commit-ID:  3193c0836f203a91bef96d88c64cccf0be090d9c
> Gitweb:     https://git.kernel.org/tip/3193c0836f203a91bef96d88c64cccf0be090d9c
> Author:     Josh Poimboeuf <jpoimboe@redhat.com>
> AuthorDate: Wed, 17 Jul 2019 20:36:45 -0500
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Thu, 18 Jul 2019 21:01:06 +0200
> 
> bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()

For some reason, this

  __attribute__((optimize("-fno-gcse")))

is disabling frame pointers in ___bpf_prog_run().  If you compile with
CONFIG_FRAME_POINTER it'll show something like:

  kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7: call without frame pointer save/setup

Also, since GCC 9.1, the GCC docs say "The optimize attribute should be
used for debugging purposes only. It is not suitable in production
code."  That doesn't sound too promising.

So it seems like this commit should be reverted. But then we're back to
objtool being broken again in the RETPOLINE=n case, which means no ORC
coverage in this function.  (See above commit for the details)

Some ideas:

- Skip objtool checking of that func/file (at least for RETPOLINE=n) --
  but then it won't have ORC coverage.

- Get rid of the "double goto" in ___bpf_prog_run(), which simplifies it
  enough for objtool to understand -- but then the text explodes for
  RETPOLINE=y.

- Add -fno-gfcse to the Makefile for kernel/bpf/core.c -- but then that
  affects the optimization of other functions in the file.  However I
  don't think the impact is significant.

- Move ___bpf_prog_run() to its own file with the -fno-gfcse flag.  I'm
  thinking this could be the least bad option.  Alexei?

-- 
Josh

