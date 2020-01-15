Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147DFC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF850214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="RbzHxMYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAOO2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:28:32 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:49296 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAOO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:28:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 2D56827E02DE;
        Wed, 15 Jan 2020 15:28:30 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LwG_wuPjVL7U; Wed, 15 Jan 2020 15:28:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 0B21127E1256;
        Wed, 15 Jan 2020 15:28:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 0B21127E1256
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1579098507;
        bh=qIpswqWnsubgtTHTB+MyTQDqzfR9952ta7nxe9fVu3Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RbzHxMYcst2qPU14AlHS0uF2OJj8ryBhvFDhwqU1SftPos7M0+89Uuwx4B+RWdETa
         ElHTR0stic2r1SqeZ1wp9Fx3PMxKk/89+lYZK3dZ1MpSpuK2ZRj7f4bDsoKy62EX7z
         74J4xyL4JY8ZdwpubRMQsKu4rw5n3NMSJgzx9gh8=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r7kxFVGWpQUF; Wed, 15 Jan 2020 15:28:26 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id EA73D27E02DE;
        Wed, 15 Jan 2020 15:28:26 +0100 (CET)
Date:   Wed, 15 Jan 2020 15:28:26 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <79048597.12371594.1579098506802.JavaMail.zimbra@kalray.eu>
In-Reply-To: <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com>
References: <20200115102142.11229-1-cleger@kalray.eu> <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com>
Subject: Re: [PATCH] remoteproc: Add support for predefined notifyids
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3794)
Thread-Topic: remoteproc: Add support for predefined notifyids
Thread-Index: GrFV/T3a3aqevNM+y1HXDJWFpEoPPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

----- On 15 Jan, 2020, at 15:06, Arnaud Pouliquen arnaud.pouliquen@st.com w=
rote:

> Hi Cl=C3=A9ment,
>=20
> On 1/15/20 11:21 AM, Clement Leger wrote:
>> In order to support preallocated notify ids, if their value is
>> equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
>> dynamically but try to allocate the requested one. This is useful when
>> using custom ids to bind them to custom vendor resources. For instance,
>> it allow to assign a group of queues to a specific interrupti in order
>> to dispatch notifications.
>>=20
>> Signed-off-by: Clement Leger <cleger@kalray.eu>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++--------
>>  include/linux/remoteproc.h           |  1 +
>>  2 files changed, 20 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/remoteproc/remoteproc_core.c
>> b/drivers/remoteproc/remoteproc_core.c
>> index 307df98347ba..b1485fcd0f11 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, in=
t i)
>>  =09/*
>>  =09 * Assign an rproc-wide unique index for this vring
>>  =09 * TODO: assign a notifyid for rvdev updates as well
>> -=09 * TODO: support predefined notifyids (via resource table)
>>  =09 */
>> -=09ret =3D idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
>> -=09if (ret < 0) {
>> -=09=09dev_err(dev, "idr_alloc failed: %d\n", ret);
>> -=09=09return ret;
>> +=09if (rsc->vring[i].notifyid =3D=3D FW_RSC_NOTIFY_ID_ANY) {
>> +=09=09ret =3D idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
>> +=09=09if (ret < 0) {
>> +=09=09=09dev_err(dev, "idr_alloc failed: %d\n", ret);
>> +=09=09=09return ret;
>> +=09=09}
>> +=09=09notifyid =3D ret;
>> +
>> +=09=09/* Let the rproc know the notifyid of this vring.*/
>> +=09=09rsc->vring[i].notifyid =3D notifyid;
>> +=09} else {
>> +=09=09/* Reserve requested notify_id */
>> +=09=09notifyid =3D rsc->vring[i].notifyid;
>> +=09=09ret =3D idr_alloc(&rproc->notifyids, rvring, notifyid,
>> +=09=09=09=09notifyid + 1, GFP_KERNEL);
>> +=09=09if (ret < 0) {
>> +=09=09=09dev_err(dev, "idr_alloc failed: %d\n", ret);
>> +=09=09=09return ret;
>> +=09=09}
>>  =09}
>> -=09notifyid =3D ret;
>> =20
>>  =09/* Potentially bump max_notifyid */
>>  =09if (notifyid > rproc->max_notifyid)
>> @@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int =
i)
>> =20
>>  =09rvring->notifyid =3D notifyid;
>> =20
>> -=09/* Let the rproc know the notifyid of this vring.*/
>> -=09rsc->vring[i].notifyid =3D notifyid;
>>  =09return 0;
>>  }
> The rproc_free_vring function resets the notifyid to -1 on free.
> This could generate a side effect if the resource table is not reloaded.

Oh indeed, I did not thought of that. What would you recommend ?
If using -1 in free vring, notify ids will be reallocated at next
round.

I was also worried that it would break some existing user applications
which uses "0" as a notify id in vring but expect the id to be
allocated dynamically. With my modification, it means it will try to=20
use "0" as a predefined id, leading to allocation failure.

>=20
>> =20
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 16ad66683ad0..dcae3394243e 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -123,6 +123,7 @@ enum fw_resource_type {
>>  };
>> =20
>>  #define FW_RSC_ADDR_ANY (-1)
>> +#define FW_RSC_NOTIFY_ID_ANY (-1)This define can also be used in
>> rproc_free_vring

Indeed.

Thanks for your review.

Regards,

Cl=C3=A9ment

>=20
> Regards,
> Arnaud
>> =20
>>  /**
>>   * struct fw_rsc_carveout - physically contiguous memory request
