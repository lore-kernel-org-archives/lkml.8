Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E46C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3924520792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595332564;
	bh=l+HUvAyrBjGy9WfEth7/photuV939CFeeU0UqdolEIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Asqao/BicrGOwbY9ugSXk0xwUuRWyNyGRYLp/VH1aSI+9HrnoQEgLg0Xk2YZ/C01U
	 aH+n63Taf995eF4/h40AemcGIZ6Xy24px8YjLBzVA3uERlV+7tYZApWjmbrI6a1yzc
	 toRuyc/mZlV08Qqbq24eydhUbetx7HjIPLmRh7PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgGUL4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgGUL4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:56:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C89C061794;
        Tue, 21 Jul 2020 04:56:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so23713965ljn.8;
        Tue, 21 Jul 2020 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UuXQlL9wnaYJsw7ikLdLURfWd1VScHy70zV2v5mo5Wk=;
        b=CR4B9VqyMBf+6kUn7fW8Fv6vPiDD0jb/DjgcVM7Xh66qnzbBkR1bwIrix3b9I7xvDq
         2mx2dR52SsNoMtXi+c1dFVt5XxbgL1nu6+0rnXgzcGqc5ZcTnyDPcIyKSn2wSaOn1P9E
         U4dMeIrfAr4c+gPzEmyT4MQpmY7vHX/n0feNKGSGSlg7CXemFsNr+qLBUf7aLVav0aWf
         sEq0gatSaDPff5TLlqxQyH6AdsVpc1yR+2L3GQXxCU94W2gWR5xI14va9jlJhQgshxu0
         nwQVXYn/QT3i5hknJsjxEtHdl33xEOdmEc5UY1+p//z3520f6XjmcHNI3eM/Jc4ES7e6
         g8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=UuXQlL9wnaYJsw7ikLdLURfWd1VScHy70zV2v5mo5Wk=;
        b=MtmYJBRPEfIQL3u9oC3nvS2Iu/oRNRQlRS3iBCwY/bTLPgiHj8hi3UWVd2DzY6Lz0y
         96IOcxXDYr+0k3y3vbr2Zx8mX+PemKnTJmm8MClLRxIPT+NKX5e6l5v4eeJyjpLbmV7+
         JdNsw58mpUUPa4fD2+JD9TDps3fkjlAHLLDU9yWIqbWcUlGeEG9ibxxRRy3sGzowtkkf
         keoWYO4VvTvHZwqO+qXMTXZDxYOCRnhkElOlZbkx/ARlWl9Inhvjcyh7P1n3ZT/lu7ia
         WjqwHeCA5IQeSOt7Zx+3ujZEYn2itQJKemeCouo4Y5YyuZpp7nL3Cy0oRcFST0aELsUp
         aLCA==
X-Gm-Message-State: AOAM5320vtO1zvg6DYht5dKubjG+2LXM9VJzoO6USfS7JlIqJ12CSybr
        EuNqJMo23Ij1Al0xWPFMd9M=
X-Google-Smtp-Source: ABdhPJwqmos6ZZxG4AKGfzLwBOkpIcuG0XibJW5qPfhgTgkYeiH/Ax0CcD+xA/8ba028wsTG5rBo3g==
X-Received: by 2002:a2e:1502:: with SMTP id s2mr11589814ljd.236.1595332560529;
        Tue, 21 Jul 2020 04:56:00 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id y8sm4232793ljy.59.2020.07.21.04.55.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 04:55:59 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
In-Reply-To: <20200721115246.GE621928@dell>
References: <20200715093209.3165641-1-lee.jones@linaro.org> <20200715093209.3165641-2-lee.jones@linaro.org> <566f2d65-1b5a-ed2a-f33f-516b66be2624@synopsys.com> <87blk9p5ia.fsf@kernel.org> <5862f649-8058-7e39-cb43-2a4b09303333@synopsys.com> <875zahp0i0.fsf@kernel.org> <20200721115246.GE621928@dell>
Date:   Tue, 21 Jul 2020 14:55:55 +0300
Message-ID: <87365lozec.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Lee Jones <lee.jones@linaro.org> writes:
> On Tue, 21 Jul 2020, Felipe Balbi wrote:
>
>> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
>>=20
>> > Hi Felipe,
>> >
>> > On 7/21/2020 1:43 PM, Felipe Balbi wrote:
>> >> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
>> >>=20
>> >>> On 7/15/2020 1:32 PM, Lee Jones wrote:
>> >>>> The value obtained from GINTSTS2 should be masked with the GINTMSK2
>> >>>> value.  Looks like this has been broken since
>> >>>> dwc2_gadget_wkup_alert_handler() was added back in 2018.
>> >>>>
>> >>>> Also fixes the following W=3D1 warning:
>> >>>>
>> >>>>    drivers/usb/dwc2/gadget.c: In function =E2=80=98dwc2_gadget_wkup=
_alert_handler=E2=80=99:
>> >>>>    drivers/usb/dwc2/gadget.c:259:6: warning: variable =E2=80=98gint=
msk2=E2=80=99 set but not used [-Wunused-but-set-variable]
>> >>>>    259 | u32 gintmsk2;
>> >>>>    | ^~~~~~~~
>> >>>>
>> >>>> Cc: Minas Harutyunyan <hminas@synopsys.com>
>> >>>> Cc: Ben Dooks <ben@simtec.co.uk>
>> >>>> Fixes: 187c5298a1229 ("usb: dwc2: gadget: Add handler for WkupAlert=
 interrupt")
>> >>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> >>>
>> >>> Acked-by: Minas Harutyunyan <hminas@synopsys.com>
>> >>=20
>> >> Should I apply the entire series or only 1/8?
>> >>=20
>> > In this series only 2 patches are related to dwc2, which I'm already A=
cked:
>> >
>> > [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
>> > [PATCH v2 2/8] usb: dwc2: gadget: Avoid pointless read of EP control=20
>> > register
>> >
>> > I can't acked other patches from this series, because they are not=20
>> > related to dwc2.
>>=20
>> heh, I saw that after sending the email, sorry :-)
>
> Also, all patches are already in -next, courtesy of Greg.

Cool, I'll rebase on top of Greg's branch

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8W18sACgkQzL64meEa
mQZHExAAoXdNBgNtWBOLLiLM8dWumwGhOlOBXhu6BxEcUtofB9WWbKIKeQFYxSaq
Oze/j7Z9hceIAIYK/xgW4Zv94oy7yYugNMD6EzvVuPk+XcTPlZj0NOM0eUAr/bwu
mrfxB4gmuKddKjrrgSNQNqVlno2CnLaXhElqh61FxrsPICMoeQa8iyPfl3L5cwC3
ty59TfHkaP3EU7TpRsj4y++z3jbLHlqtXE2p+yRsGht7UeLHd6qhJWjtVijpLU7t
yGD8DHwBFsj9s9AnXXpzSDVhp/2MJnIegH73s8g3zFQ4S2KNubADBxF16Nuxf8NZ
EOD/qUECHJSURDoXLJG07+Bf+FGNVbHWJMpWRPPz+NiNgSBBxbBqqBH4/cBYy6yd
kksNBJlmZkC+Ix4hyMJ/uQdVe3laksEiP8W7chLGJlyldzYvwUys9S+sKvl7me3V
92SOp4xj+dragFXknHtqUpIQHn+6KmRQJved8HhqTcAZ0o9dUAYa4SU8SF0aFXfX
TJyrp6ySTlupacoabzg0CC4qUGfLH91hUpewjG35qiN3weWrzQHeUyZ9rdIAVa+8
whlftnwMr/7EC2Dk1rCJJjahs8IfsHQhklI99sb+wDBl/kFVpDRyMwWO1Io4562E
ldBZ6RHgOwhO3TbYatCtvhzCiy6dqENORarHcuI8I3TQC0MzyhA=
=cJMs
-----END PGP SIGNATURE-----
--=-=-=--
