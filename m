Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F80C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1C120658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584342320;
	bh=uBZWUAhDtllCgzUKbsfgOq5XO1bRfHYmWfHJLRmvGhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=sN4Tt7ldtLHkse85FWXNJPCS7ryDo3A2UkoKTM+KperBZMcVYWM4KzSJsnt3K/7gJ
	 K43Vobm5+bn0oHRf2petVGAZsBXRq0aCCEyGhEtb1BQ08ZTuH8/DqaN+TT9gMiTFw4
	 N1syzJHTLqzJqBavxrE1jBu7wIeTB/IkoSzdSAQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgCPHFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:05:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46731 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPHFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:05:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id d23so17295764ljg.13;
        Mon, 16 Mar 2020 00:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uBZWUAhDtllCgzUKbsfgOq5XO1bRfHYmWfHJLRmvGhI=;
        b=G47QD5SLJGT3j1JEedQjgXDMILOxrXG0wgKWNCqvfz/HWI2rSsXH7IIOgvkj0D4G2m
         MiHfvmANvpwgXtxLzOVWWv42bnNJ+JFzkBGBtH+3EeLHpI2EtKRy88Bjg5dL8i7kTmmG
         wDtH0tnIzRj9SqtVZMC3nTC2vvnP2qxllaPlP7JvhEiffBEPEWSn5Hjx+4MOBvMW1914
         vagvolKGlPG1O3ondxPy3H6e08Ll5OAHoMauURVktnUEeKUfR9p8TCCt2ppGaee/DUDs
         sHkVPvjCA4aflTVcJrjxEPm9gs1DMeRtw5AFHU+mtV9RxEjE8URxxrplOE7syVIxF/dk
         3FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=uBZWUAhDtllCgzUKbsfgOq5XO1bRfHYmWfHJLRmvGhI=;
        b=SUKIv0/vigxP04l44E6LUNlT4U3YT9Qr+YuXen0qVnQKgb5f6qKQ9qpfXgrd/DV2jD
         rlRECB8Eo+HubcjqRHF796caOsXuFbw1JrhdisSt38DuBO4yYZVmVLzmCIr8KMVbQTxh
         tf53STGAZ2fwMv77aUiYFjqVZbgWuxGNxEW0ltq2C5CrkcHAeTShn2RlNrodEHWTmjmq
         pFYj/fgCp7v4COV6ajsla5Sw/X0NibNkanYt2bxDpDLosIZFRZgWv3sfpj6SY158v0vt
         /DHUJ4Nmci/tUe6L4y/kpll1RouIu7Nhi0HTuS0eYadFUQjjcj6j2I0D+NRFmseqL/cd
         yunA==
X-Gm-Message-State: ANhLgQ2MoFluWkEzf5SHq2gEC2Z/J7koIazjdMBG7KQ5YnmT3RNVq0zW
        Tbp+S7YKLO44Y1AoE2Zq82KK538FZG8=
X-Google-Smtp-Source: ADFU+vvu55HC7GzeAR9KkU065p9OIPALb8genbCq3kvbmbZRS5JPXHniAqVwx/BFg4J8aOBOTFcbDA==
X-Received: by 2002:a2e:2415:: with SMTP id k21mr1096063ljk.9.1584342317222;
        Mon, 16 Mar 2020 00:05:17 -0700 (PDT)
Received: from saruman (88-113-215-213.elisa-laajakaista.fi. [88.113.215.213])
        by smtp.gmail.com with ESMTPSA id p5sm20967403ljn.48.2020.03.16.00.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 00:05:16 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] usb: get rid of 'choice' for legacy gadget drivers
In-Reply-To: <20200315154948.26569-1-masahiroy@kernel.org>
References: <20200315154948.26569-1-masahiroy@kernel.org>
Date:   Mon, 16 Mar 2020 09:05:12 +0200
Message-ID: <875zf42313.fsf@kernel.org>
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

Masahiro Yamada <masahiroy@kernel.org> writes:
> drivers/usb/gadget/legacy/Kconfig creates a 'choice' inside another
> 'choice'.
>
> The outer choice: line 17 "USB Gadget precomposed configurations"
> The inner choice: line 484 "EHCI Debug Device mode"
>
> I wondered why the whole legacy gadget drivers reside in such a big
> choice block.
>
> This dates back to 2003, "[PATCH] USB: fix for multiple definition of
> `usb_gadget_get_string'". [1]
>
> At that time, the global function, usb_gadget_get_string(), was linked
> into multiple drivers. That was why only one driver was able to become
> built-in at the same time.
>
> Later, commit a84d9e5361bc ("usb: gadget: start with libcomposite")
> moved usb_gadget_get_string() to a separate module, libcomposite.ko
> instead of including usbstring.c from multiple modules.
>
> More and more refactoring was done, and after commit 1bcce939478f
> ("usb: gadget: multi: convert to new interface of f_mass_storage"),
> you can link multiple gadget drivers into vmlinux without causing
> multiple definition error.
>
> This is the only user of the nested choice structure ever. Removing
> this mess will make some Kconfig cleanups possible.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/=
commit/?id=3Dfee4cf49a81381e072c063571d1aadbb29207408
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Greg, if you want to pick this for v5.7, please go ahead:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5vJSgACgkQzL64meEa
mQYUDxAAxrr84ybEsxCRQlX01AkdCUFtaPtwzAr4q6cuouUdEHHNWSCKqbDCVWPa
Fxm0aPllomMAbASyuDahGoEjcg+84lVl9ieclsaNCXMDqtdNTo7bpJwrA+TjzhQb
z1c4EZlO4KR/7MY4rPRNR1v+8T+Qy7cHyxAOxOHH7uDVjbGtzq7L1ETievoRWO1k
yzY42zfEyvj7z3xfSnRN6I8FbXTEKLi4L0otRjxVe3vcO/Qvw8xp9kupDTY/twsJ
o2L+E6Z+UC1Zr/jexOQm5B9eFtUQnNSNA/eH1ez4Q/yeTJjesIeHhAJnS/C9cuTk
lFHah0K12ggH8K81thYyt3/4x8khs+rNP6kTcpGxZffM0T6Ph/o1tSmfbK2OH/Te
aHEll1S8fgKJG2t0o1TQRY2WwR3Vz3ClUtrxXSx5+uixWSU+96k/lW1o7ggXYORe
3HJS3jruc93zWKr+DkFvIW6xUrgez2enrGWXxpzdGXv4RK1tK7+WO1d46AEPYxBV
ha6kSmJ5bbYYDhFbVuA/LufmDZS56wUqRox1onDwSity1BKNzkmhHrfqGH+ncyFr
2RjfeCw2zvh1qZ2W03yRqeXA1EC+uvYBWDD1mGIjPh7i/8sboHh9HCVaOUyuZ4pp
/hIco7nCWbnw/t+OI6szV+g/tEodbJqQ1mIKuWrMo+7Ozh4S3Ms=
=bQ+k
-----END PGP SIGNATURE-----
--=-=-=--
