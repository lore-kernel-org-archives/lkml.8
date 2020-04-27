Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD1C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A35206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marvell.com header.i=@marvell.com header.b="kLohteW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgD0PTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:19:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:29818 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgD0PTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:19:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RFAqlC011627;
        Mon, 27 Apr 2020 08:18:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : subject : to
 : cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0818;
 bh=1n5BME1175zjfULitjxL66IOLBQPkaYi0RPRwyq6Z1E=;
 b=kLohteW2kVDxk0VGyEn2oPofm6mol7wr24DU6+Qq9NMunPGOCRYop1p1jq1muMtEJ2Lb
 njOo7BxB/MvRZd2RuxfJuxSMLdAfQSeN/PcJtwR3tgHSGg2V5xrBNsTBWAkMw0Zr2vPE
 UzFV4TdpH/IRhUu2OzVQLls1HaRdZkVfIVmSSf2zPgnDgbvBrkUecFlCrfMJ10sSu1HK
 9Mvlc3XP6lZqO2hJ1E3iMZIQCUrZbILBnzmkXxFTS3tnG3ZAhLyQ6G1eI8pLdc11lW9T
 5tHGILw8JCqqkhbLCZ8XlIPMLatNMlegeVm8P6yRj4IgyVrpxBsXQF3KjhaGb8sYO+HI vQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 30mmqmfnk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 08:18:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 27 Apr
 2020 08:18:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Apr 2020 08:18:53 -0700
Received: from [10.193.46.2] (unknown [10.193.46.2])
        by maili.marvell.com (Postfix) with ESMTP id 9AB1D3F703F;
        Mon, 27 Apr 2020 08:18:51 -0700 (PDT)
From:   Igor Russkikh <irusskikh@marvell.com>
Subject: Re: [EXT] [PATCH] Fix the media type of AQC100 ethernet controller in
 the driver
To:     Richard Clark <richard.xnu.clark@gmail.com>,
        <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <xuesong.cxs@alibaba-inc.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20200425005811.13021-1-richard.xnu.clark@gmail.com>
Message-ID: <3fbc3da2-cfd3-f1bf-dd04-3304d4aa8211@marvell.com>
Date:   Mon, 27 Apr 2020 18:18:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200425005811.13021-1-richard.xnu.clark@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_11:2020-04-27,2020-04-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The Aquantia AQC100 controller enables a SFP+ port, so the driver should
> configure the media type as '_TYPE_FIBRE' instead of '_TYPE_TP'.
> 
> Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
> Cc: Igor Russkikh <irusskikh@marvell.com>
> Cc: "David S. Miller" <davem@davemloft.net>

Acked-by: Igor Russkikh <irusskikh@marvell.com>

Thanks, Richard, looks like that was a typo.

Regards,
  Igor
