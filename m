Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DA3C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3833A206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579456738;
	bh=mT0Uxzq5onKGX7RnVyLTKIhtj3jJF6fLqPFpyYCi82Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mT3D8pDELAUE6WkCdL7DbTEGw+Eyf2RVhU3W5C3ZrrZ5Rkw/oSw2xwGzZfC8Qe4YR
	 zbk7v3A79li1El8iqRF8CBMApW22Iof7zcGR+LEeyob6rhVrky/7rxissVJeA9WCwQ
	 Fsa5fmdUuRrn78tAM7+fLoMgo//oWv2+ZD0KZSPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgASR64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 12:58:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgASR64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 12:58:56 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A99920684;
        Sun, 19 Jan 2020 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579456734;
        bh=mT0Uxzq5onKGX7RnVyLTKIhtj3jJF6fLqPFpyYCi82Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=InJm9RlxWDH1LktQ/klJRdyuOFGDKd3INkwDthBwngqqrIjSkKlP3avdT2IHoCtJG
         QVY05Zlw/vgty6hQmfKRSBrO0tlvd3LeHcWoVTZZLdJKw1EGPt1tx9k2XIt29OnCUF
         Um58znkTSMlb9yeAl+D/lVd6/hc26rU9vsCpt4iU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1itEqa-0004H2-OX; Sun, 19 Jan 2020 17:58:52 +0000
Date:   Sun, 19 Jan 2020 17:58:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        andrew.murray@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
Subject: Re: [RFC 2/3] KVM: arm64: pmu: Fix chained SW_INCR counters
Message-ID: <20200119175851.2104d86f@why>
In-Reply-To: <145cdd1c-266c-6252-9688-e9e4c6809dfd@redhat.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
        <20191204204426.9628-3-eric.auger@redhat.com>
        <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
        <2b30c1ca-3bc0-9f73-4bea-ee42bb74cbac@redhat.com>
        <15507faca89a980056df7119e105e82a@www.loen.fr>
        <145cdd1c-266c-6252-9688-e9e4c6809dfd@redhat.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, andrew.murray@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 20:01:42 +0100
Auger Eric <eric.auger@redhat.com> wrote:

Hi Eric,

> Hi Marc,
>=20
> On 12/5/19 3:52 PM, Marc Zyngier wrote:
> > On 2019-12-05 14:06, Auger Eric wrote: =20
> >> Hi Marc,
> >>
> >> On 12/5/19 10:43 AM, Marc Zyngier wrote: =20
> >>> Hi Eric,
> >>>
> >>> On 2019-12-04 20:44, Eric Auger wrote: =20
> >>>> At the moment a SW_INCR counter always overflows on 32-bit
> >>>> boundary, independently on whether the n+1th counter is
> >>>> programmed as CHAIN.
> >>>>
> >>>> Check whether the SW_INCR counter is a 64b counter and if so,
> >>>> implement the 64b logic.
> >>>>
> >>>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> ---
> >>>> =C2=A0virt/kvm/arm/pmu.c | 16 +++++++++++++++-
> >>>> =C2=A01 file changed, 15 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> >>>> index c3f8b059881e..7ab477db2f75 100644
> >>>> --- a/virt/kvm/arm/pmu.c
> >>>> +++ b/virt/kvm/arm/pmu.c
> >>>> @@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcpu
> >>>> *vcpu, u64 val)
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 enable =3D __vcpu_sys_reg(vcpu, PMCNTENSET_=
EL0);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARMV8_PMU_CYCLE_IDX; i++)=
 {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool chained =3D test_bi=
t(i >> 1, vcpu->arch.pmu.chained);
> >>>> + =20
> >>>
> >>> I'd rather you use kvm_pmu_pmc_is_chained() rather than open-coding
> >>> this. But see below:
> >>> =20
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(val & BIT(i)))
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 continue;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D __vcpu_sys=
_reg(vcpu, PMEVTYPER0_EL0 + i)
> >>>> @@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct kvm_vcpu
> >>>> *vcpu, u64 val)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D lower_32_bits(reg);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) =3D reg;
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!reg)
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (reg) /* no overflow */
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (chained) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1=
) + 1;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D lower_32_bits(reg);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) =3D re=
g;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (reg)
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* mark an overflow on high counter */
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i + 1);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
} else {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* mark an overflow */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(=
i);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0} =20
> >>>
> >>> I think the whole function is a bit of a mess, and could be better
> >>> structured to treat 64bit counters as a first class citizen.
> >>>
> >>> I'm suggesting something along those lines, which tries to
> >>> streamline things a bit and keep the flow uniform between the
> >>> two word sizes. IMHO, it helps reasonning about it and gives
> >>> scope to the ARMv8.5 full 64bit counters... It is of course
> >>> completely untested. =20
> >>
> >> Looks OK to me as well. One remark though, don't we need to test if the
> >> n+1th reg is enabled before incrementing it? =20
> >=20
> > Hmmm. I'm not sure. I think we should make sure that we don't flag
> > a counter as being chained if the odd counter is disabled, rather
> > than checking it here. As long as the odd counter is not chained
> > *and* enabled, we shouldn't touch it.>
> > Again, untested:
> >=20
> > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > index cf371f643ade..47366817cd2a 100644
> > --- a/virt/kvm/arm/pmu.c
> > +++ b/virt/kvm/arm/pmu.c
> > @@ -15,6 +15,7 @@
> > =C2=A0#include <kvm/arm_vgic.h>
> >=20
> > =C2=A0static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64
> > select_idx);
> > +static void kvm_pmu_update_pmc_chained(struct kvm_vcpu *vcpu, u64
> > select_idx);
> >=20
> > =C2=A0#define PERF_ATTR_CFG1_KVM_PMU_CHAINED 0x1
> >=20
> > @@ -298,6 +299,7 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu
> > *vcpu, u64 val)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For high count=
ers of chained events we must recreate the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * perf event wit=
h the long (64bit) attribute set.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_pmu_update_pmc_chained(=
vcpu, i);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_pmu_pmc_is_cha=
ined(pmc) &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 kvm_pmu_idx_is_high_counter(i)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 kvm_pmu_create_perf_event(vcpu, i);
> > @@ -645,7 +647,8 @@ static void kvm_pmu_update_pmc_chained(struct
> > kvm_vcpu *vcpu, u64 select_idx)
> > =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_pmu *pmu =3D &vcpu->arch.pmu;
> > =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_pmc *pmc =3D &pmu->pmc[select_idx];
> >=20
> > -=C2=A0=C2=A0=C2=A0 if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx)) {
> > +=C2=A0=C2=A0=C2=A0 if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_pmu_counter_is_enabled(=
vcpu, pmc->idx)) { =20
>=20
> In create_perf_event(), has_chain_evtype() is used and a 64b sample
> period would be chosen even if the counters are disjoined (since the odd
> is disabled). We would need to use pmc_is_chained() instead.
>=20
> With perf_events, the check of whether the odd register is enabled is
> properly done (create_perf_event). Then I understand whenever there is a
> change in enable state or type we delete the previous perf event and
> re-create a new one. Enable state check just is missing for SW_INCR.

Can you please respin this? I'd like to have it queued quickly, if at
all possible.

>=20
> Some other questions:
> - do we need a perf event to be created even if the counter is not
> enabled? For instance on counter resets, create_perf_events get called.

It shouldn't be necessary.

> - also actions are made for counters which are not implemented. loop
> until ARMV8_PMU_MAX_COUNTERS. Do you think it is valuable to have a
> bitmask of supported counters stored before pmu readiness?
> I can propose such changes if you think they are valuable.

That would certainly be a performance optimization.

Thanks,

	M.
--=20
Jazz is not dead. It just smells funny...
