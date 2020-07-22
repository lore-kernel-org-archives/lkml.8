Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE315C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EE720684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="WxmbK4zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbgGVUWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:22:10 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2450C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:22:09 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id v9so1664592ybe.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QkphWxYyazumKClniN3MUn39GFFNV/nqPhj6OvEhnM=;
        b=WxmbK4zLKLPTSwQ1E7baf6yDcVLqwcJsyAhxGJR3HqQXrPyLqw80Ilsz4CmV98R3E3
         ykXnZbm22OEkV71kwSuxesfswDStT/W7VQsHh5BYN3mqSpnl92ADXaYVTEkA50YlrJBx
         eX27OG4A5GtogpwQqq9cNK6uhUCwa7ltuuXg6YBp1Vn8HrJAevfa13SL064Y8IjVi2AV
         x4VlSbu6eFUXR0wtXKPl6ISo7KiWovLNe00yv6GKSB754nY64cFgkTIhKunjaXspBlgE
         zkMsHCKN1X0eajnW2LMh7Mq03QC9Tr/Quph6S4ULRkZF54a6Ug93P8sOt9asK5HNUTkX
         /9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QkphWxYyazumKClniN3MUn39GFFNV/nqPhj6OvEhnM=;
        b=S5k5vS3sDBS023Qa1VtsPCgKlkmObIAqev5Qg30Sa5cW5Q8cQp1C6d8WPPiURkpZLa
         1jw3YbkCycyTTenpFUyAiiq9Mlo50A8lJoPn4G5l5Nu1+6YfcHOppICAxRMdGyscyoeE
         gg4AR5CzQlkwaW84VNMFfETQozcbTjzUCEKWgBIicP14gd7D1r+fMKeYOlAiljia/5Ht
         FXIPiHBXw2xkhZtUqJAo250LdUuBo8+AZj6NW9dm7vhKu5xT7k3/yPqozZTwS3DDvGDL
         Sy8764+FAiUv3IlZFVrnF1v04cylcV+mSYk5GBhGA2v9IkwHD3GCHwXGfXw2BH8oLEtN
         9aUw==
X-Gm-Message-State: AOAM5319G/3FonNvQW/9bSHrJsZMqNHJQz5srzv7wSD5TKY/XH0zUw6G
        8RCdU0I68pzFIa3XkzwUitr/+7LLP2g7eTkZ45WDYnAQ6RYPu8iV
X-Google-Smtp-Source: ABdhPJwzOAVu8VbvSYiVCfE5fyc/hdk3WFhsSAt26VME4J8FZBKqRr512J8/MfvNYYd0oO8b8AzGIYGc9Pk1gR6M8+c=
X-Received: by 2002:a25:bb0d:: with SMTP id z13mr1566548ybg.488.1595449329066;
 Wed, 22 Jul 2020 13:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174654.72132-1-vitor@massaru.org> <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
 <202007211911.666E080@keescook> <CADQ6JjUgVXBfHfb=V2ajwm=rHi12rxiqEtpivjY03xZbp6k7wg@mail.gmail.com>
 <202007221244.4E3C9E45@keescook>
In-Reply-To: <202007221244.4E3C9E45@keescook>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 22 Jul 2020 17:21:33 -0300
Message-ID: <CADQ6JjXmXnHr9O1q3h5smVosvffFByJTtr49P7H0eT9A7+0pxg@mail.gmail.com>
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

I will check what can be done.
