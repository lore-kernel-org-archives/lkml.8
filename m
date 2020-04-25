Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A0DC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C1D2072B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YvCZdT56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDYXUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:20:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3060 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgDYXUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:20:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea4c59e0000>; Sat, 25 Apr 2020 16:19:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 25 Apr 2020 16:20:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 25 Apr 2020 16:20:11 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 25 Apr
 2020 23:20:05 +0000
Received: from [10.2.165.152] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 25 Apr
 2020 23:20:04 +0000
Subject: Re: [RFC PATCH v10 6/9] media: tegra: Add Tegra210 Video input driver
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <helen.koike@collabora.com>
CC:     <sboyd@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1587700513-28449-1-git-send-email-skomatineni@nvidia.com>
 <1587700513-28449-7-git-send-email-skomatineni@nvidia.com>
 <fd5300fd-33af-babe-95d0-9669b66a8c06@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <d6b92c10-92d6-b0e6-1475-429b63ff61d7@nvidia.com>
Date:   Sat, 25 Apr 2020 16:19:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fd5300fd-33af-babe-95d0-9669b66a8c06@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587856798; bh=37bwKz8PDVAT3Z+9gtG8kKeaUYEOxghtuKi7TNhemZs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=YvCZdT56apjLL/cvdA6pL/4z1TVnhZx5x2F5nKEsmGJCHctutV68/VLbWVrwFXndt
         q2HsQ6uveVhIWGb6spdGuY/E7LDvLaoYryKGYBOJvyxlbUZBpr7F7SltECts7WQufz
         6VJNlMGq+RvV7GIefuIb5koVzzimbAlVOEb7JiKSxo9k3iUFuX69srdZdK9QUJsP2x
         slqC0tv4SWWvv+Plp7a43ZYVISdBIgZzHtfZ3PP2ZeACZvqsgfTlJPe/V1JE/4B1zI
         2q7bHGeyjWUNHnTKvlyxEcm0bkoQZnPZ7mvLlGt68/BuBMvkW+/mH4hpIPjF2U4OZG
         fZ+8TC9AmvAVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/25/20 4:13 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 24.04.2020 06:55, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> +static int __maybe_unused vi_runtime_resume(struct device *dev)
>> +{
>> +     struct tegra_vi *vi =3D dev_get_drvdata(dev);
>> +     int ret;
>> +
>> +     ret =3D regulator_enable(vi->vdd);
>> +     if (ret) {
>> +             dev_err(dev, "failed to enable VDD supply: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     ret =3D clk_set_rate(vi->clk, vi->soc->vi_max_clk_hz);
>> +     if (ret) {
>> +             dev_err(dev, "failed to set vi clock rate: %d\n", ret);
>> +             goto disable_vdd;
>> +     }
> Isn't setting clock rate using assigned-clocks in a device-tree enough?
> Could you please clarify why this vi_max_clk_hz is needed?

Max clock rate with sensor support will be 998Mhz.

Later when sensor support is added, based on TPG or Sensor mode clock=20
rate will be set here

