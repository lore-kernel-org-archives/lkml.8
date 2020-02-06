Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D78C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D87C20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581014071;
	bh=8EfBbMgBVEVvho7g3qQLiX+cMqOYaCWXuctqNjwnenM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=MQFP1xITn5cVeMGIkoObMVwTWJ/hlyA4DJtRg0+YPqywpL2Fv/5tPO9x8x1AQwwR7
	 LMdy8e9Feel6bp5iOVrWeQu7rg4gaKShscuBX8UGfonNEltjzKbeINvX5F+1DiAUG3
	 aLYSgyJwTJ2M8JeVQmZdnZQg3vniaSUxV2/shFeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBFSea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:34:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35606 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgBFSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:34:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id z18so4827379lfe.2;
        Thu, 06 Feb 2020 10:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/+n2nkntJosFeYc6CO6AzXMJTC7jYibAIizSqTWcO7U=;
        b=BvXRj5fNezVzMeLFqXLZKZAln3PgbE00jyL7mwyXkgO9VAiSfun2NOhJkSN/6ANuBJ
         cOoPbbFKVPGNBlF96Rb+UEr8b5HSxM7aZubPDFkBrqOFvkBrOV05E34aojSueC9oSgQk
         2UPsCGI6A576qKWmnYgYN0MT6TnrQo26VZXpIajVxKc/6JEJL6NGhEVStRBAloyVWbaF
         3k3vs4PQ9LR0IAMO9IWKUjiTZv+W2UaVUKEK0eQVpe7jqotNcuYrNUOgITz07lkwnO4+
         4wpIecZo83R7hZw6qnXx1uEW5C3J8v1uhoBOzbjqUAgE8soYVbF6l/nUWyCD82H9He4F
         /QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=/+n2nkntJosFeYc6CO6AzXMJTC7jYibAIizSqTWcO7U=;
        b=cRttUStzJEWgZvD9D2zGFYJkB7w2MJMiy694ACGjMvro1SyjWwB2jNbZ9JaRUlxI1n
         aepx+UUCKE6Y17vVc5QwpYGJCQ1jixPm4Oj1FJNHAFXzzB+R5gASFUm2gpGwKaBckv6W
         PpiKUiGXgMzpRKM9s4IKpGMeCaRnyH27dFcmfuJ68ZsxUkpf9R/jMY790T1IPdo1kueb
         KmsfLRzg1EnKxUxwB2VwumySUB49R+e8gvhsETHwuRwMcdC77xUFU9lwDm1qw1USmRLf
         O/ew2BZuUEaAcKxdC6EhaJJAvCSuUM5z3oRtok4XqF1Hj23UfnJ123Kdkoo6oxjbeaWq
         IYFg==
X-Gm-Message-State: APjAAAXyLd2OvfeBzskrBkrVLSwHux0IMS4W+hfPpL+OGUJZ714xS6GC
        +s/bVqSod0d8QBAlzGmp1JaOncutlGA=
X-Google-Smtp-Source: APXvYqxnQQGKl5auHeuxeSsCWAnVHiddctLWR7EJGZzJSZKl8soTDt23+hh7pBDycDIXwatDJBVu1A==
X-Received: by 2002:a19:c3c2:: with SMTP id t185mr2553485lff.56.1581014067986;
        Thu, 06 Feb 2020 10:34:27 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id q13sm68396ljj.63.2020.02.06.10.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 10:34:27 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: Implement set_selfpowered()
In-Reply-To: <20200205164448.0c7532c1.john@metanate.com>
References: <20200204152933.2216615-1-john@metanate.com> <87wo9156uy.fsf@kernel.org> <20200205164448.0c7532c1.john@metanate.com>
Date:   Thu, 06 Feb 2020 20:34:23 +0200
Message-ID: <877e0z5zv4.fsf@kernel.org>
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

John Keeping <john@metanate.com> writes:

> On Wed, 05 Feb 2020 18:36:21 +0200
> Felipe Balbi <balbi@kernel.org> wrote:
>
>> John Keeping <john@metanate.com> writes:
>>=20
>> > dwc2 always reports as self-powered in response to a device status
>> > request.  Implement the set_selfpowered() operations so that the gadget
>> > can report as bus-powered when appropriate.
>> >
>> > This is modelled on the dwc3 implementation.
>> >
>> > Signed-off-by: John Keeping <john@metanate.com>
>> > ---=20=20
>>=20
>> what's the dependency here?
>
> It depends on 6de1e301b9cf ("usb: dwc2: Fix SET/CLEAR_FEATURE and
> GET_STATUS flows") in your testing/fixes tree.
>
> Sorry, I should have mentioned that in the original message.

No worries, I'll wait until those reach mainline before merging
$subject, then.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl48XC8ACgkQzL64meEa
mQawSA//bOMietY1wztRDRwp50omJNycVlgdFjSDrr8fs5Lwd0jKYkf3OFvnxZ+O
1YN9NCQpdzyAjIzc4VckKon4qPW3Zae8Sx+Bs4BP+3tTy1XHBA/X+QKFlI2PIShy
bJqr8U7Sn4SCeijFCZxSs8koH/ApEuSxuJT/f1vENk/LiVkumx3+6LMkoqhyk36e
a7nFnObjjsayvMDYTEwukKgaPF0e72gGzXOYIGZIoM6dSyxQjf5aQp1Rau8oplL/
M1IOui3iWkLaPED8XXT9nuFatn5C11UYVyyfgN6CRroGq/Pe3d+uS/zL0ILMZdRv
D/jgoUSBs5QuXiB0HMjlA39zm9g0uBIHQqlK9b/yBecRc8k54gt82cu5la0MPVTc
/lFkuq60ByuBt1smfn6sKJY8dIZjlEXM0uu02LUSTMqxLmszDvyfDPMz/79UxzmU
4Qs/LnaIJBfzu1OAmWXk2lx8OTDMNA8MfJFydRqxT8AemEcMMfoXGKeTl9YHEPG3
Cp2dc1VmJwKchxRkOeIjEViWAUKFwT8g9avoWEGfw3Jfzdbq+KOV28PxilNReTpI
fT0cF2rV5Mc+owVntQ/YjAdTQE/njPBJ+VoO8NbD9d/5ka5sv8HqvJ2aIk/NVXVS
IhrxC/zwMQkZNBCFJ+iNuLKyQtezaFOi4b3uThAE8xrGMGAvAEU=
=EmVB
-----END PGP SIGNATURE-----
--=-=-=--
