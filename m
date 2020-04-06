Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC27EC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D482076C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lAjFBTu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDFS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:59:03 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12884 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDFS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:59:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b7b910000>; Mon, 06 Apr 2020 11:57:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 11:59:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 11:59:02 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 18:59:02 +0000
Received: from [10.2.164.193] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 18:58:58 +0000
Subject: Re: [RFC PATCH v6 6/9] media: tegra: Add Tegra210 Video input driver
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <helen.koike@collabora.com>
CC:     <sboyd@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
 <ca9a792f-ff5e-c82b-c2bc-32c4875e558d@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <a972950d-5860-2b77-b5ad-90044b8deb94@nvidia.com>
Date:   Mon, 6 Apr 2020 11:58:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ca9a792f-ff5e-c82b-c2bc-32c4875e558d@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586199441; bh=o2YOjNGwEALpzr6ldAL/EJ7+Mp70+nUIZNI7t+BCnl0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=lAjFBTu4nKWpTL7Ihnm6Da8jZ0JDs32OAPpY+hl9+SriQG/IP60ClPGUFhp0tAlsn
         mw9+/7mDCmyF+oMZmKxcPvD48Juz8wnz7dWYi3BmO+eyqvsGmIbk/NNmoGL9+EEwkA
         hDERDaQC8s93mz86g6HRIwsQrkGixY86AYTodhDl4f1bPU03k8TnUF+orTq+mgt0MA
         huJtbijFv8134PZXaZZZ9MrPXWfXSTpKoPLcNNhBgahW+mUtTlHoAWPiemQWr9BlBP
         LKDbRUgrHEUopI8G59NWQeD+nYCWagN2tIW2s9lmJ9pHu1/GZGVxr4kK4f0IbudJ/p
         OPp9GiRkUvFww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/20 12:37 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 04.04.2020 04:25, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +static int tegra_csi_init(struct host1x_client *client)
>> +{
>> +     struct tegra_csi *csi =3D host1x_client_to_csi(client);
>> +     struct tegra_video_device *vid =3D dev_get_drvdata(client->host);
>> +     int ret;
>> +
>> +     vid->csi =3D csi;
>> +
>> +     INIT_LIST_HEAD(&csi->csi_chans);
>> +
>> +     if (pm_runtime_enabled(csi->dev)) {
>> +             ret =3D pm_runtime_get_sync(csi->dev);
>> +             if (ret < 0) {
>> +                     dev_err(csi->dev,
>> +                             "failed to get runtime PM: %d\n", ret);
>> +                     pm_runtime_put_noidle(csi->dev);
>> +                     return ret;
>> +             }
>> +     } else {
> RPM is supposed to be always available on Tegra nowadays.

Sorry I was not sure if its all the time enabled, so added in v6.

Will remove check and explicit runtime calls...

