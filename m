Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4536C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7EC1206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwBRCgKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDURub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDURub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:50:31 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D886EC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:50:29 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i19so15906168ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gSTzqBizHSTlhzyjEwq6twWtVxRUF+eJqd6sBDuTq6s=;
        b=XwBRCgKPTIpGHdBwf8/eZ51DLEyl5Gjzwm3TSxrFc/+F3QAP/ao4dlNbSDGlgKsdOq
         hrBOK9muophHSApmdlc1z6wmtKMUnlRMrWl0VFivol5wUsm3IoQN5h9LEbaT+UAxzzRn
         qYq2PYYTCg+W4FTqELfAKEq7Lp+5QAMPvDte0Wy+J/ZQv+n/auE27xiIBVyuCDBQ8hZZ
         BUhIpI3PIcFh1kIwK5Jg+OZsxibh8qp1ad6hrNISG+G5a9rs0iRzyk+n//UVUEj3n0Jr
         f83E/G9eX7u5iTTameSikiUdsxSoZ2JdFEWUNPP9RRkYYuy7y/85nKTJj3VCcbx6r6pf
         tW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gSTzqBizHSTlhzyjEwq6twWtVxRUF+eJqd6sBDuTq6s=;
        b=P+RTkH3dXgoFThBJHh4XjcLRkQfc375Fe9fP5542ZEmeBcasAdmCTV2eo3PNCuC0S8
         +7BXJJXyM/e3cOYdW5u99s4TiC1icwaWSnv7CWYh9kYwhczK4Xp6g+0UjxQ+BL0QWaWi
         4/JiZa7zqokg6gL5nOaDQ1fytZIB9ankYFqq6YGIXyG6i+w+T5LuRtbgdHVi7lErCGAT
         mK/I99UZtr91R6zMgshs397QIWBQDsNNoFF0LBMFAqV9VeMoR8cdqyy9AbGaXLlmqK+k
         SXAegAvn+5XImOaGs07W95yoyGLNAkkd9BeybpOPMJT56BYhWL65tvtq1+BvaGMmOVUJ
         Bg7w==
X-Gm-Message-State: AGi0PubXWTLW+paktBZt9XcFHkqucxpRCqnc0zxcl+W1t3fiX8ERHJUL
        +sESsaNbA0++uKTe0ee58+FkLOpMvwHn+rbxpyjLe4/TMG7HuA==
X-Google-Smtp-Source: APiQypIqhtP8sp5F5Lx9cNRvBG3m8VENNQOatt91bbZtafDKxjpNYRTDPUIpQeYN5fqOPyzN2omXyRiEJD12tIldrko=
X-Received: by 2002:a5d:8613:: with SMTP id f19mr12105062iol.173.1587491429103;
 Tue, 21 Apr 2020 10:50:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a58b:0:0:0:0:0 with HTTP; Tue, 21 Apr 2020 10:50:28
 -0700 (PDT)
In-Reply-To: <20200421154928.GU20730@hirez.programming.kicks-ass.net>
References: <20200324160924.739153726@infradead.org> <20200421144714.12479-1-youling257@gmail.com>
 <20200421154928.GU20730@hirez.programming.kicks-ass.net>
From:   youling 257 <youling257@gmail.com>
Date:   Wed, 22 Apr 2020 01:50:28 +0800
Message-ID: <CAOzgRda_dykZ1NU15scNRnx3VQunWKSgbD7A+CWw5mZheNQbhA@mail.gmail.com>
Subject: Re: [PATCH v3 14/26] objtool: Optimize read_sections()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux 5.7rc3 will fix? please submit the patch.

2020-04-21 23:49 GMT+08:00, Peter Zijlstra <peterz@infradead.org>:
> On Tue, Apr 21, 2020 at 10:47:14PM +0800, youling257 wrote:
>> this patch cause 64bit kernel build failed on 32bit userspace, please
>> fix.
>
> You've now spend more time and effort complaining about this than it
> would've been to fix it yourself. The fix is absolutely trivial.
>
> Anyway, I have a fix, it'll get there eventually. Excuse me for not
> considering 32bit a priority.
>
