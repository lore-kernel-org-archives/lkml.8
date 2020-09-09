Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72657C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32335215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sebRAI5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIILhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgIILct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:32:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347CCC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:32:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o8so2987361ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NECuaxSEf168q0jIzBN26ROkTAWTuBbGDh4gcowtLHY=;
        b=sebRAI5gWmXieZeflql4Wxd8595EtHbk0ITVkD25tgYixk+cPBfo3Su3vwzJHK/mTk
         9qrr5R/TWXNlRxuWLRD7z/GKlNT55VGCS5saQXkDXwTkACQPwsOK3o0W+7K7GeUrhEK8
         4HOUdBYj70etXzOmEFf/PMwYKT8fDbIbAtCx7isevFegXL9L3ru5eOlZH9Q8ExOUICNc
         qo5+sTCTb22zRWRvyphPpSIZ3+TEgFZX7N5oeeQLp+DTdYFUrpDGFAUUbBYnawhbQa+V
         DA6sltri04+VsCqe5jrl9nlarG7hWofBmEz6hX/UbkVIfxBCvAiqpeAQ9r45pe2DFc/a
         xGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NECuaxSEf168q0jIzBN26ROkTAWTuBbGDh4gcowtLHY=;
        b=WlF4czBrG+rNYrip92WJ6KkGpUB4PQsq2/a/UdC6BMoCDAVtdJ29KhJlc24MJdr542
         Ne2Ab5Ol8DFlYQzqTwEddSQAZ8p9uJ1b7EnHa1O7yaN0yFPylheAed3GrNmNxXegNidI
         V5owLB9WkHa3+J10xh53fV8BIL56EYsaJb7h5/UmOd5KKqj5AvxFgnTED6C3JFsKpteg
         d8pRVfp57W1ghuJbaPH+xkDzQyb43zK1/XswCgVqRNZQvZsNEQHeJI5hGDck5XntTW7a
         o+efbuO1RylReYUW1S5L2ZBbOv9qTU3NYujKumsJgTZgNZ86c7HW9o2zuKDpEZX5TPCp
         JThA==
X-Gm-Message-State: AOAM530eIcrHFjXA/MiucIJvK7smzqi5DQez1MH9aM3P/Eni2affmbdI
        3bI9DAfiJ3+YdmOJKYCqQYQ=
X-Google-Smtp-Source: ABdhPJxfCwCX4J4uyUUx1XwPnddonxEE3wTCxfUo+gVe7Db2JuNDUW80pab7rfxeHNSUPlqdUHvdFw==
X-Received: by 2002:a17:906:556:: with SMTP id k22mr3056519eja.369.1599651151882;
        Wed, 09 Sep 2020 04:32:31 -0700 (PDT)
Received: from felia ([2001:16b8:2d44:6000:6108:df55:7b8e:67d4])
        by smtp.gmail.com with ESMTPSA id bx24sm1872742ejb.51.2020.09.09.04.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 04:32:31 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 9 Sep 2020 13:32:30 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Ayush <ayush@disroot.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] checkpatch: GIT_COMMIT_ID: handle
 commit messages with multiple quotes
In-Reply-To: <3dea1eefdbbf97791bed3f838d4f06a7@disroot.org>
Message-ID: <alpine.DEB.2.21.2009091324590.5622@felia>
References: <alpine.DEB.2.21.2009091152530.5622@felia> <beed63208cc412f122fe273602675801add08ede.camel@perches.com> <20200907151417.44453-1-ayush@disroot.org> <22db634e7be36f4514f0c9b3ecf0060a@disroot.org> <3dea1eefdbbf97791bed3f838d4f06a7@disroot.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


dropped the maintainers.

On Wed, 9 Sep 2020, Ayush wrote:

> Sir,
> 
> > As the mentor in the linux kernel community bridge program, I usually
> > inform the mentees when the review on the mentee mailing list has
> > successfully concluded to a first acceptable state and I think it is well
> > advised to reach out to the maintainers for further discussion.
> > 
> > You did not do that, but just send some patch to the maintainers.
> > That is fully up to you, but I will not support the patch acceptance in
> > any way, and it suggests that you do not see the need to be mentored.
> > 
> > If you can land patches without mentoring support successfully, that is
> > great, but then you do not need a mentorship.
> 
> I am extremely sorry for my mistakes. It won't happen again.
>  
> > Now, to the commit:
> > 
> > Ayush, your commit message is largely incomprehensible.
> > 
> > Your follow-up explanation that was needed should have been in the commit
> > message in the first place.
> 
> It was my first patch, so I had very little idea of forming commit messages. 
> I will discuss it with mentors next time before sending the patch next time.
>

Let us start with the simpler patch and then see if you can write a commit 
message that convinces Joe to ack your patch.
 
> > Ayush, you did not sign-off with your full legal name.
> 
> My legal name according to all official identification documents of India is Ayush. 
> I have no surname registered legally.
> So should I include "Ayush <ayush@disroot.org>"  or do I need to include my last name too (Which is Ayush only)?
>

Okay. If you say so, I cannot judge but you should try to use a name that 
others can with a fair chance uniquely identify that is you.

The name is used in git log summaries, pull requests, etc.; so, it should 
be a name that with high chance to refer to one person.

Maybe you find a good way that works as suitable name for 
unique identification?


Lukas
