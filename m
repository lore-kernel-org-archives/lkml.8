Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3940E2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="htNks5ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgE1IH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:07:59 -0400
Received: from mout.web.de ([212.227.15.4]:33987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgE1IH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590653269;
        bh=Kjxv5j/70jFJObItlorcZS0xPRih2dduzhD0gfulbCU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=htNks5ESpYHDEZfGwTkdX3EIIHqVRGrQZlffDtk1EH/2oxIy5bSsRxLGuYaMpLQnu
         lTXfNK7pdF4a3dsOY6AeuRHfadjfGMzmBKaziNCRNhLahQX5JLlnbSUnKY6D+Qpc4x
         pZsCOX9Sq7EU2yCFmvffYlmzJkKmtPi6QVYmBEZQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.155.229]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MW6Ib-1jXELs0e7d-00XOOu; Thu, 28
 May 2020 10:07:49 +0200
Subject: Re: [PATCH v6] workqueue: Remove unnecessary kfree() call in
 rcu_free_wq()
To:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200528013736.39356-1-qiang.zhang@windriver.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4f292007-4da0-3558-4c6b-ca3eaf884193@web.de>
Date:   Thu, 28 May 2020 10:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528013736.39356-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uqNzjfOkrcuvda9fmBmbhmRDEw0/pz1M4Qv09p1m1OR7vIMo387
 dloYPfbsEcQZ/SjxWokYN7nLDCSQggthv+6uplr6YuG0zA4UddXn7WkctPMI+mj40JB/iIu
 HSWf7bufV5UcjUszptnUrW7BhwgZKcjmM5UY5P5wu8hDjnWLuJ3Z2MY1ywqsKhV2XnCgLJA
 hdLVHxtaTLSSFx2ZjP+iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PyTAXYFcb/w=:CGNO5UpeFqRLQPOcIfl+aq
 r12DDwVQFwBvDQRt6Jzdhds6JDLBI+etcGX+lRb7T9I20wETdl2rXw0IBOomCqegr7kzeFdEU
 3Co2bNqR+xJijTrgXQHCNh95ZrGqBVwVYidZVWH+eVdsepTyJo8CgscwpUk8Ki50uQrW1oYKd
 Nxf22rQHfUOCc/JNpfMOsoAHe9jPunKm5WzqjX/iM8kX4SDkrFaMstEsNhadgjPRPRm3sPwXm
 XeIpON1ypCbnxR6HVjcEIhO8Qsjc1Tc2gvFbwk69Kx0sNtrh6ForcFhgW1iaZN7GmyKPtkGQf
 vrLBqgIq6NnuJ3zt8iJJdDicsK2J+GtYn7fnyAsN3cpPBJyVe5GZy3aAkzCooDOAalPRp9uXp
 /Z03iFWSoyTVKz+kuH1qWvW+kdbAV1Dhn62V80f5qrZXWffqsDOojSFig3lhxoGvBtgvqOUKC
 OUbwurqmQQe3pC/zAJ5EwHPcu2eWXbCnebR9adG/vnKI6YPPG0ISme7rxXkwfYItpRvR8k9mg
 VK3ha+xQTFANAn5KgVT3Zzf9SvKXf8+vztALJTipN780YJ2aOjRgTEdKAWgRpjyih+PmzzEv8
 /uWY6Xa9kJQ1XjqxoTu/xf9Dn3jkgm4JFydnhiz9CU2BDQYusTni+c56r3kfVDyb54iE7P1B5
 T+9rH6xKdpF+Nr9Tu+Wv+Gxj8fPtEv89ogJgDnL2/qjf1eXETH7fu6fld5ovJ21N5hZvNM+g8
 uWamEWRtPXzBI+koId7MXI4Jyd/lrB4p+ckdD5gX0iJE9O3CPCqLoI3vr7ptDZ8UwofxP29PE
 jyJgpZ/iynppsnvShRHu5SctXxf4y6gFXAvm3FqJijJ5h/FLGnNgVIf63K90oqzc+qC2ob3DH
 L0U37JumhuiaSnKceBTk9eOk+Yl3jxclS/Y+JGgJJjOtADeLq8HJajGLIJ86pJg3/9G0CmrQX
 eD4HbwO69eewzKJbyChn3uVhQAN8wXrAZk9PYl1T4HDaomNccB+O5JkFzWxYt1YqawZ5DgkMd
 OEgovoBXs881ITXD/ryQ2EVrH0CqloPKi/FCqxIzSs6wCHvyoszJsqij1yWk0JaqBGernh5YQ
 AuAOO3P3bxpdY+WUkPQe9hNZzOb/GpPqm2PkuGFaybq9kgrsWFDuKojQKF/A/6FVVvWTYy+k5
 CKWMkT8tTiRW/SSMuvvmG6r2EGDiteIL2wcOf/cbqTj5SzxBUpQHLFgjf14zYnnaasIle/qly
 juvrqq0/y+GqA+JHG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thus delete this function call which became unnecessary with the referen=
ced
> software update.
=E2=80=A6
> Co-developed-by: Markus Elfring <Markus.Elfring@web.de>

I guess that this tag should usually trigger another consequence like the =
following.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Db0c3ba31be3e45a130e13b278c=
f3b90f69bda6f6#n548

Signed-off-by: Markus Elfring <Markus.Elfring@web.de>


Is there a need to tag also the patch review contribution of Lai Jiangshan=
?
https://lore.kernel.org/lkml/CAJhGHyC4XcNL8yzWZKZ=3D73wZJej4JwCaAHGV8qjYn-=
AqcEAEjQ@mail.gmail.com/
https://lore.kernel.org/patchwork/comment/1442889/
https://lkml.org/lkml/2020/5/26/201


I am unsure if such aspects will matter after Tejun Heo responded with the=
 information
=E2=80=9CApplied to wq/for-5.8.=E2=80=9D to the previous patch version yes=
terday.
https://lore.kernel.org/lkml/20200527135214.GI83516@mtj.thefacebook.com/
https://lore.kernel.org/patchwork/comment/1443888/


>  v1->v2->v3->v4->v5->v6:
>  Modify weakly submitted information and tag.

I am curious how our imaginations and preferences will evolve further
also for such wording selections.

Regards,
Markus
