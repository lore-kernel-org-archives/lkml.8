Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3D5C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C842076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="M6vaN3Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgDHMUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:20:54 -0400
Received: from mout.web.de ([212.227.15.3]:51573 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbgDHMUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586348431;
        bh=VNnQ6Zmj3bQlqQMA5yxB7qWSZuLfYMiaZZL53XywQbU=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=M6vaN3YcLlLdoMMhsHrF3vt0FqDIgaFoeMf4Jbo+wBlGg1VjFmmWJndwtz1N8zc8M
         K+dtUrTSLn6E13NNOvnAjVyG/1fsjhwMJj40kBZhi0lX/+5WwUTUM7hvnUD6DFZDHo
         ERQJXfphGZx0eMr9wfB1LmPYImYOrr6cDa2MMMeo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.170.28]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MV4hR-1jnNEA0ytx-00YTk8; Wed, 08
 Apr 2020 14:20:31 +0200
To:     dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: drm/mcde: Checking for a failed platform_get_irq() call in
 mcde_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <abd9674c-adf7-b040-814c-076e32a5a48e@web.de>
Date:   Wed, 8 Apr 2020 14:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fJsj9EGtQRoIZSX4yIB+H9dYKQ11JanGW+a7+d0e0OVkqcsSRwR
 Q9SoK5nsw3jZOcPNpbB9t5YTqiHZvygGn9+Zbtlh7djw7YWLbY3Rgpnz0AbHgNBXoAcSxZC
 qyxRcihT9oSisP4I4/xQ9iXPU7mcBbMMwwfhCOK1fCT7gobUt3ftBy41dvYEuRGPgRgO8O4
 wwn3bherDf8Wq1qlZnqtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YitY0hQW7l4=:70MIBtTbWPQO+81QXSQuAH
 ZbqvU1rGIu1KvNxfSJst9uYiGsUWPGrvvE6I3UriCT/s4+pHK2Qmzb5ncFK7BfoaSyWfylLYU
 3eUieZ7+yBB8aX86E8JrtBoSTYiRgme7HvCaTYMUYeWNjwrhCUJqNxtlhF8jKjDnXL4CY+aEm
 nFhEqnUgv1vXukuvclaSijQJ5sV1WbVxGXJJ2+ZLi8QCVTs8O5P9EtKDPd9QIWWqOZUIdjfeb
 G7IsIjJ54s5MtUNvSIE7FFNNvP/CVs94XBsEck3h5I0mZp1DRX8sUlGegznwwdAmsHwkumDse
 PGGNK6Kp15PDVM1fEpyQpPik8MCv5XBp04MyOXv00saJgk/2y38rXoHzrKp/fSgo6fBL/vVeb
 cgKbp0u8UK/FMha/MJ/Bqe/P+s5ZnOh7KucmJO3fUxrmWAhGrybAU0UI9pHU2plZj1DC8jC3O
 P6C4VWITadD39+1b/5sBD48NnQyFrCv2euWJdnRTCKMcpDopVMxVBYB9M6ULAP/TVdYOPT3M5
 ziLTLSCILwTHD/aXUgGDHnwD2RvjNwTVoT4SgWqQbSwZ1bxOLoo2itep2nJ/qVGSB+XbY/Z+t
 V5z4RwdebSDuiB80suraTjqPJAk+UiBUAxS2JZfRsq5Gue8NMVCTYFa0eHbXwJEt103pZTzJe
 hcL0uGv/J+4LdVdW6SkRGyIUSdrqSHSdaXcRfPnbP06dHh6Z/j4d2G9xOYYA89raxniGrjLwD
 kvdQT8WHc5JnCLXV3klFBXOIzkTtjJf9CssG9uPuxZ3FU+kYlngp1dREpxYZ0YJX+3SF90Dfo
 HJze7RGYHpQAHH7Sw/onXBIcftUfAKHsrnAmm0NViQwDs3f+DgeGUNwB7B6A+jShgkkb4lbw5
 Yab3c0XhKmOZzbjjmLU66+uD3h1nfTXe2q+qpCJHng3jQSU3TrXHibDEKIzQWH31grQgFMJ+K
 uvMpyZNiXLdQHvGIJNk2wEQ1qySl9Pqa7YPY3IukKMG5vgmC42PVs/07LsHyAwk1exrJkzI1P
 Yurdfs0glqpoG57uIAz2Dc8YnsRNuwH9aqrI6T2fF5ep1aH3B2FjL2FGltNsVWQv8c4eusVXV
 Dmzy5NnnZ53jXc1o9M/8+9lqPpq6Otb90BchvN+IFPTFO3aagBJrUNEpRzfzurbfv7SyV2mIj
 CKfjtEsRlMjpdUfHbzQoM8soaNkQnsQCCJqovo2BNankCMxrU7X3pOIAglBWSwEMFp/pXEtBr
 eJt7ZP31rNBTwJ5yL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have taken another look at the implementation of the function =E2=80=9Cm=
cde_probe=E2=80=9D.
A software analysis approach points the following source code out for
further development considerations.
https://elixir.bootlin.com/linux/v5.6.2/source/drivers/gpu/drm/mcde/mcde_d=
rv.c#L401
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/mcde/mcde_drv.c?id=3Df5e94d10e4c468357019e5c28d48499f677b284=
f#n402

 	irq =3D platform_get_irq(pdev, 0);
 	if (!irq) {
 		ret =3D -EINVAL;
 		goto clk_disable;
 	}


The software documentation is providing the following information
for the used programming interface.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/base/platform.c?id=3Df5e94d10e4c468357019e5c28d48499f677b284f#n221
https://elixir.bootlin.com/linux/v5.6.2/source/drivers/base/platform.c#L20=
2

=E2=80=9C=E2=80=A6
 * Return: IRQ number on success, negative error number on failure.
=E2=80=A6=E2=80=9D

Would you like to reconsider the shown condition check?

Regards,
Markus
