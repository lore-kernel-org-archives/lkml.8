Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD48C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FE92086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595504450;
	bh=CZcNO56tQJwpQ9HfYF1eMJfj2YgnOmNCEU4AroXafBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=rZLMRAVczCqjJg2xrti0+KpqFHmCa39J/G/LGyahY8nXe34in07rzElVAFugY/UGY
	 kTDwABgKKlPqbVhnojwa8K2x+3xyp1DxPaoEWXOuCiBCBKn+UwrNtYdBdkrPRi4jbs
	 XqsOM612zwWDZ6w3slXWRwqyi3ZrRgr+DpotxrSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgGWLkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:40:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0BDC0619DC;
        Thu, 23 Jul 2020 04:40:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b11so3075921lfe.10;
        Thu, 23 Jul 2020 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hlTSl0JbeUfivGnDno+RXh6gUR9iqd88iP7yuNeEXtk=;
        b=TuGKc36jfu50K0bdz7oL6F7mERT2rDnIhKa6ucV04q7ayjcCZqerXE9Q3iveogjFiY
         ElyThsbsVb8xAmYW4ffLA0ghrOymW+R4Ygw2ti/8AIT2w+H0hav5QMf/xzDP5XFjiihy
         AsbKD7FwTDcWqKHitw25WIdcnc6JTRSx7IMLEWd0b2AYWiiINE26R6+MRu2bkFS0Eqe3
         bt7yBBglwPPzH7FYRuCekWoxAsGXxXRRVQcnvS/lzia3U9tftZNhuTqSO5P4Rej0GPbV
         Bq9tDmSwcCxkR41gtXY+WodZ3WyWO79KAXjX+VdWjEXs4yQ3WTz3Gk4rTnijoIPIg0AY
         uZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=hlTSl0JbeUfivGnDno+RXh6gUR9iqd88iP7yuNeEXtk=;
        b=sCUfzoQDoETD7CLCU5wi5q+mGt/om7fTuATDrr5P/t7CTLX2O1o6MKD3B9g/jexJo+
         RUW2C/ueGi2GviIW7O5BIwD/k09x2UFY6V4hMAmYvNQWxYl93rusTDDhum4Fy/HVfk02
         RI5iWjXoie1qxtbpSrMLKIPtPa4WwlGW+79+C16Hzojq5h2xPi8JXM5565UVUlZS89Nh
         J7KCuPfyHX7fl59dTNSmdG/KTjDVf8Fl2TSN1zw0A2fbxtrZsP1aahexsfSzTALtGpUX
         GFkYyVPe59Yao4LbKblahHV5Oc9rDxewVATyQ0jw2ZZDPkbvPmTQjlTLpiSCZiCa27oq
         WQFA==
X-Gm-Message-State: AOAM530DZ29kn996emkONNklgOen61edcMl1QIDTngkt0aYUV6fEDiEH
        rly9ef5E2IRTrEx5W+6UCLn3EQwn233omw==
X-Google-Smtp-Source: ABdhPJyPfWeLMzWCj4BnlN/bxERSNQ4adkBVinZ7gFr7obQ2QOp2F7eXKwVV0IUFjLppYwPEYVN5tQ==
X-Received: by 2002:a05:6512:10ca:: with SMTP id k10mr2096425lfg.177.1595504446058;
        Thu, 23 Jul 2020 04:40:46 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id 202sm2619630lfg.24.2020.07.23.04.40.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 04:40:45 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] USB: phy: fsl-usb: remove sysfs abuse
In-Reply-To: <20200702072914.1072878-1-gregkh@linuxfoundation.org>
References: <20200702072914.1072878-1-gregkh@linuxfoundation.org>
Date:   Thu, 23 Jul 2020 14:40:41 +0300
Message-ID: <87k0yuo3wm.fsf@kernel.org>
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

> This file has a HUGE debugging sysfs file that spews out a lot of
> information all at once, which violates the one-value-per-file rule for
> sysfs.  If this is really needed, it should go into debugfs, but given
> the age of this driver, I strongly doubt anyone is using it anymore.
>
> So just remove the file entirely, it was never documented, so obviously,
> no one actually needed it :)
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

applied both, thanks Greg.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8ZdzkACgkQzL64meEa
mQa9TQ//eTbNo7vhL679/zs9ZIdL1jka4yapIht3nbNonwc1veaGiiZF+PQ3h0US
+asVQSkagKmRnjnWO1/OYH59BaqXkFwgacn15+JeL3bKSWed9hNUF8HeGmsyJ3O1
ATUkgKjkBR4jkniR3IK8XNvpMBSgBR6GRq8rTMSzvU5NuWCsCF5H+cwR1NfO41hm
DjhclfkkjgTmPNFw5guorEBZeBkrOINyvW8FCXqE47u6D69DyK13YC5x05iZIvbe
IVLG5CNl0lF47UkggeDJ4ALOydeM8tSerbNLC/COEhLjOIFq5/8StwpB2x2XwcVV
oL49dFp2V1EANzFNMrJznXTqM4QL9KOEJ6Q5yvRF84F3aCjv+vKGUsoz+4cCW69b
ccke6bSRExKBIB6Tz5l/czxEpVEkgEgJkHmsabGXG4rUe33KFnVqmU/OnO7CoISR
TbSIz1PxcZHd4gK3P8J1XVWkMPodaMtoerKvQPO2/lWVlhx6DhY53agatMy0vO9w
GSabS8l9xKJlvRBhz9Wx/XpEg57FCBgArPOhEgfDW/6PqamNdTIaYz8DeScopvpT
OhGCNX5ccz47MCuzXpbhxEYAXqYRkNr3gqKRxiPUZ+7gmBb3fx2OnUDMqUT7dzVT
iEkhHns064LZ32ZPq8rF7aFrQTvPkKbUb7VGTvimhETwGMHSzHw=
=uDk1
-----END PGP SIGNATURE-----
--=-=-=--
