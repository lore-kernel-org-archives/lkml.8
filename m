Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B2BC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31A72051A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586629767;
	bh=0DWLY6Q5BdLXAZ1eK5ePQW2STI0BTJyLylEp1LcxgiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nZK6DNam36bvVcmMLeLtSOd5FjgNJ8/vSpA2d0rgic9BlIuhZv7u9Y/lJtUk/iIDk
	 4IDmhyQiPR2LCRwe1AcjCfj1OKrxOHnkxT2OFPChFkoNKiuTciTp7tNoXIRnGTL2qJ
	 ze0p3BUufErXCGupxhR93AuUDFuT74YYBWCPazcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDKS30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 14:29:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38586 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgDKS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 14:29:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id l11so3593205lfc.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sxd7h+PAeAiaXCgNz53g2fl/gtP8m/YpMLJIBPGjhWk=;
        b=Yo/TxDg8wvuSnyo5yX3+SEqC3HPBVbPteJaCds7SQ3K/HwOt7suqJzgY9WGPY4VEEo
         6Uyg9jTxWqqRED48pwpQ3E21dLX1Rge5mBDNNdyObtLMcqjV5RGc8mlb7SscoDO3sJPZ
         WBnpY3MIfSzTOxzOsDBGov0PmQaaWkOkF9cRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sxd7h+PAeAiaXCgNz53g2fl/gtP8m/YpMLJIBPGjhWk=;
        b=k7mPhyr+TQLoMW5iR18Yxsi2V/HBCppLj/CD9xfgMIF61V03ygCD83Hz52ycIr2rb9
         t/YO2nqFgOJHfA+c54sir+eOnZc9qfF9F0VujyyCIs9V9FwhhCVU3j7X42hQq/GTvsZA
         tMA2I0xXIRZTTCmaPDJPgf68iliAvnUDK4galWD+nMa1fC5h4SuBGWTbg74wh0vk+tQC
         p5UQBm3nsUVgSEpeVJxn46m5d6bBL7n0gNy3ImCB218vv3GVtLVflycmsRiT7ohoTR31
         uYtLo2zJaxjYTcEKc75f3usxJwMWcA9t4ak5aJeDYpwBQZo629oVXKZ1/Z5vLJJ9clPV
         lxxg==
X-Gm-Message-State: AGi0PuYBhOFbXwpGfZ+h+1B+PkLxHmpbyQL01qKDOxRkIBZs39VEq0J0
        b/3UwbDxzuJTFyVXwTwKSZr8kLaRuHU=
X-Google-Smtp-Source: APiQypJaiyB9XxakUVS5P2Rg7G4cgigHNUUaXmjBLC7sKTJy3HdX330te03Sf/Jr0jn/3SITEo5J2A==
X-Received: by 2002:ac2:5684:: with SMTP id 4mr5786844lfr.88.1586629763143;
        Sat, 11 Apr 2020 11:29:23 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id j22sm4343420lfg.96.2020.04.11.11.29.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 11:29:22 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id m8so4995379lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 11:29:21 -0700 (PDT)
X-Received: by 2002:a2e:b619:: with SMTP id r25mr6374948ljn.150.1586629761353;
 Sat, 11 Apr 2020 11:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com> <20200411182043.GA3136@redhat.com>
In-Reply-To: <20200411182043.GA3136@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 11:29:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
Message-ID: <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
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

On Sat, Apr 11, 2020 at 11:21 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 04/09, Linus Torvalds wrote:
> >
> >  (1) have execve() not wait for dead threads while holding the cred
> > mutex
>
> This is what I tried to do 3 years ago, see

Well, you did it differently - by moving the "wait for dead threads"
logic to after releasing the lock.

My simpler patch was lazier - just don't wait for dead threads at all,
since they are dead and not interesting.

Because even if it's Easter weekend, those threads are not coming back
to life ;)

You do say in that old patch that we can't just share the signal
state, but I wonder how true that is. Sharing it with a TASK_ZOMBIE
doesn't seem all that problematic to me. The only thing that can do is
getting reaped by a later wait.

That said, I actually am starting to think that maybe execve() should
just try to reap those threads instead, and avoid the whole issue that
way. Basically my "option (2)" thing.

Sure, that's basically stealing them from the parent, but 'execve()'
really is special wrt threads, and the parent still has the execve()
thread itself. And it's not so different from SIGKILL, which also
forcibly breaks off any ptracer etc without anybody being able to say
anything about it.

                Linus
