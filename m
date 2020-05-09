Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B21C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E202184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589011342;
	bh=RA/fzqk96CmNb7Wg8ZxeIFCcDkjdzdPva6zqPxAaUKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=fTQK2kUFLiRtpl+d+FNZwsuhTs9z+dCZJFD2KCGkp0X+IRfcaYW1gg8E1O44QkNUS
	 CJ9nttfFo0mgZeCBYKhUpz5E/6DtZ/Q1qS7/aQaLBd6DxROv1+Hn6E9UsPyFKQTIlk
	 Kd+tA8pw6PAa9yXrw0FpMu+Pomdl7EbXuUFrFKc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEIICV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbgEIICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:02:20 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D828C061A0C;
        Sat,  9 May 2020 01:02:20 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a4so3257309lfh.12;
        Sat, 09 May 2020 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=BuTmdFQyPT/UZt2ymSX/JY4LvFwkZzPp3F14X454bn8=;
        b=Z/tAs/QevuNrQ0BwYjAZBlqOh1h4Tpajd4iqRsOnOXhX5eUw4oHZxcYnskD9rQ+V+H
         0J6XgKQA0L6T9HwSn2yizRwLeikcQcY5t7G9kIeagxty6t700t5bKuIog7umtodpU5PK
         ZSNpN7BkKE8qJp0LOkMGelIBQ5EFJUQrRDK8Fb33En3eA6DY/CNhvz06mjHIhGOtvflA
         Hq77Ek1/yQfoi/m5Fr/ZWQeO4tVVb5PEOTbnZEeh1yXbASdDE9nFPFauF5VhwwjGWTkg
         tkhxqsduFwyTpoGgwGREfLxMQsA/928ISmnVkCt+ILv2scrU9kom+ImfzGZfiuSn2BrS
         AJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=BuTmdFQyPT/UZt2ymSX/JY4LvFwkZzPp3F14X454bn8=;
        b=FroSoJFvlx/6h1QHyKSst9FYzu+H1TmKli9cXfUV6KOc9/temTO/SxWeoM/gX3FpO+
         Z4ps2L3CTjgt1etKb2aLRouTKWfnXnKxfgY2bVcHkOlBieaDtmmsszO2QM2vVKbxXI4g
         I6TzEJrh7EBzZAyb5OqMCeP+iLqYvB/MmF+l82gczMmG7rNf/YBnk2OU1Y4Sa/hl8cDy
         D/OojpuC6CqxA/JPKi/wm01f/ehmAQCybhuPCVxTIG8mEuap/JFUmL0tCnmzmIzFVPE8
         jrW+oyjcNZX/GeoMqjlnKLaEYdeFZQwHMyI5qgg1tnR+Vh1kxTwUzLkk1z4OfWg9JJfy
         NqKg==
X-Gm-Message-State: AOAM530dZvOK+q6OexQCxny7x8u1XDgjInEYfXG+jJKvY6BGbaIAgZ/s
        aLr6UfYHwogSvu6dM37yFtY=
X-Google-Smtp-Source: ABdhPJyGL1rF/FXwTFL072+D1awC/4HqNexICNeOuN2DuyGoLCL3fJot18CM74NGpLkR1xapK2MLGA==
X-Received: by 2002:ac2:5199:: with SMTP id u25mr4373879lfi.80.1589011338783;
        Sat, 09 May 2020 01:02:18 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id q19sm3059482ljj.84.2020.05.09.01.02.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 May 2020 01:02:18 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] usb: raw-gadget: fix gadget endpoint selection
In-Reply-To: <CAAeHK+yxoYigM7uWC3cpKmCjgMLXQ1pT=MkJ7XQYCVRgZ-DdTQ@mail.gmail.com>
References: <2f05fe9aa7e4bcb1bad3f6d11e48a411c901af68.1588197975.git.andreyknvl@google.com> <875zdabzs3.fsf@kernel.org> <CAAeHK+yxoYigM7uWC3cpKmCjgMLXQ1pT=MkJ7XQYCVRgZ-DdTQ@mail.gmail.com>
Date:   Sat, 09 May 2020 11:02:13 +0300
Message-ID: <87zhahlenu.fsf@kernel.org>
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

Andrey Konovalov <andreyknvl@google.com> writes:
>> here you're changing userspace ABI. Aren't we going to possibly break
>> some existing applications?
>
> Hi Felipe,
>
>  I've been working on tests for Raw Gadget for the last few weeks [1],
> which revealed a few problems with the interface. This isn't yet
> included into any released kernel, so my hope that changing the ABI is
> OK during the rc stage.

Fair enough. If that's okay with Greg, it's okay with me, but then how
do we include it into the -rc seen as it's not really a fix?

Greg, are you okay with me including such large patches during the -rc?
They essentially add new IOCTLs to the raw-gadget interface.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl62Y4YACgkQzL64meEa
mQYjJA/9Gb9ZWN8TE3Q3M6hAC05iGc3Td3l8aC6OQGmDPB5as3fHiCM9wqHOfHMr
fL3OhtCRl+C/deIgW28+4y3uQy1wYOnIvgqeEJDUPjhO+1d0I2z+F1jAJwx/9H7w
4tGD4goEl7uvRdiCwkkxNgWP74LW0+3/a8riL+UKCbgltBWQaXUIFw1ucSziJt/t
W/Sio0YbQpyRp8MBaAdRmE3slA/EUdM8B74j5d5sT60/9+dH3gqH6/9IaTjhVaJf
6q7XPbe8ribIS94rf6it04Q47hg1JTvQbvo+MPHuZuVyPj3xRkyevMzELPTp3/yv
gUwEGp16s5XpELelEtHiixSafGZykzmU9xAM203t9mhzmvqiDenDrgNaT24XASLe
tG/IjNTxNr65R/9FoUnrSTQquahZLVTE3IzS4wkznUjDK9v0P/+IuQLQVsf/3Xvg
YFXG1XCU+b6h68CG0T5Wvjbxlcte0Cycq7THcovVRyBsyPpGy7VnyJoRMB42A13G
dKKugfm5M8czyT6mOcqFQV+UzsFmwWpOjHmZLTP6+6w56FSz2Fx2S/uCduP6jSCd
yUQ+lE8kguXtonMfhWWRrR9m1jq5lsrvrFxVtDUVxB0G/VHmfL+GiNXzoGQo1IbM
RcsH7Y+y3hBXzbOE9S6J4WjvLghGrnZEdgbSvuVhh0gtIxVQXVk=
=O4Si
-----END PGP SIGNATURE-----
--=-=-=--
