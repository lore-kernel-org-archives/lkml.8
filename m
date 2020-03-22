Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9387C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 02:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8156A20754
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 02:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Say68nV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgCVC31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 22:29:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38254 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgCVC30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 22:29:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id z25so1230875pfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 19:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=arQnpFHOoa7S/s1PfPQOvxZBgmi2F7VexqtjKFUPC54=;
        b=Say68nV5UAUWTbMz1IP0uAqUmYQ6yqK1z+HBjPCjOGsfLk4NwqZDgBV3dMnIoTO3OZ
         XLnHPHX9pBvXV+ru/Chopk5a/6uurdLDcJMFNwkfvFgjtoDJ7uLm1fDGavs/2KLSsiUA
         1eQbGceXCdj1BKwMvaXiAqQknCxx5lWX4Mwjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arQnpFHOoa7S/s1PfPQOvxZBgmi2F7VexqtjKFUPC54=;
        b=EhgVax+G6k9RF3VF1NEIYVq+kd3cSSmnLNdrmtirTqVR+e++MSaKKR39C6hrbJBTIq
         ua9uC2pNvZtsb1t1ZzEJZoFji+qRliFqs7cvGm0S5Oi4Ox0ou4hp+5/3XSl/KQQwdcMt
         4M8DQKd59ZAAsU3GAX7jH5dnP9O8fKSGDHmb6o/iCdONY3SAVuJrZmjHUBPwk9secwR/
         oVkRx7P1r+O9eGx/QtJRmnDXhqQAWBkhwU+yC0jkx0dMGl36eU40bfDsKelTrAYrhpZy
         ycZBHUM8rF8CH5fCBblxnDMl9/FCXwPcdzg16LtNV1LkQ36l6BX70lf9iZ5EVxrd5zDn
         7XGQ==
X-Gm-Message-State: ANhLgQ2+8QctsKzHTjyYfc5CNw87QKuTJqyyS4XALnobWhUnkLZglGhf
        TPnLyQVOYw4i7OAFW0jfkK7V+Q==
X-Google-Smtp-Source: ADFU+vvR0op/aovsEnK4BuHeO/27tvSvROdN83jCJxW4qoTpmQPs1170B/4W+OVc70Zuu9ZFQQLrLQ==
X-Received: by 2002:aa7:9698:: with SMTP id f24mr17463029pfk.94.1584844165245;
        Sat, 21 Mar 2020 19:29:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b19sm8262224pju.12.2020.03.21.19.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 19:29:23 -0700 (PDT)
Date:   Sat, 21 Mar 2020 19:29:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] x86/speculation: Allow overriding seccomp speculation
 disable
Message-ID: <202003211916.8078081E0@keescook>
References: <20200312231222.81861-1-andi@firstfloor.org>
 <87sgi1rcje.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgi1rcje.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 03:46:29PM +0100, Thomas Gleixner wrote:
> Cc+: Seccomp maintainers ....

Thanks!

> Andi Kleen <andi@firstfloor.org> writes:
> > [...]
> >
> > Longer term we probably need to discuss if the seccomp heuristic
> > is still warranted and should be perhaps changed. It seemed
> > like a good idea when these vulnerabilities were new, and
> > no web browsers supported site isolation. But with site isolation
> > widely deployed -- Chrome has it on by default, and as I understand
> > it, Firefox is going to enable it by default soon. And other seccomp
> > users (like sshd or systemd) probably don't really need it.
> > Given that it's not clear the default heuristic is still a good
> > idea.
> >
> > But anyways this patch doesn't change any defaults, just
> > let's applications override it.
> 
> It changes the enforcement and I really want the seccomp people to have
> a say here.

None of this commit makes sense to me. :)

The point of the defaults was to grandfather older seccomp users into
speculation mitigations. Newly built seccomp users can choose to disable
this with SECCOMP_FILTER_FLAG_SPEC_ALLOW when applying seccomp filters.
The rationale was that once a process knows how to manage its exposure,
it can choose to leave off the automatic enabling. I don't see any
mention of that method in the commit log, so if there is some reason
it's not workable, that would need to be discussed first.

And the force disable matches the design goals of seccomp: no applied
restrictions can be later relaxed for a process. I'm more in favor of
changing the behavior of SPEC_STORE_BYPASS_CMD_AUTO, but probably not for
another 3 years at least. (To get us to at least 5 years since Meltdown,
which is relatively close to various longer LTS cycles.)

-Kees

-- 
Kees Cook
