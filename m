Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4616AC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC0820637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCOBgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:36:04 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:49691 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgCOBgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:36:00 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Mar 2020 21:35:59 EDT
IronPort-SDR: WNqQ90tfooloLtUjIzRFhtAWlcUNuKCojvc39CrmuyUnPQH4IsMCjaX9QtrbqwgA58OJ83eMRW
 pvfuQHALONo+eJ6gz5+BjJHP+A4SpDm4Pb6+V/b31Dde1/jCqlyQN7QJ5r60tQ1XU/8O+jsODl
 PbNunbElPLPy8q+ouAbW7MTFJ33j9SAb3QHhRziphBUcYSSqYCipZNlwoQnUeWlGjF/vD6CCbt
 UF1j/j1WFy4TuYEQDkivjR199GRLEOe43fv2EddWttL3x0zRFKymsIKw/cl0WTkWMC7EeSc8fa
 PY4=
X-IronPort-AV: E=Sophos;i="5.70,554,1574150400"; 
   d="asc'?scan'208";a="46773069"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 14 Mar 2020 14:07:40 -0800
IronPort-SDR: /RLQV7rNI7rWdaYuKuF0cHArVKFRjEu3Tv94u7m/K2L7NdynM7zDqi0boFnq57eiBBY8L7GtUH
 NpJVTMq3D4wlJugDwW3hVty+K2rzVGXdcXxGcZ6GFFhudEFzCazyXxiP6amkMb3sSLRt34LtTR
 YLvK8Ow1OVEJHfmjniyO2bNyR22k9cstAmocZxu+/VZ1aHpt7jGodTFdGPDR37WnESP+tbfMBs
 zy6FCUn+XFrI+xQkDObNMiV/3OtKIvJNASwHYbJpsrT8dWB9LesnEBfZlajvyvIckgXvrM6EHO
 dpA=
From:   Thomas Schwinge <thomas@codesourcery.com>
To:     Woody Suwalski <terraluna977@gmail.com>,
        Christian =?utf-8?Q?K=C3=B6ni?= =?utf-8?Q?g?= 
        <christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Alexander Deucher <alexander.deucher@amd.com>,
        Pavel Machek <pavel@ucw.cz>, Thomas Backlund <tmb@mageia.org>,
        Meelis Roos <mroos@linux.ee>
Subject: Re: Regression in 5.4 kernel on 32-bit Radeon IBM T40
In-Reply-To: <66a6b0ea-4ee8-1a0d-b259-568059d54e09@gmail.com>
References: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
 <20200109141436.GA22111@lst.de>
 <9ad75215-3ff1-ee76-9985-12fd78d6aa5f@amd.com>
 <67f60d13-a245-5561-1372-7d68f35969f3@gmail.com>
 <66a6b0ea-4ee8-1a0d-b259-568059d54e09@gmail.com>
User-Agent: Notmuch/0.29.1+93~g67ed7df (https://notmuchmail.org) Emacs/26.1 (i686-pc-linux-gnu)
Date:   Sat, 14 Mar 2020 23:06:51 +0100
Message-ID: <87imj6si9w.fsf@dirichlet.schwinge.homeip.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="_41aa890b-3091-490d-b17c-395cfbf074d0_"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_41aa890b-3091-490d-b17c-395cfbf074d0_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----------------
Mentor Graphics (Deutschland) GmbH, Arnulfstra=DFe 201, 80634 M=FCnchen / G=
ermany
Registergericht M=FCnchen HRB 106955, Gesch=E4ftsf=FChrer: Thomas Heurung, =
Alexander Walter

--_41aa890b-3091-490d-b17c-395cfbf074d0_
Content-Type: message/rfc822

Received: from SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) by
 SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Sat, 14 Mar 2020 15:07:30 -0700
Received: from tftp-cs (147.34.91.1) by SVR-ORW-MBX-07.mgc.mentorg.com
 (147.34.90.207) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sat, 14 Mar 2020 15:07:30 -0700
Received: by tftp-cs (Postfix, from userid 49978)
	id CA0ECC2296; Sat, 14 Mar 2020 15:07:36 -0700 (PDT)
From: Thomas Schwinge <thomas@codesourcery.com>
To: Woody Suwalski <terraluna977@gmail.com>, Christian =?utf-8?Q?K=C3=B6ni?=
 =?utf-8?Q?g?= <christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	Alexander Deucher <alexander.deucher@amd.com>, Pavel Machek <pavel@ucw.cz>,
	Thomas Backlund <tmb@mageia.org>, Meelis Roos <mroos@linux.ee>
Subject: Re: Regression in 5.4 kernel on 32-bit Radeon IBM T40
In-Reply-To: <66a6b0ea-4ee8-1a0d-b259-568059d54e09@gmail.com>
References: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
 <20200109141436.GA22111@lst.de>
 <9ad75215-3ff1-ee76-9985-12fd78d6aa5f@amd.com>
 <67f60d13-a245-5561-1372-7d68f35969f3@gmail.com>
 <66a6b0ea-4ee8-1a0d-b259-568059d54e09@gmail.com>
User-Agent: Notmuch/0.29.1+93~g67ed7df (https://notmuchmail.org) Emacs/26.1 (i686-pc-linux-gnu)
Date: Sat, 14 Mar 2020 23:06:51 +0100
Message-ID: <87imj6si9w.fsf@dirichlet.schwinge.homeip.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha512;
	protocol="application/pgp-signature"
Return-Path: tschwing@mentor.com
X-MS-Exchange-Organization-OriginalArrivalTime: 14 Mar 2020 22:07:30.5302
 (UTC)
X-MS-Exchange-Forest-ArrivalHubServer: SVR-ORW-MBX-07.mgc.mentorg.com
X-MS-Exchange-Organization-AuthSource: SVR-ORW-MBX-07.mgc.mentorg.com
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 10
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: SVR-ORW-MBX-07.mgc.mentorg.com
X-MS-Exchange-Organization-MessageHighPrecisionLatencyInProgress: LSRV=SVR-ORW-MBX-07.mgc.mentorg.com:TOTAL-FE=0.203|SMRPI-FrontendProxyAgent=0.005|SMRPI=0.005|SMR=0.160;2020-03-14T22:07:30.733Z
X-MS-Exchange-Organization-OriginalClientIPAddress: 147.34.90.207
X-MS-Exchange-Organization-OriginalServerIPAddress: 147.34.90.205
X-MS-Exchange-Organization-Network-Message-Id: 3dcc8ff0-c08c-4576-6a04-08d7c864172f
X-MS-Exchange-Organization-OriginalSize: 6329
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=SVR-ORW-MBX-07.mgc.mentorg.com:TOTAL-FE=0.218|SMRPI-FrontendProxyAgent=0.005|SMRPI=0.005|SMR=0.160|SMS=0.015
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Normal
X-MS-Exchange-Organization-Prioritization: 1
X-MS-Exchange-Organization-Rules-Execution-History: TransportVersioned.Tamer
 Ahmed

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

Has any progress been made regarding the issue reported here?

Having updated the software (here: Linux kernel), I'm running into the
same issue on my venerable ;-) Thinkpad T42 with:

    01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/AT=
I] RV200/M7 [Mobility Radeon 7500]

I lack knowledge of the specific graphics hardware/memory interface as
well as Linux kernel graphics/memory stack at that level, but I'll be
happy to try any suggestions, or test patches etc.

On 2020-01-09T21:40:50-0500, Woody Suwalski <terraluna977@gmail.com> wrote:
> Woody Suwalski wrote:
>> Christian K=C3=B6nig wrote:
>>> Am 09.01.20 um 15:14 schrieb Christoph Hellwig:
>>>> On Sat, Dec 14, 2019 at 10:17:15PM -0500, Woody Suwalski wrote:
>>>>> Regression in 5.4 kernel on 32-bit Radeon IBM T40
>>>>> triggered by
>>>>> commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713
>>>>> Author: Christoph Hellwig <hch@lst.de>
>>>>> Date:=C2=A0=C2=A0 Thu Aug 15 09:27:00 2019 +0200
>>>>>
>>>>> The above patch has triggered a display problem on IBM Thinkpad=20
>>>>> T40, where
>>>>> the screen is covered with a lots of random short black horizontal=20
>>>>> lines,
>>>>> or distorted letters in X terms.
>>>>>
>>>>> The culprit seems to be that the dma_get_required_mask() is=20
>>>>> returning a
>>>>> value 0x3fffffff
>>>>> which is smaller than dma_get_mask()0xffffffff.That results in
>>>>> dma_addressing_limited()=3D=3D0 in ttm_bo_device(), and using 40-bits=
 dma
>>>>> instead of 32-bits.
>>>> Which is the intended behavior assuming your system has 1GB of memory.
>>>> Does it?
>>>
>>> Assuming the system doesn't have the 1GB split up somehow crazy over=20
>>> the address space that should indeed work as intended.
>>>
>>>>
>>>>> If I hardcode "1" as the last parameter to ttm_bo_device_init() in=20
>>>>> place of
>>>>> a call to dma_addressing_limited(),the problem goes away.

I'm confirming that hack "resolves" the issue.

>>>> I'll need some help from the drm / radeon / TTM maintainers if there=20
>>>> are
>>>> any other side effects from not passing the need_dma32 paramters.
>>>> Obviously if the device doesn't have more than 32-bits worth of dram=20
>>>> and
>>>> no DMA offset we can't feed unaddressable memory to the device.
>>>> Unfortunately I have a very hard time following the implementation of
>>>> the TTM pool if it does anything else in this case.
>>>
>>> The only other thing which comes to mind is using huge pages. Can you=20
>>> try a kernel with CONFIG_TRANSPARENT_HUGEPAGE disabled?
>>
>> Yes, the box has 1G of RAM, and unfortunately nope,=20
>> TRANSPARENT_HUGEPAGE is not on. I am attaching the .config, maybe you=20
>> can find some insanity there... Also - for reference - a minimalistic=20
>> patch fixing symptoms (but not addressing the root cause=C2=A0 :-( )
>>
>> I can try to rebuild the kernel with HIGHMEM off, although I am not=20
>> optimistic it will change anything. But at least it should simplify=20
>> the 1G split...
>>
>> So if you have any other ideas - pls let me know..
>>
> Interesting. Rebuilding the kernel with HIMEM disabled actually solves=20
> the display problem. The debug lines show exactly same values for=20
> dma_get_required_mask() and dma_get_mask(), yet now it works OK... So=20
> what has solved it???

That I have not yet tried.


Gr=C3=BC=C3=9Fe
 Thomas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEE7KZCCFfzmIiKFvCOphHFmisdAgYFAl5tVXwACgkQphHFmisd
AgY3wAwAoOYpUrZ/3xFY2GaefxB27TuNulTAMNP8Ggb2tSZfAjvc8s/e+HRuxRjL
Ri4DFsZ38Is6OlXONfak24tZeXaxEDNqiDbib0+mFXD6saGECbNCkvpujaaT+wsf
E8Uph7Olh9mwL6C6I65w049voxw+T2pz79wIp8Y71sIBf1N5rONY9oYyBe9BhYTu
BbQaV6zZ7PY0ZisL1Pb61kBNtEdoUBubJHCbsuPGU5SKTWeG1M6o4h2+Co/T7dvF
ggfqx1vGu+RWQgHSiNTEmZqKrcMGgM9npeBU5Kb6fdeIyZZmnuZyXo734XGiDGD+
va2JTFLJLlqoh8TtbD7icyRPYj0rdGYG6rm1IqRs6/BUBnrHnYak1wylBkDPkLbq
3ssTN1+wMmv3HV4KLvAv9bhcP31l3gDAPqhJL7FxPvuYuZmtK7T7ugBsWuDlqLJh
NFSb6jSP1yLPbaHsU1aWIB2QMsYj5L7MCKVyG0O/v05MLZf0OGfNAHnn1tZ74b5R
Zh8E+AOl
=JFLI
-----END PGP SIGNATURE-----
--=-=-=--

--_41aa890b-3091-490d-b17c-395cfbf074d0_--
