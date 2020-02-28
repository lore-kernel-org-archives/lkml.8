Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F47C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D58246A5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sN6/3PtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgB1BCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:02:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45732 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbgB1BCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:02:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id y3so343377qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHNdL5vIU3ym+nRkxPHmO4brBZzXl4WpJN55o5fu+5A=;
        b=sN6/3PtIdibpX9hCccRbxgkaa/FatRK/1Jdp24JTMHjVBktQ7kIKUJChYy4rwjTyrE
         nVYelKwfOJLZ4SS8VqeAk+dM3T1WgalQZJGHwLnzjk5jW6wLDA5r8AhmTAhSPw+6z2Eg
         XALqm5/LpKaYjeU/v+VldvTI1qBsTqqetOBuC0QKjWYfrrUFmDQAevyxp0vwY0PtRsJl
         ykyYgVO05f2G9YLp+Pw66pbeD4sJPjvalvTq3MScUbfVodVm26AXwCFmuwt4sjBowap+
         o7n4z1G8TWFW9Iclyh6EK4iqiJU4a9kgJFAxSrgM6Fy4g9S6WdVaADqrvIAK0LOavMmF
         L0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHNdL5vIU3ym+nRkxPHmO4brBZzXl4WpJN55o5fu+5A=;
        b=lfJvmQpYrq/y7MtrjJrtp2MafXFsWcYZ7diiBI2SOXuV1U5u0WR1SL8oQ1Haeehrl7
         vb+ceO4uCbd6yg/l4LdLqXBhY1bm/gOGAnZOcX9JBG202EoTlvsYUhGjZjWtq20VV/Zj
         XDeoMCnYEhqB394N2LLvLRTJDvHgcyo8WE4Qyfh+l1wvFa/f75Hntb5EdkzSgtxChdGi
         b/XDHBnenz4zevww1BtQEFjax167fwCxFhyiviWG3NkcT/UfCP16lEBhas8v1X0HvAhv
         1X3TvCHrSvQXFCUp3oL67aTOerwlXUJ/jPt0DYTAutOsDFp7z7PizIBbRs29QdU+OPEj
         VFDg==
X-Gm-Message-State: APjAAAUN9C1RxVGIx1e+rfrz/Key9xRVyq4BtxNONm9PLjn5WUn85tyE
        OK3FkUYkigEMJXcBJJNtDv1Glb6H8XiDzFo4W1As
X-Google-Smtp-Source: APXvYqxqi824RiA93aCv8xP7hTuVGPyd53weG4l6SiW8n7aYoR3akEiTKuu+zA84Hf+sdPgmrEnD3/GB9eV0q4e5sdQ=
X-Received: by 2002:aed:3ecd:: with SMTP id o13mr1987479qtf.309.1582851737381;
 Thu, 27 Feb 2020 17:02:17 -0800 (PST)
MIME-Version: 1.0
References: <e75e80e820f215d2311941e083580827f6c1dbb6.1582059594.git.rgb@redhat.com>
In-Reply-To: <e75e80e820f215d2311941e083580827f6c1dbb6.1582059594.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Feb 2020 20:02:06 -0500
Message-ID: <CAHC9VhTXFg_w8xJChPZZFY=HMpF722p-_NYy=06xjSkLFSCzbg@mail.gmail.com>
Subject: Re: [PATCH ghak120] audit: trigger accompanying records when no rules present
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 4:01 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> When there are no audit rules registered, mandatory records (config,
> etc.) are missing their accompanying records (syscall, proctitle, etc.).
>
> This is due to audit context dummy set on syscall entry based on absence
> of rules that signals that no other records are to be printed.
>
> Clear the dummy bit in auditsc_set_stamp() when the first record of an
> event is generated.
>
> Please see upstream github issue
> https://github.com/linux-audit/audit-kernel/issues/120
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4effe01ebbe2..31195d122344 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2176,6 +2176,8 @@ int auditsc_get_stamp(struct audit_context *ctx,
>         t->tv_sec  = ctx->ctime.tv_sec;
>         t->tv_nsec = ctx->ctime.tv_nsec;
>         *serial    = ctx->serial;
> +       if (ctx->dummy)
> +               ctx->dummy = 0;

Two comments:

* Why even bother checking to see if ctx->dummy is true?  If it is
true you set it to false/0; if it is already false you leave it alone.
Either way ctx->dummy is going to be set to false when you are past
these two lines, might as well just always set ctx->dummy to false/0.

* Why are you setting ->dummy to false in auditsc_get_stamp() and not
someplace a bit more obvious like audit_log_start()?  Is it because
auditsc_get_stamp() only gets called once per event?  I'm willing to
take the "hit" of one extra assignment in audit_log_start() to keep
this in a more obvious place and not buried in auditsc_get_stamp().

-- 
paul moore
www.paul-moore.com
