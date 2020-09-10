Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B07C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D1F2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjfemp+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgIJIfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgIJIR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:17:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BEC061573;
        Thu, 10 Sep 2020 01:17:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so5650732wrm.9;
        Thu, 10 Sep 2020 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaysBjo3KZrd9FBnUcwdI4JKq5Yt14xiu3B8psulRlM=;
        b=kjfemp+VNTMGsHZxkjtJRSKFuiPlrPfQDmz1s+MKrr3xY8MdV77+CvSgWrYug16HSo
         6YP+RY+FZ6zlV15qC/k/XKpMrLql+2VoCxwV47cZIpJrnAVzgX0vkshSDj8BBogBfCIP
         HhdWq9nFd+IUD9cjwLETnQ5llc4LUnNQzQ/kZp1rCJNfAIhaSi5hehE0VC23UWMIxCB+
         us4lYm66jMUKbJsoVS+uFLl1ybNuTx8rc1M9Q8jBx9CEu4oLKe77B/8gOXbpiYaP2DRx
         ncPuekMPpbf2/UOrHLUG/vfz2ZztrnDXDNIQusHS5jAE4e3cNhN/JJbqpi9UkDJA6isd
         Caww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaysBjo3KZrd9FBnUcwdI4JKq5Yt14xiu3B8psulRlM=;
        b=FU0cR5+/Gvzb9Lp7Yd5RZsLhEbv8yD4e22abSjxGJiwQgEEuwwdT9NATlhQXKQQSb2
         XoKqc5JV8+ZNgAuggIIEo3I7SFVlBJYhgTw03gMwNxs4fxsIAVcL8kBc/KwSxdSvXuDr
         avupZgUSs4+ibBxTcOmZbyfQWazAlmMnM/1FIflminZ/tdEh6l/ahc8VMLn2Sx56iOJ+
         qrFT9WKCHlC+k2Pc2v2XnpkczwbNGX/aBAof6SBOy9gzGvAEJy1hrNJh/a/tNqGYNkHE
         BFGAvtWxB48n25y9Wb9XC8hVOZ3KRlp2cgAlvxggP5QNm1dos5aYiBGzfNrcAr2fW42V
         2Jcw==
X-Gm-Message-State: AOAM532QsKS6qidRv628SHbR6k7Jk6kFQpORvWPjk0W4UIJvywiZxzOa
        2o/YnRrJqSW7mDlHY2tJuNM5Qg8UoJyNppTE7uc=
X-Google-Smtp-Source: ABdhPJzuhLpB5TWTdjTNI01SJu/Gs4qQrY4U4wtzMXMZT10tTCt2zpbB4K0zo62ieKUBmeEA3Z3qB8t0hg6oHWtp4oQ=
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr7764796wru.329.1599725875970;
 Thu, 10 Sep 2020 01:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de> <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
 <20200910080850.GD24441@localhost>
In-Reply-To: <20200910080850.GD24441@localhost>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 10 Sep 2020 02:17:44 -0600
Message-ID: <CADvTj4rDdj8KtLhGZEZP+XZcF4DTE4oW9sNf=zNWaRPzkny93A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Johan Hovold <johan@kernel.org>
Cc:     Lars Melin <larsm17@gmail.com>, Oliver Neukum <oneukum@suse.de>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 2:08 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Sep 10, 2020 at 12:33:55PM +0700, Lars Melin wrote:
> > On 9/10/2020 10:02, Oliver Neukum wrote:
> > > Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> > >> This patch detects and reverses the effects of the malicious FTDI
> > >> Windows driver version 2.12.00(FTDIgate).
> > >
> > > Hi,
> > >
> > > this raises questions.
> > > Should we do this unconditionally without asking?
> > > Does this belong into kernel space?
> > >
> >
> > My answer to both of those question is a strong NO.
> >
> > The patch author tries to justify the patch with egoistical arguments
> > (easier for him and his customers) without thinking of all other users
> > of memory constrained embedded hardware that doesn't need the patch code
> > but have to carry it.
> >
> > The bricked PID is btw already supported by the linux ftdi driver so
> > there is no functionality gain in the patch.
>
> I fully agree. This doesn't belong in the kernel. If the Windows driver
> breaks someones device on purpose they should know about it, and *if*
> they want they can reprogram the device using the tools mentioned in the
> thread. But the kernel shouldn't be playing such games and reprogram
> eeproms behind people's backs.
One of the main issues is that this issue is very often not-obvious, FTDI
specifically designed their malicious driver to make it appear that the
hardware failed, they intentionally do not provide proper feedback to
the user when they soft-brick it. I assume this is because they want
to push the support costs related to their malicious driver onto the
integrator rather than themselves.
>
> Johan
