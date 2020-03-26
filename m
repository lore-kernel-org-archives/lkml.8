Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EE7C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1D720714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585263270;
	bh=f0UjLGri193S89E3mYjLNfonM34OhMW9YPxHGg7KafM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q5v9oW8f/xGgHdjW8AQO2q8fOPynj6lwb8Qoqs5YFtVzfiPI9Ys6a3vLKCGz/HxKl
	 m8rfs1nKGIjasWKPSh7/Pn30v7L/XGD4sFk3E1rWwT1Rroy3yGvRK0ofs8M2+CsKX9
	 mZWM6p7/qCEUndqQ/N/kJZBo3Yz+oPMjNyZ8T+90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCZWy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:54:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44197 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgCZWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:54:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so8218001lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dketg2xmeCHjMWwyChFsYCLkTQHS2H7rmpcy40U5XQk=;
        b=Mz5JJuHy+EHtTW2ruQf6KS8rf1FyuAKeuMpuRqgexQnmQQXt6lXbg+bouBcIe/NI2b
         R1cEuYVS8YOPkYGJL/h8vPIKKTpgjeVLMEQKoTdrlx6KjEjvXsSQtn4JutgSGcLNu7FE
         HzaHp6I8DeDQygWQA5Xz+Ha5vDztHbTw+RVIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dketg2xmeCHjMWwyChFsYCLkTQHS2H7rmpcy40U5XQk=;
        b=G830efXa3oOG1iEvBJF9FJHW/NGvKS3EyDq41U+65NsXkldQMzzyxkdTKy8blZGDOr
         Z/R69kfc1nDqDjgUEXKIM7YUQk+/MrEdPSHkqTDuD345I1kamouGdoOx26m01gBMexT2
         qKWq57aFHPQdwWhH6wcRoreOAgyj0b2zKZ25gwI4GD8jniRbpliCeyy3pJ5vHgTvYPTq
         T6+K+TZF8261neG2v1pA3lf4u0qAQ4/xBShQp5KYzxFG4zNmqINvWM5lHlWc+/5WHR2Q
         8wu1i88H5tWGLM9X7ScigWwDcOq8T7Qxv29EwnTUFUbpDOH5LsqNbAJqoKYIEbSsxWky
         d4dA==
X-Gm-Message-State: AGi0Pub99eIlRtXLcndlS69ZggA6Y4BKxN4EB74AUpx+4FnCvuvb8TYB
        sJ3Z8iVx4J0u74botYJ1kyyt0mvahAk=
X-Google-Smtp-Source: ADFU+vv212PQ7vsEGQT6w9lLSJdHhAnK1IGi+2EwyHqdozp4ip+pHzzcl7QLGbepWFh5fDgINRye5w==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr6535785ljg.185.1585263265840;
        Thu, 26 Mar 2020 15:54:25 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d20sm2173778lfl.53.2020.03.26.15.54.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 15:54:24 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id c5so6314215lfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:54:24 -0700 (PDT)
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr3366363lfr.152.1585263263622;
 Thu, 26 Mar 2020 15:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
 <20200304131035.731a3947@lwn.net> <alpine.DEB.2.21.2003042145340.2698@felia>
 <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
 <alpine.DEB.2.21.2003062214500.5521@felia> <20200307110154.719572e4@onda.lan>
 <0d5503e1d864f2588e756ae590ff8935e11bf9d6.camel@perches.com>
 <4d5291fa3fb4962b1fa55e8fd9ef421ef0c1b1e5.camel@perches.com> <00d11cf766237d9c12c2a06458962c4bae84fa78.camel@perches.com>
In-Reply-To: <00d11cf766237d9c12c2a06458962c4bae84fa78.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Mar 2020 15:54:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3=D0uFHXFsEz2CAvFGTb8RV1KJH-eOCqR5JUQGvOqeA@mail.gmail.com>
Message-ID: <CAHk-=wg3=D0uFHXFsEz2CAvFGTb8RV1KJH-eOCqR5JUQGvOqeA@mail.gmail.com>
Subject: Re: [PATCH] parse-maintainers: Do not sort section content by default
To:     Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 9:47 AM Joe Perches <joe@perches.com> wrote:
>
> Linus? ping?

Applied and pushed out.

            Linus
