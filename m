Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F1DC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4243020674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiJsisWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgELIgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbgELIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:36:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:36:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so14258603wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DMbCWzJsZM9DNTLzWEC8TAykJzUse/sU79x4x91C8Yo=;
        b=FiJsisWPn2KGy1wWHzBWq7nclevQuBINRZTmi8N6JLqVbR/oVnEk8Ttyx9bGcKT9nR
         ig/Lzc4Znqz38Yu+0edEZOvXpiJoN2FqhOeIWoi6Vm7qzTn/YVlYhtOKj9EZYuF5OlVU
         BNEqjI7jJz8OkKhP1J9CvbkDC/KVv9vS/yujGSPhJP8rR5iU7axxDyISX2Z5J2ZBseEv
         nj6uvntA5SfQtxQTW3OSOImDztMzGWXczLeCSXfsnrafNitkjId9t4SmkJFkHMh3yhgh
         UEdLHhVlbWyQ7evEQHcRdbFnv9IK77nYs5oNCOw/8jS6o3Kd0/cqeyObqxGiKvHJfsDc
         c5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DMbCWzJsZM9DNTLzWEC8TAykJzUse/sU79x4x91C8Yo=;
        b=n1oM1lx1V6aSFhGQmeB5MgCIdnL1lkuBOmhqku/n1OFm5mY4umuqWwLv6BOr4VAWNl
         jrUAhpLzuFqg7s4YGyu4X2J+uGAi+/RL/veUZ5BDW+MwZIMgK2sIHMb5VioZJgTaX+GD
         LaASqk9YvyzjyabBOiiAVvvVNdna3mk47hfrcvKxOp90MVlg4+yHhQ8/WL6dSWlm/smY
         xxoSS+MxRfOwcyZHONW9m4aIAABaYmC72Yn8qyHxHpSRMIxhu1S+G5NpD78RBIHc5H9L
         sDQBSSQhzyMM7ZIHWmPv26aHP9B27kerg1/6qki0Sv3ofrQUrFk7uzdq5vDaOHb9OZpA
         I16w==
X-Gm-Message-State: AGi0PuY2tW6sqZRQqX30EFMxvJ2Fm6F4FYTAUHiqtIfBLydSjNWtsozp
        vK2waFMRWSRklyhtMHqsZTI=
X-Google-Smtp-Source: APiQypKvU4+RHSTrvSDGPNDm9fnWGR9yw7wjSnwOTTnkAQLGwcIipeHB/l3vNdoHsb1U9asimbf+OQ==
X-Received: by 2002:adf:e450:: with SMTP id t16mr13673642wrm.66.1589272591116;
        Tue, 12 May 2020 01:36:31 -0700 (PDT)
Received: from macbook-pro-alvaro.lan (198.red-83-49-57.dynamicip.rima-tde.net. [83.49.57.198])
        by smtp.gmail.com with ESMTPSA id f128sm18329615wme.1.2020.05.12.01.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 01:36:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nand: raw: use write_oob_raw for MTD_OPS_AUTO_OOB mode
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20200511182923.6a4961ab@xps13>
Date:   Tue, 12 May 2020 10:36:25 +0200
Cc:     Boris Brezillon <boris.brezillon@collabora.com>, richard@nod.at,
        vigneshr@ti.com, s.hauer@pengutronix.de, masonccyang@mxic.com.tw,
        christophe.kerello@st.com, stefan@agner.ch, piotrs@cadence.com,
        devik@eaxlabs.cz, tglx@linutronix.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F41AA9B-71D6-47FA-BC12-24941F84DA71@gmail.com>
References: <20200504094253.2741109-1-noltari@gmail.com>
 <20200504123237.5c128668@collabora.com> <20200511182923.6a4961ab@xps13>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> El 11 may 2020, a las 18:29, Miquel Raynal <miquel.raynal@bootlin.com> =
escribi=C3=B3:
>=20
> Hello,
>=20
> Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 4 May
> 2020 12:32:37 +0200:
>=20
>> On Mon,  4 May 2020 11:42:53 +0200
>> =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com> wrote:
>>=20
>>> Some NAND controllers change the ECC bytes when OOB is written with =
ECC
>>> enabled.
>>> This is a problem in brcmnand, since adding JFFS2 cleanmarkers after =
the page
>>> has been erased will change the ECC bytes to 0 and the controller =
will think
>>> the block is bad.
>>> It can be fixed by using write_oob_raw, which ensures ECC is =
disabled.
>>>=20
>>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>>> ---
>>> drivers/mtd/nand/raw/nand_base.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/mtd/nand/raw/nand_base.c =
b/drivers/mtd/nand/raw/nand_base.c
>>> index c24e5e2ba130..755d25200520 100644
>>> --- a/drivers/mtd/nand/raw/nand_base.c
>>> +++ b/drivers/mtd/nand/raw/nand_base.c
>>> @@ -488,7 +488,7 @@ static int nand_do_write_oob(struct nand_chip =
*chip, loff_t to,
>>>=20
>>> 	nand_fill_oob(chip, ops->oobbuf, ops->ooblen, ops);
>>>=20
>>> -	if (ops->mode =3D=3D MTD_OPS_RAW)
>>> +	if (ops->mode =3D=3D MTD_OPS_AUTO_OOB || ops->mode =3D=3D =
MTD_OPS_RAW)
>>> 		status =3D chip->ecc.write_oob_raw(chip, page & =
chip->pagemask); =20
>>=20
>> The doc says:
>>=20
>> @MTD_OPS_PLACE_OOB:  OOB data are placed at the given offset =
(default)
>> @MTD_OPS_AUTO_OOB:   OOB data are automatically placed at the free =
areas
>>                     which are defined by the internal ecclayout
>> @MTD_OPS_RAW:        data are transferred as-is, with no error
>> 		     correction; this mode implies %MTD_OPS_PLACE_OOB
>>=20
>> To me, that means MTD_OPS_PLACE_OOB and MTD_OPS_AUTO_OOB do not imply
>> MTD_OPS_RAW. Anyway those modes are just too vague. We really should
>> separate the ECC-disabled/ECC-enabled concept (AKA raw vs non-raw =
mode)
>> from the OOB placement scheme. IIRC, Miquel had a patchset doing =
that.
>>=20
>> We also should have the concept of protected OOB-region vs
>> unprotected-OOB-region if we want JFFS2 to work with controllers that
>> protect part of the OOB region. Once we have that we can patch JFFS2
>> to write things with =
"ECC-disabled"+"auto-OOB-placement-on-unprotected
>> area".
>=20
> I see the problem but as Boris said the fix is not valid as-is.
> Problem is: I don't have a better proposal yet.
>=20
> Is forcing JFFS2 to write cleanmarkers in raw mode only an option?

The doc says that for MTD_OPS_AUTO_OOB "the data is automatically placed =
at the free areas which are defined by the internal ecclayout=E2=80=9D.
So, if we=E2=80=99re placing this data in the free OOB area left by the =
ECC bytes it means that this automatically placed data won=E2=80=99t be =
error correctable, since it=E2=80=99s in the OOB, and the OOB data =
isn=E2=80=99t error corrected, right?

The problem is that "flash_erase -j=E2=80=9D uses MTD_OPS_AUTO_OOB to =
write the OOB JFFS2 clean markers and if this is written with ECC =
enabled the NAND controller will change the ECC bytes to an invalid =
value (or at least brcmnand controller).

Another option could be adding another mode, something like =
MTD_OPS_AUTO_OOB_RAW and using it in mtd-utils and JFFS2.

Best regards,
=C3=81lvaro.=
