Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A596C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFD220729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWkTFvqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHJOAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgHJOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:00:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D6C061756;
        Mon, 10 Aug 2020 07:00:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g19so9454824ejc.9;
        Mon, 10 Aug 2020 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Jkjqxej/y2JcP9NMnzzVbe7sdXk6we2prVXda1ylkY=;
        b=rWkTFvqs7MCFdNX1Ov/4AEueG11h0PTT10mj/x4xXRHoyKmLX+Go+qCwa78mdtZ92S
         21L3Ybw7avC7xwPTkA+vjM5wEwn+ZelYcHlo9OOlD8KGQIwsMltiV7ggg6OItQ2bNg1T
         BOpW2dZWJ4C3FTbBov32q2R1UNCpLNNwVr+9w+l1QsY2BeNVKPdQxSUWUqVo+xDDt7N1
         rvGAuuDGT0RfNzJ6SJU74z/TUAWKH6i1vvRmptsd0ihWZ1OUfODewhXkxME7/rk1eXg/
         KjWh3seamRaAO6iFVxBCLrT96EoI5RPdbwqXxbWk6TfjkDWxE8RlUwZchj7m+D4gmHvP
         PIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Jkjqxej/y2JcP9NMnzzVbe7sdXk6we2prVXda1ylkY=;
        b=WDXZNIas7V27bR+uU+uKlL/ps7fDVfZStoD2fmGzOpWkbMIsJ/MQn1T583powditZP
         GLXWANaUkeLq8fiCXxeyRAgPBotnigF7q5uknctNrd4u7bWQgJf7EecxMBwXYb7E62Y/
         xQjazrAmtb8z4E/MPQP74KslOa9a7RsmlZDfWb7uUMttXrfxVaD/5W0kP+dTDCkzkwjc
         q/mG0KO8LMuctO0FppRyRhkDB8wi62HN0FCTAd8ZCD+m7nKuczpywMfl3P/JPn3ENV2I
         05KmwPGvwKGm55EDapjVShW6nv92uvhFBiGAbXwZZsuC6qyvLB5qctcIz7tw/a2Jy0qd
         nAIQ==
X-Gm-Message-State: AOAM530ylyG4U2gsp3ZMd1qy2OvfTA2u8mscnSNjAVpGbpFd/JmbZ399
        b0ZCrK7+nWUBBSx3M08VbOk5n/ks
X-Google-Smtp-Source: ABdhPJw6aU2rEDCyVIk4J/4v8Rf4ZwH02pdOOxfJipNx6W6tt0vEHyAVO/i7TIF/ZHhqOLcgPYwsAw==
X-Received: by 2002:a17:906:d187:: with SMTP id c7mr22271872ejz.196.1597068037973;
        Mon, 10 Aug 2020 07:00:37 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id dr21sm8762514ejc.112.2020.08.10.07.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:00:36 -0700 (PDT)
Date:   Mon, 10 Aug 2020 16:00:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        yuehaibing@huawei.com, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: tegra-xudc: Avoid GFP_ATOMIC where it is
 not needed
Message-ID: <20200810140035.GA808811@ulmo>
References: <20200809072948.743269-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20200809072948.743269-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 09, 2020 at 09:29:48AM +0200, Christophe JAILLET wrote:
> There is no need to use GFP_ATOMIC here. It is a probe function, no
> spinlock is taken.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me. I can't think of any reason why this would have to be
an atomic allocation. Nagarjuna, please shout if this is really needed,
otherwise:

Acked-by: Thierry Reding <treding@nvidia.com>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8xUvcACgkQ3SOs138+
s6F9rw/+PeuqljJiA32vQ8TM7tR5BDd66QmCNhEsxxi8d8jhOXoun3IBvCmN4640
xy5z+K7q4m36vAZ62TpE7PGzuIRdYINZfPFryH1746ZJ5oIBYPvVIgnB9PL1Zxrb
SPAmxYAWic9t9zxgRUKYyX2vA2MZ6usvF1VoQ5/3QrJDU9EWBAT3QLCOQG4xkHaJ
66pkAKvNU807JFHz6DnFwJJO+OO3kqcmiZkvrrblDARIf4FiMXo+V1rn4TSBf+aj
vGI6H2FwBx7ye/sTKUutk0UayG3yyh12tZ51rPibwOPzmU/nfQPVD2Pg66Og5H5A
9UpScutoVDK4mEzriaZIVhY6qIfwuiYB0EQlVF3wQJaOC5tihmt+BJiLj5C568oR
HS8Qtq3i0IDf8jao36zTItstFn94UdgkmSI/Tib9XasfQqdw1oUo1huOCC2734bj
osFeqlVWoqOz9fL7T26owy29Rqe/X/4aMkch/8ngs7bqWC/+yU/GsXCo6pjw/byz
PH9BipZhJAKfpkdPTstA9Ghmt96eWIG7BkKuGj1bvP+xk57DD8JhATVURKr9QnJV
VUVI5sAnX3YLmwZ2EQoZ8K9hoDg6yuxkzVsXfMy5Pf2Z5mU9EbTOVEm1d5Atq68v
JKX6VIpWehZ9PK73SDRAP175Ll77CAu4y7NTNrcloNbpJq65OyY=
=6BAu
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
