Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692EDC352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3578122464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WrL06LEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGLYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:24:42 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9055 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:24:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3d48e00000>; Fri, 07 Feb 2020 03:24:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Feb 2020 03:24:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Feb 2020 03:24:41 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 11:24:36 +0000
CC:     <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: [PATCH v2 4/9] ASoC: tegra: add Tegra210 based I2S driver
To:     Dmitry Osipenko <digetx@gmail.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-5-git-send-email-spujar@nvidia.com>
 <3a586a6b-5f53-dc44-b9fc-67c633c626ef@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <eccf7df5-bc24-3fe2-e57c-9f3238a6a66d@nvidia.com>
Date:   Fri, 7 Feb 2020 16:54:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <3a586a6b-5f53-dc44-b9fc-67c633c626ef@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581074656; bh=zfeC66O1YGW3WlNhQr5Kn916aqKN333KkUzqs+80gNo=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=WrL06LElnSm09IhvXzZuW+itpyYbqV7/N6jBLvpvZBWDHC3yIx1psDaXDS/yeXtyU
         BV+dTv/obC2kRsiEV+KD40yD4dNLtK7DvF0mWTWpCHE3C7YL59WJTxvjK2KzTW1wWT
         G8Z39q3LT3YMVw8c5qoqNThsacWulfqkWqUrUhwbfnxPQ8Uz+oEX1lLqBrC0RdZPZs
         /Z1U1btLksnxtxtYy0asgd1sEN5sepXQz6kH43FUMrSYbzakvBvNaYG88TiIEvWSFo
         O48zzm2B1LmJdXSAifk5iCg37saAtb+3NskX5y6eumfoVBruA41YK8gbhoRQL8uuo6
         vhORN4wM1oGeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2020 10:29 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +static const int tegra210_cif_fmt[] =3D {
>> +     0,
>> +     TEGRA_ACIF_BITS_16,
>> +     TEGRA_ACIF_BITS_32,
>> +};
>> +
>> +static const int tegra210_i2s_bit_fmt[] =3D {
>> +     0,
>> +     I2S_BITS_16,
>> +     I2S_BITS_32,
>> +};
>> +
>> +static const int tegra210_i2s_sample_size[] =3D {
>> +     0,
>> +     16,
>> +     32,
>> +};
> static const *unsigned* int?

will do.

