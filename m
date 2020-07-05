Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A148EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 01:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AC120772
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 01:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFuRg+vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGEBsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 21:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGEBsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 21:48:12 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275CCC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 18:48:12 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id m9so15836609qvx.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 18:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/hu7y+yOVto4nrricqxCwZMyinp+RJJtA5lqDBHvZLM=;
        b=hFuRg+viDUZb/6bmXvHocd5SwCcq55FBed80YkLVNAz8j6R105QysUJJF0PhLuoLYY
         JylHF+DIzZt8rtH+ltu0jfXY3d/SRP0Q4MJ2JfrcAare0spNdmbrR9YQh9QVdwgLSYQ2
         Zq8VtpUwwR1roiM8+oDOkqfKNPvpBv397QQD79GgYbgqM69W5bnWsetmQhk01yi6PtpH
         QXP4SmcvjooFQl5CanghdrY0f9LReP+vER4DNFUBOwOpsb4GPd4FFVZg96rWbUXXEyae
         nSrtZp+nSFa83W3eCAbOgKptuuSvAAr5LSA/1G1j+ZdtDzRTb0aEaewhG+6T55t9z2xB
         NlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/hu7y+yOVto4nrricqxCwZMyinp+RJJtA5lqDBHvZLM=;
        b=UTbhVd/vEG2/LwoRFbXMo77h7OGL2ri8adv1MPexxZZdCGkf2GIIoN0pIqgsu3XaJY
         +QS/MhdWW6hew/qjamSLlvljlQEgSR3ZWdYaQQ9xpYRnxJ9QHIetoXz+WkdERYQl2ogm
         Q3JtT/eiHh7zynhuWG9hfqNKJutCpQOEYCTXegwknqe50/xJZCiqI5C6s14FCpKA1apM
         vswqRDZKFNKLeE6facygX7GQdjF0vPIKcRY/tdYYwAST0dAQvknRoTuqzEl8LNyGajVm
         p2VBCJF6QBjoD44RrP0TT+Jb66HaAo6HZLRYf9mr7X28qAbcs9NbJSIL+F/g6O204MVp
         GDgA==
X-Gm-Message-State: AOAM531pz9d8DR+2itodBix/c7F0x/DqD3hZuF7oqRvFnhWS9vEhaH6Z
        ygnsK77FNDkSdS8H/hA0AxLAM/TetqonTwHCZQeb4/43/u0=
X-Google-Smtp-Source: ABdhPJzlVof7X6aF7gFmqI8yxfGBsllRbWPLQpAvcs5VZVEXH8YULSfubB9CL0qKOHCHiNgNmPhMmuJsQNqTOAiLiKQ=
X-Received: by 2002:a0c:a8e6:: with SMTP id h38mr35506999qvc.15.1593913690134;
 Sat, 04 Jul 2020 18:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
 <20200704122222.GB15530@amd> <CAAvDm6bjTzcRXs0qMF2nTo_mfEDE1MYbh_ExMojOMNZ9H+iKVg@mail.gmail.com>
 <20200704200923.GB24405@amd>
In-Reply-To: <20200704200923.GB24405@amd>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Sun, 5 Jul 2020 09:47:59 +0800
Message-ID: <CAAvDm6ZYh7wirQx4QQb13js5VOcK8BcHu_0e1zAQyO+Y2xrk9g@mail.gmail.com>
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg KH <greg@kroah.com>,
        kernelnewbies <Kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see. Thank you .

Pavel Machek <pavel@ucw.cz> =E4=BA=8E2020=E5=B9=B47=E6=9C=885=E6=97=A5=E5=
=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=884:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat 2020-07-04 21:34:36, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong wrote:
> > Thank you for taking the time to respond to me.
> >
> > >These machines are still mostly IBM-PC compatible, so it is likely to
> > >somehow work. You'll likely get worse power and thermal
> > >management. Try it.
> > It's an industrial personal computer with an Intel processor.
> > What I am worried about is that it may damage the hardware.
>
> I'd simply try it. Risk is really quite low...
>
> If in doubt, you could ask vendor.
>
> But you will not get definitive answers on the mailing list...
>
>                                                                         P=
avel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
