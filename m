Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94466C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692DE20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580477402;
	bh=7nCtx9E1R22cOlqOHkg/lsnX7MOdIFOpv9Kqo050/84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=NgBLdghDOESHxDde9UbGXBcTBHlOMuiio89yZQPf7qL91K6CPslft3VxWWEMyq52Z
	 QZQL5X+yXJ8nFLZLaT/whY9IQtZW7nSz0+GPrRlHrdmFnOYPrv1AC52ZocZH8pIAJk
	 fkyCrVkdUg2THdFTDgoGWVrgCarcGVK9KizJ1wUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgAaNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:30:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41332 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgAaNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:30:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so4859416lfp.8;
        Fri, 31 Jan 2020 05:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7nCtx9E1R22cOlqOHkg/lsnX7MOdIFOpv9Kqo050/84=;
        b=r6JeGB4WafMEddCLgZJJXZWwy3zgazET9jMPTcaJdAZM4Smttk8qoFY79S6u5M7wJo
         MW5sF9EIB8ilFF+u539gPebTmswV0n7ugnt3nee5p+N6sXg/i39tj/kx8xnyq1bESCvv
         FsgFReIcpd+8XKJoAQiwLITwa3GY5W9HASB/PIRMDca9zjdLfFuRvUrVpvWaigcpddgr
         OVXZCNa7ZiUo0+SokoBIxKs7VZFdM6x02FfoZVQGUnXSDPqzI8o68qdrzZThLDFFgzEU
         WfeMs+WXquRWOzup0QzBMYCP4yW0FnT8/VDvMHuBkL9VUpEOsLs/MHo0u20hbZBX/Mtp
         NKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=7nCtx9E1R22cOlqOHkg/lsnX7MOdIFOpv9Kqo050/84=;
        b=FVldo5wx0TPbSwYpBv24HhmkgIrczHJc3waCnhTwmq/M7hGQ0Aq5z8D2YNntQaRPip
         Mgab2OsGyUGJXTM0LU/t6u2ZYac+c1jMU8SXxkRuPp/ZXv2jjDStBKoX5pitIg+fJfYs
         dFqIZXGK7mSiwefdsVIWyDh3WA81Vt0DkenmIANBZagnfb5Wy1j1s32GYxDc85OZIPqT
         VPBTo2mETNDoUVPt7gJv8DWwdnWn/W18AUZ1VjLU1sAtZQnDIqbfxD4I1KE2y5v1oANR
         05T56sFQKdxjEzzB/II4kOZkloc11PNN3fbCCC1xv8Q85WOuU5UQBXocll9hFsLjHGd7
         gXng==
X-Gm-Message-State: APjAAAVQQ/qqjyPsx487e/g1ePNIcFgpo9Qt6PAwGTmVBtJqdU8+c85L
        1mOixQDK/XLoTDwzbgDQHyc=
X-Google-Smtp-Source: APXvYqw9Y+k0ca1hl88/2I68pFz4/fGlwLZ4mcQ5yslVZts2CAyWoPoJd6N5Bvdw9QY3sICSZXiezg==
X-Received: by 2002:ac2:5596:: with SMTP id v22mr5487593lfg.200.1580477397793;
        Fri, 31 Jan 2020 05:29:57 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id q13sm5583986ljj.63.2020.01.31.05.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 05:29:57 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        devicetree@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 10/19] usb: dwc3: Add support for role-switch-default-mode binding
In-Reply-To: <20200122185610.131930-11-bryan.odonoghue@linaro.org>
References: <20200122185610.131930-1-bryan.odonoghue@linaro.org> <20200122185610.131930-11-bryan.odonoghue@linaro.org>
Date:   Fri, 31 Jan 2020 15:29:52 +0200
Message-ID: <87o8uj7nzj.fsf@kernel.org>
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

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
> From: John Stultz <john.stultz@linaro.org>
>
> Support the new role-switch-default-mode binding for configuring
> the default role the controller assumes as when the usb role is
> USB_ROLE_NONE

per specification, device is supposed to be the default role. Why isn't
that working for you?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl40K9AACgkQzL64meEa
mQbgJQ//TZGlvG3P1aWp5ikix5NKdKJ2sn7Oz9CZMoAkeF04sOAHSwiD+hcm8jMP
7iN/2N/pkzajnK8rltb/GI2AfoTeHWPkOzg4uC6+lqOAfg8n1axLg8uj1nVyO07Z
7yJMhTaRmOO7moEJVk7T+pCNpz+YMb53EV9vcH5n8tqNq/0rmNa86quWooJdSrEe
2tYX/ZHmMx0LtZ00ki/EtGAqywOnwCk1XkrNa4mcFUaysjtuEaNjxid6dQnVJjjr
R0VhJPqNQgc/20eQslhaTR9ln45B3d31k9NhEgt9KykSdaC/MtvuTr9fBqhaxvUO
YlFCL0wvU6Or+YyALv67Kh1CP3NySUwICvkPCyOX06cXFKwFMDJc7sUsckcdhgXh
X3rjmnjLAkH0mTZK+dn5Q8lzRkcDADmgf19vMTyn9QKio1X5+pswDZErD7gNS/Ho
/VLig6h+0dc3z2VDHBGPuXcpgSfuETZoGXTA6Xgk7zNbNFq0RWODlT6foxcLyPSO
8sUDoWyZDGXCPykmjpEEs2/0hrsQAJiZxnf47tJ5Kif9AsUQuD5I6+ZVK/EDTqq0
3L48JMX2WryTWlbGCwYCSohEhB9bEJijE6tYAzshlQQh/72yelzOBEHUpSWpRw4u
iqd+eKlALpvs4lm544oI8eWplPd6xoFccGwO5s+eY5jSIyKaf3k=
=N9RZ
-----END PGP SIGNATURE-----
--=-=-=--
