Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CA6C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60522146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjigAAWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgCDKZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:25:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35589 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCDKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:25:46 -0500
Received: by mail-qk1-f195.google.com with SMTP id 145so1039244qkl.2;
        Wed, 04 Mar 2020 02:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vs92E6t2iJuDEH9h/ywUF++j9tfXcW1XKQ/oXX/xo3Y=;
        b=RjigAAWugnyIHTLiOk0B/tBTJhPYm5ficMzYvrryN0hWII15MfwhmtNWx1FR3JrZz2
         l44Lf9ONnMlrXypxK+2A/Ipxi9Psx6iNOBiQVbEV6/zxDgRkOl01SeknItPWeNiklsGK
         PQ78VQQ68xU+JcYiBvYgMpfY1n7lo9TdDwU5hBlDbzKC/whO2AkL7RcP1xOJz+W0fZO/
         Kev19kXp4Gpdv/6MueV44cVJ/hUnqZPnO8HRjvnbEmAqpVZ4I4ghfEZ8aCdwNjSAZc7C
         bo0ulzMJYScd3LnoTj/uXSkt87NSxRrzonQAmQqA0lh/k7XpDbErPVTdebGipuDNv40o
         rT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vs92E6t2iJuDEH9h/ywUF++j9tfXcW1XKQ/oXX/xo3Y=;
        b=IcAGkh1S/5r7rRH43IaHFNlNgsMJR/c6gv/OKb16ldeyCNrxultGvllQWQcmImq1Kj
         04LgOboxt0FE7K1K9/zDVf8K7g3/i3ZJmPBVjvVys4+4tZgAYc7W9d/VCfqvttTvwESV
         YhL38bZXCnQNeQWmqQs7fNmhEDSJt5kh0ZEp/WAIPN39VZrLU6ILdBia3PrhDCfmx/8t
         SE3Sgs/hp0NgqrTg3hMelhHgnuo2uGVmuuYPd+OchcF+3FTFUzvRutomAJj5ekEjR0iN
         1lcXLemdABwPvt5se+qMXLapSgJN9PT6W06VYjYxe+gwKh6NgifCxzgUy7PvjBdt0rbI
         zVrw==
X-Gm-Message-State: ANhLgQ2bAfEgTMSPuBcIl2joWge5t9pEtwTBaE78odEzJEww0d5ZKrti
        JRi3gnUqeFOt/cTuYeOkoxBQsmHEseVpQck58wo=
X-Google-Smtp-Source: ADFU+vs813/fagg85IoeT76Lq/3A1ZqT+Mq5gua/L+5xcvfreaqLMwonKgzuWMQ+Kjr6SLEw2PgaETteOwKeTmKx6wU=
X-Received: by 2002:a05:620a:13b5:: with SMTP id m21mr1994448qki.469.1583317545844;
 Wed, 04 Mar 2020 02:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20200205001116.14096-1-chris.packham@alliedtelesis.co.nz>
 <20200212215200.GA2367959@kroah.com> <CAKcpw6VczRuMC_KRzP6VRPeZPtmEpVOJE5Fc+JhDH4mWU7jUVg@mail.gmail.com>
 <20200304063910.GA1203555@kroah.com>
In-Reply-To: <20200304063910.GA1203555@kroah.com>
From:   YunQiang Su <wzssyqa@gmail.com>
Date:   Wed, 4 Mar 2020 18:25:34 +0800
Message-ID: <CAKcpw6Vt1wUGcps2b86YGU8gGijvKTa6ERL5F1Nk=utaJyz+kg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Re-instate octeon staging drivers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Paul Burton <paulburton@kernel.org>,
        linux@roeck-us.net, linux-mips <linux-mips@vger.kernel.org>,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ralf Baechle <ralf@linux-mips.org>, dan.carpenter@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B43=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 04, 2020 at 09:48:46AM +0800, YunQiang Su wrote:
> > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B42=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=885:52=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed, Feb 05, 2020 at 01:11:10PM +1300, Chris Packham wrote:
> > > > This series re-instates the octeon drivers that were recently remov=
ed and
> > > > addresses the build issues that lead to that decision.
> > > >
> > > > I've approached Cavium/Marvell about taking a more active interest =
in getting
> > > > the code out of staging and into their proper location. No reply on=
 that (yet).
> > >
> > > Good luck with talking to the companies, hopefully that will work.
> > >
> > > Anyway, I've applied this series, thanks for this, let's see what bre=
aks
> > > now :)
> >
> > Did you meet any problem to merge Chris's patchset?
>
> They are all in linux-next, so you can see for yourself :)

Thank you so much. I found it.
It is very important for Debian MIPS Ports as we are using some of
Octeon machines.

>
> greg k-h



--=20
YunQiang Su
