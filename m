Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABD8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEF3246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SnZZ+hJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCBIYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:24:25 -0500
Received: from mout.web.de ([212.227.17.12]:41785 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgCBIYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583137418;
        bh=oOwZ5yNHNAxH4ADQa6ZEfz/xm5NK1m0TwLEgpPwX9jM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SnZZ+hJq+gJJIbCTFQUopz2NfIETURMzSRHoTC8Uf2hyv2TJIJnTB0iGjFoXEDBLD
         3UQlx8lP//seFRTl0oBx8LfEJ+OQzsi8IIzjbWuIKW7JeRlQ8RBXEan3aOazV9o0Ls
         Bws75PCh2MvS2HbIsCDcm9j1bUwp9ip2tqwjYg9E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.91.182]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAvCS-1jGQ8c1ugW-00A1pt; Mon, 02
 Mar 2020 09:23:38 +0100
Subject: Re: [v2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
 <158287862131.18632.11822701514141299400.stgit@devnote2>
 <972ba3a8-9dd7-e043-d2f0-8fa8620686f7@infradead.org>
 <20200302155247.93558d4865a8bcd160ef39e5@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5db1431a-7854-6837-4922-214c094e03aa@web.de>
Date:   Mon, 2 Mar 2020 09:23:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302155247.93558d4865a8bcd160ef39e5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N4P7BCyjZtkHyOWM5mUveUfESBrn1sDMVnXFHjwwTnUZ7qhJ9a3
 VNUA+B5BcnzxCFUu4U8Dv7b3BGr+rkiizJD2aI9OwJp3IhWQb3f9mk+MTYhAFahThYmN8PZ
 UjWFN6iEg9yHY71p8GDKABv0mNvBCnekWbJbiLfJtDjYhM/V5B4pCsHLmwJxWrGj+i6Xl8J
 A1ApD4/8tcESmq546ujyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sg/GReKFBAU=:KKlUE3s3Tzk5zNbPTzRpyh
 +N+E8YRwKtyDmJGyDjpKnn3GaRv/lQ+HyLy0pPqwAqMDUolkq9vXZpsdOMpz2zzO5s/rh+UmY
 Oh5iTsq2Z+ICjwAzMj4MlGjPB2XrNLbNO3NvVGqQhVVdcy7zEAXEATZAa70Rku1REge26S8mn
 +0mHdo5ZT8N1paZbVlOJ1z2qJcBOvx76vnPCXbdbfolFcynytSWdCqtR3TjDtKBwB5wKvZq+G
 Fuc3WhWsbDtA557A/EHL1MJEIuR9dTJ13Gg2OjVZr/l96aR/DJ1BbgDmLKEBDJKOfM7mtuhQ/
 bVNMj+4C828UbZjrZxSl5CW6P/s2ynqZLuc8H7mHTx+riQK1hmE9a98UBtvDYp0ySP5t7KKav
 7dDjchnvmcw+GnkpxayM3mz6smyORPyAgyapDqSs5yAbVpcXCev251DRlyVtoUktbUNGpUJGd
 xfht2D/xvkTpxEwMctjQUYuWRSRkZ2v7WkjZLmB6GfdLF8hLWv/cWax7/mF9GOnQ7YXSX8LEX
 RFF41NIJbYXz8Z1EImbDiXVMR725XloFLPu9J78GuElWmd6P5XddWzuQc2olPWGLvIoq9a7II
 gzn3JZ9eRtcSSKIm0vJGNmtaNvHZcVUpWclGtxTkkJ0vTyC9dmTULesYv146vEx2rccnihCVd
 zs7xQFbtQlUuGabzfO3AgSpF+o9RYm0/sFYsYUJuHO7Xka4PEkfGXoLeTV7CBYfEPJ0ne2QAj
 lHOBT+JCxTa9QxSWdCIV4rEMcEfasCgRY3ZS7WSaeuv6vjnQaPzvVCumNv57mxWhN3N1y2hZp
 0JPdzXaeHOEYd0sy1DYwRQJYuFft9hczLJkRbr2fDuo8+63EjuvvoQG2lIi9n5dPkJV2pEo1E
 xVZGesfla5GCpf5W/zqIsdoIJ3NPTfAk66YUZr6bTPr12ry1bTy4zbhTB7SmPI7PT3kUobw20
 gQUWxcR1oEVlvqEhglyRAvpdsWnJisqm+Zt2w1KINqxDAiCcPKWiX4jqqtJ/qx3pPHAWkJs9w
 Yg4WLTAOZUbyVK16eVTIFNIZ9pTTC9+g6VRBZTKi52twhss1vusuEehN427z7AoGCnO0ws6Ol
 FO/wDTFtt0CHX32GUsEfWKm2eitsoVQgSpHSrHRQuzQD+rOOQGWYF6dASqKvATl/xqk7GpC+s
 2SW0zzbQpL2weV+vIE58euTU6oVtGWcu8ceYTf+xKUxbREv7SyKMV9cgpIxobJINNIiuh1QU9
 uoqSuc+n7z5zm/KCz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, I got it. The last sentence is confusing. How about below?
>
> "If you want to use the boot-time tracer, you need to use the boot confi=
guration."

Can any tracing parameters be specified in the boot command line already?

How many settings will fit into the discussed places?

Regards,
Markus
