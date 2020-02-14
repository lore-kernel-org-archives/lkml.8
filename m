Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B1FC3B19D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF2824654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QI6Ew9ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgBNOFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:05:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19624 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgBNOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:05:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e46a9050000>; Fri, 14 Feb 2020 06:04:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Feb 2020 06:05:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Feb 2020 06:05:07 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 14:05:04 +0000
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>, <atalambedu@nvidia.com>, <tiwai@suse.com>,
        <viswanathl@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <mkumard@nvidia.com>,
        <dramesh@nvidia.com>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-5-git-send-email-spujar@nvidia.com>
 <a440d105-8db9-ecf1-3718-e58804ce14b8@gmail.com>
 <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
 <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
 <bdc749bc-b62c-a041-c17c-33fd49fe8e2e@nvidia.com>
 <598fe377-5b95-d30a-eb64-89a645166d42@gmail.com>
 <3f51939d-cf4b-f69b-728a-7eb99bbae458@nvidia.com>
 <34ac1fd3-ae0f-07f2-555f-a55087a2c9dc@nvidia.com>
 <1a84b393-938f-8bed-d08e-cc3bb6ed4844@gmail.com>
 <0fc814c2-0dc6-7741-b954-463381ff7fb9@nvidia.com>
 <b5c581b9-17af-d004-33fb-2cc782ab820a@gmail.com>
 <9f73afdf-1e9a-cdbd-f972-a022d503ef51@nvidia.com>
 <264d3354-8a2e-ee12-44ae-aff69213d551@nvidia.com>
 <075e476a-36bb-5fee-15bc-76af4474a797@gmail.com>
 <c6022a93-b79a-c691-1d75-d007d0b64ead@nvidia.com>
 <3b42c858-733b-0d17-f457-8043d97f5058@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <62b8ffbc-aa32-ae44-6cb4-b176b8ba9b0e@nvidia.com>
Date:   Fri, 14 Feb 2020 14:05:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3b42c858-733b-0d17-f457-8043d97f5058@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581689093; bh=FOw4bWZEh/AbWKd98TO0Ip7GRAKPee6mZCFYh4kd40w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QI6Ew9ps6koVrDmIS4lwL+Pl6aXPVaJAaivfgwoF8faY4OsNX+S91a24nV6/HZcH0
         x4z16S42vrq91k5KA4wW6nxUmq1PH9BQso2+95cd3aVczvqbIHKD3RiZ6YjI6L0xez
         tS2AvbiMQSRsUHdLtb9rKZjfE/aiRO6q0MXMwHw5u09kdx76ScVdRz8sG3lS6NS7yX
         j1oMBmq1rDwScwRul3uDTm2Dhl9Z+uiPksmBfnrsb5GKcyJOzPD1fH2HgP/4mxkNQk
         sl66OawXc9aDMOAWMkGseZWc03IyOsKWBrt/Rr0BPoZjVIV3L24MmqxqU+7wlBeVNc
         X4TdHMw1quYBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/01/2020 03:41, Dmitry Osipenko wrote:

...

> The !RPM case isn't supported by Tegra anymore in upstream kernel. I'm
> trying to help to make yours driver better and gave you reasons to
> remove the unneeded code, while you're keep saying that "there is no
> harm to retain it", which is not a reason to clutter up the code. I
> don't feel that it's worthwhile to continue arguing here.

On further review, it does look like a reasonable argument to get rid of
this now completely. Like you see less clutter and the soc-core should
ensure that the card is shutdown before unloading. OK, so fine with me.

Jon

-- 
nvpublic
