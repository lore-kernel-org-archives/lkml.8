Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99005C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA0920842
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="AOlOEr1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFKXJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:09:44 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60786 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFKXJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x2I+4wEt+ndD3DAovJGmxH8wykiwurzy6HtFRBsQBso=; b=AOlOEr1h01xKYHXIq+FDtdK8fV
        t938zGbURQF+SpD804shhOweuygX26rFPYZB7wOUfe8/fgjpwdu+sjbBNiG5Pgqzr6Bmszwk/L9kC
        K1p0Bp8VHsoLXn+0yE8uAaYeOWiwcQ6zTuEieIYrLtSoX8QjFNsLfpYiPMM9g2oUtarlEt31gAVAK
        O+ryzQeuT8086Kf71K3gMScjAJjWw4yQbz1G4F8xNuOOrLZQVnvLehDj7gAou8YBFUDH1Di74PCme
        jkk7DtdgHIlGaIYu5E6MKYhgmA6sM7MsnjvcIktmfJMyJIPnO7cgQs2FXazslsuMYCB9Yi3Lpeshq
        MHLudDUQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jjWKF-0001kE-4v; Thu, 11 Jun 2020 17:09:35 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-6-logang@deltatee.com>
 <BYAPR04MB4965AE69900A7832EEC4141086800@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3e198d5f-e303-25d9-0e8e-e5916809800d@deltatee.com>
Date:   Thu, 11 Jun 2020 17:09:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965AE69900A7832EEC4141086800@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 5/9] nvme-core: Introduce nvme_ctrl_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-06-11 5:02 p.m., Chaitanya Kulkarni wrote:
> On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
>> +#ifdef CONFIG_NVME_TARGET_PASSTHRU
>> +/*
>> + * The exports that follow within this ifdef are only for
>> + * use by the nvmet-passthru and should not be used for
>> + * other things.
>> + */
> 
> The above comment is duplicate #ifdef is self explanatory and I didn't
> find similar style in existing repo  (e.g. CONFIG_NVME_MULTIPATH,
> CONFIG_BLK_SED_OPAL) so let's not introduce new style which will create
> confusion to future code.

Christoph specifically asked for this ifdef and comment.

Logan
