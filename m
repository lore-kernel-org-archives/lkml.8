Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8CCC352B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD782063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MhN9aGST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbgDMRFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732369AbgDMREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:49 -0400
X-Greylist: delayed 2991 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Apr 2020 10:04:44 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D6C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=nthD7hLIwbiHeyFNzH25utLfX0DBvZR/iBIyaq9rJo8=; b=MhN9aGSTvwKDekidmpqmJaWXbp
        vNUZOIT6r9VN12kuKGlFRkc4Mc0nERXWph1qCPyofygRpUVkAx4fW8G7awHFEuzjLq+TUiLwLC6oQ
        DaM+hWU80X6pt63hBmTcN2Kbn2bUIeNL2a4yFcHwh5q22AIR69LwrMP03Hj+hTosjxx6trD3a59yU
        zGSSz185KV1YZCHWt6sP6I641S+jKPx/YSxjJPbp+GMNyelltySronvlWN/zom7gSYBcXT/iRyWmt
        sGpVB1ueS98GItO6iqdDxbwzPSQJQsiv6SAI1q9mZwM4AhgapKTfdgYUJIsF89Vs5jtdcxfX8DUv/
        nHtgftMA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jO2Vm-0000ON-L3; Mon, 13 Apr 2020 17:04:43 +0000
Subject: Re: [PATCH v2,1/3] driver: rpmon: new driver Remote Processor Monitor
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200411095301.18780-1-wenhu.wang@vivo.com>
 <20200412112405.24116-1-wenhu.wang@vivo.com>
 <20200412112405.24116-2-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <816c6ed0-9b37-f43a-24ad-e742ca24c8ba@infradead.org>
Date:   Mon, 13 Apr 2020 10:04:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412112405.24116-2-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/12/20 4:24 AM, Wang Wenhu wrote:
> RPMON is a driver framework. It supports remote processor monitor
> from user level. The baisc components are a character device

                       basic

> with sysfs interfaces for user space communication and different
> kinds of message drivers introduced modularly, which are used to
> communicate with remote processors.
> 
> As for user space, one can get notifications of different events
> of remote processors, like their registrations, through standard
> file read operation of the file discriptors related to the exported

                                  descriptors

> character devices. Actions can also be taken into account via
> standard write operations to the devices. Besides, the sysfs class
> attributes could be accessed conveniently.
> 
> Message drivers act as engines to communicate with remote processors.
> Currently RPMON_QMI is available which uses QMI infrastructures
> on Qualcomm SoC Platforms.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

The rest of the changes to patch 1/3 look good. Thanks.


> ---
> Changes since v1:
>  - Addressed review comments from Randy
> 
> ---
>  drivers/Kconfig        |   2 +
>  drivers/Makefile       |   1 +
>  drivers/rpmon/Kconfig  |  26 +++
>  drivers/rpmon/Makefile |   1 +
>  drivers/rpmon/rpmon.c  | 506 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/rpmon.h  |  68 ++++++
>  6 files changed, 604 insertions(+)
>  create mode 100644 drivers/rpmon/Kconfig
>  create mode 100644 drivers/rpmon/Makefile
>  create mode 100644 drivers/rpmon/rpmon.c
>  create mode 100644 include/linux/rpmon.h


-- 
~Randy

