Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F3AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A543A208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkYKcrsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgGaKNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 06:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732140AbgGaKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 06:13:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B95C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 03:13:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k8so8747050wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1gkrmFg0o+12Y03vP1FnEKruTlzpJFIVm0HRG9MN2V8=;
        b=YkYKcrsBgLHYHGVJ43tmH16sSa2eAcMwTqPvmgVUKZzZB5dhDmTk83CkjSRyQnQvcx
         Al2f0EH+vIgUebabdG+VWknE8juifG3ejKDWR4Epk6WCdOrC/0Zo9+s81GSoqWZEI5tp
         oX13iLnAVzlipY1QnjYaYN9CVv+nthWS4NGyePT3/VAQT+oc3ZZSMee5+UggjjSo+RYr
         Azr1FqAYGMmAXP4pG9Su7zlrIFywofbnEti+m/SUdDoe88yr4rIOAWmikPAUYJvEoY5m
         0Ac+izV0ZYJGccBUIwTMewf6ocpj+VRdEtIl70kNNwhdpZ0qENIEAOGXb+lsgiYGtwAP
         kDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gkrmFg0o+12Y03vP1FnEKruTlzpJFIVm0HRG9MN2V8=;
        b=Iob5kEimxChM94XoZ5umTqZkxZGcwD2UltOpoTxkyT7YiaL+WI01goGQ17Un2qQnP/
         ZYZo2y4e4A+io05Rg4QcIuI0dGh0xaC6U+PFfjNSd0RJM6YVJINdrtAdlDFbV5rwfya/
         HJ7j5ZlQyc3EiFu7Pjx++NBaApcIGJLA8Ey//hTa7r/iBOF1sGvRh2d/ZmesQu4Ib1BJ
         E4yPSwhbpQ8ZnTa9KgOmgJDgR4hPkY8Q+3641uXfE4MWzaARK6/rTVLv8jnTDtSS7aTC
         xDlmXTJa9tUA3F/nurHdjPAWrvOXmTZwLeGZGH1pijuY9VZ2nHSWbSZ8YOu/XmKsL2uw
         3w7w==
X-Gm-Message-State: AOAM5334xSeUd2fD+FMybHNobhk3yGq853f117IK35aToOo4E4Nevduz
        u5n/Ea18TBVdJmvEb72UoKQ=
X-Google-Smtp-Source: ABdhPJzZQKhZcWRLSBVwjBQI1G/y9nmNWX7hTZyyq6+hn+3T4WwMdqQtnsQpU0bSz6ga+mjkhHbswA==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr1518117wmb.59.1596190421325;
        Fri, 31 Jul 2020 03:13:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id p15sm12632865wrj.61.2020.07.31.03.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 03:13:40 -0700 (PDT)
Date:   Fri, 31 Jul 2020 11:13:38 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     "Pincus, Josh" <Josh.Pincus@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhabin@linux.alibaba.com" <zhabin@linux.alibaba.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Message-ID: <20200731101338.GA177875@stefanha-x1.localdomain>
References: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 08:15:12PM +0000, Pincus, Josh wrote:
> We were looking into a similar enhancement for the Virt I/O MMIO transpor=
t and came across this project.
> This enhancement would be perfect for us.
>=20
> Has there been any progress since Feb, 2020?  It looks like the effort mi=
ght have stalled?

CCing Alex Bennee. I think he recently asked the same question.

Stefan

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8j7tIACgkQnKSrs4Gr
c8hBuAf+OmPRYxvZokWgMkN08xj8gRvvsYKyjcYDdgX/rT2XKHyUAwL1nadrkyW+
OEx3K+jwC9f6Z2ICwRg08ccNCKct3Si4abzvk8Ky3HMFFh5k0Bt2RnUdTeJ3dws0
X1Vkd+RMaLdGv8Jdm4KoGDpCx1lXtjY+cVtzMt3bC2g0QUwXrs91wMTbS3RSbP1A
lBfgkUwrr3p4ZoDQooCINljLPfAGFmgQLuWOQHopMss4e+IKKkC5otjNPVgZanUs
Fvu/P+6lt3nSpsKNqCJBqsBNEqo7JbvwsMUd8dDrn47Xrwyjl6kDMITpRgr5gQAw
xJTdNfpW9eouJ0XSbZNU1nZZQu0XMw==
=KbmI
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
