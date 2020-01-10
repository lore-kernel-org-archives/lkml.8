Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7552C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E1C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBg/03wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgAJIqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:46:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34831 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgAJIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:46:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id j1so1300027lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gE41CI+UO29+oRSh0CE+A4Cy7VX9Ko+r2yjHEZQRQIw=;
        b=LBg/03wbU8KDXflVCoE8juUy0G/qXD24pxuCidV/FEYY/d8lfHd+QZBG47Rud3w99N
         v0pv58Bj7M8Njpq8BtrM5jQ02W3ZpsSvEYwe83ie/jYvIEUPz3uo8YY/5nD646MZKKAe
         GBjDbrq/08bKdk93vDhwMcxibL8ey5atFivZK+TJHCKSlPNSNN2jpElvzo5bwtZ2iBYp
         F/y5SIhXaxDbW71ysnVIu2LbJZmTNIb3yEPGYUxFcaEP6ctnur4dJa1tBBq7UAmIZP2q
         1DSyVbsPJ7nvtGWY7nyzVEGnlIhQp4ooOYz8AFIav/RrObR1N2S+hdgwr6FXKBrzlXeA
         iGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gE41CI+UO29+oRSh0CE+A4Cy7VX9Ko+r2yjHEZQRQIw=;
        b=I2tjwWpdnZdtEvclhES0tHaFa3ncLzTFWuC8m69Dr0pglY+kLnRkWXqTaPro5Z83FY
         X7srwMso+EG3Vd0+U8hcAwpzGehOHdfzPhWSZ0cN9a/70VgTD3XNpuuXXCqcrDqz3Rzy
         lHcHoYA0t0RupnQh8sqhRH6xQBBh45CmXL7DliSpSSlrrxjJQpd7WwgSeq6hLxcBuvR5
         9733ADPPShpusUQ7tE4BAvEKikzXUK/urlb8Yx6CEd9gCCMvY+AriRwMqxlKO2gq1ONg
         QyHCzqzR1bp4yAJP6QwlXBo2TjjhmQvDS8xmkjyl9AharZBnl8v2AqD4PWPOacV7/6Ix
         AQBw==
X-Gm-Message-State: APjAAAXXObAc/3khcbM1logdmUTxhiyv3n0AonTDTuU6diJumfatGz6m
        ZkOvzhKSnG0nCsPClhUg4pU1FO39Dy6XAi9p6Og=
X-Google-Smtp-Source: APXvYqx9hrU3q94rvOoTzQuya0Vrb4qWio67QYzza2bIhueQIi2aTgcKz8aQpGMVK9D6gqAhGkmOGQrv379UVZa1ejw=
X-Received: by 2002:a05:651c:104:: with SMTP id a4mr1841938ljb.104.1578645993591;
 Fri, 10 Jan 2020 00:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com> <874kx4bb1m.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kx4bb1m.fsf@nanos.tec.linutronix.de>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Fri, 10 Jan 2020 16:46:21 +0800
Message-ID: <CAFH1YnM=wOTpWEsoYeqaazdH3rdY-sG57=hTAwEcagJKLFbQ9g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 5:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Zhenzhong Duan <zhenzhong.duan@gmail.com> writes:
>
> > Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
> > CONFIG_ACPI are defined, but definition of variable 'i' is out of guard=
.
> > If any of the two macros is undefined, below warning triggers during
> > build, fix it by moving 'i' in the guard.
> >
> > arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable =E2=80=
=98i=E2=80=99 [-Wunused-variable]
> >
> > Also use true/false instead of 1/0 for boolean return.
>
> No. This is not the scope of the unused variable issue. This want's to
> be a separate patch.

I'm trying to combine trivial changes into one, so you maintainers
don't mind to pick two trivial patches? :)

Regards
Zhenzhong
