Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BABCC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054C9206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItnsYShc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgC2VjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:39:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC2VjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:39:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so18856617wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+YFamD+rk3pGnPVsQCdZ4BWzaSDaazUq7GaLMAvAmQ=;
        b=ItnsYShcZm6ooRrKDOeQxLDzvFUEHhf1luwCKa2jXLuYMQLHD3kRPw9TDOJUY05WFA
         BRfkFkmum2aCG9ZfEepcnnnx1PQEsgX8YpLDsnPP9PYEPGwbgncnlFls1GUQVQTYM4M8
         wiqvgw3nuQcSK5aIJD6biTbwJu6aV9VIm+7GCMbV/5A/b06Ho0OJ4VcV2kD3mJyjCluc
         x+jmHy/iga9z0oabN/uuSn1uL/CJtvK5d/r40NG+ygCU0vsOmVXZt7PdTFhu+sj002jn
         Z/wj1hZgO9sxhypOB/UjppXuN7X+vOLQsa5lUiU/Fn6/w6jGI6YmEWngNVItWEj6Of7p
         fOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+YFamD+rk3pGnPVsQCdZ4BWzaSDaazUq7GaLMAvAmQ=;
        b=p+03oSnC4sQTfT7PI7WlJng9mH3mUUYKQtRCale9oNByDG9unQDLPrQJhuSv8ShRfv
         wHG8cgakbLsY1huN9099xK7UN+976Ij3RJiBc9BwMclrurvoXAXxKqfSjUEKvv8hwi2x
         XBnxTF+Tp4EjBKenTWmYi/D3T09k3NR1C835f5qEiLTYSZS188Pjes8IeJ2n+s5jkwv0
         ynZyCjwdg9+f1/MnBsV3b3TAeM/QWdEk0LEa87ZAbYPsWAUOpHYN1X5CXbr7DvbAI+pP
         Y80CWeif8S86+DZoO2DOFjdDglZvRto6OiX5FTUegZo1GcH5fVYXcLqc6U+26U3LmdCj
         NfuA==
X-Gm-Message-State: ANhLgQ1b3ytI/ewCbL1dQPZOd2wv3MXRv4kyxmGwM1FTcPK+2NZQ0f1I
        3EIhIpdJh1vf0gZRk+q6xZDvs+QvxiCOG2ZocFU=
X-Google-Smtp-Source: ADFU+vu8292N+WSo2qX5+fXRx0ukzJleSgC0ZJHbXVoT6wC1iH/8UAVErvplccBL52nDTVHlBmLC0/+L4LQJg91oL+A=
X-Received: by 2002:adf:9384:: with SMTP id 4mr11351603wrp.214.1585517944701;
 Sun, 29 Mar 2020 14:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200305183939.256241-1-davidgow@google.com> <CAFd5g45XJLXYfXB-FJhFYnBYUdqM4ztC=p=Akj3+GbHXfHxzgQ@mail.gmail.com>
In-Reply-To: <CAFd5g45XJLXYfXB-FJhFYnBYUdqM4ztC=p=Akj3+GbHXfHxzgQ@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 29 Mar 2020 23:38:53 +0200
Message-ID: <CAFLxGvw6Sp899NN3CMvC4R9Uz1dSiKw4mdwnKRUvnGg-mr7ttw@mail.gmail.com>
Subject: Re: [PATCH] um: Fix overlapping ELF segments when statically linked
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:24 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Mar 5, 2020 at 10:39 AM David Gow <davidgow@google.com> wrote:
> >
> > When statically linked, the .text section in UML kernels is not page
> > aligned, causing it to share a page with the executable headers. As
> > .text and the executable headers have different permissions, this causes
> > the kernel to wish to map the same page twice (once as headers with r--
> > permissions, once as .text with r-x permissions), causing a segfault,
> > and a nasty message printed to the host kernel's dmesg:
> >
> > "Uhuuh, elf segment at 0000000060000000 requested but the memory is
> > mapped already"
> >
> > By aligning the .text to a page boundary (as in the dynamically linked
> > version in dyn.lds.S), there is no such overlap, and the kernel runs
> > correctly.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> I can confirm that I am seeing this problem as well. (I know we run
> the same Linux distro; nevertheless, this is a real problem for some
> population of users.)
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Applied, thanks!

-- 
Thanks,
//richard
