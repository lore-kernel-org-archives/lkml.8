Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84801C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE182082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RiBDDr5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGLGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:06:34 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17405 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:06:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3d44aa0000>; Fri, 07 Feb 2020 03:06:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Feb 2020 03:06:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Feb 2020 03:06:32 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 11:06:27 +0000
CC:     <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: [PATCH v2 3/9] ASoC: tegra: add Tegra210 based DMIC driver
To:     Dmitry Osipenko <digetx@gmail.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-4-git-send-email-spujar@nvidia.com>
 <9ada4090-169e-0767-db5d-739f6e621812@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <3e89e75d-2f5a-dc42-98f7-8e1262afe380@nvidia.com>
Date:   Fri, 7 Feb 2020 16:36:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <9ada4090-169e-0767-db5d-739f6e621812@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581073578; bh=3R4H2IZWw7cTPGDMdPoqMKekUyJM+BtKnjJ790Z/Zqo=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=RiBDDr5xvmcO6DXh82HHBPn9OlvxmrN84Ur8NAesELWcxhWHETz2Qpwo349cijTe1
         QjoUYMgDdWdh+navso0UWpxkqK07SM3YLwwJm4vxYcuSF+FZzgNhr0GxxrFKsa080o
         oVYcP/MXaPYi+9wg0P4bQAW4N16lOmYMdVyIsroHaaFyr2nswdnmJ8EAXbJKRmN9f6
         Q8MZ026nkP9lw/HMi9CIG4rQYQ1+eOi80nooxaG+W8IFZ/wHsktWY02gQiFft3mIYx
         t7GXZpdxMgIR48hbR4euPfqJgOytS2V7I9ppkWKhmxHLBqMhe8s2OJOE81qaz+61nj
         5QJCcY9AKwGLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2020 10:23 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +static const struct reg_default tegra210_dmic_reg_defaults[] =3D {
>> +     { TEGRA210_DMIC_TX_INT_MASK, 0x00000001},
>> +     { TEGRA210_DMIC_TX_CIF_CTRL, 0x00007700},
>> +     { TEGRA210_DMIC_CG, 0x1},
>> +     { TEGRA210_DMIC_CTRL, 0x00000301},
>> +     /* Below enables all filters - DCR, LP and SC */
>> +     { TEGRA210_DMIC_DBG_CTRL, 0xe },
>> +     /* Below as per latest POR value */
>> +     { TEGRA210_DMIC_DCR_BIQUAD_0_COEF_4, 0x0},
>> +     /* LP filter is configured for pass through and used to apply gain=
 */
>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_0, 0x00800000},
>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_1, 0x0},
>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_2, 0x0},
>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_3, 0x0},
>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_4, 0x0},
>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_0, 0x00800000},
>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_1, 0x0},
>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_2, 0x0},
>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_3, 0x0},
>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_4, 0x0},
>> +};
> I'd add a space on the right side of `}`, for consistency with the left.

Do you mean like this?
{ TEGRA210_DMIC_TX_INT_MASK, 0x00000001 },
{ TEGRA210_DMIC_TX_CIF_CTRL, 0x00007700 },
 =C2=A0=C2=A0=C2=A0 . . .

