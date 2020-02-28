Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA014C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDA02067C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="feZ3IcTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgB1NJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:09:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32875 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1NJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:09:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id c62so1761364edf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTsS9WO7t3WlZZMouHSL/m/iJQUQUndophD3E0ikjkg=;
        b=feZ3IcTL6/dc4LteFo3/h4IU0zbf0C61VrjMT18a/IQCzq5nurYsruha7zzuCLClPG
         Dis6tDOrnR4iZYGRzmNBtm6q37mM+O8J2eIUjqNb5hnd3+Cef8BAG/RsYwTpy1XarjbV
         R5C3Qsv8bQAfAxeF+6k9dBcuGNkQMeaXGERnfZDCYJ7cW/mZHN1fA+Hqgwy0zUTG4Ugr
         dpLdJm61NBCqvnEBMKsa2KcB81MFM9n23ixnb/4oCYsjImEMfOc6DsmvYZ2FuLsAsCkh
         3U7p90Oy+ScNyZWfDK9lkrrnNSnZ327Hg+xVLQtT/AkJiz95lYuIirLl20yNLTw0mixX
         Y8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTsS9WO7t3WlZZMouHSL/m/iJQUQUndophD3E0ikjkg=;
        b=cVt90U0lszxfMGEw6FgRZ+oSsKSOFMzQovlIrP33+TDhEo2eNYmJcd/0S07T6/o6Tb
         H/Zjcl6ixzdoWuV0EN6iMC/gZfU5mcMuEWiiP8k2OSdB9z9UOTWVHAhOUmbRh32G9/LJ
         WLQVZIauCPsXgY5CiH6pUHfQRzjIaBEmAGjaDPGTxy3r9nXBUQy5OPF1ZkFBbC1Ll7xj
         s+TGPWLfKaosqD0uvm688VtjfUXNVfz513aOx4m2lsXu3tko8gOZrVb32q+cc93H8Uww
         zxCOUF6CvpJJcVxIoRzHNYwtUSCRxfnYCEQS8CnGjaUQwFSB5ZfeNdRBOC0ro6bxE2jV
         246Q==
X-Gm-Message-State: APjAAAWVT0Bys93hbhDmzKoF0361/nav37BlM9qvND5vLWA1YY4xo/YI
        gC1QPOl36WiOMrK/ATx2gpgtZ0hoN/0iei46Jd/4
X-Google-Smtp-Source: APXvYqym8cced9EAYXY0hZPlUxkHmVZTLvhbQfaeakFPaa+UnZ0Olsv7FMLpwZ43E1FqVffiGTc93Vn1fHeYScAifPc=
X-Received: by 2002:a50:cc8d:: with SMTP id q13mr4104551edi.12.1582895345585;
 Fri, 28 Feb 2020 05:09:05 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003cbb40059f4e0346@google.com> <CAHC9VhQVXk5ucd3=7OC=BxEkZGGLfXv9bESX67Mr-TRmTwxjEg@mail.gmail.com>
 <17916d0509978e14d9a5e9eb52d760fa57460542.camel@redhat.com>
 <CAHC9VhQnbdJprbdTa_XcgUJaiwhzbnGMWJqHczU54UMk0AFCtw@mail.gmail.com>
 <CACT4Y+azQXLcPqtJG9zbj8hxqw4jE3dcwUj5T06bdL3uMaZk+Q@mail.gmail.com>
 <CAHC9VhRRDJzyene2_40nhnxRV_ufgyaU=RrFxYGsnxR4Z_AWWw@mail.gmail.com> <55b362f2-9e6b-2121-ad1f-61d34517520b@i-love.sakura.ne.jp>
In-Reply-To: <55b362f2-9e6b-2121-ad1f-61d34517520b@i-love.sakura.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Feb 2020 08:08:54 -0500
Message-ID: <CAHC9VhT51-xezOmy1SM4eP_jFH9A8Tc05wY=cwDg7oC=FgYbYQ@mail.gmail.com>
Subject: Re: kernel panic: audit: backlog limit exceeded
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+9a5e789e4725b9ef1316@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 5:03 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2020/02/28 9:14, Paul Moore wrote:
> > We could consider adding a fuzz-friendly build time config which would
> > disable the panic failsafe, but it probably isn't worth it at the
> > moment considering the syzbot's pid namespace limitations.
>
> I think adding a fuzz-friendly build time config does worth. For example,
> we have locations where printk() emits "BUG:" or "WARNING:" and fuzzer
> misunderstands that a crash occurred. PID namespace is irrelevant.
> I proposed one at
> https://lkml.kernel.org/r/20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp .
> I appreciate your response.

To be clear, I was talking specifically about the intentional panic in
audit_panic().  It is different from every other panic I've ever seen
(perhaps there are others?) in that it doesn't indicate a serious
error condition in the kernel, it indicates that audit records were
dropped.  It seems extreme to most people, but some use cases require
that the system panic rather than lose audit records.

My suggestion was that we could introduce a Kconfig build flag that
syzbot (and other fuzzers) could use to make the AUDIT_FAIL_PANIC case
in audit_panic() less panicky.  However, as syzbot isn't currently
able to test the kernel's audit code due to it's pid namespace
restrictions, it doesn't make much sense to add this capability.  If
syzbot removes that restriction, or when we get to the point that we
support multiple audit daemons, we can revisit this.

-- 
paul moore
www.paul-moore.com
