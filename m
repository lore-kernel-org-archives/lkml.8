Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BC6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4862073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owwok9nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgC3N2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:28:33 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:35153 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3N2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:28:32 -0400
Received: by mail-pj1-f47.google.com with SMTP id g9so7325655pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBCKK13T41q3QG0TppGXO2lZGhQh6qelUIiSqxBjEqI=;
        b=owwok9nnTm2h8HjCzP3xGyehqOa/D+rKX7q4nWprRdggtnJb5k4WbkW7j4YGgTAr+M
         e+EpZs3JBoKipKK6VzoGzFYfOBzGqUVKrAHFaAkMPzoq5zKgZh4XKY/iSydLHtxGYVPQ
         pkydDsz11PnPj0PAfpf1EJUESjnQbcOrM8+t9X0P3Tj+tHQ5eLx98f94ryTAs7zqv8Q4
         lBQl/0pcMhjnmKlmqBVFWMfX3HGM0DVbLgRm+yRbgrOBA6n+45u4s4eGtd8gJzk27CyO
         nVGveG0hva5lKioQ8b9ZoYzU6GFsUduRVHG070E1uGf4+2x+3d9Am3TU4hYJEtM9FB0W
         S2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBCKK13T41q3QG0TppGXO2lZGhQh6qelUIiSqxBjEqI=;
        b=A3iFfcxX/bKgX+m2+V0ykCJfQ7x4r4AfUzETVamxn3HwIS8ZRIggqEIPJmwrf3WfUH
         OAMUq2wEb4RtjoVo+J1srfzaeOubwsnc0hANI1sTYG+qpj9XSD/+Db2Xo6J9ThdwF+Yk
         GC9ryjVj/+ClHLn0YDkFBU8e+1yzb9X/l/4xZ4/jK6w0FwkiWeCtfQZRnhOv1sqa07qv
         b+ewTLcAXqlL6yNgmx3dlDZFits8eYUMNRVaACVgXXbn9+cSvnxA9mn3GYMnJPOjNk4g
         nuFBhKX+Q2DPnC5FwS99bJoLDFUYl4Qp9Ct23Un3RSxftX4HT5DEIMtjCpmQPiGuK3x9
         qxnQ==
X-Gm-Message-State: ANhLgQ00ok40uIDsPdQWMK/PlJAe4ub7EkoeA4SUuO86RBV6jzpVVR61
        4rnL2y2YB1JyWhvaYaXnLrPoUPfVfKcpQBBTxiM=
X-Google-Smtp-Source: ADFU+vuCxvBKRdQ2wcv7fCD7lauMynN9CQZU+vWb3ZPwxC5L7KH31wswhJV8W6PoJtrvgXXul1Gjk/xfZRgMPz96J60=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr16021231pjn.8.1585574909737;
 Mon, 30 Mar 2020 06:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200330085854.19774-1-geert@linux-m68k.org> <CAHp75Vc1gW2FnRpTNm6uu4gY3bSmccSkCFkAKqYraLincK29yA@mail.gmail.com>
 <CAMuHMdXDBtOo_deXsmX=zA9_va0O5j8XydxoigmS35+Tj7xDDA@mail.gmail.com>
In-Reply-To: <CAMuHMdXDBtOo_deXsmX=zA9_va0O5j8XydxoigmS35+Tj7xDDA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Mar 2020 16:28:22 +0300
Message-ID: <CAHp75VfsfBD7djyB=S8QtQPdKTkpU5gFzyRYr8FshavoWgT0CA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.6
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 4:26 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Andy,
>
> On Mon, Mar 30, 2020 at 3:08 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 30, 2020 at 12:00 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > Below is the list of build error/warning regressions/improvements in
> > > v5.6[1] compared to v5.5[2].
> >
> > >   + /kisskb/src/include/linux/dev_printk.h: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]:  => 232:23
> >
> > This is interesting... I checked all dev_WARN_ONCE() and didn't find an issue.
>
> arcv2/axs103_smp_defconfig
>
> It's probably due to a broken configuration for the arc toolchain.

Alexey, do have any insight?

-- 
With Best Regards,
Andy Shevchenko
