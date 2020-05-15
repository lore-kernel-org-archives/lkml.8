Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A38CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F680206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589535076;
	bh=sax79nWs/v/WgVzGTEueYBucfR0bYJPQI5J7wMOGit4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=QFxCQdZth5vz0ddxfbGBVFvcKcVG2r77XCyGeLmXraS5713zaPmw19Q6KRWB1bTjc
	 zXSp6bBjQEO+ulIcp0FRIt5NNQlyvVVi7TL+rJNHqWiIyU2HRpDzinRvMNm6l03d0x
	 kgWClFdQcCS95vWmZxiaZiSETguOHmTjMYGJ9cjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgEOJbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgEOJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:31:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C7C061A0C;
        Fri, 15 May 2020 02:31:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 202so1244384lfe.5;
        Fri, 15 May 2020 02:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=w0eGqlOZ52vQy1Dkr85GlfLJmiL8U3wT1Ya8mJ/znt0=;
        b=D2wNjY3MJAOzxofquD/Y0UCnjJ5fMCOl9Ng9w38us71OAo0uPFKLsdSgtg/vqQyZWX
         q8znqNuphrJgEwk/T+VbOfZy9vC04v9Yt3WwGrrfr13XMtgjjKV4I+MJBtM3ur/x2u+M
         R3geRf3OblRWETJeHASkjtGCPj0DXFviuprj3BXSwbejB7UQBx1zWaE3I6Kwz+EVnRA9
         byqPT434+EJ5aPIE0Im4tJhd71jdCQFgLM+hTdRaeqEXbze84lcxWsDnSiZYyceqXK5f
         vw/Qw5oj9hWsRhKJEfnd7aQKDTzVhbfrQomLW6WTcttCBiX/UlnUsAwMjUf/iHVhb5Af
         Zy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=w0eGqlOZ52vQy1Dkr85GlfLJmiL8U3wT1Ya8mJ/znt0=;
        b=auuyWMl5fVl9228uDtBS1wytQlLrd+WtSZBO5151SD4ojQPJ2Q8KtzHvDYyxbabPp4
         FfgJIQf67OXVoyBoFmBc56STyslZBZLtc7brNoHDBV9PVecYNryEd2qQBPAbkSCa37ZV
         nLCLQr7SrkanoCq/Q6Eqyx93Wt2bvEs9njsxxrmshGwlsswJcnME17pvPe2pt33GtOwo
         MruAQd4aGjCzjmIuFDl/Isvw2BgayGx+uRYY6ZdhA0KRcIR+eEoAvy2JKm/d1FeO2SiH
         1Hbueg4KByLngHTx9o1WXTm9MIW3JGwY6al9ZqcWaDQTqD8TGd8mjBHXIAgQIAj1IdH4
         QVBQ==
X-Gm-Message-State: AOAM532o5FBP5cz+jrorQ5qTnDsnSH+70T0cKjqxoY98s0RHRU4S9BeS
        njLVTnvYqRMIWrGi1aaco7w=
X-Google-Smtp-Source: ABdhPJwJtuMGAWzQaBQVqZ/aXcBAp+d6w1PONLrgV8Exlm0JbQrhntEPE8IE5SLgExGfimn8BUsb6A==
X-Received: by 2002:ac2:44cd:: with SMTP id d13mr1811163lfm.2.1589535073199;
        Fri, 15 May 2020 02:31:13 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id a1sm839104ljn.101.2020.05.15.02.31.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 May 2020 02:31:12 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Jun Li <lijun.kernel@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, peter.chen@nxp.com,
        Li Jun <jun.li@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
In-Reply-To: <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com> <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com> <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com> <87h7wqmwrv.fsf@kernel.org> <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
Date:   Fri, 15 May 2020 12:31:07 +0300
Message-ID: <87imgx35pg.fsf@kernel.org>
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

Jun Li <lijun.kernel@gmail.com> writes:
>> @@ -397,12 +407,18 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, u=
nsigned cmd,
>>                         dwc3_gadget_ep_get_transfer_index(dep);
>>         }
>>
>> -       if (saved_config) {
>> +       if (saved_hs_config) {
>>                 reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> -               reg |=3D saved_config;
>> +               reg |=3D saved_hs_config;
>>                 dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>>         }
>>
>> +       if (saved_ss_config) {
>> +               reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
>> +               reg |=3D saved_ss_config;
>> +               dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
>> +       }
>> +
>>         return ret;
>>  }
>
> Unfortunately this way can't work, once the SS PHY enters P3, disable
> suspend_en can't force SS PHY exit P3, unless do this at the very beginni=
ng
> to prevent SS PHY entering P3(e.g. add "snps,dis_u3_susphy_quirk" for tes=
t).

It sounds like you have a quirky PHY. If that's the case, then you
probably need to use the flag you mentioned above. Please verify with
that.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6+YVsACgkQzL64meEa
mQbdgRAA2/XUFT7mg4gDxdDx3PjeMl7KW1uDTUiFf7LeQT4Vwkqq2epxcPwqjaQU
Bnt4CLX2TGgdmL/IntNlpU9i6M3a+IeDZM0D+S7/NK1Ty2iMuQ0kGA6wZOfUdbY+
RpA6Yrl1DkqQ6pMsLUYkDyGauPx7qFOJ8mx4XDEjX7v6fI/AcKkDMCx/Yuj89zhd
Yf56yxVKq/tiDOe7U7IC/IpEx9Zt7TGEVUqSotC+23A08/YBiKy229Qv5v9KkoXt
VP0xHBZGPBnEQ79rCZHxj8M8E2nDmYSLqvAOwDp27EeQNq1j/6XMlzk2bR1jvnpq
s78lCPBLGoJc/8WVgBJtLZ0BTLKPctS17xatz/3gtgd8sX03ddyp4cG+xMVKC16f
1kbOg820KTvr1UDgaMq3Bo9lFTFCkOg25WYHx4c1/w/VeclRpfK+2QVqXE0eZ/ME
8d9oM9tCKILQc1SlSy9tHwKRj5+KCd993CzSyMuMwMO1RqM+nadmQJMcexiquxiS
T5rHakbLtnpimLfO7SEi/OvuypKkWhLt52JTwgech584qyKWVh3tR/QbZCPMo7Dj
IAyB80gcRaVN5kZjfdTOeSxUpjuJuJujUwmgFhw/00nqBJ3EPogo6F8n2WDCORpH
kybGfZw3RrMTtrfd0gQU4rZf6Cel6kE+L7Jjy7skyJ466XjfTpU=
=hLf8
-----END PGP SIGNATURE-----
--=-=-=--
