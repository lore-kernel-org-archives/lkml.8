Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B80C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF5320675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcYhIWBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgENUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgENUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:22:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D83C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:22:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s1so222478qkf.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version;
        bh=8SQfuyaOZCvYd3/hde0Ei4fxfgVmOiAcZ6vRF2d2JVE=;
        b=gcYhIWBaR1AtQHmn73GDdqf4cmf06P2RorZZ+lJaHkQvztImOUbI1C3E6Puqu6QxbK
         7baCEyHpUEcrWmU5ArIf11t0b/ueGsaNMpb5vlGMReUostX5qqUCVJ2p2Ym+5tG4JPiZ
         Ilqp+aTsG/+xF+K0yIo7W+tOES2qnQkw8QXyjUEhcp2cu5FxG8ayztFUwlVNcz4ChylJ
         sAElY2aLOQN06fHcMhOOZ1lI39o85P0hn8zI71rvhBmlOHcEMNl/UFEOIJ4ykPsa0+DW
         2OAoNetAOp6DtBDRwyWBSSbstkYEkkV+Yd2b7xMpOtLMqwLZfBpwoL7X97D+Hkziouwy
         vV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version;
        bh=8SQfuyaOZCvYd3/hde0Ei4fxfgVmOiAcZ6vRF2d2JVE=;
        b=M5UJ7kLRytgjOtzE8/UK0i7ryJwzOo5pg1DoqxDXeAOonbqmaIRkswfkQQDuqzfnvW
         TAq2f8FY2czrLDp+7xMd847NLxECYqMalQ7SxVAzemskYC4l5tag75Jp5SnUbzOxZhJf
         rFbJRmFMFsPB4Rqdcyz2+ATJcLgQTSnytld2xCuhYz5k0SXkNQgrApN+kDf17VvaLWw9
         i1Y0OKuP/sprtFoFCsmvn2ysS6/zcxeBVG6FKCt839ScOeu0584NtPRedz4s/uNvRlZk
         y/alK+9KdqMwHQDeul5lnrvCOpN2ohLJHlZeeKEQyXdoyaEDxCwDC6/8bpx87LKHO9wk
         xESA==
X-Gm-Message-State: AOAM532yGwSvWtdB176AoXGjawiQPwZYdYJMM1nhkE8CBhp7YsVLr4Sj
        /7P6EGd3S3Mxet/OFNgyt6w=
X-Google-Smtp-Source: ABdhPJzU+tYb9m69rF7oG6STN0UmKcUTKGXF3ue8PYs+Pz4IZ+fPFF6AbRmFYnY6ysKWucTlMen1vg==
X-Received: by 2002:a37:4b4f:: with SMTP id y76mr145366qka.292.1589487762952;
        Thu, 14 May 2020 13:22:42 -0700 (PDT)
Received: from LeoBras (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id g66sm3348344qkb.122.2020.05.14.13.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:22:41 -0700 (PDT)
Message-ID: <251d086383fc5a94a5f9dc7c348339413f705458.camel@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/rtas: Implement reentrant rtas call
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Date:   Thu, 14 May 2020 17:22:26 -0300
In-Reply-To: <875zcy2v8o.fsf@linux.ibm.com>
References: <20200408223901.760733-1-leonardo@linux.ibm.com>
         <87ftdb87jf.fsf@linux.ibm.com>
         <ba97d52df60ac9c4a4afc2c03121a8c263aa5a15.camel@linux.ibm.com>
         <875zcy2v8o.fsf@linux.ibm.com>
Organization: IBM
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EPXKkKrztE/RJuZN2zTS"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EPXKkKrztE/RJuZN2zTS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-05-14 at 14:04 -0500, Nathan Lynch wrote:
> I checked with partition firmware development and these calls can be
> used concurrently with arbitrary other RTAS calls, which confirms your
> interpretation. Thanks for bearing with me.

I was not aware of how I could get this information.=20
It was of great help!

Thank you for your contribution!

--=-EPXKkKrztE/RJuZN2zTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJIBAABCAAyFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl69qIIUHGxlb2JyYXMu
Y0BnbWFpbC5jb20ACgkQlQYWtz9SttT40g//RNI2FQvkeWJdspK33RxnVszosgPu
Lk03U8D3Ca/7opCRu9imULxme2ZKN9fhdMuDTEVTZ/C6ePnvjZzW7nTsR+a9PPvf
poRp1ax1tO9MUKpvgTYp2B90juREk/QXG6zlkRqX8DXtpYvTUP8V5eaTu2caDux0
nUaidimSlHC91rBNy8RIcDUbYK528eqSy0NGDO1Ne6vnx8+Nldia8m7wEZ1phfbi
+2HkT6pPBLdBNz99u5tyoRMwst/oYpXyZxn76dIN1YfDWMr1MvykORh2L1U00Bi1
F+mc37I59b7qjMoaPaLIdUe0xHHld3LWnTy8QzAl3Bc38HU1tr7ArZbtqKEk13ra
za+NI3BUFp/kWCjnc3gS/YFIEvHQFSytI1b9MGVtfek6a5VaGMzndbqD+Jq7Oxb3
Lajb28yhcsWClaNt/9Ahh5cV2wEQFq/+BMpzIt0xHu1XOsrKzF8IgK5VZgJynnew
Z5anm6d1v1sv8A1S4morQgeNTVHWt5UPGkUuNLHTst8lCw/ZxZ3f5C1vSAC/+JD/
qFNShRviePOrW2Lhcw4PJ/6MHIVFhBkI/PA1FvDBO6ikB+9dyheim4dt6Khqa7CE
tWmEdPtQvUGahm9pitZaSrDtDcEhh6hKgjfQ2oYgUuy4zWpWj3khldRfOZ4Yj5nw
mERoUCtRtutfCT4=
=FQdj
-----END PGP SIGNATURE-----

--=-EPXKkKrztE/RJuZN2zTS--

