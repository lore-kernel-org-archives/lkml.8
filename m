Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F760C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A4E20691
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591757625;
	bh=D8hQc4Kxyap6WmQAGeRc6/yANnD6rhyaGMOxHLKk8qY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E834fVSsQzWJXp6YlkMwJVoGKCRyZAYt/eycv+rfklMF7Q6BNM4DXnYwOVvSt9eKe
	 YVJSKLrvu7gjI4VeJZC3jRQY9lwIawlisjAWi+dRIkQFKopHvQKTVGxmUcnkIaWTNd
	 y8tPDSUR2BsAIL7P6AIS8lGtFFYf1vw/Vc9bNDLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgFJCxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgFJCxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:53:43 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471282083E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591757622;
        bh=D8hQc4Kxyap6WmQAGeRc6/yANnD6rhyaGMOxHLKk8qY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cnNSV5maGjn/ERbZkPdiqXXFRR475ELKK4IHPhaEirALbWQxilgVgLfnl3tdpOjFv
         8luYQI5I0umFVp2BX1rdmvLJ/CW8v5JX82lQsG+MQTsfmJ6FutciHLWXLXQ9PeDB4E
         zmbdldmg7cC+KztIakdROB03A6+cUdHD9xrEu1Q0=
Received: by mail-lj1-f179.google.com with SMTP id n23so567352ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 19:53:42 -0700 (PDT)
X-Gm-Message-State: AOAM533c2+Fyx7tHcbP26FTmWWiCzq60DwFpQLOovATlrgjF6Csui26S
        zrpmSjcsArOufKiJjv7HlMg/+/WVFLnPMUqqmuw=
X-Google-Smtp-Source: ABdhPJwSALbKM1A6JD9h8yOnCClWQJQ4/0Uc0WvXIAo3ApyoWfMywIlEUhySemMwZnbnUui+xpukRQKYU1OyskEbk9Q=
X-Received: by 2002:a2e:2a42:: with SMTP id q63mr613929ljq.265.1591757620450;
 Tue, 09 Jun 2020 19:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whQt69ApMkZF8b2Q2idMDgPpPETZeeOuZg59CrOO4025w@mail.gmail.com>
 <20200428091149.GB19958@linux.vnet.ibm.com> <20200428123914.GA27920@redhat.com>
 <20200504164724.GA28697@redhat.com> <d30603a6-1055-bd78-46ac-94a9091cf487@de.ibm.com>
In-Reply-To: <d30603a6-1055-bd78-46ac-94a9091cf487@de.ibm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 10 Jun 2020 10:53:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSnv=d+Ya=uxw-F-tp4TXtt=96qZcGKaLuT8C_BdUKZbQ@mail.gmail.com>
Message-ID: <CAJF2gTSnv=d+Ya=uxw-F-tp4TXtt=96qZcGKaLuT8C_BdUKZbQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: ensure that uprobe->offset and ->ref_ctr_offset
 are properly aligned
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Security Officers <security@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 2:41 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 04.05.20 18:47, Oleg Nesterov wrote:
> > uprobe_write_opcode() must not cross page boundary; prepare_uprobe()
> > relies on arch_uprobe_analyze_insn() which should validate "vaddr" but
> > some architectures (csky, s390, and sparc) don't do this.
>
> I think the idea was that the uprobe instruction is 2 bytes and instructions
> are always aligned to 2 bytes on s390.  (we can have 2,4 or 6 bytes).
Agree, csky has two length-types of instructions (2,4 bytes).

>
> >
> > We can remove the BUG_ON() check in prepare_uprobe() and validate the
> > offset early in __uprobe_register(). The new IS_ALIGNED() check matches
> > the alignment check in arch_prepare_kprobe() on supported architectures,
> > so I think that all insns must be aligned to UPROBE_SWBP_INSN_SIZE.
>
> Not sure if it would have been possible to try to create a uprobe on an
> odd address. If yes, then the new IS_ALIGNED check certainly makes this
> better for s390, so the patch looks sane. Adding Vasily and Sven to double
> check.
Also good to csky.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
