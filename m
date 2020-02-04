Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AC5C352A1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C484521775
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qVsWiJP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBDEYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:24:43 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12586 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgBDEYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:24:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e38f1f30000>; Mon, 03 Feb 2020 20:24:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 20:24:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 20:24:42 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 04:24:37 +0000
CC:     <spujar@nvidia.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: sound: tegra: add DT binding for AHUB
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-2-git-send-email-spujar@nvidia.com>
 <32d6c62d-0ac4-54e0-2efb-9f9a8cf2d271@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <62ea74fe-1f3c-e56c-669f-9a2dd9c02412@nvidia.com>
Date:   Tue, 4 Feb 2020 09:54:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <32d6c62d-0ac4-54e0-2efb-9f9a8cf2d271@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580790259; bh=c7jWe5+LZRdJDnKDrOesDfCG5Wq2kGvI3fJo43SYT+M=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=qVsWiJP3Pc+CUUL/ZLo8d9Y0iCzJUjSU5/EdA5r9EnEKfftMA2EOxLnsAuA/KVsMF
         KUVPkCBC+gpmBumUOq5rvGGCD9kQDM+aQ6+d+O8Kmy1zxU0jVDZn8KMwf9sdGgxET0
         RtIdAQyLHLTaV9seQLYkwjk4o1uouRPZknEjGMkncgyBxKnywLnqq7LMQS3m/8mEPl
         wIUYM19jnqVYOEkv9OQTg8mL8TRHDZew6WUTQCGPUHu2f0pSy+r3C/LmWJgu+EY60B
         Qev/FCnAeNogiid+Ng8YZ3Niq+V7vo32L85/Nfx8v4givaZzJ4AGdXw30otGm0KhXq
         u4bbs1zQ/qN4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2020 1:49 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          const: nvidia,tegra210-i2s
>> +      - items:
>> +          - enum:
>> +              - nvidia,tegra194-i2s
>> +              - nvidia,tegra186-i2s
>> +          - enum:
>> +              - nvidia,tegra210-i2s
> Couldn't this be something like this:
>
> properties:
>    compatible:
>      - enum:
>        - nvidia,tegra210-i2s
>        - nvidia,tegra186-i2s
>        - nvidia,tegra194-i2s

I used that way because,
For Tegra210: compatible =3D "nvidia,tegra210-i2s";
For Tegra186: compatible =3D "nvidia,tegra186-i2s", "nvidia,tegra210-i2s";=
=20
(future proof)
For Tegra194: compatible =3D "nvidia,tegra194-i2s", "nvidia,tegra210-i2s";=
=20
(future proof)

Currently driver uses "nvidia,tegra210-i2s" alone.

YAML binding check fails otherwise as it does not let me have future=20
proof bindings.

