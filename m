Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C39C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A908420721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588665043;
	bh=mJhZOZvknx96YuEoIZ2lqzNSjlIdDACHMJ5KWHSNI14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=zp9wzUMVD46xGFl4H3OMZluKX+wIQ6tlJaLj+kAQxtqmzgnRDKludSUycxDVbSUyt
	 oNuH2blHDkPD5Cg5NPlfGwwaNV+zgwq5WjjaAPCbKVkqEe5yeVltNsVA5vm6uOrwFL
	 cmmIEh6qzY00zMFQdBziFXHLPmyO+uqQQ+sgKUVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgEEHum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727784AbgEEHum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:50:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4448EC061A0F;
        Tue,  5 May 2020 00:50:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f11so606081ljp.1;
        Tue, 05 May 2020 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=mJhZOZvknx96YuEoIZ2lqzNSjlIdDACHMJ5KWHSNI14=;
        b=Jizk0qQFeKxlo8BmZLCqFT59LkhWbkXaUm0JvMxInhtI9stFaerYXfYpUUKPMTu00J
         ecApN3Lk7NeLleo2HSyydSUzr5PNBpX5ZaYGCOwcIZ8FNZeUSp6jCnJn2qwxzrEggFKq
         1Vk6FhUySRdnFAJVz0hmZwzqRN91fkmic/fkWJa7EBS7346q7U2NR8t39kmZk6qZwFRT
         nB5YHtcurGSRefimxZBJKyQRhlTZjt+cqCYyFYsJP75irnzM+Mcas/7fzG3lVukrzZmT
         h24/VnE5bsE+UK0XL6HiChm201DbTx71pM/PuhoPiCKm6pAYUZ6YvH3rYpazj8VXwWD6
         jHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=mJhZOZvknx96YuEoIZ2lqzNSjlIdDACHMJ5KWHSNI14=;
        b=cM/Ejt9zSsea2Ng1CuC3C4QasqJ2XmSvycHw5qBqAbA94gblOCP/wCsdabW4y0+DHU
         eGCa8s3iCdVqhbEeVOhRX+9/QJOq9kWSymjrKz0xuks4xiwN2Tfng7S0ZmQQzo5rGQ7n
         ZWZ/L/U64wyqYqI7K/9S8nC3lMa0mShkojonLV9JvfCsg0qL9oaw6w9czJj/875B3oWP
         7Zup/IatpUcymLDHl0pqEZFODYWb/wAyNbt/0pR+mZA+1YLnkSkp6w7kel76KEgocMat
         vaGi73o1Qc10McZs456iiYEMHFshzKo5GmTkE9vA3Mg01YYpPYBeo9YBKBkmeFLT1k24
         H/VA==
X-Gm-Message-State: AGi0Puad4TrqYdX/BAgyR9bNHsQ0fJ6wfbona4bVqk5TUsi/RENt+LyP
        jxbOkSsaSbzFkPPQejADVMU=
X-Google-Smtp-Source: APiQypJwsh0uX8J+3lDVtKC/e8pRKH67pL7DjJ9HXCeAvh1fxGH8InEw1kyUTUPeGekvJ5dU+OHkSA==
X-Received: by 2002:a2e:9996:: with SMTP id w22mr1008682lji.59.1588665039763;
        Tue, 05 May 2020 00:50:39 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id k18sm1510096lfg.81.2020.05.05.00.50.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 00:50:39 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH USB 2/2] usb: raw-gadget: fix typo in uapi headers
In-Reply-To: <059e7e0ff26cc7d6e85275f764e31d85db867c4b.1587690539.git.andreyknvl@google.com>
References: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com> <059e7e0ff26cc7d6e85275f764e31d85db867c4b.1587690539.git.andreyknvl@google.com>
Date:   Tue, 05 May 2020 10:50:34 +0300
Message-ID: <87y2q6akhh.fsf@kernel.org>
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

Andrey Konovalov <andreyknvl@google.com> writes:

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

return -ENOCHANGELOG

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6xGsoACgkQzL64meEa
mQYUDBAAxMRssVJC1mciz/vwFtxsZjLPKIe8BSFhAU7jrWxXqtA+7D3QLYd5JLvw
4xzZnTOSw/AOa/YAdsgGCQOpvNwqCBlQkR0EmaFEyIKNLwg28I+R23pVAT5cGX5r
lUPymKhGnvPmSjau74MZkdMlPL8hp0c6iGFbq4OykXNilBWnX9FqmsjLle54S7cq
FRbmQTA6GfLMw+O7DpET5rjI/vV3gosobuiYJE7ntB9luoz3RGnUmva7TTeaK+I8
MWGcjppGG3pgeVbfSNIm0rQhATgoXwS6qGWtU9HV6+S5yaEZTbbVWwZKvDyxOelI
SzfTsZK20u0BhzqgP6NBJKcDIk0c2mPF70rWUdwBRbMxhejFcYWiFXs9IITxwtRr
mVUc8GjujXzMgk3mzG/UNQigNWpGGzvAeUFo5ft5fnYckcsmN3IlotthVFDXE25g
3JPG/Lv5kDsYBOsarbgUsRN8VlJKHfyygST5B+MxVZnYZh7xY+qrR97mYA9ZdaEz
gW/WCykw424CoWvNHl4OXXDP44eiBDtUDcedPHGoY43YM63fK439yeeSCAM73b7S
4f9P+GU1uIYUvZ8VZjnhKB94VdBzO2F1HkdswZOl9uAFNmZvcPPiIMYdhSEwMT+8
OvcTBCCEjG0UMS1kvu6uNhtCeFy4HdoeRAcLt9+Y8Iy81ngYTBA=
=7IjE
-----END PGP SIGNATURE-----
--=-=-=--
