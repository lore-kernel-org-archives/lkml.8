Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B4BC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98B72075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MfRDokUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgAMRw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:52:27 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37276 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgAMRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:52:26 -0500
Received: by mail-il1-f196.google.com with SMTP id t8so8937004iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tR/PVmec9Acg9lLoWkjAACYeH6TaFlhfszmRPXAXo1I=;
        b=MfRDokUBQY6p/kpal7XLw/g38Gh/IYdjm7i351TEXrATsDe15BahgFzUxUw2OmWv3l
         PYV4Mv2Il9WIz8LTiICJ1SBtYdi5VjGf38h8gB80wwGQAUlIlbhv7UhJhatiNCgeoZqk
         JM+eizhJUClZ7yCT3TMjSjHSi++Sn0aZWVSBOv53ifvZlTrnUsu+yNtpcbvb46ywW/TC
         Sb536csF4MpO14QhxwoKAlHNmxLu++s2/9SMwgGmd+4wnm1E+JUuxkJZSlGgL9zxpGzD
         3Zelh6J1MpWq1zuisaeDHXlCuztNvunhxSLppqDpUE8fmnD09ZPY7oFLG0MX/nyceWlV
         3umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tR/PVmec9Acg9lLoWkjAACYeH6TaFlhfszmRPXAXo1I=;
        b=Els7Rrp2docqYP7PIf3z3ZBUHx/hSd4kUPnzeWWU2wjWueO5cSzWH1QRgIphtcmG6v
         8XL8u8IY78ndi4qbRY7sSpl3CzqfOxysMflJ0vU0flPgh92zZGoEgSzt5E8DqGVR8X2D
         Q75yacQvkJiItcIhAs2p1Guv0PC/06Uvs6+d2p4RD7ia89h/eUgl6OZnY8IhTWd4aSZz
         uOdNErwe66q6nF7rrLzrIkEsORhGIk5m2+iiLbwq11dI4YKbx+jtftYso7tWRjgmfNCc
         LYMOoF/8OWfJwbLFGNTN7Ewoii5BvbTaZyry32nct0NsNa9LeA+oQlZD/KTfF5s3NdbW
         xWVA==
X-Gm-Message-State: APjAAAWK0VF8Ax97CWtceKpqIq71GBIgoB0i8zrKpDWuqgqU7YWhV1zP
        CDRntloFVXRA8u8Lfsck1YslfmXYkGM8lFQJx46YvA==
X-Google-Smtp-Source: APXvYqwmifsPMIM7NR3deurhYvdhd2YslDh3Tb150YC7L/n4Un9cMt8a1ojcsrjY1X3Jknn0LNc6fVsXk09C2r1UTTE=
X-Received: by 2002:a92:db49:: with SMTP id w9mr14818680ilq.277.1578937945418;
 Mon, 13 Jan 2020 09:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20200113065808.25f28c40@canb.auug.org.au> <CAOesGMifHn6DbNgYm6YUbdKjSL5rNgdWrq+HX9dEusrOr9xX2A@mail.gmail.com>
 <20200113113837.130c3936@canb.auug.org.au> <caeb1af8-4aa2-71dc-0a70-127c0b474f93@st.com>
 <20200113224620.5d33fa63@canb.auug.org.au>
In-Reply-To: <20200113224620.5d33fa63@canb.auug.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 13 Jan 2020 09:52:13 -0800
Message-ID: <CAOesGMh0yfq_0RPzASjNPUgff4P+PMdo2fEB3BFO++Y6zz1n0g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Yann Gautier <yann.gautier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 3:46 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Alexandre,
>
> On Mon, 13 Jan 2020 09:17:08 +0100 Alexandre Torgue <alexandre.torgue@st.com> wrote:
> >
> > Sorry for this oversight. DO I have something to do ? (except to not
> > forget to check my signed-off next time).
>
> That is up to the arm-soc tree maintainers.

Nothing needed at this time.

The point of making sure maintainers sign off on patches is to track
their path into the tree. In this case we still know it comes in via
you. But make sure you're diligent on this for future patches.


Thanks!

-Olof
