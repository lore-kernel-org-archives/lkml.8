Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741F2C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C982187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="lygI9pvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgAOPLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:11:06 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:45312 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:11:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 1DEB827E0D9F;
        Wed, 15 Jan 2020 16:11:04 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jGtPhsUPDTD7; Wed, 15 Jan 2020 16:11:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 70FFB27E1110;
        Wed, 15 Jan 2020 16:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 70FFB27E1110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1579101063;
        bh=tQNg8W4B8It38KS9py0wzoez0QyArcbSpmUEs0bg+o0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lygI9pvO6qxSgj7WW4L36Q07iz/d/9CzwOB5QZlVMV8QfEkOH3XzgoaMZRtQ8Y3rc
         dFz1W3A7aLZbniZ9L32Lv6NazsQECc76Uc2GzwSmPS6PpuoU24IwNEpomo42W8F+78
         HdIvkdkAdNxotcJctFLAFV5FTq3GILww6f2vZRvg=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YGtuSEVMnM9r; Wed, 15 Jan 2020 16:11:03 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5CC8127E0D9F;
        Wed, 15 Jan 2020 16:11:03 +0100 (CET)
Date:   Wed, 15 Jan 2020 16:11:03 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <612100872.12377996.1579101063237.JavaMail.zimbra@kalray.eu>
In-Reply-To: <a1116656-cf2e-c1a1-7cc3-0fe2a79f076e@st.com>
References: <20200115102142.11229-1-cleger@kalray.eu> <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com> <79048597.12371594.1579098506802.JavaMail.zimbra@kalray.eu> <a1116656-cf2e-c1a1-7cc3-0fe2a79f076e@st.com>
Subject: Re: [PATCH] remoteproc: Add support for predefined notifyids
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - GC75 (Linux)/8.8.12_GA_3794)
Thread-Topic: remoteproc: Add support for predefined notifyids
Thread-Index: J8aJAfA4my59MouK2aS5tI7ySP9YKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 15 Jan, 2020, at 16:09, Arnaud Pouliquen arnaud.pouliquen@st.com w=
rote:

> On 1/15/20 3:28 PM, Cl=C3=A9ment Leger wrote:
>> Hi Arnaud,
>>=20
>> ----- On 15 Jan, 2020, at 15:06, Arnaud Pouliquen arnaud.pouliquen@st.co=
m wrote:
>>=20
>>> Hi Cl=C3=A9ment,
>>>
>>> On 1/15/20 11:21 AM, Clement Leger wrote:
>>>> In order to support preallocated notify ids, if their value is
>>>> equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
>>>> dynamically but try to allocate the requested one. This is useful when
>>>> using custom ids to bind them to custom vendor resources. For instance=
,
>>>> it allow to assign a group of queues to a specific interrupti in order
>>>> to dispatch notifications.
>>>>
>>>> Signed-off-by: Clement Leger <cleger@kalray.eu>
>>>> ---
>>>>  drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++--------
>>>>  include/linux/remoteproc.h           |  1 +
>>>>  2 files changed, 20 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>>> b/drivers/remoteproc/remoteproc_core.c
>>>> index 307df98347ba..b1485fcd0f11 100644
>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>> @@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, =
int i)
>>>>  =09/*
>>>>  =09 * Assign an rproc-wide unique index for this vring
>>>>  =09 * TODO: assign a notifyid for rvdev updates as well
>>>> -=09 * TODO: support predefined notifyids (via resource table)
>>>>  =09 */
>>>> -=09ret =3D idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
>>>> -=09if (ret < 0) {
>>>> -=09=09dev_err(dev, "idr_alloc failed: %d\n", ret);
>>>> -=09=09return ret;
>>>> +=09if (rsc->vring[i].notifyid =3D=3D FW_RSC_NOTIFY_ID_ANY) {
>>>> +=09=09ret =3D idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
>>>> +=09=09if (ret < 0) {
>>>> +=09=09=09dev_err(dev, "idr_alloc failed: %d\n", ret);
>>>> +=09=09=09return ret;
>>>> +=09=09}
>>>> +=09=09notifyid =3D ret;
>>>> +
>>>> +=09=09/* Let the rproc know the notifyid of this vring.*/
>>>> +=09=09rsc->vring[i].notifyid =3D notifyid;
>>>> +=09} else {
>>>> +=09=09/* Reserve requested notify_id */
>>>> +=09=09notifyid =3D rsc->vring[i].notifyid;
>>>> +=09=09ret =3D idr_alloc(&rproc->notifyids, rvring, notifyid,
>>>> +=09=09=09=09notifyid + 1, GFP_KERNEL);
>>>> +=09=09if (ret < 0) {
>>>> +=09=09=09dev_err(dev, "idr_alloc failed: %d\n", ret);
>>>> +=09=09=09return ret;
>>>> +=09=09}
>>>>  =09}
>>>> -=09notifyid =3D ret;
>>>> =20
>>>>  =09/* Potentially bump max_notifyid */
>>>>  =09if (notifyid > rproc->max_notifyid)
>>>> @@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, in=
t i)
>>>> =20
>>>>  =09rvring->notifyid =3D notifyid;
>>>> =20
>>>> -=09/* Let the rproc know the notifyid of this vring.*/
>>>> -=09rsc->vring[i].notifyid =3D notifyid;
>>>>  =09return 0;
>>>>  }
>>> The rproc_free_vring function resets the notifyid to -1 on free.
>>> This could generate a side effect if the resource table is not reloaded=
.
>>=20
>> Oh indeed, I did not thought of that. What would you recommend ?
>> If using -1 in free vring, notify ids will be reallocated at next
>> round.
> Regarding the code i'm not sure that it is useful to reset the notifyID t=
o -1 on
> free.
> In current version, on alloc, the notifyID is overwriten without check.
> And as vdev status is updated, vring struct in resource table should be
> considered as invalid
> Except if i missed a usecase/race condition...
>=20
>>=20
>> I was also worried that it would break some existing user applications
>> which uses "0" as a notify id in vring but expect the id to be
>> allocated dynamically. With my modification, it means it will try to
>> use "0" as a predefined id, leading to allocation failure.
>>=20
> Yes this could introduce regression for firmware that sets 0 as default v=
alue.
> Probably better to introduce this patch with a new version of the resourc=
e table
> :)

Understood ;)

Regards,

Cl=C3=A9ment

>=20
> Regards
> Arnaud
>>>
>>>> =20
>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>> index 16ad66683ad0..dcae3394243e 100644
>>>> --- a/include/linux/remoteproc.h
>>>> +++ b/include/linux/remoteproc.h
>>>> @@ -123,6 +123,7 @@ enum fw_resource_type {
>>>>  };
>>>> =20
>>>>  #define FW_RSC_ADDR_ANY (-1)
>>>> +#define FW_RSC_NOTIFY_ID_ANY (-1)This define can also be used in
>>>> rproc_free_vring
>>=20
>> Indeed.
>>=20
>> Thanks for your review.
>>=20
>> Regards,
>>=20
>> Cl=C3=A9ment
>>=20
>>>
>>> Regards,
>>> Arnaud
>>>> =20
>>>>  /**
> >>>   * struct fw_rsc_carveout - physically contiguous memory request
