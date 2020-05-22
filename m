Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC38F206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="GBkI9Cu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgEVT2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:28:52 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:59952 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbgEVT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:28:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4885527E06AA;
        Fri, 22 May 2020 21:28:49 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id b6iUs8aZ7XqK; Fri, 22 May 2020 21:28:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 7AA1127E0840;
        Fri, 22 May 2020 21:28:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 7AA1127E0840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1590175728;
        bh=QDZ1ILKwvaxO0MLvkYfaYFAn8N9kLymelXTd+ycIlxE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GBkI9Cu9fLJj52109XeakQoWI0EY29WAtHeKR3w7/2/GaQNq1yP5MftEo2SCvbnrt
         AERtuM/cjxdn/r3X8ID78iDNK3hUt0493g2/vswLS/1ZDZE+vYDM609p/WSV87sxaf
         8DzYEOw9eNjxWIzkGYA6EvHj6lan1jHYwrQJ2bY0=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lBlZkvKX9U9Q; Fri, 22 May 2020 21:28:48 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 54F3C27E06AA;
        Fri, 22 May 2020 21:28:48 +0200 (CEST)
Date:   Fri, 22 May 2020 21:28:47 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     s-anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <811755772.4219337.1590175727911.JavaMail.zimbra@kalray.eu>
In-Reply-To: <4fab212b-a9d2-927e-d3d7-e591912fd6cf@ti.com>
References: <20200325204701.16862-1-s-anna@ti.com> <20200521180417.GJ408178@builder.lan> <997d6f9a-64ba-7a89-e909-9a5a474120b0@ti.com> <f15b0c6d-eee8-b839-0c79-a5316dbbfa7b@ti.com> <20200522173346.GJ11847@yoga> <1739080680.4218297.1590170621467.JavaMail.zimbra@kalray.eu> <1334263091.4218509.1590171014972.JavaMail.zimbra@kalray.eu> <4fab212b-a9d2-927e-d3d7-e591912fd6cf@ti.com>
Subject: Re: [PATCH 3/4] remoteproc: add support for a new 64-bit trace
 version
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC81 (Linux)/8.8.15_GA_3895)
Thread-Topic: remoteproc: add support for a new 64-bit trace version
Thread-Index: EKz8Ma+TkCvCS/nH+JoP9C9wZLySvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

----- On 22 May, 2020, at 20:59, s-anna s-anna@ti.com wrote:

> Hi Clement,
>=20
>>  > ----- On 22 May, 2020, at 20:03, Cl=C3=A9ment Leger cleger@kalray.eu =
wrote:>
>>> Hi Suman,
>>>
>>> ----- On 22 May, 2020, at 19:33, Bjorn Andersson bjorn.andersson@linaro=
.org
>>> wrote:
>>>
>>>> On Fri 22 May 09:54 PDT 2020, Suman Anna wrote:
>>>>
>>>>> On 5/21/20 2:42 PM, Suman Anna wrote:
>>>>>> Hi Bjorn,
>>>>>>
>>>>>> On 5/21/20 1:04 PM, Bjorn Andersson wrote:
>>>>>>> On Wed 25 Mar 13:47 PDT 2020, Suman Anna wrote:
>>>> [..]
>>>>>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc=
.h
>>>> [..]
>>>>>>>> +struct fw_rsc_trace2 {
>>>>>>>
>>>>>>> Sounds more like fw_rsc_trace64 to me - in particular since the ver=
sion
>>>>>>> of trace2 is 1...
>>>>>>
>>>>>> Yeah, will rename this.
>>>>>>
>>>>>>>
>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 padding;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 u64 da;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 len;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 reserved;
>>>>>>>
>>>>>>> What's the purpose of this reserved field?
>>>>>>
>>>>>> Partly to make sure the entire resource is aligned on an 8-byte, and
>>>>>> partly copied over from fw_rsc_trace entry. I guess 32-bits is alrea=
dy
>>>>>> large enough of a size for trace entries irrespective of 32-bit or
>>>>>> 64-bit traces, so I doubt if we want to make the len field also a u6=
4.
>>>>>
>>>>> Looking at this again, I can drop both padding and reserved fields, i=
f I
>>>>> move the len field before da. Any preferences/comments?
>>>
>> Sorry, my message went a bit too fast... So as I was saying:
>>=20
>> Not only the in-structure alignment matters but also in the resource tab=
le.
>> Since the resource table is often packed (see [1] for instance), if a tr=
ace
>> resource is embedded in the resource table after another resource aligne=
d
>> on 32 bits only, your 64 bits trace field will potentially end up
>> misaligned.
>=20
> Right. Since one can mix and match the resources of different sizes and
> include them in any order, the onus is going to be on the resource table
> constructors to ensure the inter-resource alignments, if any are
> required. The resource table format allows you to add padding fields in
> between if needed, and the remoteproc core relies on the offsets.

Agreed

>=20
> I can only ensure the alignment within this resource structure with
> ready-available access and conversion to/from a 64-bit type, as long as
> the resource is starting on a 64-bit boundary.
>=20
>>=20
>> To overcome this, there is multiple solutions:
>>=20
>> - Split the 64 bits fields into 32bits low and high parts:
>> Since all resources are aligned on 32bits, it will be ok
>=20
> Yes, this is one solution. At the same time, this means you need
> additional conversion logic for converting to and from 64-bit field. In
> this particular case, da is the address of the trace buffer pointer on a
> 64-bit processor, so we can directly use the address of the trace
> buffer. Guess it is a question of easier translation vs packing the
> resource table as tight as possible.

You simply have to add two wrapper such as the following:

static inline void rproc_rsc_set_addr(u32 *low, u32 *hi, u64 val)
{
=09*low =3D lower_32_bits(val);
=09*hi =3D upper_32_bits(val);
}

static inline u64 rproc_rsc_get_addr(u32 low, u32 hi)
{
=09return ((u64) hi << 32) | low;
}

This is not really difficult to use and will ensure your new trace
resource can be used easily without breaking 32 bits alignment.
Breaking compatibility is an option also and it is probably needed
to document it clearly if it is chosen to do so.

>=20
>>=20
>> - Use memcpy_from/to_io when reading/writing such fields
>> As I said in a previous message this should probably be used since
>> the memories that are accessed by rproc are io mem (ioremap in almost
>> all drivers).
>=20
> Anything running out of DDR actually doesn't need the io mem semantics,
> so we actually need to be fixing the drivers. Blindly changing the
> current memcpy to memcpy_to_io in the core loader is also not right. Any
> internal memories properties will actually depend on the processor and
> SoC. Eg: The R5 TCM interfaces in general can be treated as normal memori=
es.

Agreed, this is most of the case indeed where the memories are actually
accessible directly. But using ioremap potentially creates a mapping that
does not support misaligned accesses and so accesses should be always align=
ed.
memcpy_from/to_io ensures that.
IMHO, there is probably something to be rework since the drivers are mappin=
g
the memories but the core is accessing this memory, knowing nothing about
how it was mapped.

Regards,

Cl=C3=A9ment

>=20
> regards
> Suman
>=20
>>=20
>> Regards,
>>=20
>> Cl=C3=A9ment
>>=20
>> [1]
>> https://github.com/OpenAMP/open-amp/blob/master/apps/machine/zynqmp_r5/r=
sc_table.h
>>>
>>>
>>>
>>>
>>>>>
>>>>
>>>> Sounds good to me.
>>>>
>>>> Thanks,
> >>> Bjorn
