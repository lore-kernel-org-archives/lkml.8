Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835F4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D12B2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588969691;
	bh=yOarqGZ6EnoTymo8WqocMUJc/ZvwqBRa/vUsSMDQx8k=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=vMWC4Y/vTDbiRa5tychEtzpu3+UhD+0bsP/J3HjfGt3blSOa8J5q9YSUgI5BE3bWt
	 e2KIq4LW9w+Pm0GFvsI7ksS5IyX5wql5DeLe3LO+So15bc4i+kiow2QtA+lH5tLlMF
	 BbNty7Tx9M9USqhzxQRuSzuFwZFAjuq4iwPODhhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgEHU2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgEHU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:28:10 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA7DC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 13:28:08 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id fb4so1260861qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yOarqGZ6EnoTymo8WqocMUJc/ZvwqBRa/vUsSMDQx8k=;
        b=OQZoCfheERUX2DtkmSqCvmJTdkZ5GnadHCDZ+KCbqY9bsa5S86FPUElvzTcUEQfeBy
         jYtXgLVHA2+iBs6X+pWwKnMIr8Bti0BzignC7Dk3fhVWmntdaXnSaXtVrxU9AuIi3493
         8d2aw6wAeePItIEMBZPZSSj+VwNUmOWKZR/ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=yOarqGZ6EnoTymo8WqocMUJc/ZvwqBRa/vUsSMDQx8k=;
        b=CVwTHw8OCSJMkVsx7tdrYBi5g1Btse5j5wqXzvTe69JPSyR9w7Heie8VUfXcfawE2x
         6P7J56UtEx2rJySLkwAZcS4dyz0ipiVHm+7nOvp2M8UA9YQzVguH9DSJFcjHXntp3Rnx
         SIeUidyjw1lZyItDmqXWGUBLGj7llSmLuxd1vITjGU30AovN7v+GghG18RamcmuCTKGJ
         v5+Lt7gHOY71M7sis/wi3b20cFSaLSckdUcXRRBwjIv/prjkB6htlje0hucnjV63gDlT
         YPsq1mQwBqX77Uo21O8Itv5QXuuKD9zeZnh0WcJt8fIPrA2lyEJpTlscFfr+VmuDt3ye
         RqtA==
X-Gm-Message-State: AGi0PuaAdUz9if5H9a6bf+wfGTOuM6tijqWE8NRgNahCZHBBWcBB5eoQ
        uwZuU0M98H0xPlbHg6yAaaVj7Q==
X-Google-Smtp-Source: APiQypKc6TNsMOecJ6omgxiAaKe1l2+kixkHfrAI/5noGGHdVzQ5EtUdd30fnGRPngi7spZX+DNZxw==
X-Received: by 2002:a05:6214:188a:: with SMTP id cx10mr4557487qvb.119.1588969687732;
        Fri, 08 May 2020 13:28:07 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id o68sm1950028qka.110.2020.05.08.13.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 13:28:06 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Fri, 08 May 2020 16:28:04 -0400
Date:   Fri, 8 May 2020 16:28:04 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     webmaster@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [sysadmin] New Wiki URLs?
Message-ID: <20200508202804.tiqcdgpamq4sbhw2@chatter.i7.local>
Mail-Followup-To: webmaster@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200428044440.kd2rf3cxa5rffewm@falbala.internal.home.lespocky.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q3wvykdlcinmtkcu"
Content-Disposition: inline
In-Reply-To: <20200428044440.kd2rf3cxa5rffewm@falbala.internal.home.lespocky.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q3wvykdlcinmtkcu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:44:40AM +0200, Alexander Dahl wrote:
> Could the webmasters of kernel.org please configure some kind of
> redirects so people don't get 404 errors when looking for docs?

If someone goes through the trouble of compiling a list of such=20
redirects, then perhaps. The previous site (wireless.kernel.org) was not=20
maintained by the Linux Foundation, so we don't have any kind of=20
definitive mapping of old URLs to new URLs.

Regards,
-K

--q3wvykdlcinmtkcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXrXA0gAKCRC2xBzjVmSZ
bIg2AQCK85jhipcysZcwpd4q6layN3GUb3iuQLwv0ELLjBjyAgD/b64rAt/TUSCN
/NKNyCTD+eGCYA+680rXiY6l1zrpBAk=
=ze7e
-----END PGP SIGNATURE-----

--q3wvykdlcinmtkcu--
