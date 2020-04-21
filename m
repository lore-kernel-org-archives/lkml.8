Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788FFC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B582071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="WG5rI4ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgDUPiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:38:10 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:59044 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgDUPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:38:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 49B5427E02FA;
        Tue, 21 Apr 2020 17:38:07 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NFeVXngl6t0K; Tue, 21 Apr 2020 17:38:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 56BCA27E0A7E;
        Tue, 21 Apr 2020 17:38:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 56BCA27E0A7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1587483486;
        bh=E8Ef7Y9juD0L2yAlkBR135rMMoMAmO27lR7T+Rur6Qs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WG5rI4nsdyZ/n6I/DKusgV+iXVV+IPnkZ25CsrFG8CMWbSpcqpA2APdPsmewJfxSS
         nHHhSmAIOVf+JEYh4cIqTM9KOfJcvgywN2R19TyeC6boSRDVpK26QVhmTbB6ncy//v
         ebHQOSRZAuUEmg41DPI6+pDzXKq/NaViizxTWJkI=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UhMRJdWpDRmw; Tue, 21 Apr 2020 17:38:06 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 3765427E02FA;
        Tue, 21 Apr 2020 17:38:06 +0200 (CEST)
Date:   Tue, 21 Apr 2020 17:38:06 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     s-anna <s-anna@ti.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>
Message-ID: <777435415.16656480.1587483486065.JavaMail.zimbra@kalray.eu>
In-Reply-To: <a7994631-7a63-5477-df70-e40b995fe14f@ti.com>
References: <20200331083336.7459-1-cleger@kalray.eu> <0fc07250-c62c-cb10-58e5-04ccdd6ee176@ti.com> <a7994631-7a63-5477-df70-e40b995fe14f@ti.com>
Subject: Re: [PATCH v2] remoteproc: remove rproc_elf32_sanity_check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3895)
Thread-Topic: remoteproc: remove rproc_elf32_sanity_check
Thread-Index: u5IOaZRLFAz0NztRXGyHwYidGzKInw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anna,

----- On 21 Apr, 2020, at 17:30, s-anna s-anna@ti.com wrote:

> Hi Clement,
>=20
> On 3/31/20 10:13 AM, Suman Anna wrote:
>> On 3/31/20 3:33 AM, Clement Leger wrote:
>>> Since checks are present in the remoteproc elf loader before calling
>>> da_to_va, loading a elf64 will work on 32bits flavors of kernel.
>>> Indeed, if a segment size is larger than what size_t can hold, the
>>> loader will return an error so the functionality is equivalent to
>>> what exists today.
>>>
>>> Signed-off-by: Clement Leger <cleger@kalray.eu>
>>=20
>> Acked-by: Suman Anna <s-anna@ti.com>
>=20
> Can you repost this after rebasing on top of the rproc-next branch
> which has the rproc_alloc refactoring changes pushed now?

Yes, I will do that.

Regards,

Cl=C3=A9ment

>=20
> regards
> Suman
>=20
>>=20
>> regards
>> Suman
>>=20
>>> ---
>>> Changes from v1 -> v2:
>>>   - Remove possibity to override sanity_check operation
>>>
>>>   drivers/remoteproc/remoteproc_core.c       |  3 +--
>>>   drivers/remoteproc/remoteproc_elf_loader.c | 21 ---------------------
>>>   drivers/remoteproc/remoteproc_internal.h   |  1 -
>>>   drivers/remoteproc/st_remoteproc.c         |  2 +-
>>>   drivers/remoteproc/st_slim_rproc.c         |  2 +-
>>>   drivers/remoteproc/stm32_rproc.c           |  2 +-
>>>   6 files changed, 4 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>> b/drivers/remoteproc/remoteproc_core.c
>>> index a9ac1d01e09b..191560048c1a 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -2068,8 +2068,7 @@ struct rproc *rproc_alloc(struct device *dev, con=
st char
>>> *name,
>>>   =09=09rproc->ops->load =3D rproc_elf_load_segments;
>>>   =09=09rproc->ops->parse_fw =3D rproc_elf_load_rsc_table;
>>>   =09=09rproc->ops->find_loaded_rsc_table =3D rproc_elf_find_loaded_rsc=
_table;
>>> -=09=09if (!rproc->ops->sanity_check)
>>> -=09=09=09rproc->ops->sanity_check =3D rproc_elf32_sanity_check;
>>> +=09=09rproc->ops->sanity_check =3D rproc_elf_sanity_check;
>>>   =09=09rproc->ops->get_boot_addr =3D rproc_elf_get_boot_addr;
>>>   =09}
>>>  =20
>>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
>>> b/drivers/remoteproc/remoteproc_elf_loader.c
>>> index 16e2c496fd45..29034f99898d 100644
>>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>>> @@ -112,27 +112,6 @@ int rproc_elf_sanity_check(struct rproc *rproc, co=
nst
>>> struct firmware *fw)
>>>   }
>>>   EXPORT_SYMBOL(rproc_elf_sanity_check);
>>>  =20
>>> -/**
>>> - * rproc_elf_sanity_check() - Sanity Check ELF32 firmware image
>>> - * @rproc: the remote processor handle
>>> - * @fw: the ELF32 firmware image
>>> - *
>>> - * Make sure this fw image is sane.
>>> - */
>>> -int rproc_elf32_sanity_check(struct rproc *rproc, const struct firmwar=
e *fw)
>>> -{
>>> -=09int ret =3D rproc_elf_sanity_check(rproc, fw);
>>> -
>>> -=09if (ret)
>>> -=09=09return ret;
>>> -
>>> -=09if (fw_elf_get_class(fw) =3D=3D ELFCLASS32)
>>> -=09=09return 0;
>>> -
>>> -=09return -EINVAL;
>>> -}
>>> -EXPORT_SYMBOL(rproc_elf32_sanity_check);
>>> -
>>>   /**
>>>    * rproc_elf_get_boot_addr() - Get rproc's boot address.
>>>    * @rproc: the remote processor handle
>>> diff --git a/drivers/remoteproc/remoteproc_internal.h
>>> b/drivers/remoteproc/remoteproc_internal.h
>>> index b389dc79da81..31994715fd43 100644
>>> --- a/drivers/remoteproc/remoteproc_internal.h
>>> +++ b/drivers/remoteproc/remoteproc_internal.h
>>> @@ -54,7 +54,6 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, siz=
e_t len);
>>>   phys_addr_t rproc_va_to_pa(void *cpu_addr);
>>>   int rproc_trigger_recovery(struct rproc *rproc);
>>>  =20
>>> -int rproc_elf32_sanity_check(struct rproc *rproc, const struct firmwar=
e *fw);
>>>   int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware=
 *fw);
>>>   u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmwar=
e *fw);
>>>   int rproc_elf_load_segments(struct rproc *rproc, const struct firmwar=
e *fw);
>>> diff --git a/drivers/remoteproc/st_remoteproc.c
>>> b/drivers/remoteproc/st_remoteproc.c
>>> index a6cbfa452764..a3268d95a50e 100644
>>> --- a/drivers/remoteproc/st_remoteproc.c
>>> +++ b/drivers/remoteproc/st_remoteproc.c
>>> @@ -233,7 +233,7 @@ static const struct rproc_ops st_rproc_ops =3D {
>>>   =09.parse_fw=09=09=3D st_rproc_parse_fw,
>>>   =09.load=09=09=09=3D rproc_elf_load_segments,
>>>   =09.find_loaded_rsc_table=09=3D rproc_elf_find_loaded_rsc_table,
>>> -=09.sanity_check=09=09=3D rproc_elf32_sanity_check,
>>> +=09.sanity_check=09=09=3D rproc_elf_sanity_check,
>>>   =09.get_boot_addr=09=09=3D rproc_elf_get_boot_addr,
>>>   };
>>>  =20
>>> diff --git a/drivers/remoteproc/st_slim_rproc.c
>>> b/drivers/remoteproc/st_slim_rproc.c
>>> index 3cca8b65a8db..09bcb4d8b9e0 100644
>>> --- a/drivers/remoteproc/st_slim_rproc.c
>>> +++ b/drivers/remoteproc/st_slim_rproc.c
>>> @@ -203,7 +203,7 @@ static const struct rproc_ops slim_rproc_ops =3D {
>>>   =09.da_to_va       =3D slim_rproc_da_to_va,
>>>   =09.get_boot_addr=09=3D rproc_elf_get_boot_addr,
>>>   =09.load=09=09=3D rproc_elf_load_segments,
>>> -=09.sanity_check=09=3D rproc_elf32_sanity_check,
>>> +=09.sanity_check=09=3D rproc_elf_sanity_check,
>>>   };
>>>  =20
>>>   /**
>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm3=
2_rproc.c
>>> index 6a66dbf2df40..2e07a95439c8 100644
>>> --- a/drivers/remoteproc/stm32_rproc.c
>>> +++ b/drivers/remoteproc/stm32_rproc.c
>>> @@ -505,7 +505,7 @@ static struct rproc_ops st_rproc_ops =3D {
>>>   =09.load=09=09=3D rproc_elf_load_segments,
>>>   =09.parse_fw=09=3D stm32_rproc_parse_fw,
>>>   =09.find_loaded_rsc_table =3D rproc_elf_find_loaded_rsc_table,
>>> -=09.sanity_check=09=3D rproc_elf32_sanity_check,
>>> +=09.sanity_check=09=3D rproc_elf_sanity_check,
>>>   =09.get_boot_addr=09=3D rproc_elf_get_boot_addr,
>>>   };
>>>  =20
>>>
