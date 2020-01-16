Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C181BC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AB820730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579179898;
	bh=oHRvLFsSZO6m5OUuYzRooxxwNZyNse+CVWLNaVKCMQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=tkgL0kznnW7i9ipDSBbLK6aNsdjHbO8SeSZdMQbmrtjTo+iodKTjSSI+82GvaU0mD
	 CqGc6nxYrZLJyBGPgDAdc+d2OFTjbumwAmMnEHaBjJdkMdkUdEHepI1rQyK64suVMu
	 ugB9w5CecM1953a+wGOqOfZz/NZ06HB1iUxsE974=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAPNE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:04:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45336 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:04:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so22516635ljc.12;
        Thu, 16 Jan 2020 05:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=oHRvLFsSZO6m5OUuYzRooxxwNZyNse+CVWLNaVKCMQQ=;
        b=KhIVuR+gxWcwLJ11YF7kRi4tbGlMNWp6VSAL3G8rxgw4ld0+ahnopyFBMnawRh57dY
         QGQOgxjFPdOY8xqgCCTy9z7tZjVDXJRClUKZN+mWAQxUAwiS/T1g/VjuuPxXsyzWwfTR
         sDntahJ+pzCEqFFl+uT65etVw9Z5kuIu8jmSeuNBUBFg+hJsEw0Qy2oqi3sbJkXckvLt
         U+rf11i1fbsW6bwoudDVzHDVrZTHRfJj90C6S5gS+kxvPAWiNR0uLzwnVK96NRr+8F4E
         hp5QQagpjmXXy+mRgcTxjzvfTevL7unn/FnKglCD5Wouas9j0A5huVPLVgsUlk76gKBN
         Xsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=oHRvLFsSZO6m5OUuYzRooxxwNZyNse+CVWLNaVKCMQQ=;
        b=UcQQL7K41cZOTJ1Nkj3owO2zhO0lXctZYTf7NSl4mopT4UOfuM7Sj6Jg1Euu9QefS5
         QLmyHdGZjvCG6uEdRZ51FydSKCC0hVpaCkRjVBKHYBphfTaoKvfjlZ3upkT46uZB33O8
         mMcuExGcxTq7sEAifbmxipRWC+/fc3EIYujyhgEIS6hYqSI8B4RaoHCfMIpziK3kawrt
         UfLUWNTIkWwy1Xn2IhPmlqkY065tF/9lUDJFZ18r7eAPqY/RozTiMZ64LtkcluBVDT5s
         aOhwZe3vYGaUIq1m24puSJTh6zCKJESQ4gLgtajL2BNoB/AYpY9ALOpNJkmpgLWv93cJ
         nrQg==
X-Gm-Message-State: APjAAAUVdEU718sn3k9pPV5E0xG/q3XHfnVP29QcwpqBQ+yQTb7zLijA
        yGBTCRT98j7E/Umdfa21T6a/wV69kbYcrQ==
X-Google-Smtp-Source: APXvYqzONfQMaakO1AnVbdh4w7e7YJyb7Q8b6QWCcufg6r22Wmoop2YYvaOEVO/wZ0Ar+VAqT2QG+w==
X-Received: by 2002:a2e:990e:: with SMTP id v14mr2098350lji.23.1579179895377;
        Thu, 16 Jan 2020 05:04:55 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id g15sm10634929ljl.10.2020.01.16.05.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 05:04:54 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     "Ardelean\, Alexandru" <alexandru.Ardelean@analog.com>,
        "m.olbrich\@pengutronix.de" <m.olbrich@pengutronix.de>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bigeasy\@linutronix.de" <bigeasy@linutronix.de>,
        "lars\@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] usb: dwc3: gadget: Handle dequeuing of non queued URB gracefully
In-Reply-To: <9d6ec804e3f1f462e5c6a43d19c83ff3493e3727.camel@analog.com>
References: <20191106144553.16956-1-alexandru.ardelean@analog.com> <20191112144108.GA1859@pengutronix.de> <9d6ec804e3f1f462e5c6a43d19c83ff3493e3727.camel@analog.com>
Date:   Thu, 16 Jan 2020 15:05:54 +0200
Message-ID: <87ftgf5z65.fsf@kernel.org>
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

"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> writes:
> On Tue, 2019-11-12 at 15:41 +0100, Michael Olbrich wrote:
>> [External]
>>=20
>> On Wed, Nov 06, 2019 at 04:45:53PM +0200, Alexandru Ardelean wrote:
>> > From: Lars-Peter Clausen <lars@metafoo.de>
>> >=20
>> > Trying to dequeue and URB that is currently not queued should be a no-
>> > op
>> > and be handled gracefully.
>> >=20
>> > Use the list field of the URB to indicate whether it is queued or not
>> > by
>> > setting it to the empty list when it is not queued.
>> >=20
>> > Handling this gracefully allows for race condition free synchronization
>> > between the complete callback being called to to a completed transfer
>> > and
>> > trying to call usb_ep_dequeue() at the same time.
>> >=20
>> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>=20
>> Thanks, no more "dwc3 fe200000.usb: request 00000000cdd42e4a was not
>> queued
>> to ep2in" messages with this patch applied.
>>=20
>> Tested-by: Michael Olbrich <m.olbrich@pengutronix.de>
>>=20
>
> I thought I replied here, but I guess I never hit the Send button.
> Many thanks @Michael for testing this.
>
> I'd also use the opportunity to make this a patch-ping message.

https://lore.kernel.org/linux-usb/875zhd6pw0.fsf@kernel.org/T/#u

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4gX7IACgkQzL64meEa
mQbl/xAAxg29eDM+Ua+CWApxRhTmdYgTlYT5XRtQFBHBwhuRjqVtDLVx0dQsTM9d
+GAd0dJSWYIfYGKdNcs8F0QP+WGVd7iaW0XbtxoVQOyYA9fPyKrAuRZJ0cyB5oYP
dFBzXHtKihWnYhYDO/vpUxv0pq8f++3ulrPMyuL3ASgzo21aiGYhSYkw0A+K7lW5
xZhtOeEYTGtTtBm1KbT8Nf36e1Y7MNERLnswDIf/G/Mf9eZYvBChM7NldgWI0aBM
2eZlxWfd+G2pNWuEqmSs9pccLp/iqry4m1nh6sPj3CYVRTG1fYiBs8LK/DMhkW7N
SXaMzWfTnuyMaSpVDAKi8nS1IaZ+rbx8lqvUW58tlh19CIkljctu2MCGD87W2xEM
g2tXDEpJQl/EpDuHqBIB65JI73JiLHML70OUUxlaJkItM2IjpDd6qVRtIdQDQGIh
omebx8yY45K9ogM1ZmJTN87vm/ZNnSisdPZazOfWh6oD1ZnEGB5TNtRhN1ZFYMvt
56DntYRDF9vao7UoKeTIs8IiZjaQTtf9YByQLQ7e3J5x2IjcTEQFcpDZA92QpF/V
6iGNKJB3yInOAI5xHiEwHG5nOPUfnh/9ExqDRjzl83eooYyO9d0tb0NpdVE7mgFK
PN0t/WDQombAOaoVYun0PREpAlLSxKGlk0gY/nXASOofBuqXglM=
=hRcu
-----END PGP SIGNATURE-----
--=-=-=--
