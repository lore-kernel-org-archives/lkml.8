Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB16C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EC32100A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V4frLrDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgGPXIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:08:37 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14622 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGPXIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:08:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f10dc520001>; Thu, 16 Jul 2020 16:01:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 16:03:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 16 Jul 2020 16:03:34 -0700
Received: from [10.2.163.115] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 23:03:33 +0000
Subject: Re: [RFC PATCH v3 16/18] gpu: host1x: mipi: Split
 tegra_mipi_calibrate and tegra_mipi_wait
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <robh+dt@kernel.org>,
        <helen.koike@collabora.com>
CC:     <sboyd@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
References: <1594786855-26506-1-git-send-email-skomatineni@nvidia.com>
 <1594786855-26506-17-git-send-email-skomatineni@nvidia.com>
 <a06dec8f-7042-767b-545b-048685a7683d@gmail.com>
 <20d63eca-4b2b-584e-a391-a4fb64a16b40@nvidia.com>
 <c4945c77-5de1-e9b1-9f4f-cdd78bca18c7@gmail.com>
 <ce0c5ffb-f859-0eab-1ea5-044623dff221@nvidia.com>
 <a2b8169c-c4a3-4862-cd27-8c1a51ddc558@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <4690e682-8495-2327-87c7-c2f06a7a479d@nvidia.com>
Date:   Thu, 16 Jul 2020 16:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a2b8169c-c4a3-4862-cd27-8c1a51ddc558@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594940498; bh=IQ4O2kXu/48GGMSWcmenLqn3VSY97/qSJdItJz4Xank=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=V4frLrDLf7wzr0GcMAG5OoC/zyA5bktipRy0lGWuXWWDftChPohKciCAmm+JjbAoU
         pWjJmGcoJmpj6ldw7hsRba1+g472cWg97oF+ii67zUYi16RiqCRY9fRucdY+h0Wi8t
         fnSd/puBb2s02xeKlHXYNkCPWoCnMDg4VFL5Gs1++AfWgAlQGvxqmrMS+48dBbOEmF
         Q4E588yA44lTB776Z466paiOsjdg2Wh0qjSEtR3k0hsUnIMCGInCshsyOn+noXdF5f
         sJl3iEhJRGCPLut0Vyf/lh+t7UxCijNTSp3xOQkNlULfwoQcV3jZhiJiYAUtsMfbxH
         azPzNs2i2p4+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/16/20 4:01 PM, Dmitry Osipenko wrote:
> 17.07.2020 01:49, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> What keeps MIPI clock enabled after completion of the
>>> tegra_mipi_calibrate() invocation?
>> MIPI clock is disabled at end of tegra_mipi_calibrate and is re-enabled
>> during tegra_mipi_wait.
>>
>> I think I should fix this to keep the clock enabled till calibration
>> results are latched.
>>
>> All consumers of tegra_mipi_calibrate() will call tegra_mipi_wait().
>>
>> So will remove clk_disable mipi clk at end of tegra_mipi_calibrate() and
>> clk_enable mipi_clk at beginning of tegra_mipi_wait()
> Isn't it possible to perform the calibration after enabling CSI and
> before of starting the sensor streaming?
Currently this is what I am doing. Triggering calibration start during=20
CSI receiver being ready and then sensor streaming will happen where=20
internal MIPI CAL detects for LP -> HS transition and applies results to=20
pads. So checking for calibration results after sensor stream is enabled
