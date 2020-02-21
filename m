Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E0FC3565B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329C5208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582313211;
	bh=i4tSZk9ITG7rehWj5qDLAA1gX11ih1LCCMUT2wDKZ4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rJq3sHw+fcWT1P1qcmsWKJ28dXdEFEuu2aafrnhoWBNTrRXzOMy9PwkINOdyf4C0O
	 j3ZExQAm6eKZh55paFG0UU9VWEtYN3u8/GTI6Hh5UQbegqPaijWKsZm9jCUiroD2XV
	 pDy0Pz1NYufm2KaqBLMxHWor+uiugHnpe86qBIK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgBUT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:26:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39893 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgBUT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:26:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id n30so1486215lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dySq1l3asr1HRFdBoND5+/A1oxOW8lUHSK+OCHfNPcA=;
        b=equBr8Zes6R6b4rIEzwkzyJRJj85yEFZ26p5vYyReOS3ME6RWlBTWy9VGIlLMUnpUO
         z1IhW/3DdktZWYIDolZ9Gt29wooAukLmK6Msln/B0PjQp9OpY1QqxN7yYIfsYKTngNLH
         +AupZ4Eiah1/lhSBwy16fcgaZwAeblakPYzQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dySq1l3asr1HRFdBoND5+/A1oxOW8lUHSK+OCHfNPcA=;
        b=P0yp27ZSd8H9nEt0I+0uvGYAyaJVU/HHE+5SyCRFpawRMcrlsoUh38n9eCBPEOQ5yg
         SmX7ZxkdtEUT94+ZjKAfZUeREZ3doailZoBAWqxBTfIFvIcn3QAqmCX1l26gYXd+f5Oe
         /n0JQ2d05hnrfBgpw/L9oNcIWLYThPKS3ntYozSFzKilrSkKd1daOU8RL8jxp37acTWK
         8XtUodp7v1uVIVSHgOHuCVOYygX4X1e99PKrs62Tw8ewUTVkKFHFqlytHQMHkJmxtXEX
         XYGZy/tvIzjR8tYOhOIoZj/UU8S98Ky8DYBo8wmtYgJPpELYZ6X7sKj4rAvdVQ4AiY2f
         DBlg==
X-Gm-Message-State: APjAAAX1kMJ3Afr3zZNLLN4H1e0dcIDUW7hx+T64GMgq0a4RjwqhkEt/
        2BpWlk1KTC1LJAaGzPeqIdEfLuEuJg0=
X-Google-Smtp-Source: APXvYqyzJARvfyOb4ta0TZ72VnlvBg2+HtAdyj+FtDwmSltkvRM7DUajDnbYj8EzQJCvefyiEqPfyw==
X-Received: by 2002:a05:6512:1106:: with SMTP id l6mr5611340lfg.147.1582313206981;
        Fri, 21 Feb 2020 11:26:46 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d24sm2095404lja.82.2020.02.21.11.26.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 11:26:46 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id z5so2262899lfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:26:45 -0800 (PST)
X-Received: by 2002:a05:6512:687:: with SMTP id t7mr21192197lfe.30.1582313205540;
 Fri, 21 Feb 2020 11:26:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wi4uO+Djqr4Jc1TnCofwxUTuXHtgkgwnVX86q06UGV6DA@mail.gmail.com>
 <6A09F721-0AD9-4B86-AB3E-563A1CF5ABDE@amacapital.net>
In-Reply-To: <6A09F721-0AD9-4B86-AB3E-563A1CF5ABDE@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Feb 2020 11:26:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com>
Message-ID: <CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com>
Subject: Re: [PATCH] mm/tlb: Fix use_mm() vs TLB invalidate
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:22 AM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
> In this particular case, if we actually flub this, we are very likely to =
cause data corruption =E2=80=94 we=E2=80=99re about to do user access with =
the wrong mm.

So?

IF this ever triggers, it has presumably been around for decades.

Nobody noticed.

Adding a WARN_ON_ONCE() means that somebody will now notice. Good.

Adding a BUG_ON() will now possibly mean that the machine is dead, and
is not sending the bug-report to anybody.

It's not going to hit, of course. But if you are 100% sure of that,
then it shouldn't exist at all.

And if you're not 100% sure of it, then it's going to be in some very
unusual circumstances (possibly some odd driver subsystem that does
something completely wrong - wouldn't be the first time), and the last
thing you want to do is lose the information about it.

So BUG_ON() is basically ALWAYS 100% the wrong thing to do. The
argument that "there could be memory corruption" is complete and utter
garbage. See above why.

Stop it. Seriously.

                Linus
