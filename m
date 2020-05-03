Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85854C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC4B206F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="I5dB89K0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgECNDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:03:55 -0400
Received: from mout.web.de ([212.227.15.3]:50993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgECNDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588511027;
        bh=luUWOSurUWv8Y8HSTIcfmRsAiC2aJOWuuo0/vNEMFEQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=I5dB89K04HMvfkNrTUu6X2qoYj5YEDRVxMUY/7bmUO8YlKsX5M+M1wlOdv+7oSrmW
         JeSjBdTC0QqHIpnnPqrH1Uh5oNhAo0iAILPEzK5mQpp2dFWDw8zkfoW/VC6sYX5zbH
         MVdSiaj+w09EmV+hFM/FryajhTOym6MmiBn6IKuA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.26.31]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0Ix-1jFNQ82Ca3-00yPs8; Sun, 03
 May 2020 15:03:47 +0200
Subject: Re: [PATCH] checkpatch: add support for title acrosses three lines in
 commit id description
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org
References: <20200503123435.GD10332@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <df619612-3825-4637-e025-618a7a982310@web.de>
Date:   Sun, 3 May 2020 15:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503123435.GD10332@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+H1AVTi6CX+RViudSSfT9MZFOWyNtOH0bHzzwEX+EH9FyHN9PF4
 MdC97gdYJqFMs7W+c9dyXJwoX2m/899+ue5F6favdHwS0WXKFm/iV8saQfKx+7/MjE/XZXi
 DQRahSaWAjs6d/UBfoorjE3jr8ASPN7mQ8GgQyxq/C4kNv6P8mhAQE1U2teNAe5WdrrrrA7
 86EKVsnVn2GJDlYmxwPCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2RU6bDv9qdo=:FCn9tYU+pH0Eevczq+Pwoe
 asGIPB8kKOYb1JqKv4h/pnUyI1YqV8v68oC0i0lpc7gPg4HbxAYSnUgrorakInf1nuY/ExK5m
 GEBQj4lxBVc1jiqF4uQloQ99ebxLQc/lJ8XNzrtDjNbYzriuHI6LIKwSM4/4ntwh0j6qou9Nt
 GIEL0k7IojyolhqT/QspOugbajWXzDq2ou8APdm9SEDodGvcYalYOXCGAQHnp56wt0qn0ksVF
 JCjJ/Ts2D0R2VJO3S5AziGqZbCNgcIac5SnftHE9yEsGkv2GKJ3edFhvve5qSvg5t9OciKlzN
 +x+vsKr6ocpBsBC+qH51YOFgFmy4U9xkppjtA4qrc9yVKc/uZXJi8NDObQNarAvOH+R3d1v4w
 qoBR3xrRyJ5SM4teicchyEpBu41lWL2DwgLQ+ry6jsutosyUpF7Y8wTNpfksiLkQZoBwwyWsz
 KXJJQlST9pIp8NgbG9c2fXzQ3Ss7UILnYnVmv5VYij2W6xcE/VQKF/DP7YFMt5LAD3w9z9xX6
 ZpPCRbM7PAV7nFCt/fKT6M0rch6wkETH0czSTJshz2pWqc87Q+XMYCK9ceS6q+06+ls6twYMB
 4aI7ldvTL/lm6JxPSy/vuqG60ILVBHi5TmO71RDadEwGSDxwdrguoNpPpwxSntNIlZfVs9BOs
 CZU7e/KYUH7VKbsp1K0bWzPvHQTCzX51DsrDYxxddwH4eyXRl77qlgMSI/xnxVWu1Q6kK7xtA
 OIJIdn9PDRkeYYomsZaK0uj9qFmKLNTjy1IP8cHA/bercB9D2uoQDF9tV7H2M5AFpuV68pAAo
 a+jULa52PT9Ds1PdHsHl6xcaOkSR5Yu895h7qy89Ku6Vip/uA/qy7sfS3t6p131vjbysPi7jI
 1qos9H7u3pbBl1F5W9eLfYK28vaOMgQycvN0mT8W0EqTl6qvtohhA8x0Wib/OMDDN+AvWChvf
 cPPrmPw4SYCV8D15vpq3sZo/sCtNWb8yFPVh5ic1SkKQTngga/ZWAke+eKVux0Dt/AA1LOJHt
 7LDWZzWFKbbyudR5/mlNdxMdvYWNXasS7nI+e+UrOvf7aA4g9VSDRTiqdZa9YDVNIxSvW2ygh
 OJwgtARaHSZL1JIlZh1Fewg7x2KfvMQKqjuR6sFZRHFOrbTnV6rXCmCH+vw1Uru+2PAP+zNEU
 Yvqp55BWfx/A4SpquX/XSP4lHlizWWEMtrqxVtDYJOhNPCJSzEfIhmbwEwQ/tlmbmKF4ojzWw
 XvYlLLi2tY2189wA0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The current GIT_COMMIT_ID will report error when the title in commit id
> description acrosses three lines, =E2=80=A6

I suggest to improve the commit message (and subsequent Perl code)
also according to the usage of the text =E2=80=9Cacrosses=E2=80=9D.


> This patch adds support for three lines title in the commit id descripti=
on,
> and emit diagnostics info when the title acrosses more than three lines.

Please split this paragraph into two imperative wordings.

Regards,
Markus
