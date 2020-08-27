Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0844822B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598540064;
	bh=LzWZBpCw/l+Ix/GXPE6nae42Wme8sXfeIYoOLqaRLsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=KeS27DvwZ0jm6e2RLepNOtKn4jCNKvGA9g+m+xBQDOZExVezJ849AaE+StWStJiHK
	 Y8O3upwdqKijcNN/EbTfOTUhmASi1wLb0qIe4PxQkdMaxBVtwe6jUQ6ZiVRpGPpvsH
	 y8PubhV8kNnqIz1uwaadiz/CwPWGxRlLGBsRkc/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgH0NMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgH0NKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:10:35 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2095B207CD;
        Thu, 27 Aug 2020 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598533367;
        bh=LzWZBpCw/l+Ix/GXPE6nae42Wme8sXfeIYoOLqaRLsQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=y0Z196NIPvRRFED15YhQtorRsjOAL/5EHRTli8FDYNANC23zGBgTup+7OEOHNLZU6
         yjR68sJL4gcNocA9V4maauV4CZLScAgY4aBIvQ56F73mQ0ZDQz2pwgAcE+d6Fjy4v6
         tjj2go46yC/493h+pidRAT7l+Uzv/tpbV0gPSOx0=
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>, Peter Chen <peter.chen@nxp.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
In-Reply-To: <b083883d-b8c3-ee16-6b02-8987cade17ed@ti.com>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com>
 <20200826031948.GA7646@b29397-desktop>
 <DM6PR07MB5529A43AFDEB25993595DB59DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20200826071504.GA19661@b29397-desktop>
 <DM6PR07MB5529EB2FB7E3380321191B44DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM7PR04MB71576DF6C03387C7628DBE3A8B540@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <ab38721a-ef48-c6a7-aa33-3085ca7b8852@ti.com>
 <20200827002339.GA17559@b29397-desktop>
 <b083883d-b8c3-ee16-6b02-8987cade17ed@ti.com>
Date:   Thu, 27 Aug 2020 16:02:39 +0300
Message-ID: <87sgc8i6mo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>>>>>>>> From: Pawel Laszczak <pawell@cadence.com>
>>>>>>>>>
>>>>>>>>> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
>>>>>>>>> amplitude is varied below and above the Squelch Level of Receiver
>>>>>>>>> during the active packet multiple times.
>>>>>>>>>
>>>>>>>>> Version 1 of the controller allows PHY to be reset when RX fail
>>>>>>>>> condition is detected to work around the above issue. This feature
>>>>>>>>> is disabled by default and needs to be enabled using a bit from
>>>>>>>>> the newly added PHYRST_CFG register. This patch enables the worka=
round.
>>>>>>>>>
>>>>>>>>> As there is no way to distinguish between the controller version
>>>>>>>>> before the device controller is started we need to rely on a DT
>>>>>>>>> property to decide when to apply the workaround.
>>>>>>>>
>>>>>>>> Pawel, it could know the controller version at cdns3_gadget_start,
>>>>>>>> but the controller starts when it tries to bind gadget driver, at
>>>>>>>> that time, it has already known the controller version.
>>>>>>>>
>>>>>>>> For me, the device controller starts is using USB_CONF.DEVEN (Devi=
ce
>>>>>>>> Enable) through usb_gadget_connect, I am not sure if it is the same
>>>>>>>> with yours.
>>>>>>>>
>>>>>>>
>>>>>>> Yes in device mode driver knows controller version but this
>>>>>>> workaround Must be enabled also in host mode. In host mode the
>>>>>>> controller doesn't have access to device registers. The controller
>>>>>>> version is placed in device register.
>>>>>>>
>>>>>>
>>>>>> You may suggest your design team adding CHIP_VER register at global
>>>>>> register region, it will easy the software engineer life.
>>>>>>
>>>>> >From what I read, this register is only enabling USB2 PHY reset
>>>>>> software control, it needs for all chips with rev 0x0002450D, and the
>>>>>> place you current change is only for 0x0002450D, right?
>>>>>
>>>>> Even I could say that this workaround should be enabled only for Spec=
ific USB2
>>>>> PHY  (only 0x0002450D)
>>>>>
>>>>> This bit should not have any impact for Cadence PHY but it can has Im=
pact for third
>>>>> party PHYs.
>>>>>
>>>>
>>>> So, it is related to specific PHY, but enable this specific PHY reset =
bit is at controller region, why don't
>>>> put this enable bit at PHY region?
>>>
>>> I think this is related to Controller + PHY combination.
>>> The fix for the issue is via a bit in the controller, so it needs to be=
 managed by the
>>> controller driver.
>>>
>>>>
>>>> So, you use controller's device property to know this specific PHY, ca=
n controller know this specific
>>>> PHY dynamically?
>>>
>>> Still the PHY will have to tell the controller the enable that bit. How=
 to do that?
>>>
>>> Adding a dt-property that vendors can used was the simplest option.
>>>
>>=20
>> Ok, does all controllers with ver 0x0002450D need this fix? I just think
>> if we introduce a flag stands for ver 0x0002450D in case this ver has
>> other issues in future or just using phy reset enable property?
>>=20
>> Pawel & Roger, what's your opinion?
>>=20
> I think it is best to keep the flags specific to the issue rather than
> a one flag for all issues with a specific version. This way you can
> re-use the flag irrespective of IP version.

I second that. Specially when some SoC-manufacturers may implement ECO
fixes and not change IP revision.

> But best case is that Cadence put a IP revision register in common area a=
s you
> have previously suggested so driver can automatically apply quirks to spe=
cific
> versions.

little too late for that :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9Hru8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQY8xg//WHz2GcqK1+sGxk+5lOGCP/rWdOLo+WMg
UgBC36W9zMY0Cchh0rRluRfliavEkvtnIF12d8aQSg1tpqWQ+Mu2S8QwWUJCleaa
wO77Ocyg3PfAOjHWEnWBJxrOoplNwnza/3uoKVfpPeJrHlqzwH9ibhe7MKdYlO13
tTEHyGXL2G9tTiiF4KhEC0Q9W86i4lYscTfu9BZaRD0GESrnN+6BkLnBQHG7Eo2R
fmj0ydezud89ezWtMhfSEXnsxRsylP/Nho5Rrd3mKyY4kL6A07JlGTzsZ5RDQmkp
6V9MAyvw2IEIe41swFNf3VChP95c7eHmSVXlu0vuoJC+nluTqfHdCSq8LU6G1TQT
BobJOm8/gSLfgNUua41wOf2HSDg0tNOzQ1FBPwJvphcLfDRJ0ExVjY12poRsaYV8
ZISZzXrHddMVLOh5f36FeUkzEOVHl4Q13H9CjqOg+ehfqeXaY+iX7i3mVMkfpmsO
eGCm5UUXxkcyvvlvCFYIcUTiWQ10y+M5Oql/HR5grD2MVEkUbWZyRU56WKRYkYgL
VsOJ+lHx09MAo7aH2twsq/lf/A5zeo9f9qA/fyV0ppfCJBqeQOzuLGODD5r0zVWG
F+tOI4MEAJyuQ4bKBPfENenFSck5oonFWZBtpMKYBD3JlG6u53MUFEIrMGTyUnl8
+ZbqFHkObCI=
=7clK
-----END PGP SIGNATURE-----
--=-=-=--
