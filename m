Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C360C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:14:28 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1261520673
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BL7yCcY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1261520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgDLUO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:14:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C38C0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:14:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w145so5133907lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZ+Qwcgw3gLHLZ7KJ4zioyHNcOotsBRlbLtro3s6FMc=;
        b=BL7yCcY3gKtsDl12StG7JoulZj14GrKguH2zdHtOwis+eyDBJHJUxuZmBSd7XFIRa0
         j6gbF/xb5x3bStD8gv/E+AbKLXK/42iz3LkiiuMRtUDVM+SXpob1CWdAqALo/Fo+os/Z
         RLv/FQShwCKh19zxfb2HvGj9/yf9B1piv4h48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZ+Qwcgw3gLHLZ7KJ4zioyHNcOotsBRlbLtro3s6FMc=;
        b=idQubaN2Kj5EYt+mwH6XfWsPabXl/LdUsdiAL46sa2SVgqAbzZ33idbsIGqoS3fKlc
         DRlEHYkuOzoOOA4KFx7xUfQkcWcwfhffymbnruICSf1ZKM5Fcb4bZSn7HcSvPXy+44gm
         OskBAxA9DG4ge6rfRc3zSXx7fAsyRcwaD5b9AisMdzl6n12UcqjN5gzdKItciYE4CkbR
         vYGjR3fOwgMEOIh2RDQ8HM0hTHoEo2D28toXWgOIVeFh26vGlkuSijwPZvA9yvXJDrCw
         ZARwttg9wY3NzCVpA4rIKaKleI1Zkx0Y9oN8UPBylWjcBo451Kh+CFG5sajzkUfNlnkq
         P6bg==
X-Gm-Message-State: AGi0PuYcr6xECB1/aQiT11q1F7kcsEwv1xB+pms5HMyR5rTX5SIwGiO0
        4dIgaq8l3AP6Oz2OvNkJe8d31gLqndk=
X-Google-Smtp-Source: APiQypJPfHcGutGUEwwNZt6i9EBECvFpTfd4vhV9Cg8qHO3BlgrScC5YM7+BVKFwvJTDu8noeDcU9Q==
X-Received: by 2002:a05:6512:490:: with SMTP id v16mr8545845lfq.71.1586722462260;
        Sun, 12 Apr 2020 13:14:22 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o25sm6182353lfg.41.2020.04.12.13.14.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 13:14:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id r24so6924759ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:14:21 -0700 (PDT)
X-Received: by 2002:a2e:870f:: with SMTP id m15mr8811329lji.16.1586722460809;
 Sun, 12 Apr 2020 13:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com>
In-Reply-To: <20200412195049.GA23824@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Apr 2020 13:14:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
Message-ID: <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 12:51 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> To be honest, I don't understand it... OK, suppose that the main thread
> M execs and zap_other_threads() finds a single (and alive) sub-thread T,
> sig->notify_count = 1.
>
> If T is traced, then ->notify_count won't be decremented until the tracer
> reaps this task, so we have the same problem.

Right you are.

I was hoping to avoid the "move notify_count update", but you're
right, the threads that do get properly killed will never get to that
point, so now the live ones that we're waiting for will just hit the
same issue that the dead ones did.

Goot catch. So the optimistic simplification doesn't work.

> > You do say in that old patch that we can't just share the signal
> > state, but I wonder how true that is.
>
> We can share sighand_struct with TASK_ZOMBIE's. The problem is that
> we can not unshare ->sighand until they go away, execing thread and
> zombies must use the same sighand->siglock to serialize the access to
> ->thread_head/etc.

Yeah, they'll still touch the lock, and maybe look at it, but it's not
like they'll be changing any state.

> but see above, I don't think this makes any sense.

Yeah, I think your patch is better since my simplification doesn't work.

             Linus
