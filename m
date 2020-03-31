Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15A2C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A496420784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sPjiUuqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgCaN44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:56:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15202 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:56:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e834c1a0000>; Tue, 31 Mar 2020 06:56:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 31 Mar 2020 06:56:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 31 Mar 2020 06:56:55 -0700
Received: from [10.26.72.141] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 13:56:54 +0000
Subject: Re: [PATCH V2 1/3] soc/tegra: fuse: Add custom SoC attributes
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200331103341.19571-1-jonathanh@nvidia.com>
 <4f1fabbb-a0a3-6f7d-f62c-2bd545f2644a@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bd1b2056-dc72-323b-bda5-d99df3a139a6@nvidia.com>
Date:   Tue, 31 Mar 2020 14:56:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4f1fabbb-a0a3-6f7d-f62c-2bd545f2644a@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585663002; bh=kzFsughcFE0TQtZJTETz31yFA7yQ/27hpX9Njq52hy4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=sPjiUuqtZqe15GRCaVr4cakBP79Sk4wSsuTCV/lRiRgi5KAWuC5kqsP07t9m4tb/6
         sYGavEv9r2w0ELFTdKP6NvZctxnbv/JNw3Dzz55+8BuU2pIX6bwGiwMI7tStP7AG6u
         5oO770HUDDg08SzpWaTjMjK33JCUqLdTIISb2EQovO1BIfxvjfv2IGZp+vNFMA4BwQ
         1ewKo4q7A+v2BpC2ZmKHyOM6jZv4RI+nEImbzGwsm9VT3DPUa0UaQkEROHWvStLmYu
         uHPrSri7LQXplOythTWIry/Rk/uekzCcZhJOOvepeYX1GWtXnff3JD19G7a7jT0kGr
         MwiAGvtxUjdnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/03/2020 14:39, Dmitry Osipenko wrote:
> 31.03.2020 13:33, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Add a custom SoC attribute for Tegra to expose the HIDREV register
>> fields to userspace via the sysfs. This register provides additional
>> details about the type of device (eg, silicon, FPGA, etc) as well as
>> revision. Exposing this information is useful for identifying the
>> exact device revision and device type.
>>
>> For Tegra devices up until Tegra186, the majorrev and minorrev fields of
>> the HIDREV register are used to determine the device revision and device
>> type. For Tegra194, the majorrev and minorrev fields only determine the
>> revision. Starting with Tegra194, there is an additional field,
>> pre_si_platform (which occupies bits 20-23), that now determines device
>> type. Therefore, for all Tegra devices, add a custom SoC attribute for
>> the majorrev and minorrev fields and for Tegra194 add an additional
>> attribute for the pre_si_platform field.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/soc/tegra/fuse/fuse-tegra.c    | 51 ++++++++++++++++++++++++++
>>  drivers/soc/tegra/fuse/fuse-tegra20.c  |  1 +
>>  drivers/soc/tegra/fuse/fuse-tegra30.c  |  6 +++
>>  drivers/soc/tegra/fuse/fuse.h          |  8 ++++
>>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 10 +++++
>>  5 files changed, 76 insertions(+)
>>
>> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fus=
e/fuse-tegra.c
>> index 802717b9f6a3..639734dca5df 100644
>> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
>> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
>> @@ -300,6 +300,56 @@ static void tegra_enable_fuse_clk(void __iomem *bas=
e)
>>  	writel(reg, base + 0x14);
>>  }
>> =20
>> +static ssize_t tegra_soc_majorrev_show(struct device *dev,
>> +				       struct device_attribute *attr,
>> +				       char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", tegra_get_major_rev());
>> +}
>> +
>> +static DEVICE_ATTR(majorrev, S_IRUGO, tegra_soc_majorrev_show,  NULL);
>> +
>> +static ssize_t tegra_soc_minorrev_show(struct device *dev,
>> +				       struct device_attribute *attr,
>> +				       char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", tegra_get_minor_rev());
>> +}
>> +
>> +static DEVICE_ATTR(minorrev, S_IRUGO, tegra_soc_minorrev_show,  NULL);
>=20
> Checkpatch should give a warning about that permission isn't in octal
> format, please don't ignore it.

Indeed. Will fix. I thought I had ran this previously, obviously not.

Jon

--=20
nvpublic
