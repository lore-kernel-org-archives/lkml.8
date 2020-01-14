Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E57C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872B2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaI4/us4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgANIVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:21:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54427 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgANIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578990060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuWgcBzyxfCZHiZvCkvjwdRcBMrfoCkxiwSI2/QXtic=;
        b=SaI4/us4C7hys9J19qZ59ukWTWyrIVdOfLQDY65wp7NOfj+SEsVbxisZOfJ2Q8KyAC4ziC
        ixjnpiWDlmX4b2zghgCFqlL4uWIG4orAplw1Z2d59LnoM/HqyFS3EpwiaZC1qtvchtzzyK
        5fh4fDBODA3Wsgo/PjInjuonhtaFITY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-QV_CL5bGPSqijPl5J2PZ6g-1; Tue, 14 Jan 2020 03:20:56 -0500
X-MC-Unique: QV_CL5bGPSqijPl5J2PZ6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4D7800A02;
        Tue, 14 Jan 2020 08:20:54 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 592175D9E5;
        Tue, 14 Jan 2020 08:20:52 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Check hopefully the last
 DISCARD command error
To:     Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org
Cc:     andre.przywara@arm.com, wanghaibin.wang@huawei.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191225133014.1825-1-yuzenghui@huawei.com>
 <f9997198-c990-d638-24d0-41d6280a9d8a@redhat.com>
 <41c88abb-433a-f87c-c858-7f2eb4c40926@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <615c4713-d00e-e2f7-c2d4-fa8047355c9b@redhat.com>
Date:   Tue, 14 Jan 2020 09:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <41c88abb-433a-f87c-c858-7f2eb4c40926@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 1/14/20 8:10 AM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/1/10 16:37, Auger Eric wrote:
>> Hi Zenghui,
>>
>> On 12/25/19 2:30 PM, Zenghui Yu wrote:
>>> DISCARD command error occurs if any of the following apply:
>>>
>>> =C2=A0 - [ ... (those which we have already handled) ]
>> nit: I would remove the above and simply say the discard is supposed t=
o
>> fail if the collection is not mapped to any target redistributor. If a=
n
>> ITE exists then the ite->collection is non NULL.
>=20
> I think this is not always true. Let's talk about the following scenari=
o
> (a bit insane, though):
>=20
> 1. First map a LPI to an unmapped Collection, then ite->collection is
> =C2=A0=C2=A0 non NULL and its target_addr is COLLECTION_NOT_MAPPED.
>=20
> 2. Then issue MAPC and unMAPC(V=3D0) commands on this Collection, the
> =C2=A0=C2=A0 ite->collection will be NULL, see vgic_its_free_collection=
().
You're right I missed that case.
>=20
> Discard the LPI mapping after "1" or "2", we will both encounter the
> unmapped collection command error.
>=20
>> What needs to be checked is its_is_collection_mapped().
>>
>> By the way update_affinity_collection() also tests ite->collection. I
>> think this is useless or do I miss something?
>=20
> Yeah, I agree. We managed to invoke update_affinity_collection(,, coll)=
,
> ensure that the 'coll' can _not_ be NULL.
> So '!ite->collection' is already a subcase of 'coll !=3D ite->collectio=
n'.
> We can safely get rid of it.
OK. But that's not for the (wrong) reason I mentioned above. So it is a
minor cleanup and you may just leave it as is and just focus on this fix.

Thanks

Eric
>=20
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
>=20
> Thanks for that. I'll change the commit message with your suggestion an=
d
> add your R-b in v2.
>=20
>=20
> Thanks,
> Zenghui
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

