Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F63C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A3208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MNpH087T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGCGBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:01:52 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10873 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCGBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:01:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efec99c0000>; Thu, 02 Jul 2020 23:01:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 23:01:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Jul 2020 23:01:51 -0700
Received: from [172.20.40.54] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jul
 2020 06:01:51 +0000
Subject: Re: [git pull] drm for 5.8-rc1
From:   James Jones <jajones@nvidia.com>
To:     Daniel Stone <daniel@fooishbar.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box>
 <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
 <20200701075719.p7h5zypdtlhqxtgv@box> <20200701075902.hhmaskxtjsm4bcx7@box>
 <77e744b9-b5e2-9e9b-44c1-98584d2ae2f3@nvidia.com>
 <CAPj87rOrUHBZZR3cw+iqUMtZL1ZQyjd=RoM2yHt5oUeRO5uDTA@mail.gmail.com>
 <5ffa32db-4383-80f6-c0cf-a9bb12e729aa@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a3d331e9-d17e-9135-68c7-8e3e10df184d@nvidia.com>
Date:   Thu, 2 Jul 2020 23:01:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ffa32db-4383-80f6-c0cf-a9bb12e729aa@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593756060; bh=oey+lAcqjyvtPJCijFnrSu5cD1hCcZdlv0Qpemv2n5g=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MNpH087ToCVSf2E1woo+gOhwKNnLwwmyP5dNaRXSCmmnzsRwSS9I9Iaex2v+2Alh+
         dztiqsiU+4thD0DK8NPqqihMwtXAntz1bnQRG85WZq/vlbn78KZ+iRXwDhhjJx69xw
         MGrlm1z5T8IKwdV5BJxExHAdCklx66RgwMV5KARhUSkuRNcw+dASGzoBTU7SiNFKZi
         zU6ZQ0O3W+EYoeDztWzbS17i/M+9hsv6EChdDx85FiAf9tvoKiTrVwZadUzAA7rrHp
         nZbeTMF7dCDsBf4rkqmRqP7Bmh5HRgUDE/FvRZNsUTeBUr02EdBaMO5yi53IyZzx65
         U8RT9QToM7UHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 2:14 PM, James Jones wrote:
> On 7/2/20 1:22 AM, Daniel Stone wrote:
>> Hi,
>>
>> On Wed, 1 Jul 2020 at 20:45, James Jones <jajones@nvidia.com> wrote:
>>> OK, I think I see what's going on.=C2=A0 In the Xorg modesetting driver=
, the
>>> logic is basically:
>>>
>>> if (gbm_has_modifiers && DRM_CAP_ADDFB2_MODIFIERS !=3D 0) {
>>> =C2=A0=C2=A0=C2=A0 drmModeAddFB2WithModifiers(..., gbm_bo_get_modifier(=
bo->gbm));
>>> } else {
>>> =C2=A0=C2=A0=C2=A0 drmModeAddFB(...);
>>> }
>>
>> I read this thread expecting to explain the correct behaviour we
>> implement in Weston and how modesetting needs to be fixed, but ...
>> that seems OK to me? As long as `gbm_has_modifiers` is a proxy for 'we
>> used gbm_(bo|surface)_create_with_modifiers to allocate the buffer'.
>=20
> Yes, the hazards of reporting findings before verifying.=C2=A0 I now see=
=20
> modesetting does query the DRM-KMS modifiers and attempt to allocate=20
> with them if it found any.=C2=A0 However, I still see a lot of ways thing=
s=20
> can go wrong, but I'm not going to share my speculation again until I've=
=20
> actually verified it, which is taking a frustratingly long time.=C2=A0 Th=
e=20
> modesetting driver is not my friend right now.

OK, several hours of dumb build+config mistakes later, I was actually=20
able to reproduce the failure and walk through things.  There is a=20
trivial fix for the issues in the X modesetting driver, working off=20
Daniel Stone's claim that gbm_bo_get_modifier() should only be called=20
when the allocation was made with gbm_bo_create_with_modifiers().=20
modeset doesn't respect that requirement now in the case that the atomic=20
modesetting path is disabled, which is always the case currently because=20
that path is broken.  Respecting that requirement is a half-liner and=20
allows X to start properly.

If I force modeset to use the atomic path, X still fails to start with=20
the above fix, validating the second theory I'd had:

-Current Mesa nouveau code basically ignores the modifier list passed in=20
unless it is a single modifier requesting linear layout, and goes about=20
allocating whatever layout it sees fit, and succeeds the allocation=20
despite being passed a list of modifiers it knows nothing about.  Not=20
great, fixed in my pending patches, obviously doesn't help existing=20
deployed userspace.

-Current Mesa nouveau code, when asked what modifier it used for the=20
above allocation, returns one of the "legacy" modifiers nouveau DRM-KMS=20
knows nothing about.

-When the modeset driver tries to create an FB for that BO with the=20
returned modifier, the nouveau kernel driver of course refuses.

I think it's probably worth fixing the modesetting driver for the=20
reasons Daniel Vetter mentioned.  Then if I get my Mesa patches in=20
before a new modesetting driver with working Atomic support is released,=20
there'll be no need for long-term workarounds in the kernel.

Down to the real question of what to do in the kernel to support current=20
userspace code: I still think the best fix is to accept the old=20
modifiers but not advertise them.  However, Daniel Stone and others, if=20
you think this will actually break userspace in other ways (Could you=20
describe in a bit more detail or point me to test cases if so?), I=20
suppose the only option would be to advertise & accept the old modifiers=20
for now, and I suppose at a config option at some point to phase the old=20
ones out, eventually drop them entirely.  This would be unfortunate,=20
because as I mentioned, it could sometimes result in situations where=20
apps think they can share a buffer between two devices but will get=20
garbled data in practice.

I've included an initial version of the kernel patch inline below.=20
Needs more testing, but I wanted to share it in case anyone has feedback=20
on the idea, wants to see the general workflow, or wants to help test.

>>> There's no attempt to verify the DRM-KMS device supports the modifier,
>>> but then, why would there be?=C2=A0 GBM presumably chose a supported mo=
difier
>>> at buffer creation time, and we don't know which plane the FB is going
>>> to be used with yet.=C2=A0 GBM doesn't actually ask the kernel which
>>> modifiers it supports here either though.
>>
>> Right, it doesn't ask, because userspace tells it which modifiers to
>> use. The correct behaviour is to take the list from the KMS
>> `IN_FORMATS` property and then pass that to
>> `gbm_(bo|surface)_create_with_modifiers`; GBM must then select from
>> that list and only that list. If that call does not succeed and Xorg
>> falls back to `gbm_surface_create`, then it must not call
>> `gbm_bo_get_modifier` - so that would be a modesetting bug. If that
>> call does succeed and `gbm_bo_get_modifier` subsequently reports a
>> modifier which was not in the list, that's a Mesa driver bug.
>>
>>> It just goes into Mesa via
>>> DRI and reports the modifier (unpatched) Mesa chose on its own.=C2=A0 M=
esa
>>> just hard-codes the modifiers in its driver backends since its thinking
>>> in terms of a device's 3D engine, not display.=C2=A0 In theory, Mesa's =
DRI
>>> drivers could query KMS for supported modifiers if allocating from GBM
>>> using the non-modifiers path and the SCANOUT flag is set (perhaps some
>>> drivers do this or its equivalent?=C2=A0 Haven't checked.), but that se=
ems
>>> pretty gnarly and doesn't fix the modifier-based GBM allocation path
>>> AFAIK.=C2=A0 Bit of a mess.
>>
>> Two options for GBM users:
>> * call gbm_*_create_with_modifiers, it succeeds, call
>> gbm_bo_get_modifier, pass modifier into AddFB
>> * call gbm_*_create (without modifiers), it succeeds, do not call
>> gbm_bo_get_modifier, do not pass a modifier into AddFB
>>
>> Anything else is a bug in the user. Note that falling back from 1 to 2
>> is fine: if `gbm_*_create_with_modifiers()` fails, you can fall back
>> to the non-modifier path, provided you don't later try to get a
>> modifier back out.
>>
>>> For a quick userspace fix that could probably be pushed out everywhere
>>> (Only affects Xorg server 1.20+ AFAIK), just retrying
>>> drmModeAddFB2WithModifiers() without the DRM_MODE_FB_MODIFIERS flag on
>>> failure should be sufficient.
>>
>> This would break other drivers.
>=20
> I think this could be done in a way that wouldn't, though it wouldn't be=
=20
> quite as simple.=C2=A0 Let's see what the true root cause is first though=
.
>=20
>>> Still need to verify as I'm having
>>> trouble wrangling my Xorg build at the moment and I'm pressed for time.
>>> A more complete fix would be quite involved, as modesetting isn't reall=
y
>>> properly plumbed to validate GBM's modifiers against KMS planes, and it
>>> doesn't seem like GBM/Mesa/DRI should be responsible for this as noted
>>> above given the general modifier workflow/design.
>>>
>>> Most importantly, options I've considered for fixing from the kernel=20
>>> side:
>>>
>>> -Accept "legacy" modifiers in nouveau in addition to the new modifiers,
>>> though avoid reporting them to userspace as supported to avoid further
>>> proliferation.=C2=A0 This is pretty straightforward.=C2=A0 I'll need to=
 modify
>>> both the AddFB2 handler (nouveau_validate_decode_mod) and the mode set
>>> plane validation logic (nv50_plane_format_mod_supported), but it should
>>> end up just being a few lines of code.
>>
>> I do think that they should also be reported to userspace if they are
>> accepted. Other users can and do look at the modifier list to see if
>> the buffer is acceptable for a given plane, so the consistency is good
>> here. Of course, in Mesa you would want to prioritise the new
>> modifiers over the legacy ones, and not allocate or return the legacy
>> ones unless that was all you were asked for. This would involve
>> tracking the used modifier explicitly through Mesa, rather than
>> throwing it away at alloc time and then later divining it from the
>> tiling mode.
>=20
> Reporting them as supported is equivalent to reporting support for a=20
> memory layout the chips don't actually support (It corresponds to a=20
> valid layout on Tegra chips, but not on discrete NV chips).=C2=A0 This is=
=20
> what the new modifiers are trying to avoid in the first place: Implying=20
> buffers can be shared between these Tegra chips and discrete NV GPUs.
>=20
> Thanks,
> -James
>=20
>> Cheers,
>> Daniel
>>

nouveau: Accept 'legacy' format modifiers

Accept the DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK()
family of modifiers to handle broken userspace
Xorg modesetting and Mesa drivers.
---
  drivers/gpu/drm/nouveau/nouveau_display.c | 26 +++++++++++++++++++++--
  1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c=20
b/drivers/gpu/drm/nouveau/nouveau_display.c
index 496c4621cc78..31543086254b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -191,8 +191,14 @@ nouveau_decode_mod(struct nouveau_drm *drm,
  		   uint32_t *tile_mode,
  		   uint8_t *kind)
  {
+	struct nouveau_display *disp =3D nouveau_display(drm->dev);
  	BUG_ON(!tile_mode || !kind);

+	if ((modifier & (0xffull << 12)) =3D=3D 0ull) {
+		/* Legacy modifier.  Translate to this device's 'kind.' */
+		modifier |=3D disp->format_modifiers[0] & (0xffull << 12);
+	}
+
  	if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR) {
  		/* tile_mode will not be used in this case */
  		*tile_mode =3D 0;
@@ -227,6 +233,16 @@ nouveau_framebuffer_get_layout(struct=20
drm_framebuffer *fb,
  	}
  }

+static const u64 legacy_modifiers[] =3D {
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(0),
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(1),
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(2),
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(3),
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(4),
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(5),
+	DRM_FORMAT_MOD_INVALID
+};
+
  static int
  nouveau_validate_decode_mod(struct nouveau_drm *drm,
  			    uint64_t modifier,
@@ -247,8 +263,14 @@ nouveau_validate_decode_mod(struct nouveau_drm *drm,
  	     (disp->format_modifiers[mod] !=3D modifier);
  	     mod++);

-	if (disp->format_modifiers[mod] =3D=3D DRM_FORMAT_MOD_INVALID)
-		return -EINVAL;
+	if (disp->format_modifiers[mod] =3D=3D DRM_FORMAT_MOD_INVALID) {
+		for (mod =3D 0;
+		     (legacy_modifiers[mod] !=3D DRM_FORMAT_MOD_INVALID) &&
+		     (legacy_modifiers[mod] !=3D modifier);
+		     mod++);
+		if (legacy_modifiers[mod] =3D=3D DRM_FORMAT_MOD_INVALID)
+			return -EINVAL;
+	}

  	nouveau_decode_mod(drm, modifier, tile_mode, kind);

--=20
2.17.1

