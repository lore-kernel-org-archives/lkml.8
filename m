Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C7DC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2129520767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lgd9Hgzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCSWjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:39:43 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52376 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCSWjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:39:42 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so1636908pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=7mMAj8dUbAadtvulGNGY4QfYnieXkzH3hC7LluqQC7w=;
        b=Lgd9Hgzqo90zpN++gDqagmBBkHHSJlmPirhxcUzg+37BS+hWQVBA7vV640vQFRNd5l
         xWKdbaGhnEihCgFA/lHDH6U540gyXi6hA23jFRDmu3hyAaNyBAKHDJVeRwgk/yBOtqPm
         Q7Kr3wpsKDdAEVjyvEqiExTKjoAn7gOJtKSwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=7mMAj8dUbAadtvulGNGY4QfYnieXkzH3hC7LluqQC7w=;
        b=ani+IEBWlJF5SHJrU3HwPALj1ClPmt1ZQ0La9FeSGWu982MtpYKC1BTYH6YEspJcCc
         5dVWqFM1UYpPlTFKVB39Q3dTsN700To6ertTBIF/+hJTOnRUpn2coN/sJqGDquZa9Srw
         RiiqY95QSE6VlyzYjNLqbq/wJqeKpZ+Sd/jrRjNabGXy4KHZecjzAsyiePh0jrDzBaJX
         ReX9/iX57UGSAIZh9WaVZMW5aePlkh/fVDd1GXhTF7jSQJD8zTQGQwmoc2FTuGoJysBC
         jPkuS4E+OrU0a+oeIY7YW+Gz/BV7j+THY8zVCoVUwlLkQ3wn6K+L2Av+CrK5tePm73gv
         glJw==
X-Gm-Message-State: ANhLgQ3z1mHZh3QjONi13e0vj/V8/86fYJ87r9GLRI1eM5XmgokHyWb6
        GYquH++PiavqWbFlR5eyfW76Gk8GSgI=
X-Google-Smtp-Source: ADFU+vvVmFXLAxs6dCiwhXzCd4ILz2lDLhBmP3EvjM3zl27Yjl7Tom/VFHkVLS/IIUiyDnwnT6laNg==
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr6230009pjq.14.1584657579847;
        Thu, 19 Mar 2020 15:39:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g16sm3412012pgb.54.2020.03.19.15.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 15:39:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6a3aebf8-72dd-a1d6-bf0c-aad6204cb6c7@codeaurora.org>
References: <1584505758-21037-1-git-send-email-mkshah@codeaurora.org> <1584505758-21037-3-git-send-email-mkshah@codeaurora.org> <158457754092.152100.9555786468515303757@swboyd.mtv.corp.google.com> <6a3aebf8-72dd-a1d6-bf0c-aad6204cb6c7@codeaurora.org>
Subject: Re: [PATCH v5 2/4] soc: qcom: Add SoC sleep stats driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Thu, 19 Mar 2020 15:39:38 -0700
Message-ID: <158465757824.152100.16700786589009071452@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-03-19 08:14:03)
> On 3/19/2020 5:55 AM, Stephen Boyd wrote:
> > Quoting Maulik Shah (2020-03-17 21:29:16)
> >> diff --git a/drivers/soc/qcom/soc_sleep_stats.c b/drivers/soc/qcom/soc=
_sleep_stats.c
> >> new file mode 100644
> >> index 0000000..0db7c3d
> >> --- /dev/null
> >> +++ b/drivers/soc/qcom/soc_sleep_stats.c
> >> @@ -0,0 +1,244 @@
[..]
> >> +
> >> +static struct subsystem_data subsystems[] =3D {
> > This can be const.
> we are passing each element of this in debugfs_create_file as (void * dat=
a)
> making this const is saying error passing const as void *.

I think we can cast it and have a comment. This way the structure can be
placed in the RO section of memory.

> >> +       { "modem", 605, 1 },
> >> +       { "adsp", 606, 2 },
> >> +       { "cdsp", 607, 5 },
> >> +       { "slpi", 608, 3 },
> >> +       { "gpu", 609, 0 },
> >> +       { "display", 610, 0 },
> >> +};
> >> +
> >> +struct stats_config {
> >> +       unsigned int offset_addr;
> >> +       unsigned int num_records;
> >> +       bool appended_stats_avail;
> >> +};
> >> +
> >> +struct stats_prv_data {
> >> +       const struct stats_config *config;
> > Can we have 'bool has_appended_stats' here instead?
> any reason to move? this is per compatible config where rpm based target =
have appended stats available.

It avoids one indirection to figure out something and makes the code
clearer. prv_data doesn't have any use for config otherwise.

> >
> >> +{
> >> +       u64 accumulated =3D stat->accumulated;
> >> +       /*
> >> +        * If a subsystem is in sleep when reading the sleep stats adj=
ust
> >> +        * the accumulated sleep duration to show actual sleep time.
> >> +        */
> >> +       if (stat->last_entered_at > stat->last_exited_at)
> >> +               accumulated +=3D arch_timer_read_counter()
> > This assumes that arch_timer_read_counter() is returning the physical
> > counter? Is accumulated duration useful for anything? I don't like that
> > we're relying on the arch timer code to return a certain counter value
> > that may or may not be the same as what is written into smem.
>=20
> we are not comparing it with what is written into smem. The idea here is =
to adjust the accumulated sleep length to reflect close/real value.
>=20
> When a subsystem goes to sleep, it updates entry time and then stays in s=
leep.
> Exit time and accumulated duration is updated when subsystem comes out of=
 low power mode.

Who is updating the accumulated time? This debugfs code? Or the
subsystems themselves?

>=20
> Now if Subsystem updated entry time and went in sleep, while printing acc=
umulated duration
> will keep giving older value.
>=20
> If read it at interval of say every 10 seconds, if subsystem never comes =
out during this.
> Even after 10 seconds, it gives older accumulated duration, while we want=
 to get
> printed as close to real value. so its updated here.
>=20
> Now when it comes out of sleep, it always prints value given from subsyst=
em.

Thanks, I understand the motivation.

>=20
> >
> >> +                              - stat->last_entered_at;
> >> +
> >> +       seq_printf(s, "Count =3D %u\n", stat->count);
> >> +       seq_printf(s, "Last Entered At =3D %llu\n", stat->last_entered=
_at);
> >> +       seq_printf(s, "Last Exited At =3D %llu\n", stat->last_exited_a=
t);
> >> +       seq_printf(s, "Accumulated Duration =3D %llu\n", accumulated);
> >> +}
> >> +
> >> +static int subsystem_sleep_stats_show(struct seq_file *s, void *d)
> >> +{
> >> +       struct subsystem_data *subsystem =3D s->private;
> >> +       struct sleep_stats *stat;
> >> +
> >> +       stat =3D qcom_smem_get(subsystem->pid, subsystem->smem_item, N=
ULL);
> > We already get this during probe in create_debugfs_entries() (which is
> > too generic of a name by the way).=20
> I will update the name.
> > Why can't we stash that pointer away
> > so that it comes through the 'd' parameter to this function?
> i think you are missing a subsystem restart case, in that pointer may be =
updated to new value.
> so we can not just save it and re-use it every time, we don't know when s=
ubsystem restart happens and we now need new pointer.

Yes I'm missing subsystem restart. A comment would certainly help. If
this is the case, maybe this should be libified and each subsystem
driver should call some add/remove function in here so that we can
refetch the smem pointer. Doing the lookup each time isn't great.

> >
> >> +
> >> +               prv_data[i].reg =3D reg + offset;
> >> +
> >> +               type =3D readl(prv_data[i].reg);
> >> +               memcpy(stat_type, &type, sizeof(u32));
> > Is it a 4-byte ascii register that may or may not be NUL terminated? We
> > should use __raw_readl() then so we don't do an endian swap. Using
> > memcpy_fromio() does this all for you.
>=20
> memcpy_fromio() seems not copying properly with u32 or u32+1 size.=C2=A0 =
seems it need align to 8 byte.
>=20
> so when i pass u64 size it seems working fine. i will change this to use =
memcpy_fromio with sizeof(u64).

What is the failure? Do you need to read 4 bytes at a time? On arm64
memcpy_fromio() looks to do byte size reads if the size isn't 8 bytes.
Maybe just use __raw_readl() then if it is only 4 bytes and you need a
word accessor.
