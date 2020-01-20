Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D1FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516E321835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZKGZ4tF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgATNab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:30:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29986 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbgATNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579527029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TahDzpx2FwVLwxvnjEhWFO8fvu/DLphSie6ZIG78wig=;
        b=SZKGZ4tFKTQuXPVUBU6AFyQODU2vaDRz0FITjYFKseu/uk+AwkvFtO1FkZ9cZKGYrnVEs2
        SVuyK3SFtzTy3+fDJ0uFW8NIOmhvvc7pOe5SpeQMbnhnED0HfFXNjie65vS0iC/3TPjKSL
        lEVRvfFPqgOs45+S/g8alAeyO7gyhas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-vo7-Jc-tPgOWVGMX5t687w-1; Mon, 20 Jan 2020 08:30:26 -0500
X-MC-Unique: vo7-Jc-tPgOWVGMX5t687w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8A018010C4;
        Mon, 20 Jan 2020 13:30:23 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CA2284790;
        Mon, 20 Jan 2020 13:30:18 +0000 (UTC)
Subject: Re: [RFC 2/3] KVM: arm64: pmu: Fix chained SW_INCR counters
To:     Marc Zyngier <maz@kernel.org>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        andrew.murray@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-3-eric.auger@redhat.com>
 <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
 <2b30c1ca-3bc0-9f73-4bea-ee42bb74cbac@redhat.com>
 <15507faca89a980056df7119e105e82a@www.loen.fr>
 <145cdd1c-266c-6252-9688-e9e4c6809dfd@redhat.com>
 <20200119175851.2104d86f@why>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <2a989f57-c6ff-652f-4c0d-50881639024d@redhat.com>
Date:   Mon, 20 Jan 2020 14:30:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200119175851.2104d86f@why>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,
On 1/19/20 6:58 PM, Marc Zyngier wrote:
> On Thu, 5 Dec 2019 20:01:42 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
>=20
> Hi Eric,
>=20
>> Hi Marc,
>>
>> On 12/5/19 3:52 PM, Marc Zyngier wrote:
>>> On 2019-12-05 14:06, Auger Eric wrote: =20
>>>> Hi Marc,
>>>>
>>>> On 12/5/19 10:43 AM, Marc Zyngier wrote: =20
>>>>> Hi Eric,
>>>>>
>>>>> On 2019-12-04 20:44, Eric Auger wrote: =20
>>>>>> At the moment a SW_INCR counter always overflows on 32-bit
>>>>>> boundary, independently on whether the n+1th counter is
>>>>>> programmed as CHAIN.
>>>>>>
>>>>>> Check whether the SW_INCR counter is a 64b counter and if so,
>>>>>> implement the 64b logic.
>>>>>>
>>>>>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters=
")
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>> ---
>>>>>> =C2=A0virt/kvm/arm/pmu.c | 16 +++++++++++++++-
>>>>>> =C2=A01 file changed, 15 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>>>>>> index c3f8b059881e..7ab477db2f75 100644
>>>>>> --- a/virt/kvm/arm/pmu.c
>>>>>> +++ b/virt/kvm/arm/pmu.c
>>>>>> @@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcp=
u
>>>>>> *vcpu, u64 val)
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 enable =3D __vcpu_sys_reg(vcpu, PMCNTENSE=
T_EL0);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARMV8_PMU_CYCLE_IDX; i+=
+) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool chained =3D test_=
bit(i >> 1, vcpu->arch.pmu.chained);
>>>>>> + =20
>>>>>
>>>>> I'd rather you use kvm_pmu_pmc_is_chained() rather than open-coding
>>>>> this. But see below:
>>>>> =20
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(val & BIT(i=
)))
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 continue;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D __vcpu_s=
ys_reg(vcpu, PMEVTYPER0_EL0 + i)
>>>>>> @@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct kvm_vc=
pu
>>>>>> *vcpu, u64 val)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D lower_32_bits(reg);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) =3D reg;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (!reg)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (reg) /* no overflow */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (chained) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i +=
 1) + 1;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D lower_32_bits(reg);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) =3D =
reg;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (reg)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* mark an overflow on high counter */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i + =
1);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 } else {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* mark an overflow */
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BI=
T(i);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0} =20
>>>>>
>>>>> I think the whole function is a bit of a mess, and could be better
>>>>> structured to treat 64bit counters as a first class citizen.
>>>>>
>>>>> I'm suggesting something along those lines, which tries to
>>>>> streamline things a bit and keep the flow uniform between the
>>>>> two word sizes. IMHO, it helps reasonning about it and gives
>>>>> scope to the ARMv8.5 full 64bit counters... It is of course
>>>>> completely untested. =20
>>>>
>>>> Looks OK to me as well. One remark though, don't we need to test if =
the
>>>> n+1th reg is enabled before incrementing it? =20
>>>
>>> Hmmm. I'm not sure. I think we should make sure that we don't flag
>>> a counter as being chained if the odd counter is disabled, rather
>>> than checking it here. As long as the odd counter is not chained
>>> *and* enabled, we shouldn't touch it.>
>>> Again, untested:
>>>
>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>>> index cf371f643ade..47366817cd2a 100644
>>> --- a/virt/kvm/arm/pmu.c
>>> +++ b/virt/kvm/arm/pmu.c
>>> @@ -15,6 +15,7 @@
>>> =C2=A0#include <kvm/arm_vgic.h>
>>>
>>> =C2=A0static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u6=
4
>>> select_idx);
>>> +static void kvm_pmu_update_pmc_chained(struct kvm_vcpu *vcpu, u64
>>> select_idx);
>>>
>>> =C2=A0#define PERF_ATTR_CFG1_KVM_PMU_CHAINED 0x1
>>>
>>> @@ -298,6 +299,7 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu
>>> *vcpu, u64 val)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For high cou=
nters of chained events we must recreate the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * perf event w=
ith the long (64bit) attribute set.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_pmu_update_pmc_chaine=
d(vcpu, i);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_pmu_pmc_is_c=
hained(pmc) &&
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 kvm_pmu_idx_is_high_counter(i)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 kvm_pmu_create_perf_event(vcpu, i);
>>> @@ -645,7 +647,8 @@ static void kvm_pmu_update_pmc_chained(struct
>>> kvm_vcpu *vcpu, u64 select_idx)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_pmu *pmu =3D &vcpu->arch.pmu;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_pmc *pmc =3D &pmu->pmc[select_idx=
];
>>>
>>> -=C2=A0=C2=A0=C2=A0 if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx))=
 {
>>> +=C2=A0=C2=A0=C2=A0 if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx) =
&&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_pmu_counter_is_enable=
d(vcpu, pmc->idx)) { =20
>>
>> In create_perf_event(), has_chain_evtype() is used and a 64b sample
>> period would be chosen even if the counters are disjoined (since the o=
dd
>> is disabled). We would need to use pmc_is_chained() instead.
>>
>> With perf_events, the check of whether the odd register is enabled is
>> properly done (create_perf_event). Then I understand whenever there is=
 a
>> change in enable state or type we delete the previous perf event and
>> re-create a new one. Enable state check just is missing for SW_INCR.
>=20
> Can you please respin this? I'd like to have it queued quickly, if at
> all possible.

Yes I am going to respin quickly.

Thanks

Eric
>=20
>>
>> Some other questions:
>> - do we need a perf event to be created even if the counter is not
>> enabled? For instance on counter resets, create_perf_events get called=
.
>=20
> It shouldn't be necessary.
>=20
>> - also actions are made for counters which are not implemented. loop
>> until ARMV8_PMU_MAX_COUNTERS. Do you think it is valuable to have a
>> bitmask of supported counters stored before pmu readiness?
>> I can propose such changes if you think they are valuable.
>=20
> That would certainly be a performance optimization.
>=20
> Thanks,
>=20
> 	M.
>=20

