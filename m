Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C92C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589A920575
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589265658;
	bh=bQMdQdnVPDvpxknl79QvpAcLjSL/PPXel8ZsZdUjAyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Mcg3jdHXAuurytiEOiIw2Q+FZG/6z4bZHmezJq3SMuBrkndfMQGjsvF/7PEBy/Bri
	 JkBJuD7mw1CvjnjJggv5JKV/p8phnkBAf7cLF2K/943UkyFDt7y+/6mlZZ4WL5ZCLb
	 Pt5f4+TOQ0EdU3ODpRyfiwpH1y7YlFYhTqjTjOEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgELGk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgELGk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:40:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CDEC061A0C;
        Mon, 11 May 2020 23:40:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so12261636ljl.6;
        Mon, 11 May 2020 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CvDFw3VxZkX78aA+MdfUy4a8VmJHp4z5s/fOMPEwqfQ=;
        b=Bd33efnXE88VWqLM9bDrxn8uzAhETLqeNNnaUtoxd7tYE2HBkf4C3c1NamPswJcGD4
         b40w77ZcdtFoJOJPA9M6JURDOFnFubs6oHOKKnAERMdmHnxcEaxr1L5jTPSzS+DKGF8B
         HUzc7mnAnCZ9LcvcW3tOE7mT81ftX1kaG2+7+tKA5qC9oiWPED5qupwREMAF8HtfmN3z
         stfFng5kQqvknayHKTO87Cit80dvR5RGogU6P88CHEDwPr03PZ5sGoxtAVA2RbyTcGAq
         w9v5qFdLJW/qGLi+lAj8kl1WZCgP4nXJpDW1DC5wV7j1Pc6XAWhzkXOdLnMzL9zBvgaH
         AZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=CvDFw3VxZkX78aA+MdfUy4a8VmJHp4z5s/fOMPEwqfQ=;
        b=H5hPy1jx6gnhQPlrU+4czF7Rwk1KK39ru1/zNGvP9cOGvJmmpHjtYyIX8t47OnqLkw
         Vg5T0ackZv6UI5qbnZoR7xtkn4VxkrLhZ31smsaKXHv4TMEAqHVhhOQwUfYPf/HQETy5
         DrtufyhmxgprAZQdKlARXAJycz4hKdwz8QxmKpaEwESD9x7qC6NvOXDM4iccpwItTxey
         xGfPEvhGnvgQdmMoNZcIyAgp3UdW3Ewn5Bo2T+X25FxW2Vu/CpFMRVV3GXIuUoyamPdp
         +UIdXj3hm5VE/99HpncJl6erGyRtuiwXPddleqVbjiDRV8/5IDVoHupEZWOsu/QlMA2r
         LHaA==
X-Gm-Message-State: AOAM530xDkdxVEsUHin0MLP6nFObK7LsxkZn1SN+ZnB0HE3DNcNsRDvg
        PUNSTcpfkPT5u8s9d1x0a2E=
X-Google-Smtp-Source: ABdhPJwMIxXKqZg9TJAoa+cxwCGsXoXtp+dvXK94pDmluoVg92qTksjGCWtkRhjO5mm2pvwfqHw7rQ==
X-Received: by 2002:a2e:8944:: with SMTP id b4mr12748662ljk.84.1589265654887;
        Mon, 11 May 2020 23:40:54 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id r13sm9734148ljh.66.2020.05.11.23.40.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 23:40:53 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] usb: raw-gadget: fix gadget endpoint selection
In-Reply-To: <20200509170843.GD2482887@kroah.com>
References: <2f05fe9aa7e4bcb1bad3f6d11e48a411c901af68.1588197975.git.andreyknvl@google.com> <875zdabzs3.fsf@kernel.org> <CAAeHK+yxoYigM7uWC3cpKmCjgMLXQ1pT=MkJ7XQYCVRgZ-DdTQ@mail.gmail.com> <87zhahlenu.fsf@kernel.org> <20200509170843.GD2482887@kroah.com>
Date:   Tue, 12 May 2020 09:40:49 +0300
Message-ID: <87mu6d4pvy.fsf@kernel.org>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Sat, May 09, 2020 at 11:02:13AM +0300, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Andrey Konovalov <andreyknvl@google.com> writes:
>> >> here you're changing userspace ABI. Aren't we going to possibly break
>> >> some existing applications?
>> >
>> > Hi Felipe,
>> >
>> >  I've been working on tests for Raw Gadget for the last few weeks [1],
>> > which revealed a few problems with the interface. This isn't yet
>> > included into any released kernel, so my hope that changing the ABI is
>> > OK during the rc stage.
>>=20
>> Fair enough. If that's okay with Greg, it's okay with me, but then how
>> do we include it into the -rc seen as it's not really a fix?
>>=20
>> Greg, are you okay with me including such large patches during the -rc?
>> They essentially add new IOCTLs to the raw-gadget interface.
>
> Yes, as the driver only went in for -rc1, it's fine to add fixes like
> this so late as we don't want to ship a -final with it in broken form.

Thanks, I'll prepare a pull request containing it.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl66RPEACgkQzL64meEa
mQauvA//RClDtkgGG6+X7US8hr34DwyDpHe+viSSYdHCtCF0Wsjkd5q55u9PIwBu
DHxZc7kOIwoMEWJaTyx8nb02zrMN1UeyEMzL6vhCuLKDXUn/SsmaujPh2whJlBBz
zvp89pkxF/Sup2TwNQyA9KAaf5xmS5kUZAebXdOVxczicfa91pwYzY96NUp5OG32
MNDZDVNlYzxxGbHvEdE9/azwGnPHwRBlWomvb/YnaUbwMG6+ZQicS9+bFxsp+TQx
j4+1AzX1fj/YTS+fME3pUiFLsuOF2h6V3iLhm4RhFLJoZ8MQ2JqAtO7zd9PxjzUU
ZSu3KyqQ3TswX/WGoSRBPw6gJX/RrP1Gmnu32okfXKsZeLl8XVbhDTHzTlyGQKB9
NAakHCE7egZ4h1vK81aC4kVuvOBayPP6nbiAN1QNC6OeN2WXhvp2FXN8bd7/RDtp
w4OEpWm3MGMAxlXic2GkJchUsYxEmQQ2rPE1xG/eGCc7vASbHjLOB28raH7EiDU+
U0zJ8xpIpviX+Z07EWHeGWO99ENk45ZqRWu8L4jMPIhnc54NM7OBcDZTY3hhw2IH
dQkL39KouhMFH8e2hGkHvn/vOBHNcCKE7Ofnb4mzxe8XB5zWEJVFja8iQy0XIt6p
ql34MLf7ciYoAWHdWpbISmTcrCIlQAUgQHNf0EFTMeZwgCwvbNk=
=3yqU
-----END PGP SIGNATURE-----
--=-=-=--
