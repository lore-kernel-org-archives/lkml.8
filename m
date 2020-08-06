Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6C0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B2C2250E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYE8nyEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHFByp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHFByn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:54:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CAEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 18:54:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 2so5827034pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5H0OWR7yCbAHwEy7+8p7gn2MJ5SCAkA4Ter08Q/R3C8=;
        b=AYE8nyEw+B0iljRnVp8UD4uNHGy16TQt33EHi7WtysCIwK30dUxwCF59kl6N9Qy+sl
         qvjdSjHZPDogrm6GG2dwzLJ2uL7ya875GQ83IBIdoB+SAjMLxtJ2XUJt0oRbWP1O+bte
         A4b/uwa7AJmnNHO8CBAE6IagT3cEhEEfpE6bbsqIfQqF7YQeV6Ep2l7SeLA11NwdgBHN
         BAkBkZiUzJZyFu7q07WL23HmYLOq+eF1DvbKhPUFxdZKPqO7yJynadbtRDwHKkai2UD3
         aGwQ6FGmk+Y4Mg/CfkxxzYQ6gvT63n/ypD3J1YyTVWHOSXrk+TrtyZEbpmEeaLloEDvy
         iWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5H0OWR7yCbAHwEy7+8p7gn2MJ5SCAkA4Ter08Q/R3C8=;
        b=GiUnsMA+r+OTUybWgD+HE5Z+Z5jS1B1Qz4g7jWYR7tU5yzBWeLCM4wcCihG3R2uWeN
         fGK4Lex1kzeQQ3xb7yyqVpkB7ICDx25vwx3jIQWh7/JGk9BaDXhP1eRO0S7PJz2lyFtd
         eC925TWmeJCRo0ERrc9CoaImAB8CCK3PXzN4IHtWMc9SBS3Mk7K06nz9iMpBwsQRxz1U
         iw+Ti3embckR3dg1z1rswi6dTLehgwqOC1mQ9SjpF/Ek/KzVZiUY9+1RpcmjUiAa0o+3
         RQ+SDu/tZ5KBioRJKWwrqvwRnvdujX4gLrWLpvk1HagFnEow74BvQv7hAl4EQhckAMDU
         W/vA==
X-Gm-Message-State: AOAM533TOdPdUdidIED7E2vZhSKwlCozWEYxJAR6NZCe/gHW2C22i5kr
        T73hS/34Zuq4c9G47LE+v7k=
X-Google-Smtp-Source: ABdhPJwa0azJfgzvrQZNiYWoP0aR9irxIRYnPVcZ9J20VIXVHDcpzvAxjayGDSFMW2tIRxQZnYzNOw==
X-Received: by 2002:a17:902:7283:: with SMTP id d3mr5690831pll.233.1596678880679;
        Wed, 05 Aug 2020 18:54:40 -0700 (PDT)
Received: from Gentoo ([212.102.36.166])
        by smtp.gmail.com with ESMTPSA id k8sm4659943pje.28.2020.08.05.18.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 18:54:39 -0700 (PDT)
Date:   Thu, 6 Aug 2020 07:24:23 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     David Niklas <Hgntkwis@vfemail.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re:Use the script already there.. Is anyone else getting a bad
 signature from kernel.org's 5.8 sources+Greg's sign?
Message-ID: <20200806015423.GA13702@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        David Niklas <Hgntkwis@vfemail.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20200805205924.1f646d45@Phenom-II-x6.niklas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20200805205924.1f646d45@Phenom-II-x6.niklas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 20:59 Wed 05 Aug 2020, David Niklas wrote:
>Hello,
>I downloaded the kernel sources from kernel.org using curl, then
>opera, and finally lynx (to rule out an html parsing bug). I did the same
>with the sign and I keep getting:
>
>%  gpg2 --verify linux-5.8.tar.sign linux-5.8.tar.xz
>gpg: Signature made Mon Aug  3 00:19:13 2020 EDT
>gpg:                using RSA key 647F28654894E3BD457199BE38DBBDC86092693E
>gpg: BAD signature from "Greg Kroah-Hartman
><gregkh@linuxfoundation.org>" [unknown]
>
>I did refresh all the keys just in case.
>I believe this is important so I'm addressing this to the signer and only
>CC'ing the list.
>
>If I'm made some simple mistake, feel free to send SIG666 to my terminal.
>I did re-read the man page just in case.
>
>Thanks,
>David

You should be using this script to download and verify kernel from
kernel.org ...it there for a reason , please use it...which take away
all the manual labor ..

Here is pointer to get the script :

https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball

Thanks,
Bhaskar

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl8rYswACgkQsjqdtxFL
KRUKLQf/crhY20tYe6N6vOlBSIH/Szm53+KL6S2NfnunnrG3ug8VsVT8DzP6rHlw
dDfb2aoSde1QyayQxNb8Q0iMH8fgn2BLCCkD/va1yLhEXsVrG1WsECTMKIZxumL0
Jgd1+oefsK3z9pQVKYTdoocXQBhpvRKK20SvOQbldgxeHLFR3zxJSxqSvmxgHTKB
FCsDrr42kvleA/IUtCzeGLNVcADOzXjxPraCKFUiFmb3WystVafmR5I2zSzv5zvt
uGhrT3ReJRuPcYMERmMUq02TkXURvyNbc2RH6FLknd4JzLHCxCtN+1vmuCMWUfOv
eRDrHRyS0H1ZbBdKtsOujwhk/aPwxg==
=kDWE
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
