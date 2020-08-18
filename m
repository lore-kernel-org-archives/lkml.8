Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC5BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A87207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597714105;
	bh=vGxAG/BKTNrQwzRAadNrqX266j7voKqUO2ljJmp/3Tc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b7mvmU7JR3yutA6EUHT7046IBtcqwWVTvW74xRTK6Hqq65PmtWRtzONBBr6dzgYI5
	 CC5bJhP6XI0wTZpQmnFBnenZ0hZbTYeLndsxcvYIk/dzqPWQuhrMNE/2AmYcYRBfkC
	 Yvvszjxq7hP/xsmwlAsMj3Zj0UFC5hXOngSgSKng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHRB2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHRB2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:28:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B66C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:28:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w25so19543448ljo.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9GGIPZeeCr2buv5LskGV0KUkXunajXDJwMIsnUEH9E=;
        b=XB+4puoAJ7oLIcF7LzRl/MGchCEIBEGK143/RcJlKBa6gZV2vs2J0/WgoHfVuiYGzU
         yP8FrR6fRFu089/Ospd7PbbInczCklxVj6i0XRwtqWSI/I6DXT6hmzzEpnvoMEV80Id2
         N57VYh7HVcjr6EsHTAY/h831U5di5F/kheIj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9GGIPZeeCr2buv5LskGV0KUkXunajXDJwMIsnUEH9E=;
        b=DzxVLTp1yDGRe0JZocCyksDwX68X+K/M+2+DBWeMx6AEB018wKpQCvYgj/0kccz9Y6
         Hb/DLSBHMUq/WWtzox+drcpIYLMtctANAQsBGYEbVQiI3dZ1BZKIH/++L4Qb3n0q+0UN
         SQF0kvinhNOur1XdDaxIZoeYRzRxEZOe37vOw5wVC1jKTEfZAU/AeiqSz4D/mU4OQbdX
         VRi8B6m8STmurVjnWtPhzhbszuTZFI/e2xpfMdO6N/hpe0CAAjadk6+posrJ7tKNfj7K
         tlAekDETGKBSBHclS2BKMBpC4KVHdriBXVozX3QCjeAQEpk0qXAg29whiIg0yhoZ/+fv
         mHzw==
X-Gm-Message-State: AOAM532TJBW0hSMVBSslG/8k20JQONx1xtEHtsN4aIcJsf0eKk40XpSp
        Bc+I4iBLqm2V4tYIfI5iAlHwsQ70/xYy/A==
X-Google-Smtp-Source: ABdhPJxg5sajwy1HPWyPCn7c4mBytgEPha4c4Y08Hjr0X2TepaaWQP3XpS+wl3PdTjb7utJwSpFB4Q==
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr9290334ljo.267.1597714100419;
        Mon, 17 Aug 2020 18:28:20 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id j66sm5962034lfd.74.2020.08.17.18.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 18:28:20 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id m22so19559804ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:28:19 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr8521728lfo.125.1597713683604;
 Mon, 17 Aug 2020 18:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-12-ebiederm@xmission.com>
 <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com> <87v9hg69ph.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9hg69ph.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 18:21:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_Tg4TYz2_SPE=h+xjXKTDCTCRzg=1ERgh_6WOVTgz9w@mail.gmail.com>
Message-ID: <CAHk-=wj_Tg4TYz2_SPE=h+xjXKTDCTCRzg=1ERgh_6WOVTgz9w@mail.gmail.com>
Subject: Re: [PATCH 12/17] proc/fd: In fdinfo seq_show don't use get_files_struct
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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

On Mon, Aug 17, 2020 at 6:13 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> task_lock is needed to protect task->files.

Hah. Right you are. I found a few cases where we didn't do that, but I
hadn't noticed that they were all of the pattern

        struct task_struct *tsk = current;

so "tsk->files" was safe for that reason..

So never mind.

           Linus
