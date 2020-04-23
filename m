Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEFC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649E120857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfBGHPK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgDWPF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728551AbgDWPF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:05:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09202C08E934;
        Thu, 23 Apr 2020 08:05:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g6so3014917pgs.9;
        Thu, 23 Apr 2020 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHcF20Pivw8z3/ND3mH4iQQaNlvKu4UnK2vOPdbQVJA=;
        b=FfBGHPK7wd3f4BANvXku7COH9+t7ONn4xwNP0pCwrDxGoSAjfB+kx+Ba2EjlFV+MQx
         6JOKBdD69hIcNz+Lx0mdmGb4L7e8Z3Rq71Pmu08iUZaKD09/qI2P1Ufw4/8/ycV6U4VO
         PYJdNt4VGItxq7kJAlDRpz8DxoOvOjDhWktDup3jVleZ4Tocp5zsDz+ATnQEvpnMPrFv
         6UEd4Uu0xASl247ScxZsDPwy0zvKJ5ofx0Kry678mnDgEpnZIyVvLHVS+0I1TJnXgyd4
         CoHNMAjjymhKxRZJCFoGWt0v/1M/GTR7iKdgHZ4H2MWSIDwfojhh/OEdjCh/55XlfHZZ
         iOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHcF20Pivw8z3/ND3mH4iQQaNlvKu4UnK2vOPdbQVJA=;
        b=U7y9lY6dEOi34YPEJ868aDV5mWj7UhGs61gepVITmSXMHy2YGowgHkLVAnN1aLRf5I
         2Ag5Bt9PGPJ8T5Ek3XDJiZG6Z0uSgXbEFaUzDpscB/jxw3SGNe/xACG3eQaLYxp4M+QY
         Sz1vP+F2pNEDNYmQva6fnzXEHDaRVPN8F+PhAmnPD8QZvtLycS7dKPxXlviMTd6dzO+g
         r/yMIfuuDJiJJYV+LQQ/SBldGqI0+uHidDLq+Tzzg/VZOSBTf0eY9MsEaA+AaxXn8DIi
         RF2H1QzVG1hlR7gJuAwo/H0zXdPkagRc0OLoeZ13AzSCnngr+cOlpiMVmbWi/Q8tKMLm
         1S6w==
X-Gm-Message-State: AGi0PuayJ2KkNkQ4aufo/sdqUgJ4VCRPf8b754WzmfrJMq9us+FdKNmD
        l4nEmvfxym7ta64tXvJcogLP8ROwyAcXTsmFez0=
X-Google-Smtp-Source: APiQypLZf74LwPBpTYXTJ9GR4vXb1ctcANv6Y0o2lRSo2eTWzHdfq22mdOYPLt5ZSvJ/rqzQ1KHuwiCeFT/95uxbJt4=
X-Received: by 2002:a63:5511:: with SMTP id j17mr4281090pgb.4.1587654325529;
 Thu, 23 Apr 2020 08:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200423142637eucas1p2ea543e281d96c75aa4292b49756f2146@eucas1p2.samsung.com>
 <20200423142627.1820-1-zhengdejin5@gmail.com> <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
In-Reply-To: <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Apr 2020 18:05:18 +0300
Message-ID: <CAHp75Vd8kC6ub-=pwe3QtdZ=FBqka3F1bbHea6__G5_Vm_ybcQ@mail.gmail.com>
Subject: Re: [PATCH v2] console: console: Complete exception handling in newport_probe()
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Dejin Zheng <zhengdejin5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, FlorianSchandinat@gmx.de,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 5:55 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> > +     if (err)
> > +             iounmap((void *)npregs);
>
> Looks OK but while you are at it, could you please also add missing
> release_mem_region() on error and on device removal:
>
>         newport_addr = dev->resource.start + 0xF0000;
>         if (!request_mem_region(newport_addr, 0x10000, "Newport"))
>                 return -ENODEV;
>
>         npregs = (struct newport_regs *)/* ioremap cannot fail */
>                 ioremap(newport_addr, sizeof(struct newport_regs));
>         console_lock();
>         err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>         console_unlock();
>         return err;
> }
>
> static void newport_remove(struct gio_device *dev)
> {
>         give_up_console(&newport_con);
>         iounmap((void *)npregs);
> }
>
> ?

Don't you think that proper solution is rather switch to memremap()?

> >       return err;
> >  }

-- 
With Best Regards,
Andy Shevchenko
