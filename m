Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F507C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9DA20758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKomY94B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgETLYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETLYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:24:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D11C061A0E;
        Wed, 20 May 2020 04:24:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so3381419ejd.0;
        Wed, 20 May 2020 04:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rM6TuXzAfG+Cg1PeXrhjsnMeCds8hzCLFKNqnazCe1o=;
        b=rKomY94B3lyOtRSFb4PBs6G9lWDzlV7Pr55EMkHkmhJ+S6ZFBQEGZcgkbns/S8ayYM
         3WN5IYivoUhkBHTUM39A3jzciphtcJZPKMO4QoqWXFydA7CR2UnzeU4sFepiRFibWqSs
         GyMukzaJb0O8ApHkOD7aCVCb2cim2PnqzS92lfaCRqJQu3CM1OgSNlF0M2In7IPtzHQW
         3CRZ5afKX04glhKoa9T+TWzh3yMOk8sjmFXVtFr5gbPXFaDEm3wZXkDQlvi3mxxEulSc
         AzJye4IS6rC3ZPWGxsbJHMFWkKpZys4WvUFvmgXwCnw/A6bMwoiXf8/mJJ2ueVEuXsPb
         Yslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rM6TuXzAfG+Cg1PeXrhjsnMeCds8hzCLFKNqnazCe1o=;
        b=hiK89ti0GnEnQSruqezmE7xyGWXJHxzdZYuFiOe4xcF1DUnLtkzDVcKnWFOvWXmS5l
         3Tabo0PvN+l2jS7R2EJATyVXYK4TwG+/WWEihJMUV/O3m5bPwpaSR+KGfzFXJMHnxPkV
         ILSk4eoGf6ITuo0nTmSxq6Scs7bR8Z5xHvvfvDGNy9W1lrLa7nPFWE8cipaSrKAJtWGp
         G50krIGiIGpu57epQZK0spdGRodltj0MO/RSb00t9nbqSgZJMmVks5+L9yCE2WCduUgj
         d1XC11V26jsU92hzVdXx9z6DsOUcnrJgyfks6A13ZfKg3Vx6l34crmaXzGtaWrh8GL4n
         BV2A==
X-Gm-Message-State: AOAM5321ajsy+bu10OF/C/wf/ExCbIxrlVZr+Bia8EJ/ThLLmivz3zJB
        5WtNAilcDmSgXiiRowNgeK8=
X-Google-Smtp-Source: ABdhPJw5WrhAq1CxpQ+C3vJ7bKyvmoGcaPX59iGGanIN0OAbpabxLUUBjtZNMcV34PqQByDS0PPvBg==
X-Received: by 2002:a17:907:aae:: with SMTP id bz14mr3119837ejc.521.1589973891012;
        Wed, 20 May 2020 04:24:51 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id h5sm1733495ejg.124.2020.05.20.04.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:24:48 -0700 (PDT)
Date:   Wed, 20 May 2020 13:24:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh+dt@kernel.org, jonathanh@nvidia.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] arm64: tegra: Fix flag for 64-bit resources in
 'ranges' property
Message-ID: <20200520112447.GC2141681@ulmo>
References: <20200513191627.8533-1-vidyas@nvidia.com>
 <20200514135437.29814-1-vidyas@nvidia.com>
 <20200518135006.GB31554@e121166-lin.cambridge.arm.com>
 <e64ccace-d2b9-0e03-db3f-e65ed6f56230@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <e64ccace-d2b9-0e03-db3f-e65ed6f56230@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 07:52:24PM +0530, Vidya Sagar wrote:
> Thanks Lorenzo.
> I've moved linux-pci to BCC and included
> devicetree and linux-tegra mailing lists to CC.
>=20
> Rob, Could you please review this patch?

I don't think there's any need for Rob to review this. It's a simple
bugfix and I've applied it for v5.8.

Thanks,
Thierry

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7FE38ACgkQ3SOs138+
s6HPDhAAmLcGCglJvHOKAlrfnKHcEc9ouq1S0D072FzCtpybboX8Pf89sG2s0ME0
2NTcwWNTwTLFUcGghwzc/AW3fsofQUilwio37IwgFzyHxG1tTnJ5jN86o0niGAlu
Qq/oNYtnkRNIJ5N4/+2k5Z6Vhek3XcMwX77WNO/84FcT9hwvE6yaT8/5GbQiCA95
x8Jd2b+hYqfYV6k6qP2tm2oHWlE/VZbwZzMA6Mhgj6APecsKA0tMEwDFcbuQCdsK
48EBqcaQGsiAvDvWWVdT7tetV+U6EPSEZDSXPflTV434mKkXHPfXhIS8G+nGRcWz
0eekGbiuHwEH3sWRLW9Cx3bs4XYEGAvOwtpJuJc3GIKFWveTeh1XG0WXu0k1h2HH
krNJ6NdjZcLQuqbx6Q8M37aD6UT9WsrYfi2LlQB2kUFbyMmaXM7oHdLjXmW75FZR
kXD5cWKfr5CQp8nJX3WadKEwt3nCDUWE8RnV9rYxc4NqnVfVy/fSDtU+RtxSTH5s
ZqAyqQKGWASjNEpYzyOuNfGh0IfTDvK+PH7izjcOp5jczFIe9CQVhDF6A7sRz6Tq
R6+qfzdClObL/MIvGJlE0KRsmGrka7HIv0mBkmkX/UflZ7rIWKpvOO2JS89v1ZpU
YQcDpForQXpkaHS9szRneb0MNgYmXP95ytItGP8eGvYzIys+rAA=
=YugZ
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
