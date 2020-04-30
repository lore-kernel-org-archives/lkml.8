Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4094EC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0A12082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254486;
	bh=7YQPAWpsy0ebKHn4zN2P6u/P17OkB8cD8kvZq0jfjyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BWxXRYI01ZrF69AXSMuKy449pOyr8Fj4w1mr9Ec7XKbfr9EO0grRmKI2lGXeW+J0P
	 fB+zrhLUjLHmwA6HDuHwgRct9K/venHA/I/u7YsiKQe8H3VL2e9tFFxYXSykFNPCRN
	 B4FquwX34PDBnGT3pf6nLNEzBSz+cAU2yyh4e9Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgD3NsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgD3NsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:48:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E78C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:48:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so6540220ljn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rk+RJgrEnm0xyLamKgsXkHtAQWa4YU0qEK0UgCt3wQ4=;
        b=C6HUgoidZojkkiLsrkTF1SEFzplNlYHLmoNQSUpoLclLDMz5MA0+rBkIeOcm/ceBHH
         DnBRLb07lXk5/YfyPJgFQkb3RB0xRDXZDYlSMRRUQofRf0nssRwzLZxr/Wy2OLR3shaf
         JIURR5s86YDVXB50uceDwJ6TWx9ix1Wup0nrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rk+RJgrEnm0xyLamKgsXkHtAQWa4YU0qEK0UgCt3wQ4=;
        b=sNtfRqt8pTBAdiBIAn6jljG5CbvWI9NPaEaDpPxAIC9lmej3IOAfA1CsIFCsf87KU8
         Rrd8lIMOUBJl3TOCKozdONivQzOpip4N7jTJYpbJrRB3rsg/JsfFwy7fJPiZ1VhzQQQH
         S/QfPCWTxVs0H7DIM8rqtEZxKGt+VPq6rhE7rqiQtp6U6TbSed9+F0YM6Fd0F6UvL7a4
         I4/ymOlcURI2kQYleHqABcl/6Qxr20oMPKg5h0xy8yzlsr1n13dtzZmba3y5sb4ALe+r
         TRjEvQa6u6nu/F/P64MPDpqmuTJgl3UtfPpiJzP1+/6hFHTCahveahYlohRxRful+jeW
         ogjg==
X-Gm-Message-State: AGi0PuZvbXl89vxPohk0WMLERE619buzt8lj5n3432GyNuR5QM91Rr2D
        NNmUNtdC9AW90YDCMPvEo+RUo21KWlc=
X-Google-Smtp-Source: APiQypIr+4rfUw8hppRJdMEoCkzozEh2i3f8VCMYbXrYiXmxUi4WUxXTHELMyP+dZDRaWeCjVE52HQ==
X-Received: by 2002:a2e:b248:: with SMTP id n8mr2199974ljm.207.1588254479134;
        Thu, 30 Apr 2020 06:47:59 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 1sm4557122ljw.91.2020.04.30.06.47.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 06:47:58 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id w20so6594278ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:47:58 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr2243347ljg.204.1588254477655;
 Thu, 30 Apr 2020 06:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <CAHk-=wgcvn1_1kCkyourNCKeH+KrzSMRvc-ai_NLU4RGZT_XBg@mail.gmail.com> <AM6PR03MB5170CCB8D9D41904066DAFD5E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170CCB8D9D41904066DAFD5E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 06:47:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOdXfMa35bwCNfCNSsAndO-hFmsSNRWEEDziA1iDYGjg@mail.gmail.com>
Message-ID: <CAHk-=wiOdXfMa35bwCNfCNSsAndO-hFmsSNRWEEDziA1iDYGjg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 6:39 AM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> Excuse me, but what in my /proc folder there is no attr/something
> is there a procfs equivalent of pthread_attach ?
>
> What exactly is "attr/something" ?

Anything that uses that proc_pid_attr_write().

Which you should have realized, since you wrote the patch that changed
that function to return -EAGAIN.

That's

    /proc/<pid>/attr/{current,exec,fscreate,keycreate,prev,sockcreate}

and some smack files.

Your patch definitely made them return -EINVAL if they happen in that
execve() black hole, instead of waiting for the execve() to just
complete and then just work.

Dropping a lock really is broken. It';s broken even if you then set a
flag saying "I dropped the lock, now you can't use it".

                  Linus
