Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B802250E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="uhBO0OpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgHETsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgHEQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:57:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37EC001FCC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 08:52:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so25491749plk.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rgPdx4FvPNj3L/b4d9eiz4Lukmw32rT0pYFOATs+yo=;
        b=uhBO0OpFg/LYWCU/5Q95FYkvHAjv/6vqQnVWGZzffuTQK/Qt3glmHzfnFmhjJqC8RT
         N0CiCQ6ukSeX5YVxSKoMGN9Qb1uJBgtNieq4cbiZZSukukLRsN2H4hGfYtlcRiwHyfs3
         BvjqbigytY0sqh3GHRdYZ4Dp0GpMRo6dKqTWxcM19sUN5Y1Yv8qcNnh5Zt+epIcPsJ95
         paI74rAQyMO4signAODc/PF3fcaVtAkg4y87a9W67Jz1Dchst1zaLxoEIQcm/vUWZJQh
         m5f5buRbOnH0sv7xBuqOH/zDcxvvoc1xi8kLJC9YoO8EdYWn1DBBSpoZtiHLLljLBM0c
         azHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rgPdx4FvPNj3L/b4d9eiz4Lukmw32rT0pYFOATs+yo=;
        b=dO6b8Yk+EtcfrH25Sn7ceE5mWbRaXV48dbCiIRSNSFxTMEdjVJNXKV4yRLx3YpBkXj
         FDpEzNcUi2yPMGMHEPsX9RBUMDWrucrcVnenyUmalnhM4mo1BAgqQBuI8+vET0Yl4Sbo
         AK6dpLLZxYCqYRrVrz7j1YJ11hUe466vsibRd/U4bRt6vyTykcoXnP4/l3JwtOaa6iHI
         cYVD4g8CNH/WLa3KOwK/ZKfWyDPg8lYXEEJzDfDDCUs6dGko3aJMgw6Baceci09iXH1Y
         UAZ482A7OMBr4xVmmH3HfIN93VDnQ2ylmnDAxC2GAq+/7ldXtW/ocb8jy9mAalyGQcEG
         jS7g==
X-Gm-Message-State: AOAM533NU41cSieW//8rS6WohuL1iGEAa3OUwK6rq31Oq3WkDzf5uIPY
        hni6finlt2RMHDrF7ZobRSA+TiTP6b58b6fS3EdId0+a0CTFew==
X-Google-Smtp-Source: ABdhPJz+S08tQUWlf0uwerTLvPYHj7weeZ1Gqq2V3WinQnKdQtXh5JjIbGt6HHa9rGmGMGwnT3MhZnsWIgeaF+dLaW8=
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr4074109pjb.229.1596642731102;
 Wed, 05 Aug 2020 08:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200805142136.0331f7ea@canb.auug.org.au> <CAMZfGtX0a3tui_KQfCXLcARVcev9V-HV6HMkXgVXObq8w-4EQg@mail.gmail.com>
 <20200805111105.081276bb@oasis.local.home>
In-Reply-To: <20200805111105.081276bb@oasis.local.home>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 5 Aug 2020 23:51:34 +0800
Message-ID: <CAMZfGtU7iTFAZVRFgh5vgzB9nSOoDjm7F4Jqpd4uhEe8NListQ@mail.gmail.com>
Subject: Re: [External] linux-next: build warning after merge of the ftrace tree
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 11:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 5 Aug 2020 12:53:39 +0800
> Muchun Song <songmuchun@bytedance.com> wrote:
>
> > On Wed, Aug 5, 2020 at 12:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the ftrace tree, today's linux-next build (powerpc
> > > ppc64_defconfig) produced this warning:
> > >
> > > kernel/kprobes.c: In function 'kill_kprobe':
> > > kernel/kprobes.c:1116:33: warning: statement with no effect [-Wunused-value]
> > >  1116 | #define disarm_kprobe_ftrace(p) (-ENODEV)
> > >       |                                 ^
> > > kernel/kprobes.c:2154:3: note: in expansion of macro 'disarm_kprobe_ftrace'
> > >  2154 |   disarm_kprobe_ftrace(p);
> > >       |   ^~~~~~~~~~~~~~~~~~~~
> > >
> >
> > Sorry, maybe we should rework the macro of disarm_kprobe_ftrace to an
> > inline function like below.
> >
> > -#define disarm_kprobe_ftrace(p)        (-ENODEV)
> > +static inline int disarm_kprobe_ftrace(struct kprobe *p)
> > +{
> > +       return -ENODEV
> > +}
> >  #endif
>
> Looks like that would work. Care to send a formal patch. Could you also
> change arm_kprobe_ftrace() as well?

OK, I will do that. Thanks.

>
> Thanks!
>
> -- Steve



-- 
Yours,
Muchun
