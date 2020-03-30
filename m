Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D3C2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2FB206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fExB7XpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgC3JCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:02:02 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42510 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbgC3JCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:02:01 -0400
Received: by mail-qv1-f66.google.com with SMTP id ca9so8501694qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yTXcAm8xTZZlLv27rN0g4+yu3w2ZB5Uvj+XDLCM2Es=;
        b=fExB7XpWILh9K7fynAxxQYw//W3hUVCDQMwbfAXNtfjIlXo3SFYHWvzyJMndxZwR2N
         KBUh16CiA3j7/aSrXYS+N6OdNeSuC1oS/Uq+PCamn/cxVCzDq4L19UOxgmDZuGvxqR4r
         ea/to9r1ZF4Afeq3u+BV0xWGPGN4iF72JAi+TyeSnoYywsNTLMhKd+cnuPOnzoqTyUxl
         vpskI2pFsUrdFHmeN2aw1AmtIK8w+8ku//sKSq87Gpj4Bvo/k8iPYvm/MlKdq1mCVqDw
         CmFSJJWeYm8p9pquqLeJT261L+OKUNCRxj+dI9qrwkjodlEQCva8BULWRLr9ilc38Y4D
         RqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yTXcAm8xTZZlLv27rN0g4+yu3w2ZB5Uvj+XDLCM2Es=;
        b=ZKj7aGoJZYBN1zkPErJrGVy53i7ALwDB2y6RGWDyta9RFwr1oxMndu7WfrM9tS6qye
         Jsse3qUS9flND7JbKa0VRU+DJ7AE+Xo9tCbbU7tZ2bn67ARKfb17gSR+Me2wHNXBnS4y
         e921niVlMKh5+xmzX/QK4yCB9P+EEr24gDOMm3uuMzjt5YW0yr358xNsg2hiy6gVwwXB
         lKt44LvWpD4DtVMVwHYW9JZO7nT63w67bLcrYnRmL2gzyBd0uXwBZa7OoLMEulBQ8rZh
         ZqRa47dBTydrHU6Ax31lo70G60PvEqlfRnUHkuArcu4wEathN5o06qnsm/GsOWx9CA8x
         lYrg==
X-Gm-Message-State: ANhLgQ26TDKtxZnFw7rwei/tftSBhE3i/hSTW+cGsC7dwNpYK1zggObK
        PfVU3yOSpVkYVNNFN/nFYuum9D63ovmgAhRa0+EKiw==
X-Google-Smtp-Source: ADFU+vvD/6dG6pRSGnJBnlqX4CdrzrUlbYE8lR5UYGUsPdMEkb/7J9W7tnn/t8sOcJdinRhiUqQ0ut4pNbnUOVLK7N8=
X-Received: by 2002:ad4:49d1:: with SMTP id j17mr11017654qvy.80.1585558920517;
 Mon, 30 Mar 2020 02:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200327223646.20779-1-gpiccoli@canonical.com>
 <7fe65aef-94e1-b51a-0434-b1fe9d402d7b@i-love.sakura.ne.jp>
 <CAHD1Q_zx29ZP37WcUr34ZEyqWkA9J23RmLa8jFyuLDrS_yC50A@mail.gmail.com> <CACT4Y+bjsEFsP1ELGuTXbZV5m3gWys444p5cq=375KPkpFk0Gg@mail.gmail.com>
In-Reply-To: <CACT4Y+bjsEFsP1ELGuTXbZV5m3gWys444p5cq=375KPkpFk0Gg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Mar 2020 11:01:49 +0200
Message-ID: <CACT4Y+YE-j5ncjTGN6UhngfCNRgVo-QDZ3VCBGACdbs9-v+axQ@mail.gmail.com>
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        CKI Project <cki-project@redhat.com>,
        kbuild test robot <lkp@intel.com>, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:49 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Mar 30, 2020 at 2:43 AM Guilherme Piccoli
> <gpiccoli@canonical.com> wrote:
> >
> > Hi Tetsuo and Dmitry, thanks for noticing this Tetsuo. And sorry for
> > not looping you in the patch Dmitry, I wasn't aware that you were
> > working with testing. By the way, I suggest people interested in linux
> > testing to create a ML; I'd be glad to have looped such list, but I
> > couldn't find information about a group dealing with testing.
> >
> > So Tetsuo, you got it right: just change it to
> > "sysctl.kernel.hung_task_all_cpu_backtrace=1" and that should work
> > fine, once Vlastimil's patch gets merged (and I hope it happens soon).
> > Cheers,
> >
> >
> > Guilherme
>
> +LKML, workflows, syzkaller, kernelci, cki, kbuild
>
> Tetsuo, thanks for notifying again.
>
> Yes, kernel devs breaking all testing happens from time to time and
> currently there is no good way to address this.
> Other things I remember is the introduction of CONFIG_DEBUG_MEMORY,
> which defaults to =n and disables KASAN, which in turn produced an
> explosion of assorted crashes caused by memory corruptions; also
> periodic changes in kernel crash messages which I assume all testing
> systems parse and need to understand.
>
> Is there already a mailing list for this? Or should we create one?
> I.e. announce and changes that may need actions from all testing
> systems.
> Another thing that may benefit from announcements is addition of new
> useful debugging configs. Currently they are introduced silently and
> don't reach the target audience.

I've fixed this up:
https://github.com/google/syzkaller/commit/c8d1cc20df5ca5d9ea437054720fa3cfdfa1f578

But what would be even better is some kind of canned configs/settings
for testing systems so that I enable it once and then such changes
magically auto-happen for me.
Imposing work on N testing systems maintainers is not good.
And there really is no good point in the current kernel dev process
for this. Announcing unmerged changes is too early (as this patch
showed). And once it's in linux-next it's already too late..
And I don't want to be inventing a new unique kernel configuration for
testing. I don't think it's the right way to approach this. Whatever
is "the testing configuration", whatever kernel developers want to see
in task hang reports, I just want the system to provide that.
