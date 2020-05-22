Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F92FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA62072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="NVtj+Ij+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgEVSKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:10:18 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:51130 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgEVSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:10:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 002A727E06AA;
        Fri, 22 May 2020 20:10:16 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R-U1f_76ElBJ; Fri, 22 May 2020 20:10:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 43C3A27E1552;
        Fri, 22 May 2020 20:10:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 43C3A27E1552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1590171015;
        bh=bK83LII32CYIXyNdBCoJRVs5oREoCEW0+9bccKTq9hk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NVtj+Ij+ss4G7UKccUqDpaqJ6k3alv4FFmlutBMH6TKECR4B9pdEfjUey3hS29asP
         k4AzlgGLkGIHc7LSyAhWmtBYuCuO97RXvvmJInVeW9rkiPh625qIIX98U6vAdUaMxt
         abGB0OGkTCP4INpZmk7pAhPs1rTMvOKkR1/ZqyWw=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id efYqJTyB0HMQ; Fri, 22 May 2020 20:10:15 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 286DD27E06AA;
        Fri, 22 May 2020 20:10:15 +0200 (CEST)
Date:   Fri, 22 May 2020 20:10:14 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     s-anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1334263091.4218509.1590171014972.JavaMail.zimbra@kalray.eu>
In-Reply-To: <1739080680.4218297.1590170621467.JavaMail.zimbra@kalray.eu>
References: <20200325204701.16862-1-s-anna@ti.com> <20200325204701.16862-4-s-anna@ti.com> <20200521180417.GJ408178@builder.lan> <997d6f9a-64ba-7a89-e909-9a5a474120b0@ti.com> <f15b0c6d-eee8-b839-0c79-a5316dbbfa7b@ti.com> <20200522173346.GJ11847@yoga> <1739080680.4218297.1590170621467.JavaMail.zimbra@kalray.eu>
Subject: Re: [PATCH 3/4] remoteproc: add support for a new 64-bit trace
 version
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3895)
Thread-Topic: remoteproc: add support for a new 64-bit trace version
Thread-Index: L30XW51sgsk7NRKU7I+TV4VplJ8G6Xb707z7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 22 May, 2020, at 20:03, Cl=C3=A9ment Leger cleger@kalray.eu wrote:

> Hi Suman,
>=20
> ----- On 22 May, 2020, at 19:33, Bjorn Andersson bjorn.andersson@linaro.o=
rg
> wrote:
>=20
>> On Fri 22 May 09:54 PDT 2020, Suman Anna wrote:
>>=20
>>> On 5/21/20 2:42 PM, Suman Anna wrote:
>>> > Hi Bjorn,
>>> >=20
>>> > On 5/21/20 1:04 PM, Bjorn Andersson wrote:
>>> > > On Wed 25 Mar 13:47 PDT 2020, Suman Anna wrote:
>> [..]
>>> > > > diff --git a/include/linux/remoteproc.h b/include/linux/remotepro=
c.h
>> [..]
>>> > > > +struct fw_rsc_trace2 {
>>> > >=20
>>> > > Sounds more like fw_rsc_trace64 to me - in particular since the ver=
sion
>>> > > of trace2 is 1...
>>> >=20
>>> > Yeah, will rename this.
>>> >=20
>>> > >=20
>>> > > > +=C2=A0=C2=A0=C2=A0 u32 padding;
>>> > > > +=C2=A0=C2=A0=C2=A0 u64 da;
>>> > > > +=C2=A0=C2=A0=C2=A0 u32 len;
>>> > > > +=C2=A0=C2=A0=C2=A0 u32 reserved;
>>> > >=20
>>> > > What's the purpose of this reserved field?
>>> >=20
>>> > Partly to make sure the entire resource is aligned on an 8-byte, and
>>> > partly copied over from fw_rsc_trace entry. I guess 32-bits is alread=
y
>>> > large enough of a size for trace entries irrespective of 32-bit or
>>> > 64-bit traces, so I doubt if we want to make the len field also a u64=
.
>>>=20
>>> Looking at this again, I can drop both padding and reserved fields, if =
I
>>> move the len field before da. Any preferences/comments?
>=20
Sorry, my message went a bit too fast... So as I was saying:

Not only the in-structure alignment matters but also in the resource table.
Since the resource table is often packed (see [1] for instance), if a trace
resource is embedded in the resource table after another resource aligned
on 32 bits only, your 64 bits trace field will potentially end up
misaligned.

To overcome this, there is multiple solutions:

- Split the 64 bits fields into 32bits low and high parts:
Since all resources are aligned on 32bits, it will be ok

- Use memcpy_from/to_io when reading/writing such fields
As I said in a previous message this should probably be used since
the memories that are accessed by rproc are io mem (ioremap in almost
all drivers).

Regards,

Cl=C3=A9ment

[1]  https://github.com/OpenAMP/open-amp/blob/master/apps/machine/zynqmp_r5=
/rsc_table.h
>=20
>=20
>=20
>=20
>>>=20
>>=20
>> Sounds good to me.
>>=20
>> Thanks,
> > Bjorn
