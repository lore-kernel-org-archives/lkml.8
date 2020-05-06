Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E28C47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143782073B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="nSJZu/Fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgEFAAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgEFAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:00:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542BCC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 17:00:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so385861wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iD14m2oqtz2m5olanAMCvHCDcEx9U6emVEbdAioaj8=;
        b=nSJZu/FoIdJ+qkbbRlKX/R3Ewl+m3sPF9nEVWJt+/W45oSngIvx5d8Qphlbp4P08bN
         Pu4Emc3Zg4MMm+MaCwmWTGETQmAMJ9sy8sUHu2MUHmTq8ZLHs9VkLM9MBJzyEbkYqVgU
         EAx3O9Vf55SxohUSlOgAM62+r6tPhWgoLzQSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iD14m2oqtz2m5olanAMCvHCDcEx9U6emVEbdAioaj8=;
        b=dVpcLiRP0jgdP3eaxQJ6R3A4UXBRzwPFz0g9QCzbRQvAMCUbC02viBCR0+fos0coEJ
         HXDA2l/Ahyzky9xyn4iqxtgwZHOGqGwN4GhdAntZpc8e2IR5tWkt/wI8dXphmHox0+IY
         lUhcpMoMXuUIKwhSlUEA6n3cOWO/G5Cp/+6tMtn4JNHFfmqYLN/JAhqcNvaFzAsMgAiK
         05+oY1T+64tfUymXNcBw1MgMyZLyFu1zVdryL8G+6CKj7Z+vN5ktqmmyqAE17ft1tqZw
         WOAM9djUBgMFl0ItmMmdSkwJCh6FlQQCYHdxMkP2C9XwKRw6RsxToiMynN+9+c+IaTRV
         fX7A==
X-Gm-Message-State: AGi0PubjqyFdLlJPLdag5HVeT8bEO2WHEkYD2DbU6X3yTiJm+avKuaGy
        /VQbTL/qxS/7uGHTNQ+Jxh7WByLT3WuxaGt5pX7T
X-Google-Smtp-Source: APiQypIMLYZZDdT77MeBbFFO6dqLUMN5K3k4qgrEOS96GhN+81eZdKIvX9PkmZg2Z83Itjj9g0U9RLobX+Eh/CL/mrQ=
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr1122660wmj.186.1588723216414;
 Tue, 05 May 2020 17:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200504040319.31423-1-atish.patra@wdc.com> <mhng-a3f16502-c8cd-46db-afa1-86df18b3778d@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-a3f16502-c8cd-46db-afa1-86df18b3778d@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 5 May 2020 17:00:05 -0700
Message-ID: <CAOnJCUJtnVjYwfaHbiUdO4SqPk8rY0q0uYckNJpQpc7jK0Pz7g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Remove unused code from STRICT_KERNEL_RWX
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:55 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sun, 03 May 2020 21:03:19 PDT (-0700), Atish Patra wrote:
> > This patch removes the unused functions set_kernel_text_rw/ro.
> > Currently, it is not being invoked from anywhere and no other architecture
> > (except arm) uses this code. Even in ARM, these functions are not invoked
> > from anywhere currently.
> >
> > Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index b55be44ff9bd..ba60a581e9b6 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -501,22 +501,6 @@ static inline void setup_vm_final(void)
> >  #endif /* CONFIG_MMU */
> >
> >  #ifdef CONFIG_STRICT_KERNEL_RWX
> > -void set_kernel_text_rw(void)
> > -{
> > -     unsigned long text_start = (unsigned long)_text;
> > -     unsigned long text_end = (unsigned long)_etext;
> > -
> > -     set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
> > -}
> > -
> > -void set_kernel_text_ro(void)
> > -{
> > -     unsigned long text_start = (unsigned long)_text;
> > -     unsigned long text_end = (unsigned long)_etext;
> > -
> > -     set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> > -}
> > -
> >  void mark_rodata_ro(void)
> >  {
> >       unsigned long text_start = (unsigned long)_text;
>
> Thanks, this is on fixes.  Are you going to remove the ARM code as well?
>

Yeah and also I realized that I forgot to remove the declarations from
the header file.
My bad. I will send out a v2. Please drop this one and take v2.

-- 
Regards,
Atish
