Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB362C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938A520857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Pdh1ABmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDUKAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:00:38 -0400
Received: from mout.web.de ([217.72.192.78]:57985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUKA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587463214;
        bh=j3SZwNEHSqu2cbxR5ko6PkLrb6LJcz2rET5qZgSrXoo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Pdh1ABmN13DL/NFY0Udx5t5Ejyri28GzsGnJ5eP8smPpIogcifxiILS+7IhWlJyTs
         MTa7WLIWrhK7olISrZdsUrfE2XKvbQisXMKk9L3McXgdulFT48g7RjPsapF/nIqhgT
         Ph+d3NdGJXfBBlBIHm9gj1GT5YA0v+W4G3DnkzYo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.91.59]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYNrh-1jn5fr2Pfl-00V5GH; Tue, 21
 Apr 2020 12:00:14 +0200
Subject: Re: [V3] amdgpu: remove unnecessary condition check
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        =?UTF-8?Q?Felix_K=c3=bchling?= <Felix.Kuehling@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, opensource.kernel@vivo.com,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
References: <AIsA-wCZCFCxiq0WKb3WjKr*.3.1587458683834.Hmail.bernard@vivo.com>
 <ccd14dee-f275-5de4-b5c1-4f359d155288@amd.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <aa0a34ce-714f-a637-d1a8-54de94a09e75@web.de>
Date:   Tue, 21 Apr 2020 12:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ccd14dee-f275-5de4-b5c1-4f359d155288@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pk/aytSaSu7CRTb7AZCjmXG2USN5K3WKY69mNifyeD28BWJwfdQ
 5VmoPgJ9gC7OphwTRVvtK/U/o8NUxcA2d2E5qw64m+E32MHxKecKPRFMDAthmKt8AMJX3ps
 697iWwCIMDSRFxpDITUOxKaN7g6N9ZVGiT28OgR2vuwwcREs5DYt5NEGG7QbuGnJnd8kU/3
 cKJotNNqskj/rWwkawKBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPwsHXYQWG0=:ogabPJ9yTcpW281r9UWgVS
 Iwmr6mXIfaCahwEKocticVKc+q92MgdbsVjvhSK0GjdA8sTsvTqULhI+BVYSADV3kEuxRM5lk
 oT1WBLGD46WoagDmyaLige9C+1dO3YAfM28yQt8+wHD6kd9CxBrrQJb9PYubPgxHy2JIoIM82
 Hzjxul8NCTiqJD1hxpoJhiOqqmSOPsSro9BAfYEz/HAJr3i1TP90uXJ3yZ1GRYH8EkYdWzOqJ
 mLdgm3RwzSdtQSVhchNdrZknTZEuvyeBlcs7znAmxAexPY/LisIjt3rVxpWcKZp0YvcvW7vGm
 oPfsZOsMqsQpZ0XA/vxn1s4fYD0ylgeHBcEK+fh3iYwU0eUO6ZYLBXyObSPjn5MdPgUvQL77H
 oM7C+0l0bM75QBjPKjzwBeSQ8NfjXa/ePjqfae8bwnL7F5H5cOF70z+YL+tRp16w4zNqlAoUq
 st7UDMx9v2nNGFE/fWUTtGjY2oHDbT6L4LApq7CVCCkamoc+/S/Rg7Yh/jloMlFZ5VV9O5UlF
 m5bI5g8SjqtRDjtP4lD+s45OjgE4Ec5liRkjSPzcRH49fvsinxM9Hwc6LSRm+odvAerxL/ZzD
 95icMAVqPoDjoHtnrsTvP5CL42iYgVYeHQYwTSSJu4E1+J8RiOnUygl9969ufxzmJsDk1m6ti
 4nTmdJ3oOWZInDyOv9tNZq/3D44ruDg0jVYF/CNfxpAnLCDg4rs+VgxS7vXKSwoVJBd2KENHS
 q9M798DtDwlb0HPqoGV+hG/bDOXtfWRBGwERQs3zt1ZBD7urBd3TwI5wRgIKquTZClo+bfC65
 Dq3f884RnOcWMQ5Kyp0jZfCek7RhgO1nCrYHOLVOAaqZfDWzj4g7mfI9VtpJyituLPP3hB2sa
 OInrD7tvTUVDKw6VHaINJZiI39hyBYZ8xwnjSmep120aRw6Z9hfcU/NPuh9Lh6js/str0ERpC
 oDYhwg4khwjsOkwMr/ZskNu+m8/anJTq64aYoOKTdhKb29T5Kbncw2czWgpz2+chWLom8ZaC/
 KhshE2uMlAR28HPwvC91J8J+NY8X57Oqu3/ksfokk2P4pMkoSYtxSebBcglAQI8GUNv5cfiQp
 I0wnmnXEIx7eaNyjbLrOi7pnJvOUSZ9/jDtqumOIIMPdeCAkQ8UoFyTe9lsKF+f9brZmCfj23
 1891BVGu13JMjYcQUs3tZSXEokroz6215yHiEYKRAl9pbVN0tFwXR0l1mG0hRV86UXCtGXXTI
 JMCI60+EKjtQVNSrW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> But i have to say there are so many code not follow the kernel code-sty=
le in amdgpu module.
>> And also the ./scripts/checkpatch.pl did not throw any warning or error=
.
>
> That is unfortunately true, yes. But we try to push new code through the=
 usual code review and improve things as we go.
>
> On the other hand patches just to fix the coding style are usually seen =
as an unnecessary interruption and just a waste of time.

Would you become interested in adjusting deviations from known programming=
 guidelines
in an automatic way with the help of corresponding advanced development to=
ols?

Regards,
Markus
