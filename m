Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03055C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F2D20658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597862296;
	bh=JTCYO8qkHEiuX+BlGTWxjy1hbhVzsbjzkn2WWsZSY0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2hNsieDPKz+xBcKSfWMOE3pe2AdJrCZnRb+EbJCb7OY+KZentDC0kpF8QQ4bW0ef3
	 L7SmlCQMAHqFbSE5LLyIVwnIED2wdJMqArF+5WrOf3i/ppPVuFgn4hhadY2nvBAtpQ
	 nF3iUs+mTABLjSG3+H6q6cFeCV/mvwwMGvWrIvNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHSSiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHSSiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:38:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB15C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:38:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so26526395ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCuKkyRxcbup4ABdZGpC9XS5K02qBsfUZIlHBjZs1pc=;
        b=YN7mKrskvwWbX56uQExfTWNmH6b7b06GM1t6v6PKQMs/53B4exuT41lXnTdk02Vy1a
         kyWEZ0RcGu5BbhBuNhEnWP2R+82h3AWl7VuY+FT8Owk6ALwcQj9n43iDoTjn/PJjStUs
         +r7PqpmcMgHSVrmWSkasonWj1JvkoFL9fZBlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCuKkyRxcbup4ABdZGpC9XS5K02qBsfUZIlHBjZs1pc=;
        b=Qj6rTpuOPuPfrBSp3G6LYDEolkYX/hfouTv1RV5YSR//w9b5/0E7nZfvk8cpnU0WxB
         uEYP7tf86d37xhuxJT/KRO9eta+ol/Qr8gAaxVyGEpkwNTsgWFpAIpn1Av6ddqiSO0tV
         STF9nDhawuyYqcCXsyUAnnDpugtuiwuVISxkHMfsXJao3PwqQ1Mluw+HS4ZuPIjkby+L
         HFRs0iiZrcI89LlkGpw1ALj9mzOP3CUydqu71lkARrB87AiB8BePib0dM6fPpt32qvXd
         scR5/+yuoAq8nSqVFnUsPLx5CWoFeDvPz207xo1noEYK4mWttkRJlTeXlZV41thGHKqS
         0N1w==
X-Gm-Message-State: AOAM530SZSE3iaOwP5fak5IE4RFKTFkNL/Mg1FIa8kVkFfSc1DphMBp+
        1PKYNFe6IVNE9PiAwoIh7Lv9BhKeBX5qUg==
X-Google-Smtp-Source: ABdhPJzyZpIAwoZx35YcBMo4mdFuyeglrlMcK5pL2jHhBTppPYnZhC4L/0/Ro3hziaTtt6t6fukdww==
X-Received: by 2002:a2e:8515:: with SMTP id j21mr10827761lji.158.1597862289171;
        Wed, 19 Aug 2020 11:38:09 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j2sm6793156ljb.98.2020.08.19.11.38.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 11:38:08 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m22so26479330ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:38:08 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr13526311ljf.285.1597861941474;
 Wed, 19 Aug 2020 11:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
 <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
 <875z9g7oln.fsf@x220.int.ebiederm.org> <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
 <20200818110556.q5i5quflrcljv4wa@wittgenstein> <87pn7m22kn.fsf@x220.int.ebiederm.org>
In-Reply-To: <87pn7m22kn.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Aug 2020 11:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8BQbgJFLa+J0e=iT-1qpmCRTbPAJ8gd6MJQ=kbRPqyQ@mail.gmail.com>
Message-ID: <CAHk-=wj8BQbgJFLa+J0e=iT-1qpmCRTbPAJ8gd6MJQ=kbRPqyQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 6:25 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> So I sat down and played with it and here is what I wound up with is:
>
> __fcheck_files -> files_lookup_fd_raw
> fcheck_files   -> files_lookup_fd_locked
> fcheck_files   -> files_lookup_fd_rcu
> fcheck         -> lookup_fd_rcu
> ...
> fcheck_task    -> task_lookup_fd_fcu
> fnext_task     -> task_lookup_next_fd_rcu

This certainly looks fine to me. No confusion about what it does. So Ack.

                   Linus
