Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A03206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595598370;
	bh=vu7AEch6tVK5sMQvHGR0dpGgNZ7jy5+kRB2EBTC0xyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Ld6JRbpyYkqakcNv7tLZcdyfITj18Qmgv7yKOXX5IpME9NKQCqXz6r84JfU1ZMDQd
	 NrSCjXAl42PG9Od6Y45CRzKLpY/TmHD6drNtIL0ket9DZ0xwO6gB2wqPPHVCEUS2pK
	 jv+HbURJHGhIkVLonEhbkI/xzH287qCRFxtOBlp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGXNqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgGXNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:46:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3CEC0619D3;
        Fri, 24 Jul 2020 06:46:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so10021469ljj.10;
        Fri, 24 Jul 2020 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=vu7AEch6tVK5sMQvHGR0dpGgNZ7jy5+kRB2EBTC0xyY=;
        b=md52HGXBAlYTKVX/vc+E2YSVjr9cCh2sxaZhVBVMKsXRzJ4CSFyeQgo+AsUD4dBhbH
         a+BJdAwGPp0mmtKuPJL/woOC7G3k+QGxLaapfHOUSN0vYTKjBXGf/ygoJDNZPNATlrL0
         lNBgyM5+CJa8MnczwRhZChC9rFVwHfVd6CbkuRTgZgYh7KbAgWs/wIVNNOiIvRFqg4gz
         xRvu7Hd09vR3832fkvN3VcVhqg2p/mq5PMfAt7NeAdPXmlGPQ/PKxc4K6BJY5ohcLDUt
         Msp6JmptEwjxnEOlrjyoWSGU7e8dftJ575WnnlCkva/edVsbnfW6GLkF0WLowrlXU+NN
         5pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=vu7AEch6tVK5sMQvHGR0dpGgNZ7jy5+kRB2EBTC0xyY=;
        b=nNo5euy3vaChnnTa84b86I5+FbwnRlQRTZ3gBk+6bCYSirDOt+ssoO8Ok5ZJe0sVam
         Zz2Mw+EnCO0YkJTOj2K70Yjox54tSJwMOR39ozHOxRlmTcqgreca1DNCs2iGhw79camE
         q3+tZ99clo32Y50RVJUNklBFUipmyvjMMyehw7UhBEfXi5QT88aPpWaJvUbzGnT7Q2AL
         jDbhXW4qBqyYqMZt2EZ9sLFtwrciJR/rlyDMgoll5CEVUgjEu+Wh83i0egt4tJojNGje
         pJromSbCZGWwxMmYvGNJbCrspYFyKR+xKlkN56tq0VxM30kEVlkhXuonfswxOgoEjtJb
         yRRQ==
X-Gm-Message-State: AOAM533Czrfj24CdhZGyUS1HbsF0YmpKP3WPjXrWYz4G0SOQQs/hKE6h
        iqM3pessbjvqguy3LlyGXkI=
X-Google-Smtp-Source: ABdhPJxRLBdkoLiQ3bIn3g2yWD91G8Xg1O///R4OxhiwVBRMiIkVf0EyOqY9YyLcvXE7EpEcZxM0Cw==
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr4663110ljj.143.1595598363953;
        Fri, 24 Jul 2020 06:46:03 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id i11sm289423lfl.31.2020.07.24.06.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 06:46:03 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 0/3] Add USB role switch support to DWC2
In-Reply-To: <97cd44c1-9e19-94bc-54f8-204d79b79975@st.com>
References: <20200616140717.28465-1-amelie.delaunay@st.com> <d8069a78-2640-d112-a2fb-d86b99a8e44f@st.com> <97cd44c1-9e19-94bc-54f8-204d79b79975@st.com>
Date:   Fri, 24 Jul 2020 16:45:51 +0300
Message-ID: <87blk5owkw.fsf@kernel.org>
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


(please, no top-posting ;-)

Hi,

Amelie DELAUNAY <amelie.delaunay@st.com> writes:

> Hi Felipe,
>
> I saw that you took DT patch (ARM: dts: stm32: enable usb-role-switch on=
=20
> USB OTG on stm32mp15xx-dkx) in your next branch. As it was already in
> Alex' stm32-next branch, a potential merge conflict could occurred.

Thanks for letting me know, I have dropped it.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8a5g8ACgkQzL64meEa
mQa6GA//dv6un4DfWkydBfBMjWWl9DuRCyLB80t59IsGJejlkudKuN4qaqQSbEI2
DVpyiZKw/1Nt8aTpQJTJgsgf69vIzkhsxvkQ8tIrYZlXWwUoB/HKClA9R1gGR8Rq
oI50A35v0hRHTFoE3TlOXxC+NBeGkHw+O+yCEhOFbevHJ5N9JW6s+Vkaur11mgc8
kYIW1WYPrQ2oTAPlEgdv5HRoA2UCZX/E9poNn83gWSe8r3FL55huLPEb3Caem01y
8LKRFgDSbvoiVrVZM+bQ7JUlu0ORvwKlTak4q4InvqE9VqAsHBstN7iNvutYwtCM
X1RPT8npXN+mR8U+r1QZOZ549YDuVe/ToTPBoz6IaAf7H4OH2ET00nfEcEbJGWxJ
rap1HuJDfKFJb+4B9j5lkqoaTE25JyNqk1XY3UBKtnU4tfMeJVHw8GxJIdy3xiM/
knkPyZEk3nCRbcEoUaVhFPCvKzGweMtaer/xIw6VEM25bPZzRa2+r+2kz9k8nYnO
WfXC2r1IS2WXJC5arwG5dStHuhngmEPzYQdvV0SPCnhMHwJO9Z5rmD3F8fRNsZMS
e1kTs9dcurhVJz/Gm0RS/66kIJJGQT1xxf8/Z/sjln8+ShrPe1HDJlhsn3MEqP2l
BMh1Hh8L66Sl4tNmIB8NKl0Zryn3G/gIL8w+ExILXYzPMzhRYkk=
=6nN4
-----END PGP SIGNATURE-----
--=-=-=--
