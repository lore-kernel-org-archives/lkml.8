Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6132BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4BA2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="R6IiSv/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCEKTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:19:51 -0500
Received: from mout.web.de ([217.72.192.78]:48089 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgCEKTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583403552;
        bh=lJOB1aL2yujJXbCPVYtxOIud1lD5R8oZYw6lYmIfD/U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R6IiSv/X/CNA8Lat1J19v594k0jTkI94dUo0hdazGSKbX/xLg97aov8D+bjjnCxK0
         X+4+qiJRZIOBLN07rwp8NSY0VR+Pyr3yg600fJ/3WkgsaMZnOWzCm5YAGJKVpvLIFQ
         6lKV/udIpI19Wv3yAdsSY4X3BbUmQhDbGd2oegz0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaCbS-1jdxHC1G62-00m3k7; Thu, 05
 Mar 2020 11:19:12 +0100
Subject: Re: [PATCH v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <967d6fee-e0cd-c53f-c1f6-b367a979762c@web.de>
Date:   Thu, 5 Mar 2020 11:19:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158339066140.26602.7533299987467005089.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xWBI6zTTz8hNTjcNVKd7ehcNlQ/ItTYRXwHWz8eaiaMEovd4k+8
 M6xHc5cxEa+vtWlD9AEenMzwQTeJlZ8gpwkcKmbhfFTDl69VxfEI+tYJKpguZpgVQw+86sf
 9zozuORH+2pLSWEjGCFOKiWOMJpOvOmZXn31sqHZKH5VvD1j1EXjEdCTqYTpVVKTAv8K32V
 Lj4wBGnv4qsCywGHbheFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yTzcAZIslp4=:S2nNct0Gk7wv8vFYPQiKdM
 SEmYJ+Ua71IOYxb0J5QgyhiPumtQYgpR++yqGIbAX6XtdAgT2MflJTLtf6GYA4TDRRd+zON83
 +j8TNGi+Pat2XVVpla2SDvdE6dvL8SMDgFk087oc2Nf3FkTxvKoXojkJbcHWPfXktf3+CDsap
 S+aBP342CrBe202ee4uCntmgDHmSDuX5ejjBBjQKeP3lWrcrfQwiT9gStaYglh0ffhdWNBF+U
 FS/a26N3xnbUxqaBLZpgYXgQ7qd37/FcWeSxfdzp6Vd55LTANDv7dEXQYwu54gQwmLiG5m3iz
 WsWyRJ1LNTRRhqUJnTLKhCC+7Ox+xAScYKE6XvnV4hzFQNkCsf/1slJ6NKF7SwpLTWew08Tun
 hjdl8F+wkKJHFG2FavLzVt/ipMdHcgXzYBGNMoV6jDNnDXTuPDSJoE7I1vOajY7E9nYh32SOh
 O0IvMaZiekuXGAPBEW1q+pncG8+gEzUBOevYaHOK4LmnuXt1OCDsYCftOLy+fZnN+CjMyzp5W
 Q8ckVgXt4KpaSayR7SrpoRDbGuSZ8Dq9IPQ7r7/DUxFA5subhx31XkOtcFA5cO95uWzXjFxj+
 nPs4E+/kJzXB7FMZmFCkLw7n3f+mgdc/4P5997xm/xRZqm1gbzU0gz1ijOpXooQx+36mbuVVe
 x5k+9f/G9gfJchLQVPgdEt2RXt3yIATOgOUhQ6L+vzGX0EdImsb1xZI8kTaofkOmyKH/6403d
 cVe1gpE7GlgF0UI0cA+CaRzQx2tLJs+jBYBlLbHOB1IicLSuCY5a27v4P1DGNHIXiyI324hA/
 LgiwSrSWDEA1HHNdvVJitFs7ybLT06ENxw5Pbw2gjJ0RqMtdd7UB3u9gGr1Qbkb/gAJ1Z4qBD
 OKWkR9HnbBzo6n6nSqdpaCuej/qYCIiwW9D8uPqgeJ3rPLQDtg+m71oeEj1a4yX5POO0NZ38w
 N1S8fr40y50JvOD65Fubgln18ZZi+ui71LozuXQqriiLI7+jWGdLgSPkRnQ/oV1v6moYD+381
 7QNHPzrz/1/hfS2ZE3oHmGxCl2Q+ibSm+A4vm8wpufkV9r+2me67Q7+zi3UB3pRy5umArYQPj
 SvyOHsudSHlMy0n4IbvImkNa6r2QnLji0hYifrVLmcyFxCJ+uqcZLn9h5rYy6xLC3R9qmEtjF
 keph37I+bPFZAcXWx1T0gzXSaNopggiNXp8qbO7xu058oLNkWMiNCMt/65cIW1fytMxzZPLLZ
 PRPOBhL4a3WB6WgP4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/Documentation/admin-guide/bootconfig.rst
=E2=80=A6
>  =E2=80=A6 word must contain only alphabets, numbers, =E2=80=A6

Would the wording =E2=80=9C=E2=80=A6 alphanumeric characters =E2=80=A6=E2=
=80=9D be nicer?

Regards,
Markus
