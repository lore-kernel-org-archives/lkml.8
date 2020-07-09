Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6483920708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594276822;
	bh=JEqg8XUJLNq8qB1Kes2DnczYajQSKRC2ciMQNpupK3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=OxS4WDmcG4JxVi186X0TXVysHl+3NG9dBdmyW3ufSRUzKfvir/3zj6sAOjBzEgYwy
	 IbOJr2pYIgGlht2dz6X32dh7IQA+8KWTTss6Ulh2UVMjRwdOEGfQSkk3mk0pU/3OA6
	 9rqzV+cWm4A5/kLedJDf8XMbtbaxKkF+5sbwarEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgGIGkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGIGkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:40:20 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC496C061A0B;
        Wed,  8 Jul 2020 23:40:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t74so528181lff.2;
        Wed, 08 Jul 2020 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JEqg8XUJLNq8qB1Kes2DnczYajQSKRC2ciMQNpupK3A=;
        b=B6luC//wHghseuMOTK86eTGuZD4GEzNj9Gkmp7Na7hEpZlMG62wYvJeOvWkdQLXpjg
         xQrUKWeCyF82KJy3G8/SvC8nxQ4oOOuJJTuSCeptEqnLo49xUwCjg8iTgbJ6CYtygiNJ
         CTR1jaSPu56UqkYvUdIJeK0UF5FH+LUvvUER9y1E6wvOAPwXr0dymEEcJUnCxkKYD74X
         JwlRZwudnFM4MBgPTBwRqgmn8Eqbq6EWX/u83/OxO07hbecEflenrmLgKR1PL4Qaznhp
         rJIeyW9ZzEXemjEbJMfVFcUht11S3gpjDd3ZYizpzRB8NyqDLdlib2RurHhO99D8PbEn
         FeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=JEqg8XUJLNq8qB1Kes2DnczYajQSKRC2ciMQNpupK3A=;
        b=jTfz1Vi00s366tK5EbnCEpNDaZbrZOv6naePh2alLR/1FfYFQqiN43tZ4SPdrejLJ7
         T4+9KWBDpviv5bQBOGlXscuKQjh5ds8bxvBU94Z/YqTvMDq7fn+V3ylfBd2kKkjo4t5x
         58FKGT5RPpbmLpo5bSK/s/BWJoTsEsujg2sPgvgybOI5yYWiSKuBiRwwzKXXOZngFshi
         /eqTqDbas0TBGG1bdAjXYAVP8Q/wBftymMeE4378xlwOLYm/fLsiYOo+jwTf2S+IsYfL
         B3NRFHfivw7w3pw10BuOq2NbqFSR5hkObcG8lJ8NhFj5/m3rw0z+qVtqTJ2M41JfV20y
         GAnQ==
X-Gm-Message-State: AOAM53114qu+iATOSLJOnWOZZh6rY7pPWXcK7+z88vbEh/FBH4aykXQk
        j9PaIztdZpsDVpkaS6HRHvjYyniNrMs=
X-Google-Smtp-Source: ABdhPJzTmzxoKPVynOsAyRx9LmPvMS01GVkn19ko3AbczzbJ4spuWs0M7v+U/ylGgyb5jW4HllwRsg==
X-Received: by 2002:a19:c8a:: with SMTP id 132mr38716938lfm.23.1594276817989;
        Wed, 08 Jul 2020 23:40:17 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id o5sm740932lfg.27.2020.07.08.23.40.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 23:40:17 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [V2 PATCH] usb: mtu3: fix NULL pointer dereference
In-Reply-To: <1593502942-24455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1593502942-24455-1-git-send-email-chunfeng.yun@mediatek.com>
Date:   Thu, 09 Jul 2020 09:40:13 +0300
Message-ID: <87lfjt6vjm.fsf@kernel.org>
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

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> Some pointers are dereferenced before successful checks.
>
> Reported-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

do you need a Fixes tag here? Perhaps a Cc stable too?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8Gu80ACgkQzL64meEa
mQZPNw//XvJFpYfPEnu2HUlYe9cJSn/Gy4Xt86/O/W3mVrhmHgoYtcI4Z7mETVde
ipA995WGFkSgitYtsU18p5WgZLk1dQu+OvjxGwosumMJ9psLDjDtGFW5Q3dS3U14
OS5Moh7kxC0S5O93QwZu4PLSzIg5ise0L832MQGr5RRpw6xvcn+B75np763QbHtu
XwQzreKxXi+XBK4dkP6T7C+4zyRi8Rgq7h0TdDme/TSX9C/OJyBOoEbP5OzdFUr/
EDt7ej684t2pzUZV3lV7eUQeISPZx1KH4N3gdKLIsMzWC4zn4VCg8fK2DF9SMd6z
NyDvFR44XTg3hz54ATKCu2CwIthC5C/DORPGFllxIhiM6FLZwv6phYYb3VaJ5nC4
YysgboUCNnOO9Ih2O4xrVVkXrfOhcaZZFq9xY7mB8AHtDFjuC5kfl6coh/U3jrHH
1ctordpih8XhvSFmkXpvBKVoG4KRi53bDvwWsJk3rBRXnlPX4qrvIdkaiVOvMXh4
Gk7huQiAOcl4ddbho3mkql4SRrW7B93swFwy1SQDGpb4iZi4zLk/0Jn5HKGniRS9
wK1+k9hNc2PB+Ts7mwMh5UeAt3zBxnWWBp/UAd3k36wF5jmHG9wUTshR/2IyFUOX
pLIN0bMZ71sRhFznAegSEAuKQS36qdkRVSeTkuV1aFlhI329t6M=
=LsGT
-----END PGP SIGNATURE-----
--=-=-=--
