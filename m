Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E2EC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A93214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9IRMB/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBGPyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:54:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43486 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:54:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id z9so3238328wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrCSFuR4yeUyXeOZPQTFiDl4JKVQG4uyRkwZKKbSbgU=;
        b=t9IRMB/oirrKmziTViJwNQnoY9zfSbnExbTlr0HdckiYqUKHM5CVq35nabxifMA6Az
         7suSvU9VyEVej5gLwzksg0VtH/7Gq6tDZxHew3rS+5oDTs9gFsv2IW0FtBOe+BZs+sgw
         IcczUezWRXRTdLTkowxFO5R21mjvSHDxB2fxDQ+iIaPbSY+yCvAggmy1FPtX/J8yhA2z
         8/vLQ8nwCjfZLGt1QVvV7ZECB1xdRNaKou5qluHAh4l+qV9bmrLnJLSAXSbjbcxxJjxA
         5oV/VqNcgz/lcrJI6eL3mbUyLTbLyFUrYDMqaNczbQyHkvlKBV1zLyuHYOkDD1sHeD9e
         XVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrCSFuR4yeUyXeOZPQTFiDl4JKVQG4uyRkwZKKbSbgU=;
        b=XOgKkTRClYJOzpBaobd0SLHLyca6YdRpdqgRpmmvweSz/gA81TtOzJLd0wAgfeZ5px
         7JtVBMZG/8hM446Q7tKns+ZoZi2Xz3u67YqQljyR3f00hgf1boe3gXOuMgKCpQ36ofsB
         mgW27UOYHA1IRMw9/EoDuhElqc3JN6KB61gnx+S8ShU7LPCI9DP2fja/qZcRRgmAGqde
         /9uky1ufS/Hwc9S8ntBJnppVV+7euUD6/1LxrlBZhKhMu0RyO9T2BO1CK03OK5em0+f8
         /SEkRJKjwnCuXfS0HqWBJZlG1kc1ONmclJ/0fHMA2sDiM1xLAsVbYHCZoEJiolP0I+47
         f+xQ==
X-Gm-Message-State: APjAAAUFmRczOJtnS7w54u1Uo9nj+DQo1TpyM+dj503/qCSI8DD/XROK
        kb4EgbcVPbLw05vthZ05bsVCpsKWvm9YcYdqOCg=
X-Google-Smtp-Source: APXvYqyaUSu17N5vVAsJa8pzq6kkm/2Y+AUZsZ5VZWhzs3ndlKATNeoKlOGlMcIoJZnC0yR8zRQhy5QjeCv4dNOgYbo=
X-Received: by 2002:a5d:5152:: with SMTP id u18mr5327564wrt.214.1581090854460;
 Fri, 07 Feb 2020 07:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20200114093305.666-1-quanyang.wang@windriver.com> <415718c7-4c55-fb5d-0b10-ad5323daa5a0@windriver.com>
In-Reply-To: <415718c7-4c55-fb5d-0b10-ad5323daa5a0@windriver.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 7 Feb 2020 16:54:03 +0100
Message-ID: <CAFLxGvw-q3N98RhbtWCE5mGGv6qwrJBDTMTs_yMe9QDY6U4TAQ@mail.gmail.com>
Subject: Re: [PATCH] ubi: fix memory leak from ubi->fm_anchor
To:     Quanyang Wang <quanyang.wang@windriver.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 10:14 AM Quanyang Wang
<quanyang.wang@windriver.com> wrote:
>
> Ping?
>
> On 1/14/20 5:33 PM, quanyang.wang@windriver.com wrote:
> > From: Quanyang Wang <quanyang.wang@windriver.com>
> >
> > Some ubi_wl_entry are allocated in erase_aeb() and one of them is
> > assigned to ubi->fm_anchor in __erase_worker(). And it should be freed
> > like others which are freed in tree_destroy(). Otherwise, it will
> > cause a memory leak:
> >
> > unreferenced object 0xbc094318 (size 24):
> >    comm "ubiattach", pid 491, jiffies 4294954015 (age 420.110s)
> >    hex dump (first 24 bytes):
> >      30 43 09 bc 00 00 00 00 00 00 00 00 01 00 00 00  0C..............
> >      02 00 00 00 04 00 00 00                          ........
> >    backtrace:
> >      [<6c2d5089>] erase_aeb+0x28/0xc8
> >      [<a1c68fb1>] ubi_wl_init+0x1d8/0x4a8
> >      [<d4f408f8>] ubi_attach+0xffc/0x10d0
> >      [<add3b5d8>] ubi_attach_mtd_dev+0x5b4/0x9fc
> >      [<d375a11c>] ctrl_cdev_ioctl+0xb8/0x1d8
> >      [<72b250f2>] vfs_ioctl+0x28/0x3c
> >      [<b80095d7>] do_vfs_ioctl+0xb0/0x798
> >      [<bf9ef69e>] ksys_ioctl+0x58/0x74
> >      [<5355bdbe>] ret_fast_syscall+0x0/0x54
> >      [<90c6c3ca>] 0x7eadf854
> >
> > Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> > ---
> >   drivers/mtd/ubi/wl.c | 2 ++
> >   1 file changed, 2 insertions(+)

Good catch!
Fixes: f9c34bb52997 ("ubi: Fix producing anchor PEBs")

---
Thanks,
//richard
