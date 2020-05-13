Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1100C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA54020675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOl2Zkk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgEMFYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgEMFYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:24:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0333EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:24:04 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z80so10662622qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version;
        bh=nnZJ9ytuC5Uycj8aFhU9wwgAOq8aeC8OZx9d9mFcTI0=;
        b=kOl2Zkk6RXIICXsfORx0T9kg7dAsFx7nEEsR6a4xtaZ02wAyMk/uTi9NudM2aYID6n
         n9f5OX6ba8W9fPJgCbMuZJ4UsdLns0a4Lzi9zfsIFfy8ZkTp0XpR/yyV0br9KbpUFbSL
         7zhoU1HT1BwbmLLN5X6FnxbNl/TcvMpMfrzGs8GB+JzV327nvqqSiCGZb79RwSDB3UgO
         DRgPvAQ/qVlR2GiP7aL9qSJh91Hwvp9nUkPcka7OjiMlg196cQMQ/dnMyWWCrcmYbFen
         NawHDMEXUPFLYmQdlMqjVb2OlmSIDS0y55sMPzCT3+i2IRH4Wg8c5S/La55jWgXRbCbR
         rmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version;
        bh=nnZJ9ytuC5Uycj8aFhU9wwgAOq8aeC8OZx9d9mFcTI0=;
        b=CZ+zg71Du5zXVZlH9Y2ySH6xgSxLxgc7vC+R+dylLhLUP2PChgYAJhH28nffkcyy6W
         u8tbyTgUgvma6qNb2sTNvC+z5/4NZ/82H7u7ELXKfMw8+n1cZnrgpoULUkh6VaAmwZL+
         gKzZkwXTc0g1SrpUNmtwTq0RioLAw1AigMKOcFZMvjyc1l7sGbK4IPXuuZQHl1pmIeNK
         zlLwC2z/nM5kq6msdpOSmONl/NOVtqKi66LIVI5ZkoAWdAroMJ2upfLM+9CtswXeW5z7
         sePqkTqQkkxRHSwrlpimXlVvxO7dGeEe1zK/Uy7C2bpYj6sjRyufW2TQv2C5M/KXjtVN
         JLXA==
X-Gm-Message-State: AGi0Pua+ObtdS3MZ+grSbQKaeDj8ah8JrWCm1VzUFA6/bco0+4FSEXuS
        VekOq5bdWRRxVkmdyKn+SgQ=
X-Google-Smtp-Source: APiQypJRakJjUuMP7CQXcb13k+uyoKjaD35UQXq1vc28JJoOu5g9vuqBcWzrllzpuElOOwjIOic0vQ==
X-Received: by 2002:a05:620a:1414:: with SMTP id d20mr21369118qkj.160.1589347443160;
        Tue, 12 May 2020 22:24:03 -0700 (PDT)
Received: from LeoBras (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id d9sm13315057qtj.77.2020.05.12.22.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 22:24:02 -0700 (PDT)
Message-ID: <d3dc85e3e3ecf9c25718f1390041f78942f853c9.camel@gmail.com>
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
Date:   Wed, 13 May 2020 02:23:47 -0300
In-Reply-To: <87ftdb87jf.fsf@linux.ibm.com>
References: <20200408223901.760733-1-leonardo@linux.ibm.com>
         <87ftdb87jf.fsf@linux.ibm.com>
Organization: IBM
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JtQ8M0UIKnoBiZIEQuF2"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JtQ8M0UIKnoBiZIEQuF2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

v2:=20
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200513044025.10537=
9-2-leobras.c@gmail.com/

(Series:
http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D176534)=20

--=-JtQ8M0UIKnoBiZIEQuF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJIBAABCAAyFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl67hGMUHGxlb2JyYXMu
Y0BnbWFpbC5jb20ACgkQlQYWtz9SttREexAA6aFoNm/YDldZvZA6JFHqeKwJuWzI
X/ylsDwGqNWHNGFbcAlO5QmIucGkwpZyaakMwQUSp5s5Qom4Uh/CBX8E/ruw7T8Y
JLYn/val+t+8M/jWsXnheL3Cz5sCSaGTlrrnMxo6Rs748mCB+WHs9V+Ut57Z7Y7L
iIPkErE7E/QSPSjeRWDCe5fbHxFUivr2MQV0IZ2ZOssEcevGDz0OjKk4mOJT+3wa
vh9TZ1y12Pu5JMyXAAVL3ZbbHvyzDn3N9jgPaBAPJKEONep651raqSVOcc75vyq+
c8y6unsGJeHHQyzVii3O9LpPfZ3aTLJ1eee/9oHp4YN+qm5iwYDUMr1lNvAapyXs
1bc+tj7yXEiRCwh0kJAHxGdPypCjEis3IjjOGOP4J98KABSHPYJBENN0dJp9SYnQ
kKdID3m9vmniJZDE81GwPyTrz8EGsf3U9lGy6ZAVwODgS1SABFDPBkadBDq2b4ZU
b7uX3MCu3cuGVgruIfaiPRL9s3ObQLOLW5cUUURnhk+otblGu7/yxesX2iaZHAK0
qTJ632xx098Um39RHQLGNFGd35nf3hQ1UwFkM2Gu+1MTqDU7hcptGdYo43lq2rJw
oUQ6DPKpJ9Z5Ib/3MaVrZu23e8UTChZxizonQYMPLsYfvp4xqfM3lYIcqEO//uPg
7KsrKJWaRjrdD4s=
=sxAZ
-----END PGP SIGNATURE-----

--=-JtQ8M0UIKnoBiZIEQuF2--

