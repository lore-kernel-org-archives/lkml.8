Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB62DC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB40D20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="h0D7i/uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgEKJPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:15:44 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:60634 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKJPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:15:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 78E6827E02D1;
        Mon, 11 May 2020 11:15:41 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WDeo-rWdb0Zi; Mon, 11 May 2020 11:15:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DD1DA27E053C;
        Mon, 11 May 2020 11:15:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu DD1DA27E053C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1589188540;
        bh=1E0dJW1iWPRM52gggcDmbsBZvxVR2MdnQlbb2736LeU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=h0D7i/uhQ8BxlWA9ortvEs7mvNZz1J1xZrXrcTSUUzgDAIdsRlyhBxkQjTsH1/4N9
         6eLECjkLpZVnXfY64hL/eo6O0YUkbbVBbLevpkH+fWogwIQTo4qtHD5wLyC5iPC0Bu
         KhWwgRNh10gyWQqAKQBmpIKvgxDD5m3QXWKiJsXQ=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kRPqEYn9ZcLd; Mon, 11 May 2020 11:15:40 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id C6F1427E02D1;
        Mon, 11 May 2020 11:15:40 +0200 (CEST)
Date:   Mon, 11 May 2020 11:15:40 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     s-anna <s-anna@ti.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Message-ID: <1847639658.1891474.1589188540520.JavaMail.zimbra@kalray.eu>
In-Reply-To: <aff9b0dc-12e0-18a3-ed67-e3bed0424662@ti.com>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com> <20200410012034.GU20625@builder.lan> <AM0PR04MB44816C59A9BE84465AC8F2C388DE0@AM0PR04MB4481.eurprd04.prod.outlook.com> <20200411015104.GJ576963@builder.lan> <AM0PR04MB4481CF4ACD86C69B329D5F2188DD0@AM0PR04MB4481.eurprd04.prod.outlook.com> <07eb5b9f-60cd-6555-1904-7b348bdc43f2@ti.com> <DB6PR0402MB2760A0F6D7BC0F5AC7207E1188D50@DB6PR0402MB2760.eurprd04.prod.outlook.com> <aff9b0dc-12e0-18a3-ed67-e3bed0424662@ti.com>
Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf segments
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3895)
Thread-Topic: remoteproc: drop memset when loading elf segments
Thread-Index: biEmLGpskBEqbrR8acDJ7LHDqg0/VA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On 21 Apr, 2020, at 20:25, s-anna s-anna@ti.com wrote:

>>>
>>> Hi Peng,
>>>
>>> The trick is to use the ioremap_wc() variant instead of ioremap() in yo=
ur
>>> platform driver while mapping the TCMs. I know multiple folks have run =
into
>>> this issue. This is what most of the remoteproc drivers use, and mmio-s=
ram
>>> driver also uses the same.
>>=20
>> TCM is different from OCRAM in i.MX chips.
>> ioremap_wc not work for TCM memory, I just tried that.
>=20
> What ARM core is this? Is it a standard ARM TCM memory? The TCM
> interfaces from standard ARM cores in general are treated as normal
> memory, so write combine should be ok on them. When you say it doesn't
> work, whats not working - the memcpy/memset or the remoteproc doesn't boo=
t?
>=20
>> I am thinking we change memset/memcpy to use
>> memset_io/memcpy_fromio/memcpy_toio for remoteproc common code,
>=20
> This has other implications. Not everything is IO memory to make this
> change in the common core.

Hi Suman,

AFAIK, most (if not all) the drivers are using ioremap to expose the
remoteproc memories. Since these are IO memories, then care should be
taken when writing/reading from them and memset_io/memcpy_fromio
/memcpy_toio should be used (or ioread/write). Currently, this is not
the case in the remoteproc driver and it works because everything is
aligned and there is no misaligned access. IMHO, as suggested by Peng,
remoteproc core should use such accessors.

We (at Kalray) have some modifications to do that since
there were some misalignment after modifying the resource table (64 bits
fields).

The only drawback that I can see using io memcpy is potentially a loss
of performance for processors not requiring any alignement check. But
other than that, it seems safer for everyon and performance in init does
not seems really critical.

>=20
> If this is a custom memory interface requiring specific handling, then
> one option is to provide and use your own ops->load function within the
> driver. This is what I do for one of our remoteprocs that requires a
> specific memcpy handling semantics.

This does not only apply to firmware loading. This applies to all the
resource table accesses which are currently done using direct accesses
to members. They should also used io memcpy.

Regards,

Cl=C3=A9ment

>=20
> regards
> Suman
