Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41600C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A583206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SqSsb1n2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgEQVub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgEQVua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:50:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A76EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:50:30 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id be9so2683584edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BX4FoYb8Q9EUURS8yvzmijT8sCdQaCXfsixMsyCwRGM=;
        b=SqSsb1n27kVFMaxAn4hXLKu59KLoOg8Ken9wjldZhJrI7btR5vV/AMJWrWsRwytEC4
         HG0mgO/rX+vs1nwCP9njNCx0G3ISPA42vlJg+sIZMMovgHgp5hLlEani8/ZBrz+Imqxm
         rhUgY2jaY7bzusxd6EPn/UaIzqGpOqdaxng/oYedhxOhCViKM4909LPiBb/hzStGJZM7
         cBVHxWuAQ+5apxL0JBxuljUl2qJ7gsQHuXYAIR/XUzV4PdwIJnIHB+vxZ4KE5AUqe2P/
         yE83e8s8fJGvT6e2rzNiXLHxayH7LeOC81yjad9/O8J+nuAFAs6UsXYzsrrYlXDhgmNt
         MVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BX4FoYb8Q9EUURS8yvzmijT8sCdQaCXfsixMsyCwRGM=;
        b=W6F/GkS9kmhWsH/B5QajpVItyZhRcoXyByChblTgBXapYhrB1sLjpSW8/DBLYGlxFd
         gBlAT9Ag4fe11FfDazsQlWsaTzLeYs0WhlPljSfCk0sUoM+L2fXiKQ+wJm0NRlpF9j2P
         lrli4S79ZIBMdvHRgbh+523ir+AapEZDR7SrcPiPNKpN3HPae8qpl4LbVcFkRJcF2eUP
         k93ETiSIdn51/nY92SO0JYdnn/YT1/LmFdEJJVNXvUX6NWs/x4ODd/o46+dzbU8y12hM
         RmGxBQ/fM89qJaUhii5ZQMnnpv93z3ZRRitrNI41qHRYGp4gxfD+Ore1j/Zd7Swepb8u
         kArg==
X-Gm-Message-State: AOAM530sEj7wX/8DNOvv7DEop/FAj6ryKtHRsNWQVaCqQS5xwhu8dFK8
        0xdBvjsWE4c2J2B0ufgh94jYrZrB+sUbt3ACUT+d
X-Google-Smtp-Source: ABdhPJxJHZfif+YkeAZlV6VgpM2vWo43nbq0dxQ8qHlu/3zavUpgbK+2904Uk21mHW+zmAA0UbvAKzcGxZk5vfvNBUQ=
X-Received: by 2002:aa7:cb8d:: with SMTP id r13mr3078029edt.12.1589752228961;
 Sun, 17 May 2020 14:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587500467.git.rgb@redhat.com> <b8ba40255978a73ea15e3859d5c945ecd5fede8e.1587500467.git.rgb@redhat.com>
 <CAHC9VhR9sNB58A8uQ4FNgAXOgVJ3RaWF4y5MAo=3mcTojaym0Q@mail.gmail.com> <20200517141515.qqx3jx5ulb2546tx@madcap2.tricolour.ca>
In-Reply-To: <20200517141515.qqx3jx5ulb2546tx@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 17 May 2020 17:50:17 -0400
Message-ID: <CAHC9VhQVRyJ7GRHrujW5Ri-pvBRBgFM2Y8+OYQxca1bUyv2eyg@mail.gmail.com>
Subject: Re: [PATCH ghak25 v4 3/3] audit: add subj creds to NETFILTER_CFG
 record to cover async unregister
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     fw@strlen.de, LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        twoerner@redhat.com, Eric Paris <eparis@parisplace.org>,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 10:15 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-04-28 18:25, Paul Moore wrote:
> > On Wed, Apr 22, 2020 at 5:40 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Some table unregister actions seem to be initiated by the kernel to
> > > garbage collect unused tables that are not initiated by any userspace
> > > actions.  It was found to be necessary to add the subject credentials to
> > > cover this case to reveal the source of these actions.  A sample record:
> > >
> > >   type=NETFILTER_CFG msg=audit(2020-03-11 21:25:21.491:269) : table=nat family=bridge entries=0 op=unregister pid=153 uid=root auid=unset tty=(none) ses=unset subj=system_u:system_r:kernel_t:s0 comm=kworker/u4:2 exe=(null)
> >
> > [I'm going to comment up here instead of in the code because it is a
> > bit easier for everyone to see what the actual impact might be on the
> > records.]
> >
> > Steve wants subject info in this case, okay, but let's try to trim out
> > some of the fields which simply don't make sense in this record; I'm
> > thinking of fields that are unset/empty in the kernel case and are
> > duplicates of other records in the userspace/syscall case.  I think
> > that means we can drop "tty", "ses", "comm", and "exe" ... yes?
> >
> > While "auid" is a potential target for removal based on the
> > dup-or-unset criteria, I think it falls under Steve's request for
> > subject info here, even if it is garbage in this case.
>
> Can you explain why auid falls under this criteria but ses does not if
> both are unset?

"While "auid" is a potential target for removal based on the
dup-or-unset criteria, I think it falls under Steve's request for
subject info here, even if it is garbage in this case."

It's a concession to Steve.  As I mentioned previously, I think the
subject info is bogus in this case; either it is valid and we get it
from the SYSCALL record or it simply isn't present in any meaningful
way.

-- 
paul moore
www.paul-moore.com
