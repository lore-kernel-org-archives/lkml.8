Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A5AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D32A206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593536837;
	bh=oPlSxGwJv6Q9Jn6Pj3Ukuky8J2wsMIsNMguDoCPNm8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AOQQAWcTZsFfauZGQrbSTtFLTjZ6igmDt66ZLpn32Gzj3PdYashC4/hsMFTmESZAX
	 gVnia9HTZeh+fc4gqrQ+KseKpoZSI6pDYA4xBH5JVukELU6ZnXXTyhFB+pMllfkfds
	 +c9an+4JogiXhihlCWgtI92YnPr4CQBzj9PmZYy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390019AbgF3RHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390009AbgF3RHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:07:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B45C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:07:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p20so21364454ejd.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ep4v7Sgk0x30ZAXgHmmvI+chKVNBUjoHn6j3LyL4OVk=;
        b=bDLuMC1J3ipv5oxg6WsuGLNLBbaQ55mOuGN9gmYd6tux50ZveMInMrUVjkMhagmtQ5
         qLh1w/kcYRGFnMfNjLBP+bjgbKz0yTX5dUcCzabJRir+X9IwGpmmbEP2RWkxzYIDhJt9
         UTsF2pc9EMEECfBDdQEKoYZ3atlchjta3NnSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ep4v7Sgk0x30ZAXgHmmvI+chKVNBUjoHn6j3LyL4OVk=;
        b=DfXRkDwEuevk7v/xqwAqJ5YVist0V3QX+032P0LuiDpAtmlsBGi5s44AzFVDzqRlF+
         E7Lbzi52HBalu0l2ymIbUAo4oFFxqvnjKBeksVNzRV5R0hbyIraRq4F7F8BJFwIH0VHL
         96kbC5iXBaTF7f8ZcsVJXcnJKqT0Iz41zjFvBa1TrDqlSxcoUcm+FvBu9wZOZJpXUG2C
         C54pIrIjO2loLBXvSlOCoyn+BfSFz/xRmcLQK/W4As94MFfwnWb2T+eDXMKdpEmOVaby
         1ouIns4bQbCEqPe0wPOyg1iCOnaaEo+ogDQOcbJBVhIY+czLWP8HAa5wIKTqtcJfM3E2
         YcPw==
X-Gm-Message-State: AOAM531tA2AkR+wtRn/i5jYVygSp4HFVVf9IBNEkKRKi+Xfg/VOsyvXA
        srESH+P6NehxVJzXm3ohYiaDlSNJlc0=
X-Google-Smtp-Source: ABdhPJzfKIbubclSByFT+bzw+5SmbKGKGx1qIPUqdPZcfjPSiM4mp4xR87NWu2VFLgYsAhaYbrKKvw==
X-Received: by 2002:a17:907:1051:: with SMTP id oy17mr19928994ejb.394.1593536832204;
        Tue, 30 Jun 2020 10:07:12 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id b98sm3486762edf.24.2020.06.30.10.07.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 10:07:12 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id s10so20900023wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:07:11 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr5624686lji.371.1593536343609;
 Tue, 30 Jun 2020 09:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200625095725.GA3303921@kroah.com> <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com> <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org> <87imf963s6.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87imf963s6.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 09:58:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com>
Message-ID: <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] umh: Separate the user mode driver and the user
 mode helper support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This makes it clear which code is part of the core user mode
> helper support and which code is needed to implement user mode
> drivers.
>
>  kernel/umd.c             | 146 +++++++++++++++++++++++++++++++++++++++
>  kernel/umh.c             | 139 -------------------------------------

I certainly don't object to the split, but I hate the name.

We have uml, umd and umh for user mode {linux, drivers, helper}
respectively.And honestly, I don't see the point in using an obscure
and unreadable TLA for something like this.

I really don't think it would hurt to write out even the full name
with "usermode_driver.c" or something like that, would it?

Then "umd" could be continued to be used as a prefix for the helper
functions, by all means, but if we startv renaming files, can we do it
properly?

                   Linus
