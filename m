Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C15C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8292A20758
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="A1FsX9GT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGGGFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:05:19 -0400
Received: from mout.web.de ([217.72.192.78]:41217 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgGGGFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594101902;
        bh=8JM2O9jcHjAbFpQBOjma2wnTkbwYl3IQhMDrSrqvnYI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A1FsX9GT90we5fowiGnbvuZJCLBoyb7X4dQZDgWQkxrbNNJzRxxUi/ItvwYqIjwGt
         5HoUVjfSTB9NcS9KBmFTV4571CPOfV7CQ618Jm0dWAcuDiBZFeY+betbFdhWhRSPQs
         iMiiusLwCY/6IRxxb9J4voalZkA5cU6him+maxAs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.121.241]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqkB-1k2LmA39jn-009eyu; Tue, 07
 Jul 2020 08:05:01 +0200
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
To:     Hillf Danton <hdanton@sina.com>, iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
References: <20200706104915.11460-1-hdanton@sina.com>
 <20200706124241.4392-1-hdanton@sina.com>
 <20200707011420.1416-1-hdanton@sina.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f29f7008-6489-0db3-86b3-5f83f5ed7770@web.de>
Date:   Tue, 7 Jul 2020 08:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707011420.1416-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FjEVrQWL2QA5e4X0aVFByqrubBufrf7DYh3N3MlILuX7K7HSyMz
 U1kbCSZuNLw3tmincyjBqV8H+D3Z9Xst0EU/762LG04H/pOmEpOPI6pyW31RZQmcmpOtvWu
 eHL2O4w5hEjIckphsLdgWszNCHuqOznsDh7pubtDRZFy1OYYHu9ONqRJiIy0VbZTYxPZCkG
 t65wGHu5PXBjx9brtccgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RuTW5/5Es3w=:/gvupHiTAIkF9FbZ9XFiys
 A+VYE5eipB8Ccvhww8ybH852MiOD5JjN5frTKbFEz3sP1Oy4EsORIuLUI0TatBQV90YDjll4O
 5LQ9y7CzcPvUTkjFFsHbyB9dN+Pb41mVgSv4J00+2mlUCjoeYe4VNg68pwOQixhl3kOWbQURp
 RlHwraH8PBBrH/VO8pL15GlBTlxoSwkl0Ltm3FVgqiIMEoPx6gB0GI/GhXqY696oWLlw8f28z
 b4v8g8MMj4PrI1bUgWRrFNz9zTLr/WMGfhTXJPGjzOUhjqIuEdMYmqGmk5+S5A2RgkVUBqufU
 izJzYgQfpDvrcn1oZbwtTpwgjC8+bx6K9otplZkTATwjQhZgAYLU/OEPRQuMdQapcZMbaoNnl
 YO9OlMduNTbkFIjoH35p4iZH2d1jmi2A55rU5whZZ5SvPFXTLAdn9O41JI90tU/872zjU6Aim
 tQPgTQUG1LQLN0djJktTGSzpMI9JMVKzWLB/RiXCF8hNjPpM4YRRLqBRVyPdFAPeBOKdzaNZ9
 WA5Othv4GZax0FiP2hKx+kjjhh/zgHjhHZVu980wmLbIQFjzdF9Qi/qRsXYCJxxbqz6ttYEGO
 RlP79RUenZGMKk3ezQcF0aZLvCynoYLNbj0WF9u37J5WS3Q9p9+3Icgo+ZjfpWDcpShNXn865
 AAw7XVcsZRF+p7m121TsJsdONZl8dRJJUzBd9l0Dqc+Og9PZM/dEyHuHgWKqoR2vICInnIgXh
 7mtETRcJlRjx6hIbBmV2GjhFLhfMsCcx4oV1RFkDwaM9d6GEBlz9RW5MV780GKTe+u0S/sqED
 4Tg9ps9bJtiyv750Qm0a6Evz3Rh1ozVtFKEWl83T8nNiLdT28r3SeF++p1HWCqXePN7nwnL73
 q898y+UWBqV0dr6gRUtKUy/F3UT0+6N8hUdlKSnyatMn6JSs59n2WUgAgTeJaE7r5P+sswdFv
 XaavkJC17ihYgBukuqkpi4RlQbF96aviQrrHM7CPYimBTlpX9D/G4eh7/iHRIXO0rMQhAN2Q0
 dFyot2H/tGSZPD64lr4mQa8lywopZlPArXvk6+sTmGJ2dMw27VyZ6xB0qY3wBKLaINepwWMwQ
 MS/Lv5pYv2fCWC3xc18AjZlu+YjnrqDDotgDMRAMiuwagXJGaS0yl8HdTo9toQQDPkiyN4sfz
 1Wd2RPTXmUqer3NsMT3vv0fmcS98fOGrX7bdZmJa4Y22nj23xzxjUwMGEXtFPhcNWTarFM+Yg
 55Y6BT+D1DvrqWnSr19yI1FhsK4+vVMcNc0Y33g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2798,7 +2798,7 @@ static int vfio_iommu_type1_dma_rw_chunk
=E2=80=A6
> -	bool kthread =3D current->mm =3D=3D NULL;
> +	bool kthread_load_mm;
>  	size_t offset;

How do you think about to reduce the scope for such variables?
https://refactoring.com/catalog/reduceScopeOfVariable.html


=E2=80=A6
> @@ -2812,11 +2812,12 @@ static int vfio_iommu_type1_dma_rw_chunk
=E2=80=A6
>  	if (!mm)
>  		return -EPERM;
=E2=80=A6
> +	kthread_load_mm =3D current->flags & PF_KTHREAD &&
> +				current->mm =3D=3D NULL;
=E2=80=A6

Would you like to apply a more succinct code variant?

+	kthread_load_mm =3D current->flags & PF_KTHREAD && !current->mm;


Regards,
Markus
