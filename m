Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BEC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40A0206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="chxZwDHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgD0G7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgD0G7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:59:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9FCC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:59:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so18263468wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ow7McboKHnEHo9r5OLmsIz4Khg2qeAiEPFCtI9iJ5vg=;
        b=chxZwDHNXTJ9LJOmjqpAusafVfgN00EstU/LDJ2x3UU47pnuc7h7KV8ZvK1X26+9cQ
         m0HnppQ06MM/x9JczH2v3crR6R0b5FE62JPp/F+lKJ2mSd6UsMg0SNJBsdEVIkSNQQQh
         3xv7cS3VR3lkk5n0s8DKhUhGrUTRAtYosFliB+eaLaJJqr7LsQI4SD0MbG/Qsp7OQDUE
         5L4gF1dXrH6DMlyQbT7i8tXJznHiRk2NgtMmfQEKB1bKpigiPhCwi/+V38yU1DE1T+lD
         EQOKi9Hl1Vimen90hq9H05/SwNfrbCpzUc4pDTUWnGVlg61A83AIbexOkQdIdDzuKXv+
         Lbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ow7McboKHnEHo9r5OLmsIz4Khg2qeAiEPFCtI9iJ5vg=;
        b=dBYr06C48peOJ8LUG+T/2YSiUrNITurGaats1NQDmZ9kBjfPjx/VlwKpve1pNEKIle
         drB5xbIznUFVnQokvJeqpTl9sF455SbpHtfE+fNgGDaEfRzhlqoPhINHeyIZ/ZZjagop
         gf6SquEXaQs/G/jb4hspO79MFAdBDOPgexbg4a6BqiYc/FeGl7bVDx6xCZLJLp6Kk/Bg
         L/4ni84NB1w3vxVPc0gLSZDmpr8MvR4dNhMG8881cfPhfM2/JZXEbg8ubeqF8/bXTtgj
         40Ooz6bIgctKEolv3i6hT0FlvQ967zNzFvNtOo3WkKQZ715K6BFdtPJ9vRstOC3NF8bt
         XX4g==
X-Gm-Message-State: AGi0PuYiW8odpCMozLeGIZ9TZ7so7biPRZmuTGaxNGZnvz0TzhvCg/Mg
        DH6bNLXsDUN0MRDtdGan27DOyZqJpndwiEItmobtEw==
X-Google-Smtp-Source: APiQypKYmlBRKfcnlZ4RrIfnnayIILRLq4PzWZAAMN7VbVCPvBLaBtWLo5XIGj35M13x6iC9IplFe3P35RKC13YmeCk=
X-Received: by 2002:a7b:c755:: with SMTP id w21mr23998184wmk.120.1587970768932;
 Sun, 26 Apr 2020 23:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200426110740.123638-1-zong.li@sifive.com> <CAAhSdy3FCdzLV-nH03T=PBxB2tdZXhRrugcC2NcoA=22qpv+Lw@mail.gmail.com>
 <CANXhq0qW9ORoZ5qc5g8ikO9QdeYX=p0fwoP8pyFFkk02a7imnw@mail.gmail.com>
 <CAAhSdy2f2-SQP6TdgxA0HM2ft3eBJd6kEkB--RH=2gUuLktXLQ@mail.gmail.com>
 <CANXhq0pDYa2QfGZX87d5gyO5V2uzA3-ttPZXf7s1EkMUcG37Cw@mail.gmail.com>
 <CAAhSdy188_Kkfsz2bX05T3Rr12XDNtwGiwfqaT2TFVW7auGUaw@mail.gmail.com>
 <CANXhq0qGq33u34q7nhJE4GG03pZ8BBJrnusr=FgmTeJwtq-=4Q@mail.gmail.com> <CAHCEeh+FVYd6GKDuN4fXz9ku57vmdyVR1y_mzu89-sanNa_E3A@mail.gmail.com>
In-Reply-To: <CAHCEeh+FVYd6GKDuN4fXz9ku57vmdyVR1y_mzu89-sanNa_E3A@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 27 Apr 2020 12:29:17 +0530
Message-ID: <CAAhSdy1=Ye4wwZMcGzQmnV05eMQzBV3steopKCx9iWJWbOORrw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: allow many cores to handle IRQs
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Zong Li <zong.li@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 12:19 PM Greentime Hu <greentime.hu@sifive.com> wro=
te:
>
> Zong Li <zong.li@sifive.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8826=E6=97=A5=
 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:35=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Sun, Apr 26, 2020 at 11:21 PM Anup Patel <anup@brainfault.org> wrote=
:
> > >
> > > On Sun, Apr 26, 2020 at 8:42 PM Zong Li <zong.li@sifive.com> wrote:
> > > >
> > > > On Sun, Apr 26, 2020 at 9:38 PM Anup Patel <anup@brainfault.org> wr=
ote:
> > > > >
> > > > > +Mark Z
> > > > >
> > > > > On Sun, Apr 26, 2020 at 6:49 PM Zong Li <zong.li@sifive.com> wrot=
e:
> > > > > >
> > > > > > On Sun, Apr 26, 2020 at 8:47 PM Anup Patel <anup@brainfault.org=
> wrote:
> > > > > > >
> > > > > > > On Sun, Apr 26, 2020 at 4:37 PM Zong Li <zong.li@sifive.com> =
wrote:
> > > > > > > >
> > > > > > > > Currently, driver forces the IRQs to be handled by only one=
 core. This
> > > > > > > > patch provides the way to enable others cores to handle IRQ=
s if needed,
> > > > > > > > so users could decide how many cores they wanted on default=
 by boot
> > > > > > > > argument.
> > > > > > > >
> > > > > > > > Use 'irqaffinity' boot argument to determine affinity. If t=
here is no
> > > > > > > > irqaffinity in dts or kernel configuration, use irq default=
 affinity,
> > > > > > > > so all harts would try to claim IRQ.
> > > > > > > >
> > > > > > > > For example, add irqaffinity=3D0 in chosen node to set irq =
affinity to
> > > > > > > > hart 0. It also supports more than one harts to handle irq,=
 such as set
> > > > > > > > irqaffinity=3D0,3,4.
> > > > > > > >
> > > > > > > > You can change IRQ affinity from user-space using procfs. F=
or example,
> > > > > > > > you can make CPU0 and CPU2 serve IRQ together by the follow=
ing command:
> > > > > > > >
> > > > > > > > echo 4 > /proc/irq/<x>/smp_affinity
> > > > > > > >
> > > > > > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > > > > > ---
> > > > > > > >  drivers/irqchip/irq-sifive-plic.c | 21 +++++++------------=
--
> > > > > > > >  1 file changed, 7 insertions(+), 14 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/ir=
qchip/irq-sifive-plic.c
> > > > > > > > index d0a71febdadc..bc1440d54185 100644
> > > > > > > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > > > > > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > > > > > > @@ -111,15 +111,12 @@ static inline void plic_irq_toggle(co=
nst struct cpumask *mask,
> > > > > > > >  static void plic_irq_unmask(struct irq_data *d)
> > > > > > > >  {
> > > > > > > >         struct cpumask amask;
> > > > > > > > -       unsigned int cpu;
> > > > > > > >         struct plic_priv *priv =3D irq_get_chip_data(d->irq=
);
> > > > > > > >
> > > > > > > >         cpumask_and(&amask, &priv->lmask, cpu_online_mask);
> > > > > > > > -       cpu =3D cpumask_any_and(irq_data_get_affinity_mask(=
d),
> > > > > > > > -                                          &amask);
> > > > > > > > -       if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids))
> > > > > > > > -               return;
> > > > > > > > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> > > > > > > > +       cpumask_and(&amask, &amask, irq_data_get_affinity_m=
ask(d));
> > > > > > > > +
> > > > > > > > +       plic_irq_toggle(&amask, d, 1);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void plic_irq_mask(struct irq_data *d)
> > > > > > > > @@ -133,24 +130,20 @@ static void plic_irq_mask(struct irq_=
data *d)
> > > > > > > >  static int plic_set_affinity(struct irq_data *d,
> > > > > > > >                              const struct cpumask *mask_val=
, bool force)
> > > > > > > >  {
> > > > > > > > -       unsigned int cpu;
> > > > > > > >         struct cpumask amask;
> > > > > > > >         struct plic_priv *priv =3D irq_get_chip_data(d->irq=
);
> > > > > > > >
> > > > > > > >         cpumask_and(&amask, &priv->lmask, mask_val);
> > > > > > > >
> > > > > > > >         if (force)
> > > > > > > > -               cpu =3D cpumask_first(&amask);
> > > > > > > > +               cpumask_copy(&amask, mask_val);
> > > > > > > >         else
> > > > > > > > -               cpu =3D cpumask_any_and(&amask, cpu_online_=
mask);
> > > > > > > > -
> > > > > > > > -       if (cpu >=3D nr_cpu_ids)
> > > > > > > > -               return -EINVAL;
> > > > > > > > +               cpumask_and(&amask, &amask, cpu_online_mask=
);
> > > > > > > >
> > > > > > > >         plic_irq_toggle(&priv->lmask, d, 0);
> > > > > > > > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> > > > > > > > +       plic_irq_toggle(&amask, d, 1);
> > > > > > > >
> > > > > > > > -       irq_data_update_effective_affinity(d, cpumask_of(cp=
u));
> > > > > > > > +       irq_data_update_effective_affinity(d, &amask);
> > > > > > > >
> > > > > > > >         return IRQ_SET_MASK_OK_DONE;
> > > > > > > >  }
> > > > > > > > --
> > > > > > > > 2.26.1
> > > > > > > >
> > > > > > >
> > > > > > > I strongly oppose (NACK) this patch due to performance reason=
s.
> > > > > > >
> > > > > > > In PLIC, if we enable an IRQ X for N CPUs then when IRQ X occ=
urs:
> > > > > > > 1) All N CPUs will take interrupt
> > > > > > > 2) All N CPUs will try to read PLIC CLAIM register
> > > > > > > 3) Only one of the CPUs will see IRQ X using the CLAIM regist=
er
> > > > > > > but other N - 1 CPUs will see no interrupt and return back to=
 what
> > > > > > > they were doing. In other words, N - 1 CPUs will just waste C=
PU
> > > > > > > every time IRQ X occurs.
> > > > > > >
> > > > > > > Example1, one Application doing heavy network traffic will
> > > > > > > degrade performance of other applications because with every
> > > > > > > network RX/TX interrupt N-1 CPUs will waste CPU trying to
> > > > > > > process network interrupt.
> > > > > > >
> > > > > > > Example1, one Application doing heavy MMC/SD traffic will
> > > > > > > degrade performance of other applications because with every
> > > > > > > SPI read/write interrupt N-1 CPUs will waste CPU trying to
> > > > > > > process it.
> > > > > > >
>
> Hi Anup,
>
> If there is a case that there are a lot of interrupts from a single
> irq number coming very quickly, the first hart is still serving the
> first interrupt and still in its top half so it doesn't enable
> interrupt yet but the second interrupt is coming and waiting, only the
> rest of the harts can serve it. If they are masked, the interrupt
> won't be able to be served it right away. In this case, I think this
> patch can get better performance. Maybe we can still keep this patch
> for user to define their usage in his case?

The way you described issue, it clearly means that other device driver
you are using does not have a optimized interrupt handler and the driver
should be fixed right away. I don't see the point in hacking PLIC driver
and slowing it down because some other device driver spending too
much time in interrupt context.

Seeing your comment, I quickly looked at Cadance MACB driver which
is very important on SiFive Unleashed. It turns out that Cadance MACB
driver does not have well designed top-half and bottom-half. Best thing
would be to change Candance MACB driver to use threaded irqs so that
majority of packet processing work on SiFive unleashed is done in kernel
thread (which is preemtible).

Regards,
Anup
