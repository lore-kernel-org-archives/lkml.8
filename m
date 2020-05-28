Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125EC2068D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590692740;
	bh=cJLAhlnq2OqUbmFc8bQXuSL6bgPrceDFYO9vPJzGUCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DQxIDtCZTiqtzX/E+zFaUsokdk6Tf4Dg/RWD8Y9UbtstXSgqu6wGSVzSq9BvtbIWu
	 0QNCX4QshjEbHfUw4Wgbwy6OAQEM3WRCCmkHC5mw5o2oPU5gg9J5YvKeOOW0EEhmeZ
	 xYtsNjpzRVAbjd5LZ5Lfyc7KigNZyVOIoQbBC1C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406132AbgE1TFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406029AbgE1TFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:05:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E201C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:05:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a25so23159085ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIM8xuF5VWjvw+TNdHJ4kiSd5AWmWcoZ3yv55b5QhmI=;
        b=FUIN+4JKj2QxyK8i6JHV7/j7vy5lRuVpANaKoY2Mlj+WNN0OnhModMVphPtln7hTfr
         6e2HXcUIfOAsDiHQ1XL5v8z2Xgu1ZqPPoh0MtrHTKjhMN1uPF2+2fHIA2yVkvBMEgomb
         B5DSvFfThv/idiSSPqFeMZtDs8M840ZwViIm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIM8xuF5VWjvw+TNdHJ4kiSd5AWmWcoZ3yv55b5QhmI=;
        b=qXvyKefBK3Yg+G6ANdCLnTaIEoOuXAlBCbeCrKjr0umoVYqdW90Gb/38Htk7MMgX0S
         ACP7Rob9jMTalWJwCXchoPZES1rlWvo3Fh05W2aY0c0aioBWeFYQxqy0VJKAnUJ9jixL
         xs2mz88NgnnHEQUBWar2Bj+emgaE0sVR6KqKCaop1OTxssq+VffsLD+vTNDFDkma5VlW
         WXd0DPl3fz/arf9WpAEdJFvZYBJ5dYvZB/7+n5dBBGQbwiijsYcT7VheUqh+7bSCCVLN
         yCIW4NyHIlunQ/9moA0PZu4HQVLLcUld+RbX/b77w3/YJcTEB2iE0dhInQKgY2pKWpJB
         QR3Q==
X-Gm-Message-State: AOAM531s91crTEJAxNLLeYGt2lGeNA7ZAJp5cr2bjwDpMSTih2UObMpF
        V490G0jXaPLFsdTnCgFXXINkWukPuZM=
X-Google-Smtp-Source: ABdhPJwjRGVNt+otXJnjc+4462knsu98U3gpOzDHuIKfvloj1vLNLDrNFZjEg+k4kEPr/JIG8EdKIA==
X-Received: by 2002:a05:651c:1187:: with SMTP id w7mr2222769ljo.438.1590692733529;
        Thu, 28 May 2020 12:05:33 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w24sm1575134ljo.136.2020.05.28.12.05.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:05:32 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id h188so17240694lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:05:32 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr2356099lfu.192.1590692731704;
 Thu, 28 May 2020 12:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org> <878shcyskx.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <878shcyskx.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:05:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbYiVkYy0KpjssAEiEApEUogKpyL1VFWNic4wSp9iDYg@mail.gmail.com>
Message-ID: <CAHk-=whbYiVkYy0KpjssAEiEApEUogKpyL1VFWNic4wSp9iDYg@mail.gmail.com>
Subject: Re: [PATCH 02/11] exec: Introduce active_per_clear the per file
 version of per_clear
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the naming of "per_clear", I find the "active_per_clear" name
even more confusing.

It has all the same issues, but doubled down. What does "active" mean?

              Linus
