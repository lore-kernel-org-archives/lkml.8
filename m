Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A3020720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGIHKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:10:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:50998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIHKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:10:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 536DBAD39;
        Thu,  9 Jul 2020 07:10:06 +0000 (UTC)
Subject: Re: [PATCH] drm/aspeed: Call drm_fbdev_generic_setup after
 drm_dev_register
To:     Joel Stanley <joel@jms.id.au>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, g@ravnborg.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20200701001002.74997-1-linux@roeck-us.net>
 <20200701091021.GA266726@ravnborg.org>
 <CACPK8Xcb2jskKRsPEQ98Ty-yetkUZbZ8KzTGZ-ncc43nSXsRug@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <c19953bc-869e-c658-9f6c-77518509c663@suse.de>
Date:   Thu, 9 Jul 2020 09:10:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xcb2jskKRsPEQ98Ty-yetkUZbZ8KzTGZ-ncc43nSXsRug@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JwgtHqzHNQAcMByFqRGSr0iHYSHSfrKV5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JwgtHqzHNQAcMByFqRGSr0iHYSHSfrKV5
Content-Type: multipart/mixed; boundary="awGEYJbYIkEgYRNRLAcJkVCfUCPzIzUn3";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Joel Stanley <joel@jms.id.au>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@linux.ie>
Cc: linux-aspeed <linux-aspeed@lists.ozlabs.org>,
 Andrew Jeffery <andrew@aj.id.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, g@ravnborg.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Guenter Roeck <linux@roeck-us.net>
Message-ID: <c19953bc-869e-c658-9f6c-77518509c663@suse.de>
Subject: Re: [PATCH] drm/aspeed: Call drm_fbdev_generic_setup after
 drm_dev_register
References: <20200701001002.74997-1-linux@roeck-us.net>
 <20200701091021.GA266726@ravnborg.org>
 <CACPK8Xcb2jskKRsPEQ98Ty-yetkUZbZ8KzTGZ-ncc43nSXsRug@mail.gmail.com>
In-Reply-To: <CACPK8Xcb2jskKRsPEQ98Ty-yetkUZbZ8KzTGZ-ncc43nSXsRug@mail.gmail.com>

--awGEYJbYIkEgYRNRLAcJkVCfUCPzIzUn3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 09.07.20 um 08:51 schrieb Joel Stanley:
> On Wed, 1 Jul 2020 at 09:10, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> Hi Guenter.
>>
>> On Tue, Jun 30, 2020 at 05:10:02PM -0700, Guenter Roeck wrote:
>>> The following backtrace is seen when running aspeed G5 kernels.
>>>
>>> WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_fb_helper.c:2233 drm_fb=
dev_generic_setup+0x138/0x198
>>> aspeed_gfx 1e6e6000.display: Device has not been registered.
>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3 #1
>>> Hardware name: Generic DT based system
>>> Backtrace:
>>> [<8010d6d0>] (dump_backtrace) from [<8010d9b8>] (show_stack+0x20/0x24=
)
>>> r7:00000009 r6:60000153 r5:00000000 r4:8119fa94
>>> [<8010d998>] (show_stack) from [<80b8cb98>] (dump_stack+0xcc/0xec)
>>> [<80b8cacc>] (dump_stack) from [<80123ef0>] (__warn+0xd8/0xfc)
>>> r7:00000009 r6:80e62ed0 r5:00000000 r4:974c3ccc
>>> [<80123e18>] (__warn) from [<80123f98>] (warn_slowpath_fmt+0x84/0xc4)=

>>> r9:00000009 r8:806a0140 r7:000008b9 r6:80e62ed0 r5:80e631f8 r4:974c20=
00
>>> [<80123f18>] (warn_slowpath_fmt) from [<806a0140>] (drm_fbdev_generic=
_setup+0x138/0x198)
>>> r9:00000001 r8:9758fc10 r7:9758fc00 r6:00000000 r5:00000020 r4:9768a0=
00
>>> [<806a0008>] (drm_fbdev_generic_setup) from [<806d4558>] (aspeed_gfx_=
probe+0x204/0x32c)
>>> r7:9758fc00 r6:00000000 r5:00000000 r4:9768a000
>>> [<806d4354>] (aspeed_gfx_probe) from [<806dfca0>] (platform_drv_probe=
+0x58/0xa8)
>>>
>>> Since commit 1aed9509b29a6 ("drm/fb-helper: Remove return value from
>>> drm_fbdev_generic_setup()"), drm_fbdev_generic_setup() must be called=

>>> after drm_dev_register() to avoid the warning. Do that.
>>>
>>> Fixes: 1aed9509b29a6 ("drm/fb-helper: Remove return value from drm_fb=
dev_generic_setup()")
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>
>> I thought we had this fixed already - but could not find the patch.
>> Must have been another driver then.
>>
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>>
>> I assume Joel Stanley will pick up this patch.
>=20
> I do not have the drm maintainer tools set up at the moment. Could one
> of the other maintainers put this in the drm-misc tree?

Added to drm-misc-fixes

Best regards
Thomas

>=20
> Acked-by: Joel Stanley <joel@jms.id.au>
>=20
> Cheers,
>=20
> Joel
>=20
>>
>>         Sam
>>
>>> ---
>>>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/dr=
m/aspeed/aspeed_gfx_drv.c
>>> index 6b27242b9ee3..bca3fcff16ec 100644
>>> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
>>> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
>>> @@ -173,8 +173,6 @@ static int aspeed_gfx_load(struct drm_device *drm=
)
>>>
>>>       drm_mode_config_reset(drm);
>>>
>>> -     drm_fbdev_generic_setup(drm, 32);
>>> -
>>>       return 0;
>>>  }
>>>
>>> @@ -225,6 +223,7 @@ static int aspeed_gfx_probe(struct platform_devic=
e *pdev)
>>>       if (ret)
>>>               goto err_unload;
>>>
>>> +     drm_fbdev_generic_setup(&priv->drm, 32);
>>>       return 0;
>>>
>>>  err_unload:
>>> --
>>> 2.17.1
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--awGEYJbYIkEgYRNRLAcJkVCfUCPzIzUn3--

--JwgtHqzHNQAcMByFqRGSr0iHYSHSfrKV5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8Gws0UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiMBdQf+PCSONv5wVnl0U1CoGF+nuHfYehBq
UC4E8GSv7GL9Xw06lCqhH9vLuUA2j/heAA8n3ZdLL4wOSuPK4O0HEwm2oG36j66A
v1o/vw1/MWoXMs7C1GlifTqhefNNMYlLGXhPDEsNIpL85WSU8Ub+IVLPT/jYvCkt
Zk4eMXkLLCfrNDRSsnZYHAFmf1KxqTVoIAPvjq0wcKOZX+lON3t/ELyVgzrzQcgA
K17jNQp2cP8XD0VN8AbX8ChZs2oEesmPewo4jTZamPPDlwNhdiuNg1XifpdNS5Dh
8Mp8YDYMwxmj8sqFYNhw1EYFtSbxav/U7fi9xvcYgir1NVJATYDkHPpJTQ==
=MT6M
-----END PGP SIGNATURE-----

--JwgtHqzHNQAcMByFqRGSr0iHYSHSfrKV5--
