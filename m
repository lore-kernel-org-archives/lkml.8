Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84913C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D40D207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCYfE678"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgGPNe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgGPNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:34:57 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C46C061755;
        Thu, 16 Jul 2020 06:34:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id by13so4756468edb.11;
        Thu, 16 Jul 2020 06:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QmxJzAqj8acGvVOZn8jwBv3VA4GKb9FdYZOWeVpHqgY=;
        b=qCYfE678wmXVOSh7y3NoCzQ2arV7maAlNilVxwIOjNkaW/KZz27JBGkxz5KYAjtyti
         yZ+3+3MYjQSYlk+PIR3PUpzpZ6zguoyTGDXZVWJsoWxW7OZ3G35U6TQeMW2NeFteiQWl
         yJ30pS86Y4mGxUW8eMRJ9Wj26dDLY5pcBuz6GkQ6M4syuDJvtL7h2sbOB0aVoGdYxSmb
         QdhceUSO1r4AMRh8Og08BXpL/Df1N5Xus/w5tsdAjF2pE/2m1xCgZF+GqBazU2MrR3iA
         Hj2wiFkCqtNimwizzyy1v4xQkjRBxDPmd3XPrnN9AfqclTCahGAm2AVPFhd15Ah3UAxa
         6g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QmxJzAqj8acGvVOZn8jwBv3VA4GKb9FdYZOWeVpHqgY=;
        b=jq4iwsYGufe1fCgn2N3lMoJOeNKGedp3edW2gUV/axazIVRx4aN9hIN+GlXg8JACQ+
         i7897wGUr2USXhE/+MgUle2ux9CgTs1CE1P1X+ss8Atfhhtm2qvV39291lm3aIM7yV8+
         MGUtZjkpaTLSYPE2AcAuglSiyJgu2l9+eD06KY/YsQ0uDnkpN3ERzWWSoZBBADIXbxwt
         1zB383ewhcSA/SjofY0QjUdHTD/WacndNrUdcptCYpbUJdmwyNaeFcSHffQayt/bKFyr
         vzVJdt6H0cx4xUVSnnGgucFepoJJ/fDl27hxKZNshcO2BJKA759h1J4TFePaiRNA13x9
         Mykw==
X-Gm-Message-State: AOAM533iDXdVq6kbGAwKO5qG0EZCC06jst/CjL0inH/VANk/iYwpEX/1
        4xJPdhX4TQTaXjQbWe4xmdw=
X-Google-Smtp-Source: ABdhPJw0rCFRJeytOYppBCsq/TAXQWqyMPzMyq8a2a4DDMh36NJT34ibY9iByeVFo2LJpEuJ9ecCEw==
X-Received: by 2002:aa7:cdc2:: with SMTP id h2mr4669366edw.274.1594906495731;
        Thu, 16 Jul 2020 06:34:55 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id z5sm5031303ejw.114.2020.07.16.06.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:34:51 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:34:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] gpu: host1x: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200716133450.GJ535268@ulmo>
References: <20200716090323.13274-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <20200716090323.13274-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 05:03:23PM +0800, Qinglang Miao wrote:
> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>=20
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>  drivers/gpu/host1x/debug.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)

This doesn't apply. Can you please resend, based on something like
linux-next?

Thanks,
Thierry

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8QV3kACgkQ3SOs138+
s6GieRAAjSgN0wLDgrWyzyjLy54sFADuaoAruNpwMPVnPG89QRmsEboAxzzDdZDD
/zlTd/PJVCZVKWbIlLkP7Rna+jyUuhamF/BgQujzjbSYk76Gk1KCuhoZw86z8KGG
Fh23wZ+zX1RP+URwJatUvhZUKKEVaQl8ldHWBQG32bChAJLf2EhOqrIsMA0v0FE7
CQneC38MD9kT3m/LqV2yWyvGAP0Xy8/n0hqLSyZpPBvGLpZ/D4doXZb1Xs1PTQIp
kMi+Ia4RKh4VHRxVTDovG9v/3aBY4jX8SqFqZBUM9CMJynezT4+iZtHSx7xxw7Ir
9a1BO0r/xAMcgq5m4N8RTE5Q07kOCf/Hi4qTP5MQu1E3jYitOUB0AAuyvwFYa074
NBx0kOJmJq/rL03WZ6RM/euMCQCDwh2e9zJfiXu2eLA8R73bW+kClRv4u7RstsKc
rwQn3BjuJWY6Y183D6ZnAN7IRwZL/vxFoWvK5LhfnDTbNtHWGmZMvf3Q6FRk9U1r
jUdSy8Ptc5ozFt2IGWzTePsYp6BCwRMQ0Ja6CpMiw4hMgRJDSHmk5woB8heUY6LK
O8GbqeQ3vkz96MLjtoUxsdsPEz/Ebkh7GQXOzrQ9QyN+/jAgvE5QfGicXK+HbGrO
TcTST7suEXl4F+LubMElfG7k87ZvgRTPYaKNBo3tTOKhaX8K9dM=
=3yVO
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
