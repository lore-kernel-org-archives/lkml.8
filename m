Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8135BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527AC206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxaIl3YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgAPXyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:54:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34593 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgAPXyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:54:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id w5so8251488wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 15:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkrM20s+1fDKGBQn/43+pPYl+YDGx4tqwXoluQSwkyA=;
        b=SxaIl3YVy5O8ezTNgTT4rUfOfvuTAin9e4ah4aFqAghKh1SLuZf2HlqKPd7FsUJz2d
         KCnLUVYHeJ6Lzg9gaSpSIIiKPo5fpRFrdU3DjEbruIDmlhkGHjJ1YNL05W1qgnp+q9KL
         5KLaEomhVdPQwWBHcpnNBNiDLg31gju4Bul/W3P7TN7IQf4esGQtESRycgEJwsOsGatq
         bFuJM2diveKwYUd3+hEUgnfUOC5apF2Wj1yQuqGYaigMjZ7SEfiXikshvq5bZHqIIWZk
         6DVfWATimRiWlcilMbrVUW2ziG5BDOMjzg8V/MiztzvPUjZOckOJVrsAvpCIJ00cJ2Gn
         RlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkrM20s+1fDKGBQn/43+pPYl+YDGx4tqwXoluQSwkyA=;
        b=GysyCQKa5eFXnrcG1eppmiXhZNQfchtZj7v3cpJrscnSweJOZaV/U6DYzqqBclbNJB
         zqW1ubQcXkWd3/DMW95vOiHVxB3xirc7KI6a+SOkpJE8zHD3SNIEu4di20gyX7Sg116t
         PaMKqbfES6rcLFMQBEjNurIDMfJXA+RiUWJCeN9q1RGT3zy75YCNIvjHpd3ecsPDKrEP
         +75z7rbc2qcUpusdCNbn/PCpO4D/hyu1sFuczeVyZ4D4fmpsJOqPeOyshKGbbOO/aEos
         V1TNBeO5nNbfSzf9iA/hjyHD4TzC92E0YH+daYHvowOz2fPOugjcHLo9Ia0fnM3JCRz7
         C61Q==
X-Gm-Message-State: APjAAAUH8s/0WxyFqB3S1IaWcsqrgMYLf7EvKzQFYvN4vROumtfd8FfF
        T8bYwT+paRADshtknl3Hg5SJrS6qGflKB/bm/cyFEkjg
X-Google-Smtp-Source: APXvYqzxANPf1LbXfVujukSBW7flBiXnsJftgGvc6+BiAu5uXItzmP9amXYjGrwaXvmVWHf5VHazo0Gc5oerHbMkJX8=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr1656307wmk.68.1579218851221;
 Thu, 16 Jan 2020 15:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20200114054311.8984-1-quanyang.wang@windriver.com> <20200114092051.autszasi2rmywtyk@pengutronix.de>
In-Reply-To: <20200114092051.autszasi2rmywtyk@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 17 Jan 2020 00:54:00 +0100
Message-ID: <CAFLxGvwaabOGTLjEYUg2qdnjtbr_nnGXzBq-5rCzRpqvf-OQbQ@mail.gmail.com>
Subject: Re: [PATCH] ubifs: fix memory leak from c->sup_node
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     quanyang.wang@windriver.com, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:21 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Tue, Jan 14, 2020 at 01:43:11PM +0800, quanyang.wang@windriver.com wrote:
> > From: Quanyang Wang <quanyang.wang@windriver.com>
> >
> > The c->sup_node is allocated in function ubifs_read_sb_node but
> > is not freed. This will cause memory leak as below:
> >
> > unreferenced object 0xbc9ce000 (size 4096):
> >   comm "mount", pid 500, jiffies 4294952946 (age 315.820s)
> >   hex dump (first 32 bytes):
> >     31 18 10 06 06 7b f1 11 02 00 00 00 00 00 00 00  1....{..........
> >     00 10 00 00 06 00 00 00 00 00 00 00 08 00 00 00  ................
> >   backtrace:
> >     [<d1c503cd>] ubifs_read_superblock+0x48/0xebc
> >     [<a20e14bd>] ubifs_mount+0x974/0x1420
> >     [<8589ecc3>] legacy_get_tree+0x2c/0x50
> >     [<5f1fb889>] vfs_get_tree+0x28/0xfc
> >     [<bbfc7939>] do_mount+0x4f8/0x748
> >     [<4151f538>] ksys_mount+0x78/0xa0
> >     [<d59910a9>] ret_fast_syscall+0x0/0x54
> >     [<1cc40005>] 0x7ea02790
> >
> > Free it in ubifs_umount and in the error path of mount_ubifs.
> >
> > Fixes: fd6150051bec ("ubifs: Store read superblock node")
> > Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>
> Looks good.
>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Hm, this one is not in patchwork.
Anyway, applied. Thanks for fixing!

-- 
Thanks,
//richard
