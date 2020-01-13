Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE0C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2DC2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMm/7Vjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMHgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:36:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43762 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgAMHgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:36:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so8056338oth.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 23:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=93I5di/PNze/1qvCUt2yxFTlOobID7JYqtcC34m52co=;
        b=jMm/7Vjobrlq6qWHZvKktZxxDbJuwwCthIUVBSIpp9i8hEtzWED28KibpWMiP8dzfi
         g5l30AgvFEQns8UgXkhyhUSXzVQDE6Yf3KUqDIo2CoVHRFIg8+vcATXg15e3/wHJyyn7
         bavQdUF++anUfLeIB6DyWsPoGIn9IvcRqeK/Jl5mYeS7NNEjpw5XklLB49fWJ95KJlSk
         SjGUoJSqaYBU97H/h2zkr0IldOZsJoYdfOwVZ+Ql6TD+8WUsS00KLtXD2L954IVc/42N
         8Sj4EvXMcVz20s5rXY6uI09LsbCUjJTcaEVqmgolXj6BiMHv0xBJT8Cd0uJTL5RtKUWA
         6O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=93I5di/PNze/1qvCUt2yxFTlOobID7JYqtcC34m52co=;
        b=mwlKyTpyo61weLe4zSHKSmzRjmnp9AnharfCEwisHTHfMEC1vKcSxumYUuzRpkDjbQ
         fIskAflgw6wEFjsUcu/PRIiIMFQOjDQVmHiCVXdmmyz1P+V3rwcICVh9jlAECjWqSGfk
         sauMoeZYsDzpqeOnV1XxpGKgNA9gc5AYj3Fj8xjOKQkrZm6v3Px9SGifSOdrjojcmzzv
         rcj50eEGivwoZEynahAV1qWsdJxYRIrRxwE62OVPJlfPSq0NUc3vj+kRnhvQNF48x+mR
         YIc41sxJ2RKYVuwgujE5WesOZalurz6yzr9bCO0sXI8oe84HYyXoYO5hILxuFn5JCLRl
         abtA==
X-Gm-Message-State: APjAAAV/JKApv8biU0sHdPFxS7mb/ssClSIS0NKLsr3DrYCraA1bbEGp
        BibNma3hr1PTVK4/wYPj/XsBZg==
X-Google-Smtp-Source: APXvYqwsv8CfZ0yW7pNeDep4vxtR43hpuJ0DyJ2xOzY7s0yctnKqHlRiItKTO/VYK1udobmD9Gcmlw==
X-Received: by 2002:a9d:811:: with SMTP id 17mr12471823oty.369.1578900968202;
        Sun, 12 Jan 2020 23:36:08 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v200sm3268016oie.35.2020.01.12.23.36.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Jan 2020 23:36:07 -0800 (PST)
Date:   Sun, 12 Jan 2020 23:36:05 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Chris Down <chris@chrisdown.name>
cc:     Hugh Dickins <hughd@google.com>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Mikael Magnusson <mikachu@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
In-Reply-To: <20200110164503.GA1697@chrisdown.name>
Message-ID: <alpine.LSU.2.11.2001122259120.3471@eggly.anvils>
References: <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name> <20200107001039.GM23195@dread.disaster.area> <20200107001643.GA485121@chrisdown.name> <20200107003944.GN23195@dread.disaster.area> <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
 <alpine.LSU.2.11.2001070002040.1496@eggly.anvils> <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com> <20200107210715.GQ23195@dread.disaster.area> <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com> <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
 <20200110164503.GA1697@chrisdown.name>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020, Chris Down wrote:
> Hugh Dickins writes:
> > Dave, Amir, Chris, many thanks for the info you've filled in -
> > and absolutely no need to run any scan on your fleet for this,
> > I think we can be confident that even if fb had some 15-year-old tool
> > in use on its fleet of 2GB-file filesystems, it would not be the one
> > to insist on a kernel revert of 64-bit tmpfs inos.
> > 
> > The picture looks clear now: while ChrisD does need to hold on to his
> > config option and inode32/inode64 mount option patch, it is much better
> > left out of the kernel until (very unlikely) proved necessary.
> 
> Based on Mikael's comment above about Steam binaries, and the lack of
> likelihood that they can be rebuilt, I'm inclined to still keep inode{64,32},
> but make legacy behaviour require explicit opt-in. That is:
> 
> - Default it to inode64
> - Remove the Kconfig option
> - Only print it as an option if tmpfs was explicitly mounted with inode32
> 
> The reason I suggest keeping this is that I'm mildly concerned that the kind
> of users who might be impacted by this change due to 32-bit _FILE_OFFSET_BITS
> -- like the not-too-uncommon case that Mikael brings up -- seem unlikely to
> be the kind of people that would find it in an rc.

Okay.  None of us are thrilled with it, but I agree that
Mikael's observation should override our developer's preference.

So the "inode64" option will be accepted but redundant on mounting,
but exists for use as a remount option after mounting or remounting
with "inode32": allowing the admin to switch temporarily to mask off
the high ino bits with "inode32" when needing to run a limited binary.

Documentation and commit message to alert Andrew and Linus and distros
that we are risking some breakage with this, but supplying the antidote
(not breakage of any distros themselves, no doubt they're all good;
but breakage of what some users might run on them).

> 
> Other than that, the first patch could be similar to how it is now,
> incorporating Hugh's improvements to the first patch to put everything under
> the same stat_lock in shmem_reserve_inode.

So, I persuaded Amir to the other aspects my version, but did not
persuade you?  Well, I can live with that (or if not, can send mods
on top of yours): but please read again why I was uncomfortable with
yours, to check that you still prefer it (I agree that your patch is
simpler, and none of my discomfort decisive).

Thanks,
Hugh
