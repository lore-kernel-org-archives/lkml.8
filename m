Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75E5C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A82820733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581278829;
	bh=jM+dR0LMqymRcT/Xwfr3Fdh6cO33LSy5UIi+NftrBsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gn5CGzHnNY/eA+g4I+CJ3uCl1eWrAn7LIaI8ggGFkS1zzlg4EDlLHInB6M9x4i1j1
	 XtqU04y6DzLD3jWAeKEonGsspaxk982/f2Ng7MttSUv9iA2GDOWSbomNYVXPUjiWo1
	 lc82H0gT22naoGWg/13X8+EkW4Da8PCKMbTiQNZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgBIUHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 15:07:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41806 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgBIUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:07:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so4712066ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 12:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqkAOwU05UON4/2tM3Mm2FBB11Kh6mbQkKkZsuuJoAk=;
        b=SJ6Llb/q03yekoiDXqo0/Fb9wCK4/wepkgs+HBkTFxFClv0ZqkdI+TEOXtmuGXk7aM
         4H9xi7FR6lYiPK38/Oj9VwGy4a4rIc97oXlnfuzXiM+d5RnkelOGbqzJfL5D4b2iNoRt
         f0hGoO04FaLUBr55zVIhEiK7UlEVh/ze2PVDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqkAOwU05UON4/2tM3Mm2FBB11Kh6mbQkKkZsuuJoAk=;
        b=iIPTVTmz1FMvSfl6+W7Xf++TWJQyamKKh+rZYB4ffcBJCGiQmIi2rj3sNL0mC+jJ/w
         URZ4wQpdoa6nYV4qQGFdIE9rYtcLyl/jQzpN9c0QOZlNV1q+0M0ioSU+izlWUzEl86YC
         z2w0v+yYSn60rRVx6YBEr8RsrxvTXYjmNkVyCmtS0uxB5IMEOUrxFf7C/24QA27WZSqu
         YDvhPyAuMvVK938EyGYKKsKpyyJHFCs8zPzmxfCGPvp7tyN7fThz2r9JDlZHFi5xWWXK
         BLCp+CaaAd0OejXJALbPMzXM7bq+AJXr2Fn6JGJM4OO1JMHSh8f7DbRq2PDVB63owKsw
         mKsg==
X-Gm-Message-State: APjAAAUME86dVbFcPbJNA0KFm3EtvYBvnTrlMzaU4mRVZYuqt4dWwPds
        tAbIt4e39HVjDuhUmvsuj4C7hfushcQ=
X-Google-Smtp-Source: APXvYqw0GqziZotfYwlH/qF4Q7UZa9BUxPEoy/KMXeYSLyb8MA5VXN6UYcQx6k9N7CgbqspJHF6v5w==
X-Received: by 2002:a2e:85ce:: with SMTP id h14mr5858551ljj.41.1581278824566;
        Sun, 09 Feb 2020 12:07:04 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id u16sm5083054lfi.36.2020.02.09.12.07.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 12:07:03 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id x7so4766736ljc.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 12:07:03 -0800 (PST)
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr5865848lja.16.1581278823207;
 Sun, 09 Feb 2020 12:07:03 -0800 (PST)
MIME-Version: 1.0
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.3631526665331853849.tglx@nanos.tec.linutronix.de>
In-Reply-To: <158125695732.26104.3631526665331853849.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Feb 2020 12:06:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEg6+j1UuRSAZmXozJEw0p33gM9uPT2oAOFwsOUaa=uw@mail.gmail.com>
Message-ID: <CAHk-=wiEg6+j1UuRSAZmXozJEw0p33gM9uPT2oAOFwsOUaa=uw@mail.gmail.com>
Subject: Re: [GIT pull] perf fixes for 5.6-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 6:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    - Prevent am intgeer underflow in the perf mlock acounting
>
>    - Add a missing prototyp for arch_perf_update_userpage()
>
>    - Fix the perf parser so it does not delete parse event terms, which
>      caused a regression for using perf with the ARM CoreSight as the sink
>      confuguration was missing due to the deletion.

You've started drinking too early in the day.  But hey, I guess it was
evening _somewhere_ in the world.

Pick out the five speeling errors in that pull request message.

               Linus
