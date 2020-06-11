Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E01FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC02E207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mqf7yydv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFKJmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:42:21 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:32986 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgFKJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:42:20 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200611094216epoutp02abcaf12e2f3e54c6ba2e094f718e140a~XdAATweXb0043900439epoutp02B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:42:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200611094216epoutp02abcaf12e2f3e54c6ba2e094f718e140a~XdAATweXb0043900439epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591868537;
        bh=qEufJ1Qoyx09eZ/rcj0yxfZZfHbeSMLA7RgefL0vEYc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Mqf7yydvlUU3yhRTPozWrUreQLQ53EKoTgvMBcBj+cVm+p0ugPkDIlSnTI/yorqRq
         Sw9+KfVJ9w+DerEJOpkchvnGVr6W6MZ+m3raTKh8BMDtSkV0t3bcHX4VQzEeZhROrn
         R6FMtUK7IkeGDk0isVF8E2aPsginngQ8mKFOtoXs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200611094215epcas2p123008f754ba839948bd788c5da4534f4~Xc--YzCiY2276122761epcas2p1d;
        Thu, 11 Jun 2020 09:42:15 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.187]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49jJmP0BXXzMqYkY; Thu, 11 Jun
        2020 09:42:13 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.69.18874.47CF1EE5; Thu, 11 Jun 2020 18:42:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200611094212epcas2p4a9d6736f8ad58d796a602739665844ad~Xc-8IvcDp0437004370epcas2p4y;
        Thu, 11 Jun 2020 09:42:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200611094212epsmtrp2b7e5a8fbe9f17160eb8a8c053503f67a~Xc-8Hni-90142301423epsmtrp2L;
        Thu, 11 Jun 2020 09:42:12 +0000 (GMT)
X-AuditID: b6c32a46-519ff700000049ba-06-5ee1fc747bf2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.02.08303.47CF1EE5; Thu, 11 Jun 2020 18:42:12 +0900 (KST)
Received: from KORCO009652 (unknown [12.36.182.243]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200611094212epsmtip182a171f8c9b029809fe6b9b4ef1a2590~Xc-7x-6Dp0286202862epsmtip1T;
        Thu, 11 Jun 2020 09:42:12 +0000 (GMT)
From:   "Wooyeon Kim" <wooy88.kim@samsung.com>
To:     "'Dave Martin'" <Dave.Martin@arm.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>
Cc:     "'Catalin       Marinas'" <catalin.marinas@arm.com>,
        "'Bhupesh Sharma'" <bhsharma@redhat.com>,
        "'Julien Grall'" <julien.grall@arm.com>,
        "'Vincenzo Frascino'" <vincenzo.frascino@arm.com>,
        "'Will Deacon'" <will@kernel.org>, <yhwan.joo@samsung.com>,
        "'Anisse Astier'" <aastier@freebox.fr>,
        "'Marc Zyngier'" <maz@kernel.org>,
        "'Allison Randal'" <allison@lohutok.net>,
        "'Sanghoon Lee'" <shoon114.lee@samsung.com>,
        <jihun.kim@samsung.com>, "'Kees Cook'" <keescook@chromium.org>,
        "'Suzuki K Poulose'" <suzuki.poulose@arm.com>,
        "'Wooki Min'" <wooki.min@samsung.com>,
        "'Kristina Martsenko'" <kristina.martsenko@arm.com>,
        "'Jeongtae Park'" <jtp.park@samsung.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Steve Capper'" <steve.capper@arm.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "'James Morse'" <james.morse@arm.com>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>, <dh.han@samsung.com>
In-Reply-To: <20200608103340.GA31466@arm.com>
Subject: RE: [PATCH] arm64: fpsimd: Added API to manage fpsimd state inside
 kernel
Date:   Thu, 11 Jun 2020 18:42:12 +0900
Message-ID: <001401d63fd4$95646690$c02d33b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGxBksMB01Mym8I2jEMUBwtLj9rogIZEnF2AoMWIKECIyRV0KjnobCQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0yTVxjmfN/Xm1qtBeSMZRPrDBOEtWC7AwHHosEmWxwJJFtmBnT0kzJ7
        W1sckzjYdA3gBmNhqOU6oZBBJ65WQSKwURaFCgiTkVAYAsVxKReBzMEAV/pBwr/nfd7nOe/7
        nJPDxLkFDF9milJHapQSOY++g7hjPSwM0q2OxPON1WHI2FuMo58erBPoR2cHDc1VfQPQVyX3
        AJrRX8HRxYo6OhpursbQ38YROmr7uQ9D+vJT6OFlBRq+r6ch89ifNPRHYzEdGft7MHS3uJ2G
        RibtOPreeQdD1R0NBLpmtwN0y/wDjprWlwl0aVCIyuy1GCp6UEGL8hWbSk1AXJTZQ4jr8oYJ
        sbkmmy6e7epiiFtKTAzxrcoM8TOngyGea+6ji3MtNUC8aH41ZueH8ggZKZGSGj9SmaSSpiiT
        I3nvxCYcTxCK+IIgQRh6k+enlCjISN6Jd2OColPkrvw8v3MSeaqLipFotbw3jkVoVKk60k+m
        0uoieaRaKlcLBOpgrUShTVUmByepFOECPj9E6FImymXP5mcI9dSetPa8MVom6NmVA1hMyDkK
        x39ZoueAHUwupwHA/rU+nCoWACw0fUlsqLicRQBLX/hsOUomWzZFjQBOTxcTVDEJoH2u1+2g
        c47A55ZLYAN7ceJgj42agXMGGHAsv5220WBxgmCjbd5t8HSJchxNbgPBOQT/Lep282xOGDSU
        mjAK74Xt1xxuHufw4VxXGU7h/bB+phin1vODy+NVNGpwNMwvvI1RGi9YlK13rw05VhZ8OHR3
        03ACLpl/ZVDYE07dt2xiX7g420SncDosr/iWQZmzALyabcWoRii0lHS4MNOFD8K2gc3ldsMs
        6xqDotkwS8+l1K/B52Ybfev4J1O9+HeAZ9gWzbAtmmFbNMO2COWAqAH7SLVWkUxqQ9Qh29/b
        DNzfIyC6ARTMzAe3AowJWgFk4jwv9l6fkXguWyr5/DypUSVoUuWkthUIXbedj/t6J6lc/0up
        SxAIQ0QifpgQCUUhiOfDzjjwKJ7LSZboyLMkqSY1Wz6MyfLNxKKqWI689sxY+cwRsLrWV/ey
        PHwoTbpw2+lpaXtF//u5FmN13NuHRJ/0/9VQlut/o3VVEHpjcMjjveg94PHTA12/OVrK9NOF
        3bba9fdzE9XGQe/+o/+czIlaSitMqIH+ppOWjIKD1mjvwcudzRP3EhdeH/iaIWG9EBK7KzHJ
        rnzP+tmdx5wfd651rtZ+NDEcez3XUJ26vKjNGtp32ia6cCpAak32eCS+/rjeemX8Yu0Tx1v2
        lcMW1US5LIMcWDl++qk6sC+urT7dwyvwZvDKS7Jxbnto4OjVM+gz/25Z7f4zupTS8z2VN0cr
        Pg13rn0gZJ81E+lFoypFhM12Qb8i/OI/KY/QyiSCAFyjlfwPI5FU56cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUxTZxjH956vlirjUFBeOy2u0QuqVGWYvRpjlqnkXCgq8QYTKw0cAWlr
        bRGdM7MqwlAzHZualtZROqirFWL5qgXbUEgUUAwFxIhamzqZhsqHMUCG1dgTE+5+ef7/55fn
        4uHjwggh4heqi1mtWqGUUAKipVMiTi2eC8rXDs8sQrV+E47+uRchkGWsh0TjdRcAOm1uByhc
        dhVHZ6wNFAp4bBgarQ1SqOvmEIbKqjPR/fMqFLhbRiJn6BGJBtwmCtUO92PotqmbRMHXIziq
        HGvBkK3HRSDDyAhAjc7LOLoTmSVQ6dP16K+RGxiqumclfxAxjmsOwFTp+wmm4WKAYJz2Cop5
        29fHY7xmB49p/PskMzn2kseMe4Yo5rcmO2DeOcW7FuwVbMpjlYUlrHbN5hxBweREmNC8iTvW
        fTFE6kH/wnMghg/pdGh+7cXPAQFfSLsANHT8T3CBCPr0Fh7HCTBQ2kVypVEAH7XXkJ8Dil4N
        p5tKwWdOpPdAS4c/WsLptzxorbiAcRtPADQOVEa1MXQqdPdORDmBzoKujq6oiaBXwpmqh9F5
        LL0BGq85MI7jYbfhZXSO02mwz+elOE6GrWETzp23HM7+W0dyV2TA3680Y1wnEVZVlOGXQIJx
        nso4T2WcpzLOW6kGhB0sYTU6Vb5Kt06TpmaPynQKle6IOl+We0jlBNEXkUpdoN0+IfMBjA98
        APJxSWJsfFJQLozNU/x0nNUe2q89omR1PvANn5Akxb43WuRCOl9RzBaxrIbVfkkxfoxIjykL
        HZL/yr/K9LSVz5JTf5o/pN/PPrDYdvJqBjvuefXY5d5takI/Tw9kb53sLF01lUFLqee265Vf
        pyXV6DaktPrps4T9D1lq38b6CiBP3zU24R2OyNS9wnCc3b8y48Z3D5Sz38N9i5uHnmVJD9cO
        hk/5Sk6sKCgGx1ZcpkfFIl9T/KU44W6DNNm99Q3zWBz+JQTfK17k7tGz4Meg/EUgZ8u7jXZ5
        VsnNkNOouvvxjDUCZvbC89/KS+ob4Kad2bcs/mWFdcm/to5PzW3PMaRYQuVzm3sP5nufi7Rt
        a8yeFJx+uqRxh9iRt2xbZrpK0GJt3TZtMxUt9Qy6Owc11yWErkCxToprdYpPDRhL0pEDAAA=
X-CMS-MailID: 20200611094212epcas2p4a9d6736f8ad58d796a602739665844ad
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200605073214epcas2p1576f3f90dbcefaad6180f2559ca5980d
References: <CGME20200605073214epcas2p1576f3f90dbcefaad6180f2559ca5980d@epcas2p1.samsung.com>
        <20200605073052.23044-1-wooy88.kim@samsung.com>
        <20200605103705.GD85498@C02TD0UTHF1T.local> <20200608103340.GA31466@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Previous Mail account information is broken and send again. Sorry for
inconvenience)

Dear Dave Martin & Mark Rutland

Thank you for your kind answer.

> On Fri, Jun 05, 2020 at 11:37:05AM +0100, Mark Rutland wrote:
> > Hi Wooyeon,
> >
> > There are a *lot* of people Cc' here, many of whomo will find this 
> > irrelevant. Please try to keep the Cc list constrained to a 
> > reasonable number of interested parties.

I have adjusted the mailing list according to your opinion.

> > Please introduce the problem you are trying to solve in more detail.
> > We already have kernel_neon_{begin,end}() for kernel-mode NEON; why 
> > is that not sufficient for your needs? Please answer this before 
> > considering other details.
> >
> > What do you want to use this for?

> Ack, this looks supicious.  Can you explain why your usecase 
> _requires_ FPSIMD in hardirq context?
> 
> For now, these functions are strictly for EFI use only and should 
> never be used by modules.

I am in charge of camera driver development in Samsung S.LSI division.

In order to guarantee real time processing such as Camera 3A algorithm in
current or ongoing projects, prebuilt binary is loaded and used in kernel
space, rather than user space.
Because the binary is built with other standard library which could use
FPSIMD register, kernel API should keep the original FPSIMD state for other
user tasks.
It is mostly used for internal kernel operation including hardirq context.
(ex> hardIRQ context, kernel API called by user, kernel task)

In the case of the kernel_neon_begin / kernel_neon_end that you mentioned,
there is a limitation that cannot be used in hardirq context.
Also, if another kernel task switching occurs while kernel API is being
used, fpsimd register corruption may occur.
In addition to kernel_neon_* API,
It was necessary to add and utilize API considering kernel context.
It is for this reason that I have tried to utilize efi_fpsimd_begin/end.

Regards
Wooyeon Kim

