Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E81C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AA9207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593693249;
	bh=uhA9m0dbwPMdz7n3JIq3zFgdGwPiRO447DzKgaMeJ0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=zq/ZUI1AvYLqVr9ppBxpp7HXIB7cziIsf4G7tgAIv648V/P5i7DTzJ/9PEwCaDMyl
	 U5NwHQ6Zr9ETXqC+WC0Zwle5qYslpyowNzoCl1B+HxIjrcl0LRN2TiUamGH1h77ztL
	 6t18HzUYxxjRgYQpMSvrsCe+BLj1vxgMAt0Z413g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgGBMeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgGBMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:34:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159CC08C5C1;
        Thu,  2 Jul 2020 05:34:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so16001217lfd.10;
        Thu, 02 Jul 2020 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=73mwDxKIIi5xy52ifDuHdmCPwFGyKXx2K9p8Tj3KFm4=;
        b=oY2YIKKT6qdIqfACrZtZJq7fWxKXCzEkrVs6WeshydcoP7Slkr0sGzg39490BShUoj
         phub7Sj9yTYm7jfOLyM300/F7uKeWW4Jgn7SRLoXAw3wtRtjveoPP8Nwtr0oliEsry4X
         kapTDR9P/MCNSqI3wO3iQ0MGRS5kPJsLmfqM5OVimq/K5IsokwlY/0byBkFhu5buVdzn
         twSH7dsp1dso8x/lAEswQTKiqKO+4WHRnJ8ti5TkGDP+H7StUbMETw/3u7MRTA0aklqB
         DWtThsVo7GsEtOXod+PhUPtgBOFUiNbarR0wpejdMoXMKNO50SIrHQefzKX52gQbu5oi
         aN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=73mwDxKIIi5xy52ifDuHdmCPwFGyKXx2K9p8Tj3KFm4=;
        b=DZFNtlZ1ibc6hmPJSFhGh1rX0RDzOkOU5Q85ATFBiRfjWIqj0GKkhgrnnnVksJzYbz
         LGSoVP3szIabNk26FZf34dqZskKW0glfcZiSjfxgx2liKyXwHnlDzOj8zW1CfMW3uLop
         60rw2uWohX/9AujcnDtuRC9N9zAHH+si/wdOWGGPo4JcONIo37J9rWE6akV+L/i2Wdmk
         cCdA2NbsNywe+vEMiGPnmgoKjfc78vgxvlEyqPrUjNix/JRAYMoIRcOyCM/W20UkGLlO
         yfwJsX247MvXUXvxoytcTemGjUL/6gRftoyVQL1Y7yQa6WLgmlNn2tj0aMDg+OkUKwoE
         2f1A==
X-Gm-Message-State: AOAM530pCcq1MlzK9CtRxGJamj8NjJBSejO2/Pkp9j8ikN7barFjo4DM
        H/tzOl9ubGkV1k14tYgjnNuc7p/u
X-Google-Smtp-Source: ABdhPJxbwzKvfyX0QzWCYzf/1I6Gwt8CNMRr23fYGL1xEirTzHrD/o9yt9N5AVdARjAROXlz6cPd1g==
X-Received: by 2002:ac2:4889:: with SMTP id x9mr18419111lfc.162.1593693245337;
        Thu, 02 Jul 2020 05:34:05 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id s62sm2906537lja.100.2020.07.02.05.34.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 05:34:04 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: Fix up terminology in include files
In-Reply-To: <20200701171555.3198836-1-gregkh@linuxfoundation.org>
References: <20200701171555.3198836-1-gregkh@linuxfoundation.org>
Date:   Thu, 02 Jul 2020 15:33:59 +0300
Message-ID: <87r1tu6qq0.fsf@kernel.org>
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

> USB is a HOST/DEVICE protocol, as per the specification and all
> documentation.  Fix up terms that are not applicable to make things
> match up with the terms used through the rest of the USB stack.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl791DcACgkQzL64meEa
mQawzBAAyFcEX0ddbG6MFqGYmkToxPCvCxUrj81I3NWxoNMIX7C8zZ4JXsxXnUnm
b8uJaE9i5ULATV/7yPyEzxDxz+vDhBJQ5NAprSZHx+56M44XWP+RCKMkXcShOS4Y
5Od8V8K0xWpL8or2OGfEXyqWBKFypQgk8ev6r1UytqQmL+IJ8pWMJd4ei6STx9PS
NxE4hqRTrN5GAja6wR4R873BP9nYBvuGm/vOFXpoiGHbf1d2ODBQBgc26xHkllJc
INMU5CjEC5eyXAF0o7cmm6VcxumBpAOtu2iJVIG6CN8bGMus8HKLJNr881olrw30
3p6VtuLGjIL7aLJvj2yFqufikEiKqjmov6SUpw5drgm+Mwyazre1mr0qZss9MwiO
2q7tdRRYQNaSvNwzLuJ20q+oSHhw5AhmHD8NYCXCFUiwMjph+FaZXOFM0ja6HDth
tVZhjWqoBi+5NjVLMChiPdzXDnwn74TSWf++3Rdazog8HsWrLfHh5bHAlSb5uwQ0
lAE+DjW1rp43wqkiYHeoqOQC6L2lv82HpXXYhD9CTqf/QGjmeDYykcGVDjs8ch8H
jQzPcx4JPoLEQrAx152+secRHmliOHa3MSQrqgS0jCISAE+G9y6JlH/1tJM19FMX
tHDTYJ9rL5OacWdUn18N4xQ5WTdlWYsuuwR+F6oVpmxj35+Ujkg=
=TfOn
-----END PGP SIGNATURE-----
--=-=-=--
