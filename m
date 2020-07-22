Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EB3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC6B22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="fhWMlcxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgGVW3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVW3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:29:19 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3BC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:29:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id x9so1827020ybd.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDU5F+lKnx2jbAbcQ8EdWpqtNDoD+1zrWyM5bAIpN5w=;
        b=fhWMlcxqko5jvxwun7u9Uh71irn2Il2ZaOvNhovugAKiQoGmJ9IDiPrToHA8cjDMRu
         x1VrYa/E0VvPZoA+NaZhZXbLqncS8YhFZHpYr0fz0yhxXm9p5ySMNW38C59WR90QeHIN
         kWZ4lbpJlxdBM/tAzlp6Aj4Twlsi8M1xoZanH3IeoZa029h5A781Eq8/2XYuLuPXNnUZ
         r/RdyDA+lFa6N7kQAAG4rnbsYAyFVjv9fgJaUVY06JmjP2AsOflm13HWTc3BgsiQLiG/
         t3SwYffYY1obba81noPsvPY03PPzwOCaRAq0ZEtJmkURsIdWLd/Lf5moo2ds+3peAf40
         Zsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDU5F+lKnx2jbAbcQ8EdWpqtNDoD+1zrWyM5bAIpN5w=;
        b=EgZ+4gCtV4RmLY2vMysFs0CZ4OtweDfJpr9bXRR0W48WTQCutJHVhgLbdnr4Svt3Ww
         GJtug6WjD/WEc7nPdJImSqVZI2CmY059ZHuP6SrBn12tznb61plHYa/Zi/OgUVvAMjfI
         8Uwlu74jmivnOd2sZLyPpHZR6Lz8JnLd0NbL0orHhtJ/Htqu+OIbnIG7r2K16JdkaUbY
         2RD7RWRvlbM/9K8nOAk0nFP5F475YnBplRZxymAEEqLO6ri2HfXzNHT5JshhWYjuqi0P
         V8psdtivxSz//dxqdB+F3wS8TAaN2sHtlqkSWOeVCbO1a0rN/qaH5KzO56Lb9U/iFUXf
         JQBA==
X-Gm-Message-State: AOAM533b0+QJwQ9plYAA/nQY+SGRUZVkQrW7uLngdxmcULxZx489+DfL
        hZIRmiCH8fFh4WDG8MNlWYb8vP3C/OCuYKpb2vMSdw==
X-Google-Smtp-Source: ABdhPJyLKRl2cLOz/lGg7WJPCuMu3otLZQXrSRuCWupUdKjm0eoPDEEAPrS2s+m18HN0tAIQub01+IJfHDQ0XRTs6cM=
X-Received: by 2002:a25:ae01:: with SMTP id a1mr2350192ybj.119.1595456957139;
 Wed, 22 Jul 2020 15:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174654.72132-1-vitor@massaru.org> <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
 <202007211911.666E080@keescook> <CADQ6JjUgVXBfHfb=V2ajwm=rHi12rxiqEtpivjY03xZbp6k7wg@mail.gmail.com>
 <202007221244.4E3C9E45@keescook>
In-Reply-To: <202007221244.4E3C9E45@keescook>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 22 Jul 2020 19:28:41 -0300
Message-ID: <CADQ6JjV8cXsEKX-Yn2udhnZgJQWkbtS4XL+yaRzfydaWV5EbSQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
To:     Kees Cook <keescook@chromium.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 4:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jul 22, 2020 at 03:29:27PM -0300, Vitor Massaru Iha wrote:
> > On Tue, Jul 21, 2020 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Jul 21, 2020 at 07:19:12PM -0300, Vitor Massaru Iha wrote:
> > > > When you talk about end-of-test summary, is it what is written in
> > > > dmesg and not the kunit-tool?
> > >
> > > Right, if I build this as a module and do "modprobe user_copy_kunit",
> > > what will show up in dmesg?
> >
> > No, It doesn't. I'll put the messages again.
>
> Would it be possible to add that behavior to the core KUnit output? Then
> all module-based tests would include a summary line?

Nowadays with modprobe this is shown, is it necessary to add anything else?

root@(none):/# modprobe user_copy_kunit
TAP version 14
    # Subtest: user_copy
    1..1
random: fast init done
    ok 1 - user_copy_test
ok 1 - user_copy
root@(none):/#

>
> --
> Kees Cook
