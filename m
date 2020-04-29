Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EECC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E912076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH+tSoZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgD2WB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727918AbgD2WBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:01:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7BC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:01:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l78so3746349qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UuUxt8JMnTEs4OAjNK08FbzOYCL0sHXtPjyxW/ugHQQ=;
        b=iH+tSoZVnk+t534QuXcEkoBvf2RuLlBZm1dEZiSxi1CnI+aqg5vU4GhbvY3YwGjOQD
         828WzweKwX98QwJPMRH31iOvt5zUOHskFeus4myH/404tARuw1e3qdtT3n7DFWSgSuDD
         hnrlN+8YBjk9e7H0rp1aKB7j7WOaPW1CLbyNceLG6sEpl7ugMExpGifqdNGKTBTOTE5M
         ODLSY2MA1gT2k4vJ+ALE28Gv0NIWBK89eygt3sTNXiZ1mFo9p1OykiaV7UG9g3PV5vz3
         cgyGtl36XmkDfVw0tUJpek9JuWewLtZ7cO0/XDkyx3OUQJ/cYtz5bxrYDGZdiQ2wmkGC
         YItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UuUxt8JMnTEs4OAjNK08FbzOYCL0sHXtPjyxW/ugHQQ=;
        b=Adz625YVX15iUhkU5nwtwFGlRBn3r9Ohxia2jeUXapz4RQfBAaLCu4r1oCtVu8NEzc
         Hm0QcyaNhqcY/JuzrtYnRBTq+wlu9nSMSQkqqUfpj1bFfqaoK4teZYp6iTPi4NOkJe0w
         RxRDOBjy9WbwDg9E4iyF6fxy7zitibhdaEclPIolttAr5+PixCOpGWNhm4FIZbIwrjVM
         d8GzHbyigbMiyoPFkFwe0UnDD4ME6pzZcxGv6+fkSoTxEAKcdn/S0avD0PjgGl7WUiP2
         3c8trl3NU25qAJKU7cKXUn2lb3TuGRBaANih9bG2RH4VLLL/X4DR55sQkxVI+GmLI/vd
         SBeA==
X-Gm-Message-State: AGi0PubMjwLBK3TgLDk/ASiUs4RDTt9iIrSQUTWGDgg9C8xqqeJJaYWu
        VdMxsa+Jm12jLRTDg8s7MQzHKQEbR30=
X-Google-Smtp-Source: APiQypJMYRmplV6FdwByrU828qgKs5JAn1PNyZl2hqlUAifhY+kKslMV0mizWQew+8wQPLG3AgoMmQ==
X-Received: by 2002:a05:620a:22ab:: with SMTP id p11mr598163qkh.373.1588197713843;
        Wed, 29 Apr 2020 15:01:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b201sm358512qkg.32.2020.04.29.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:01:53 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 29 Apr 2020 18:01:51 -0400
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, ast@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: BPF vs objtool again
Message-ID: <20200429220151.GA1642005@rani.riverdale.lan>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
 <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
 <20200429215159.eah6ksnxq6g5adpx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200429215159.eah6ksnxq6g5adpx@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:51:59PM -0500, Josh Poimboeuf wrote:
> On Thu, Jul 18, 2019 at 12:14:08PM -0700, tip-bot for Josh Poimboeuf wrote:
> > Commit-ID:  3193c0836f203a91bef96d88c64cccf0be090d9c
> > Gitweb:     https://git.kernel.org/tip/3193c0836f203a91bef96d88c64cccf0be090d9c
> > Author:     Josh Poimboeuf <jpoimboe@redhat.com>
> > AuthorDate: Wed, 17 Jul 2019 20:36:45 -0500
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Thu, 18 Jul 2019 21:01:06 +0200
> > 
> > bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
> 
> For some reason, this
> 
>   __attribute__((optimize("-fno-gcse")))
> 
> is disabling frame pointers in ___bpf_prog_run().  If you compile with
> CONFIG_FRAME_POINTER it'll show something like:
> 
>   kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7: call without frame pointer save/setup
> 
> Also, since GCC 9.1, the GCC docs say "The optimize attribute should be
> used for debugging purposes only. It is not suitable in production
> code."  That doesn't sound too promising.
> 

It turns out that the optimize attribute doesn't append options to the
command-line arguments, it starts from the defaults and only adds
whatever you specify in the attribute. So it's not very useful for
production code.

See this for eg where the same thing came up in a different context.
https://lore.kernel.org/lkml/alpine.LSU.2.21.2004151445520.11688@wotan.suse.de/
