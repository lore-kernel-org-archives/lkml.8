Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7DCC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABA1208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588186672;
	bh=/XFNmO7LT0nPY9J4rb5jIjfwGROG+yhO3o7kQIeEayk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VWNn8U5FrBwev3mGQujxbq26Omk/soAuItRDIrmJEpyw+5U069S0BsmJp4xWfmoDz
	 XxbfwYeMTT5NNY4g+X6rOcXEZ/7LAzSZYYa6sjM1qyN0jWA6uv9lMMk6+LJNXRC5PR
	 D9D6BEoQwv2MJPsxdh2y967lni9SM9P6ypatUrGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgD2S5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2S5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:57:51 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB7FC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:57:50 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j14so2609843lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHNO8ffSQj18wVxeNpd2+QoUtJ2NA8Wf/sg3u3S6tQ0=;
        b=hWdULCIRoYuwqiVb+98eRdgs9Csgxr5Iv08spzH3mrwrkcq2EcJnXV/zsGjDHKhK2G
         BcJWT65MlqCwRJKdxn7pMJNONqW1o9AFzJnCHA2JIy+SEwL90weMJyTTkMDX+1bzltLY
         ICRygew5dEFIF9ElXfXtYyimXjIdj9uVNT+9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHNO8ffSQj18wVxeNpd2+QoUtJ2NA8Wf/sg3u3S6tQ0=;
        b=SZHE7VBtZQAQ+qMvdTEbOyAb/7/0fhSndXdx6hoBrimBAa+YaUVoaajCaUONxrAj1q
         nQpwJzNTmD5UF94EI0VHaNqyMvnQVsG2R9aBnEDqjvXgx4coDp3/WRLjsRIuuJahk9o6
         Rz43Z9invqKM0AJuznQZF/eMcjaAhuk0NBZjEHrPB4Ki1G3KhhKN/EK7Bn2mE7OebsOB
         qU6FVkqYchXfoPrpV9OUmdfdS34HqEbB9gRzlSvZokuQexWilraqylHUKfoVZcDHrieg
         9tsmm5bVo+Yw4UzrH/QJzd3nHVkEd7lCes1QEmlDj82+oD/7kFHjBavFtL8YDOIFlzFa
         lmig==
X-Gm-Message-State: AGi0PuYv91Szauo5eEIUKa4ByoXKD1tRVD0br8iamlBrJeSEXdclybu5
        ff26iUZZ/+TUpf4vMjvb/BE8B8DxHFY=
X-Google-Smtp-Source: APiQypKkjgNNvSUFbq/n2K/Of0yk5q3/7zLyxhzbxeMl/EIuxzEiKMY3IXt47KXrPoDzpI9wdzKdLQ==
X-Received: by 2002:a19:10:: with SMTP id 16mr2251403lfa.145.1588186668450;
        Wed, 29 Apr 2020 11:57:48 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u6sm2815537ljd.68.2020.04.29.11.57.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 11:57:47 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g4so3818885ljl.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:57:47 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr20334087ljp.209.1588186666646;
 Wed, 29 Apr 2020 11:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com> <CAG48ez06PwxJ5ysTapByKnm6O0ifJv8Py2Ln0ypZZCwdxTU9zw@mail.gmail.com>
In-Reply-To: <CAG48ez06PwxJ5ysTapByKnm6O0ifJv8Py2Ln0ypZZCwdxTU9zw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 11:57:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi125+Fsdo1FY1QnjSLqHobRCO3nqKLqyU+Gm97ESJhnQ@mail.gmail.com>
Message-ID: <CAHk-=wi125+Fsdo1FY1QnjSLqHobRCO3nqKLqyU+Gm97ESJhnQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
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

On Wed, Apr 29, 2020 at 11:33 AM Jann Horn <jannh@google.com> wrote:
>
> > That sequence count approach would be a much simpler change.
>
> In that model, what should happen if someone tries to attach to a
> process that's in execve(), but after the point of no return in
> de_thread()? "Abort" after the point of no return normally means
> force_sigsegv(), right?

It would by definition have to check the sequence number at the end of
install_exec_creds() (where we currently release the
cred_guard_mutex).

And yes, that's after the point of no return, so it would cause the
usual "kill the process".

We could check earlier too (while still able to return errors) and
return -EAGAIN or something, but that wouldn't obviate the need for
that final check, iut would just shrink the window for the "fatal
exec" case.

                Linus
