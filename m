Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1214AC4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 04:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB67120719
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 04:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584850059;
	bh=MmzjRpd1cA3MkO3jSisu6OnNkmFy4CJs3TYnE1Yhpxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gtSmuzpE9lOGooAC3zK9VEBtr45x9WVUUS822VlFbM3nKQSp+OujDceoU8MW1YYdD
	 nuMxAxaWp2j2bkD0d6+T/8gZC5rJmn8b71e7nYqrQqDqFqCpZTPo+WgS58quv6yGdx
	 oWIVo9byJ+rEeYDcxfgIoQL8DNsXgcLxtwwnDwfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgCVEHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 00:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgCVEHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 00:07:20 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4CC20722
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 04:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584850040;
        bh=MmzjRpd1cA3MkO3jSisu6OnNkmFy4CJs3TYnE1Yhpxk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wtvXqWUSVy7uWtMRU4TUWbVyM+S83YisbvHE4bn4cf2aWyhh3J9BU4fKao3LtT10/
         qOWpclXK6LbHYWs73DiXxzkRk18GsIUGke5xKWwhmf7jWteTIg22N0LlnXlDGiN9kz
         PmQHGFmkHmBBq8KffoHg4jwXhLb1aR/IvGHFdOsA=
Received: by mail-wr1-f44.google.com with SMTP id j17so8900824wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 21:07:19 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3pIYb4Ecpv4y0/Hfzqh/U/D4kQimdVY3Gdj2SEx5od89G6n9fX
        +XtJy+ZJUcTi503m6tbjPGjVvX4TbFgIa9aJCU+KiA==
X-Google-Smtp-Source: ADFU+vuIo9ggwxg/8xm/9AW7+XAYhr2y2WU/yYstA9S7KJUbcRq3645kOveaAHy/EOo+hVBC29MXG8CIyh8+DNKhLLE=
X-Received: by 2002:adf:df8f:: with SMTP id z15mr20651687wrl.184.1584850038167;
 Sat, 21 Mar 2020 21:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200312231222.81861-1-andi@firstfloor.org> <87sgi1rcje.fsf@nanos.tec.linutronix.de>
 <202003211916.8078081E0@keescook>
In-Reply-To: <202003211916.8078081E0@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 21 Mar 2020 21:07:07 -0700
X-Gmail-Original-Message-ID: <CALCETrVYSBBtjyBSsHYirKf5eL+YTcLJAnh3W2krxU+uMET8uA@mail.gmail.com>
Message-ID: <CALCETrVYSBBtjyBSsHYirKf5eL+YTcLJAnh3W2krxU+uMET8uA@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation: Allow overriding seccomp speculation disable
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <andi@firstfloor.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 7:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Mar 21, 2020 at 03:46:29PM +0100, Thomas Gleixner wrote:
> > Cc+: Seccomp maintainers ....
>
> Thanks!
>
> > Andi Kleen <andi@firstfloor.org> writes:
> > > [...]
> > >
> > > Longer term we probably need to discuss if the seccomp heuristic
> > > is still warranted and should be perhaps changed. It seemed
> > > like a good idea when these vulnerabilities were new, and
> > > no web browsers supported site isolation. But with site isolation
> > > widely deployed -- Chrome has it on by default, and as I understand
> > > it, Firefox is going to enable it by default soon. And other seccomp
> > > users (like sshd or systemd) probably don't really need it.
> > > Given that it's not clear the default heuristic is still a good
> > > idea.
> > >
> > > But anyways this patch doesn't change any defaults, just
> > > let's applications override it.
> >
> > It changes the enforcement and I really want the seccomp people to have
> > a say here.
>
> None of this commit makes sense to me. :)
>
> The point of the defaults was to grandfather older seccomp users into
> speculation mitigations. Newly built seccomp users can choose to disable
> this with SECCOMP_FILTER_FLAG_SPEC_ALLOW when applying seccomp filters.
> The rationale was that once a process knows how to manage its exposure,
> it can choose to leave off the automatic enabling. I don't see any
> mention of that method in the commit log, so if there is some reason
> it's not workable, that would need to be discussed first.

Agreed.


>
> And the force disable matches the design goals of seccomp: no applied
> restrictions can be later relaxed for a process. I'm more in favor of
> changing the behavior of SPEC_STORE_BYPASS_CMD_AUTO, but probably not for
> another 3 years at least. (To get us to at least 5 years since Meltdown,
> which is relatively close to various longer LTS cycles.)
>
> -Kees
>
> --
> Kees Cook
