Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995C5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8A82068D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590395047;
	bh=qF3nZy5bJ7P9gCbxMcGSnMA5OaRcF5JKseiRc0o1Zk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=uBVtYu1PZgPkP+ZLPGXRxHjkRcX4WsRddHQOhIvDl/ZLmEIq+itW8sYjkWgGL+k2H
	 RVjUc2jyr9/EyICEHNec1giqo/EuL/aJWbknoDhSdenXNU3sHrInXlW8q2+n8VxK+Q
	 dA8bOaj+Rh9yWvhOURWl+Z2Yy/v22/hc8E93HQqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgEYIYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgEYIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:24:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AE6C061A0E;
        Mon, 25 May 2020 01:24:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z6so19764497ljm.13;
        Mon, 25 May 2020 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ANsmsts+DHXNEc88o7BQxwGmebDh+l2B4Pvz9WLqzyk=;
        b=dC7wDseltyDwTHP3wA1YHJ/onugrBnJLQt+wdz1AkGAxhdRt7AQqbFVbEtXa1c4vme
         cPXUb3LOtmSGHqIik58e/iBF222d8d1d3hkGp6oSi3P/jexKHicIkGHfYhgiGunoDJBl
         hOUo5Oau8cnauLrWdywpaa1D088+V2fO8UUyd/Z+VjHmrHqeLlug/ShdCNSH6HM6fWtk
         nLZAV0osglxqjUxxFOPEEN4NYm6Ar4hqIugIlhmpotzkyXZNki1OexDwVmidWYsBjD88
         8LqLfc0zUCK84unUeDKe9OGYUIJtI1DHO/UHed4Bzr7X7m4GnHaSenVJMAnpfVtXWnji
         0lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=ANsmsts+DHXNEc88o7BQxwGmebDh+l2B4Pvz9WLqzyk=;
        b=GJ5jLXEONGW7tae6BavaJyxUdcU52wYsY+qEWd2hnRm7HSz6KMJxwlfx3z3POpgQcj
         2e68mXZXdReD9rp6oJMXruhyRRvKD/NUVAXbFlTBlj5lSjAWxumP+uws6j3finZbTqAK
         9whOx/OL8B5vwZWyQXWMkyOKirI5rtzHDL47lVimQWXVBICXTx/v7cOnk1MNif815vyx
         DxVf6LX5If2vZQvkigqGI1vOKXDouRi7KOmT5HWSm4t9VFZI1gdIv6+Ic+sb3JNv9yi5
         AiLqh7RZUXk9OeKuC+nWKL2t5KB+o//fxWnTKi/xpAx5+qBEseYQkZi7pzkSJxLzDRGF
         B2Dw==
X-Gm-Message-State: AOAM5307Mnc/145hkVcQBpqHQTBGe6pzrR4DKENrobQjJvTaXcxWyk29
        mlOqpZin2uESw4lvs69dscc=
X-Google-Smtp-Source: ABdhPJxNZgTanxq9CvLsQ/fUF7XgeONYIPCPiDZoewQSfO90yvUaQW600QFBf+2TaJtz/KgUa6K1qw==
X-Received: by 2002:a2e:87d7:: with SMTP id v23mr11619050ljj.334.1590395044209;
        Mon, 25 May 2020 01:24:04 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id w4sm2758698lji.2.2020.05.25.01.24.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 01:24:03 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     linux-usb@vger.kernel.org, vigneshr@ti.com,
        chunfeng.yun@mediatek.com, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 0/2] usb: dwc3: keystone: Turn on USB3 PHY before controller
In-Reply-To: <20200525071048.7738-1-rogerq@ti.com>
References: <20200525071048.7738-1-rogerq@ti.com>
Date:   Mon, 25 May 2020 11:23:58 +0300
Message-ID: <87k110whgh.fsf@kernel.org>
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
> This series prepares for Super-Speed support for AM654 SoC.
>
> Patch 1 is already in your testing/next as commit d47b0062a8ad6c5060c8443=
9745c3ce7d21d6bb9.
> Please revert that and apply the revised version in which we make
> the USB3.0 PHY optional. Thanks.
>
> cheers,
> -roger
>
> Changelog:
> v2:
> - make USB3 PHY optional
>
> Roger Quadros (2):
>   dt-bindings: usb: ti,keystone-dwc3.yaml: Add USB3.0 PHY property
>   usb: dwc3: keystone: Turn on USB3 PHY before controller

should reach testing/next shortly.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl7LgJ4ACgkQzL64meEa
mQb5WQ//Vrvlk2vNCM3DTytPOMcudLJlF7qSgD5yafe51IBxP+esW9iJ8ttw7AK/
+EDL5oqKUkORUhymPd4SGQhV23f2a31WdEoDKgc8S5OsTPyrZM8OJb8SmSiQGL/9
OaInwQmBD69/g0HxNo4LcdWkeoFNUvOdptJST/rbml59WiUwAx3By8t+liqYQ7QY
VQoO7hY2F379UU7mE7Aa37IygSDON2SEaSqrDPzhYOJehQ3IECTJA3Y3K+irTJ1Y
FyiK6S0qHtTkuf03Hn7Xdrkp3EPPnkqT760rHucMwrLjiu6L3R0pHKhalFtTQWwz
BdDCMJpMwBe5iztuZgLPvWGrDE/M0WW6Zcout3BxtBgyOIT+PWPxW9+BmLxYGljo
/zAJahDjSVPc8Ui4jHLCR7WxrCOgZutps/OaX3lxNobbQQpK7OAkXeXbV1RCXqyp
dI6uu78nSd8cbY5nRk6oSe3w/oplTeSXpnrDwTMf2dR+kJ73pXBv8anVPodj3oRn
SeDVKOtXnRqS7N3eKYAp4k8EqIfCr3Ls4Hj8bhto77BhQmDLcoVSmgJKybK9c42Z
pyeW2hHs7usGd+3uRNq06xUr1QR2VX+6yfC5AiVxgkkOlgUrQPK8gxhRdp20vckP
7HQvIQitgkOxD72mHqt75ZPElgFzkuca0Q+Dopw6EvuJPj0q8m8=
=GcB7
-----END PGP SIGNATURE-----
--=-=-=--
