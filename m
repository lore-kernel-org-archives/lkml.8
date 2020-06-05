Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBAEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494AA2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6p4AbOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFERJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgFERJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:09:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA755C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 10:09:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so10511000wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=s8YWD9RCnqEF4TZaQVMC5oFYjtu6s69kpDgaIZvDX7A=;
        b=B6p4AbOC2tchrb7j1nE5PmzEUdbj76lAx/xfAF4yGBUfLE5tJrSly2BRWptm1E8/2e
         egyq91a3tGiPIhv3bLzh17tyFqDfPRJXnaSRQIw886dqHnpXmD+kNCQkecvXAwwcbpwu
         VD72x5nvy1QHn3SrsMOthLTgaLs8jGhrrsh84WG/xufnoIDfoAPT3ya6E+Q6/evmF2I/
         hGU91OzsdNzXwZMxOaS1JXEqFEA6L7MO4K5n9tTHInlAywOWpMBFKwqU/CuS8cC8/d+R
         jqtu9u375hKyB8K7jmIarfK5S9tiyi5PTTfytMlAZOAz02gJNDauKRtgjOZ9Wvciclmk
         /Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=s8YWD9RCnqEF4TZaQVMC5oFYjtu6s69kpDgaIZvDX7A=;
        b=KwytZBkbr3JRGYVJpjLaEAB+E1RNEqV2dCbLA10Zn9gTCL0tSCBlw54Cl+2z3yn2xd
         M7JEK48cgNvkAXN2rcMnHuzZuaI+1PCSgkafxKB7KSIT6vu+ZgVFKZB6l1YkifwJ7rc9
         1ehP22SC49xlorbGpH39rSA+2uYjtnxGt5OHFBHO3Q5EzjwPYdpIbAIJEIqptpYqvqt4
         0hDAukcmNdXjDMmNidWP7rlzbnSHUpEnwHVymxJ2ogvsa0okL91R9+ETm4F/87U+wT+8
         hJXNxD14iOTrRb1Q8gzau0249ciIOecbZ1KVsG9omdvfkTDEms+xBJtDXhc0MLZg/RrX
         SIuA==
X-Gm-Message-State: AOAM5328dJG/kc6FkvWb8i4XmVGKtPygHJyT17En5oDT83KbAtiBpi3d
        2FjdgcyySqP/WIvP104LOJw=
X-Google-Smtp-Source: ABdhPJxDgfq1TXJSVZJQPfGWvL3363/0SYV4tVsvkpykIJ7ziNxGgI9QtuyfL4fmvH5ZcERaULj++Q==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr10297675wrt.160.1591376961391;
        Fri, 05 Jun 2020 10:09:21 -0700 (PDT)
Received: from macbook-pro-alvaro-eth.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id o10sm11812792wrq.40.2020.06.05.10.09.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2020 10:09:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nand: raw: use write_oob_raw for MTD_OPS_AUTO_OOB mode
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20200512105409.785febfe@collabora.com>
Date:   Fri, 5 Jun 2020 19:09:19 +0200
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, s.hauer@pengutronix.de, masonccyang@mxic.com.tw,
        christophe.kerello@st.com, stefan@agner.ch, piotrs@cadence.com,
        devik@eaxlabs.cz, tglx@linutronix.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <56DB91B3-ACCC-4E78-B489-2B4B71B8C1C2@gmail.com>
References: <20200504094253.2741109-1-noltari@gmail.com>
 <20200504123237.5c128668@collabora.com> <20200511182923.6a4961ab@xps13>
 <6F41AA9B-71D6-47FA-BC12-24941F84DA71@gmail.com>
 <20200512104422.4c31f7e0@xps13> <20200512105409.785febfe@collabora.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I=E2=80=99ve now sent another patch =E2=80=9Cmtd: rawnand: brcmnand: =
force raw OOB writes=E2=80=9D as an alternative solution to this issue.

Best regards,
=C3=81lvaro.

> El 12 may 2020, a las 10:54, Boris Brezillon =
<boris.brezillon@collabora.com> escribi=C3=B3:
>=20
> On Tue, 12 May 2020 10:44:22 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
>> Hello,
>>=20
>> Richard, maybe you'll have an idea to fix the situation here?
>>=20
>> =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com> wrote on Tue, 12 =
May 2020
>> 10:36:25 +0200:
>>=20
>>> Hi,
>>>=20
>>>> El 11 may 2020, a las 18:29, Miquel Raynal =
<miquel.raynal@bootlin.com> escribi=C3=B3:
>>>>=20
>>>> Hello,
>>>>=20
>>>> Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 4 May
>>>> 2020 12:32:37 +0200:
>>>>=20
>>>>> On Mon,  4 May 2020 11:42:53 +0200
>>>>> =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com> wrote:
>>>>>=20
>>>>>> Some NAND controllers change the ECC bytes when OOB is written =
with ECC
>>>>>> enabled.
>>>>>> This is a problem in brcmnand, since adding JFFS2 cleanmarkers =
after the page
>>>>>> has been erased will change the ECC bytes to 0 and the controller =
will think
>>>>>> the block is bad.
>>>>>> It can be fixed by using write_oob_raw, which ensures ECC is =
disabled.
>>>>>>=20
>>>>>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas =
<noltari@gmail.com>
>>>>>> ---
>>>>>> drivers/mtd/nand/raw/nand_base.c | 2 +-
>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>=20
>>>>>> diff --git a/drivers/mtd/nand/raw/nand_base.c =
b/drivers/mtd/nand/raw/nand_base.c
>>>>>> index c24e5e2ba130..755d25200520 100644
>>>>>> --- a/drivers/mtd/nand/raw/nand_base.c
>>>>>> +++ b/drivers/mtd/nand/raw/nand_base.c
>>>>>> @@ -488,7 +488,7 @@ static int nand_do_write_oob(struct nand_chip =
*chip, loff_t to,
>>>>>>=20
>>>>>> 	nand_fill_oob(chip, ops->oobbuf, ops->ooblen, ops);
>>>>>>=20
>>>>>> -	if (ops->mode =3D=3D MTD_OPS_RAW)
>>>>>> +	if (ops->mode =3D=3D MTD_OPS_AUTO_OOB || ops->mode =3D=3D =
MTD_OPS_RAW)
>>>>>> 		status =3D chip->ecc.write_oob_raw(chip, page & =
chip->pagemask);     =20
>>>>>=20
>>>>> The doc says:
>>>>>=20
>>>>> @MTD_OPS_PLACE_OOB:  OOB data are placed at the given offset =
(default)
>>>>> @MTD_OPS_AUTO_OOB:   OOB data are automatically placed at the free =
areas
>>>>>                    which are defined by the internal ecclayout
>>>>> @MTD_OPS_RAW:        data are transferred as-is, with no error
>>>>> 		     correction; this mode implies %MTD_OPS_PLACE_OOB
>>>>>=20
>>>>> To me, that means MTD_OPS_PLACE_OOB and MTD_OPS_AUTO_OOB do not =
imply
>>>>> MTD_OPS_RAW. Anyway those modes are just too vague. We really =
should
>>>>> separate the ECC-disabled/ECC-enabled concept (AKA raw vs non-raw =
mode)
>>>>> from the OOB placement scheme. IIRC, Miquel had a patchset doing =
that.
>>>>>=20
>>>>> We also should have the concept of protected OOB-region vs
>>>>> unprotected-OOB-region if we want JFFS2 to work with controllers =
that
>>>>> protect part of the OOB region. Once we have that we can patch =
JFFS2
>>>>> to write things with =
"ECC-disabled"+"auto-OOB-placement-on-unprotected
>>>>> area".   =20
>>>>=20
>>>> I see the problem but as Boris said the fix is not valid as-is.
>>>> Problem is: I don't have a better proposal yet.
>>>>=20
>>>> Is forcing JFFS2 to write cleanmarkers in raw mode only an option?  =
 =20
>>>=20
>>> The doc says that for MTD_OPS_AUTO_OOB "the data is automatically =
placed at the free areas which are defined by the internal ecclayout=E2=80=
=9D.
>>> So, if we=E2=80=99re placing this data in the free OOB area left by =
the ECC bytes it means that this automatically placed data won=E2=80=99t =
be error correctable, since it=E2=80=99s in the OOB, and the OOB data =
isn=E2=80=99t error corrected, right? =20
>>=20
>> No, free bytes sometimes are and sometimes are not covered by the ECC
>> engine. It depends on the controller.
>>=20
>>> The problem is that "flash_erase -j=E2=80=9D uses MTD_OPS_AUTO_OOB =
to write the OOB JFFS2 clean markers and if this is written with ECC =
enabled the NAND controller will change the ECC bytes to an invalid =
value (or at least brcmnand controller).
>>>=20
>>> Another option could be adding another mode, something like =
MTD_OPS_AUTO_OOB_RAW and using it in mtd-utils and JFFS2. =20
>>=20
>> No, these modes already are completely wrong, I must resend my series
>> fixing them.
>>=20
>=20
> Totally agree with Miquel on that one: let's fix the
> write/read/ecc-layout semantics instead of adding more obscure modes.

