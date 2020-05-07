Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99024C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706D721473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VfPcGUmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgEGOfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:35:55 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55880 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEGOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:35:50 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200507143548epoutp01e6a7c3555a260fdb1f24255e95312d76~MxbSuKm2_1666116661epoutp01e
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:35:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200507143548epoutp01e6a7c3555a260fdb1f24255e95312d76~MxbSuKm2_1666116661epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588862148;
        bh=2Awnxc2MzaUIX6t7iwEDNHg3jVhYVQkwPUQrJI6Ykcw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=VfPcGUmj28bMrAH6jX6qDq6XevZ0RIQ7bQunfqm3Q9PiweS2saGpcs/VsTG0EcIke
         ttZyUTPJUoq28tH/W/adFNlBf8ojHg/n65eGCbJPhstcmdpn50jVnB+/Elr4ToawWA
         +7TYF/TkCalzVPUXi8vBrPArX/KAgxWa4gRqLBmY=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200507143547epcas5p3d349290cc0bab673d92e26a5d69b0ab0~MxbSJyzYt1912219122epcas5p3e;
        Thu,  7 May 2020 14:35:47 +0000 (GMT)
X-AuditID: b6c32a49-71fff7000000271a-0d-5eb41cc34c41
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.7E.10010.3CC14BE5; Thu,  7 May 2020 23:35:47 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 3/4] scripts/checkstack.pl: add arm push handling for
 stack usage
Reply-To: v.narang@samsung.com
From:   Vaneet Narang <v.narang@samsung.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Maninder Singh <maninder1.s@samsung.com>
CC:     "George G. Davis" <george_davis@mentor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAK7LNAQxOtjsrS6b8pF93=0yqnTJT6b7V2hDOWsYGH-njNcZdw@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200507133220epcms5p87e370759fbc8aecca3093c503dd99b4c@epcms5p8>
Date:   Thu, 07 May 2020 19:02:20 +0530
X-CMS-MailID: 20200507133220epcms5p87e370759fbc8aecca3093c503dd99b4c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7bCmhu5hmS1xBnPXCVtc3J1qcXyCpcXf
        ScfYLZ78/85qcXnXHDaLw/PbWCwePrjB6sDu8fvXJEaPTas62TzmnQz02P21idGjb8sqRo/P
        m+QC2KK4bFJSczLLUov07RK4MjZtfM9a0KBcMXPnb5YGxm6lLkZODgkBE4mHtw6ydjFycQgJ
        7GaUeL51IXMXIwcHr4CgxN8dwiA1wgJRErfuf2cHsYUE5CSO39jNCBHXkTgxbw0jSDmbgJbE
        x5ZwkLCIQJjEgefvmUBGMgtcZZS4eaWXDWIXr8SM9qcsELa0xPblW8HmcAoESsy7PZURIi4q
        cXP1W3YY+/2x+VBxEYnWe2eZIWxBiQc/d0PFZSS+f+0Hu19CoJtR4vOWPjYIZwqjxOzfp5kg
        qswldm+YB7aZV8BXYuqyfrBJLAKqEm2XTrOAfCAh4CLRvDkZJMwsoC2xbOFrcDgwC2hKrN+l
        DzFFVmLqqXVMECV8Er2/nzDB/LVjHoytJHHu4E6ofyUknnTOhLrZQ+Lg4b3QcJ7EJNF85Bnz
        BEaFWYignoVk8yyEzQsYmVcxSqYWFOempxabFhjmpZbrFSfmFpfmpesl5+duYgQnGy3PHYx3
        H3zQO8TIxMF4iFGCg1lJhJfnx8Y4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryn07bECQmkJ5ak
        ZqemFqQWwWSZODilGphKdnYcV83ceblUJsA+Qp5XIvXN9Idvzj4I5dOPbFT+7KJ7/NUyP122
        Se3RSvGsTzds2HGydPUWvbtNsxecv+XPmG346s7eH/fmZkjKXj4qUiV59OvKR12euxgtuwuu
        5u+fr/rzfF/fl6AC3sApUzcErEn/L/v35FTJlfe/XFypJSS18H2txOaf3+P8p/2dKl6u6am2
        7vZyzqjWQM6MzvvyO9omHGaTfjyTmfeTQhJXq2bfK4nosw4Ky69k3Ypl7ZCSrxf+qbJRfI/2
        HZ2fZS7P3/jmbq+tq1otU2l+8tvFuviNZjYPl+/cWnb43umHW9IYrF3ZDv/plJti+9j7QWnD
        ldbFE2Y7NH043hlc/3q1EktxRqKhFnNRcSIAQD/rEaUDAAA=
X-CMS-RootMailID: 20200430124958epcas5p15ecc8e744ed0f78837a6d58274a5baf0
References: <CAK7LNAQxOtjsrS6b8pF93=0yqnTJT6b7V2hDOWsYGH-njNcZdw@mail.gmail.com>
        <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
        <1588250972-8507-3-git-send-email-maninder1.s@samsung.com>
        <CGME20200430124958epcas5p15ecc8e744ed0f78837a6d58274a5baf0@epcms5p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,=C2=A0=0D=0A=0D=0A>>=C2=A0To=C2=A0count=C2=A0stack=C2=A0usage=
=C2=A0of=C2=A0push=C2=A0=7B*,=C2=A0fp,=C2=A0ip,=C2=A0lr,=C2=A0pc=7D=C2=A0in=
struction=C2=A0in=C2=A0ARM,=0D=0A>>=C2=A0if=C2=A0FRAME=C2=A0POINTER=C2=A0is=
=C2=A0enabled.=0D=0A>>=C2=A0e.g.=C2=A0c01f0d48:=C2=A0e92ddff0=C2=A0push=C2=
=A0=7Br4,=C2=A0r5,=C2=A0r6,=C2=A0r7,=C2=A0r8,=C2=A0r9,=C2=A0sl,=C2=A0fp,=C2=
=A0ip,=C2=A0lr,=C2=A0pc=7D=0D=0A>>=0D=0A>>=C2=A0c01f0d50=C2=A0<Y>:=0D=0A>>=
=C2=A0c01f0d44:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0e1a0c00d=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mov=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip,=
=C2=A0sp=0D=0A>>=C2=A0c01f0d48:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0e9=
2ddff0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0push=C2=A0=C2=A0=C2=
=A0=C2=A0=7Br4,=C2=A0r5,=C2=A0r6,=C2=A0r7,=C2=A0r8,=C2=A0r9,=C2=A0sl,=C2=A0=
fp,=C2=A0ip,=C2=A0lr,=C2=A0pc=7D=0D=0A>>=C2=A0c01f0d4c:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0e24cb004=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0sub=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fp,=C2=A0ip,=C2=A0=234=0D=0A>>=C2=A0=
c01f0d50:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0e24dd094=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sub=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sp,=C2=A0=
sp,=C2=A0=23448=C2=A0=C2=A0=C2=A0=C2=A0;=C2=A00x1C0=0D=0A>>=0D=0A>>=C2=A0=
=24=C2=A0cat=C2=A0dump=C2=A0=7C=C2=A0scripts/checkstack.pl=C2=A0arm=0D=0A>>=
=C2=A00xc01f0d50=C2=A0Y=C2=A0=5B=5D:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0448=0D=0A>>=0D=0A>>=C2=
=A0added=C2=A0subroutine=C2=A0frame=C2=A0work=C2=A0for=C2=A0this.=0D=0A>>=
=C2=A0After=C2=A0change:=0D=0A>>=C2=A00xc01f0d500=C2=A0Y=C2=A0=5B=5D:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0492=0D=0A=C2=A0=C2=A0=0D=0A=C2=A0=0D=0A>=20Do=C2=A0you=C2=A0know=C2=A0CO=
NFIG_FRAME_WARN?=0D=0A=C2=A0Yes=20we=20know=20this=20and=20we=20use=20it=20=
to=20get=20compilation=20error=20if=20some=20function=20is=20using=20more=
=20stack.=0D=0AThis=20config=20will=20report=20issue=20at=20compilation.=0D=
=0A=C2=A0=0D=0A>I=C2=A0know=C2=A0checkstack.pl=C2=A0dumps=C2=A0the=C2=A0sta=
ck=C2=A0size=0D=0A>of=C2=A0functions,=C2=A0which=C2=A0is=C2=A0different=C2=
=A0from=C2=A0what=0D=0A>-Wframe-larger-than=C2=A0does,=C2=A0but=C2=A0the=C2=
=A0goal=C2=A0is=0D=0A>quite=C2=A0similar,=C2=A0I=C2=A0think.=0D=0A>=C2=A0=
=0D=0A>I=C2=A0just=C2=A0wondered=C2=A0if=C2=A0we=C2=A0need=C2=A0both.=0D=0A=
=C2=A0=0D=0AWe=20feel=20purpose=20of=20this=20patch=20is=20different=20from=
=20CONFIG_FRAME_WARN.=0D=0AThis=20patch=20is=20specific=20to=20ARM=20and=20=
fixes=20bug=20in=20stack=20usage=20calculation.=0D=0A=0D=0AWe=20were=20comp=
aring=20stack=20usage=20of=20ARM=20with=20ARM64=20and=20found=20big=20gap.=
=0D=0AWe=20realised=20ARM=20is=20not=20calculating=20stack=20usage=20proper=
ly.=0D=0AIt=20only=20considers=20stack=20used=20by=20local=20variables=20bu=
t=20it=20doesn't=20consider=20=0D=0Astack=20used=20to=20store=20register=20=
context=20at=20the=20start=20of=20functions.=20=0D=0AThis=20is=20not=20the=
=20case=20with=20ARM64.=20It=20seems=20ARM64=20considers=20both.=0D=0A=0D=
=0AWe=20found=20even=20stack=20variables=20are=20of=20same=20size=20on=20bo=
th=20target=20but=20=0D=0Aarm64=20stack=20usage=20is=20high.=0D=0A=0D=0ACon=
sidering=20below=20assembly,=20Actual=20stack=20usage=20is=20492=20but=20cu=
rrent=20script=20reports=20448.=0D=0Apush=20instruction=20uses=2044=20bytes=
=20of=20stack=20to=20take=20backup=20of=20registers=20as=20per=20ARM=20call=
ing=0D=0Aconvention.=0D=0A=0D=0Ac01f0d44:=20=20=20=20=20=20=20e1a0c00d=20=
=20=20=20=20=20=20=20mov=20=20=20=20=20ip,=20sp=0D=0Ac01f0d48:=20=20=20=20=
=20=20=20e92ddff0=20=20=20=20=20=20=20=20push=20=20=20=20=7Br4,=20r5,=20r6,=
=20r7,=20r8,=20r9,=20sl,=20fp,=20ip,=20lr,=20pc=7D=0D=0Ac01f0d4c:=20=20=20=
=20=20=20=20e24cb004=20=20=20=20=20=20=20=20sub=20=20=20=20=20fp,=20ip,=20=
=234=0D=0Ac01f0d50:=20=20=20=20=20=20=20e24dd094=20=20=20=20=20=20=20=20sub=
=20=20=20=20=20sp,=20sp,=20=23448=20=20=20=20;=200x1C0=0D=0A=0D=0AThanks=20=
&=20Regards,=0D=0AVaneet=20Narang=0D=0A=C2=A0=0D=0A=C2=A0=C2=A0
