Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A96520656
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591991208;
	bh=1MkhRES2j8WnMAXdAIXcPr9zM3zwgeeKa6SdrJ/ciCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zdfu6Eo216GJElnNpI5lLviIgB672xG7nk/OwGmkHZhcOdPwTeHBWmJSM/jXf69Vj
	 9H49b4r19/fbuVH8s7YhXakR0obiiwBp4yKC4vtepsfby2msWIDCZ0n+V7FRLaKbAH
	 mSf0AnGIlt8zhunopaLiohmCfImIy33tJcWKC0s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgFLTqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:46:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A0C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:46:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c17so12382147lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wAcJJThXiHq7hvG9CGUJ5Ek78X+yOs/zgmUyeGApVM=;
        b=FiIukZn667swJB/6oYoKnuyuX75YrsbvzCiFhT7GohSd1rTjOHjyYxz5VXwmDMZPc/
         NBDwBl9hfDy9mBCOMR0aqs5HcNcatdApkPZrzuQ7ggyd119veqPd7u148hu8TSKg7FWM
         FqAJA+Oh/abVtmO5ZTs6m9IssvrloICwXmGlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wAcJJThXiHq7hvG9CGUJ5Ek78X+yOs/zgmUyeGApVM=;
        b=SRasHuaVxj5KAU2QEqDtEexMPm1MtyDiW0bB460h9PxpeGZML2f2oX93C/1AJWmN5P
         b1MmM3ya9WWoXia/2Nsd7SNHa+Of9/goDC6m2L5yOXv4Xwib5tVIh1jc+fpFALwHg5mp
         /zPM1Z12syeRylnOSwBVFcN+eRAO0mj3NkGV6ZVAYd/tRjOecXnxHSOuxKSYH8L+aD33
         NsoiQtkGfVotnZuI0YfO0xXBhaqd5do1JJvsInQEQtRjyFTUQ9eCieyW9RcKIXmb+PNR
         NtM3V8g/1h3pznARecEJ1uRpu2BM+XpVm64y0AxwT5X+k6PIDlbXjtdCzlKFH/IYuhgh
         uGdQ==
X-Gm-Message-State: AOAM533q5+oDGPPMtapffv8F1OiM/cEhfEQ7RwWThmsGmOAvc4ywh4wT
        EwHNvIVEVXZXHfahM1491LWyDUif3UU=
X-Google-Smtp-Source: ABdhPJwceeMJSqAvKgtDJj05+SHgYLyXA4ZsRhQ2tS20qhBO246nBm4d/aPjnjqsphx5JobZ4vuupA==
X-Received: by 2002:a2e:750c:: with SMTP id q12mr7709943ljc.142.1591991202798;
        Fri, 12 Jun 2020 12:46:42 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w20sm1943354ljo.68.2020.06.12.12.46.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 12:46:41 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id h188so6123477lfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:46:41 -0700 (PDT)
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr7711925lfc.142.1591991201362;
 Fri, 12 Jun 2020 12:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <875zc8kxyg.fsf@x220.int.ebiederm.org> <87zh9atx0x.fsf@x220.int.ebiederm.org>
 <871rmkozf5.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <871rmkozf5.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 12:46:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com>
Message-ID: <CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com>
Subject: Re: [GIT PULL] proc fixes v2 for v5.8-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:34 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> ebiederm@xmission.com (Eric W. Biederman) writes:

What happened to that first version of the email? I never got it..

> Looking at the code the fsnotify watch should have been removed by
> fsnotify_sb_delete in generic_shutdown_super.

Hmm. Correct. The new_inode_pseudo() is for things that don't have
quotas, fsnotify or writeback.

That was used somewhat intentionally on /proc, though. /proc certainly
doesn't have quotas or writeback.

And fsnotify on /proc seems a bit questionably too. Do people actually
_do_ this and depend on it, or is this just about syzbot doing
something odd and thus showing the problem?

Anyway, I have pulled your fix, because I think it's reasonable and
safe, but I do wonder if we should have kept the new_inode_pseudo(),
and instead just make fsnotify say "you can't notify on an inode that
isn't on the superblock list". Hmm?

Is fsnotify on /proc really sensible? Do we actually generate any
useful notifications?

              Linus
