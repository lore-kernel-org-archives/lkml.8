Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F61F20735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K32NsG9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbgDMRSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732592AbgDMRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:18:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0650C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=yKvM65C9W/yR400UxN3D30rKKHhihxPzOdkNttGDCrU=; b=K32NsG9h3gVOlUzfGbARzsDcOE
        fVJpliyntBTTDwjnhVw63lnV2v0NwSXoQdVJB89tVzUiI4XgoLrZmvT4DgljmmfrH9Wsy6YA2HG/t
        ak1j7YpQecymaOd9T9xnUzpPfui3z2JLo8bp/isP2r+aqxryefex4KQyl2kDYSsjxckVyZ/I8ZDKh
        9DxeZQjqvlnrrs8meuN+Ps9ehVsMyiSbI+dXwmzcaWyxg65LUBFc3UHcF74QIaYVfV8+F1Psapmgr
        Nna+OM21R0pVR2dJECoEbaigxY+wmhTY4YXLAoK7bKMTzQCLiH59ENAhY6CQzYVfNJR1jvyvvjgFd
        raXnXHeQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jO2ib-00049w-UI; Mon, 13 Apr 2020 17:17:57 +0000
Subject: Re: [PATCH v2,3/3] driver: rpmon: add rpmon_qmi driver
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200411095301.18780-1-wenhu.wang@vivo.com>
 <20200412112405.24116-1-wenhu.wang@vivo.com>
 <20200412112405.24116-4-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5fd54517-15a9-03e6-7820-93a873c2b3da@infradead.org>
Date:   Mon, 13 Apr 2020 10:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412112405.24116-4-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/12/20 4:24 AM, Wang Wenhu wrote:
> Implements a kind of communication routine for RPMON to communicate
> with remote processors through QMI infrastructure. RPMON_QMI itself
> is designed as a modular framework that would introduce different
> kind of message sets binding to different services.
> 
> RPMON_QMI creates a device of rpmon_device type for each remote
> processor endpoint. All the endpoint devices share an unique set
> of QMI suite.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changes since v1:
>  - Addressed review comments from Randy
> 
> ---
>  drivers/rpmon/Kconfig     |  15 ++
>  drivers/rpmon/Makefile    |   1 +
>  drivers/rpmon/rpmon_qmi.c | 431 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 447 insertions(+)
>  create mode 100644 drivers/rpmon/rpmon_qmi.c
> 

> diff --git a/drivers/rpmon/rpmon_qmi.c b/drivers/rpmon/rpmon_qmi.c
> new file mode 100644
> index 000000000000..fe3b48c23cb9
> --- /dev/null
> +++ b/drivers/rpmon/rpmon_qmi.c
> @@ -0,0 +1,431 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + *
> + * RPMON: An implementation of remote processor monitor framework
> + * for modern SoCs that typically have heterogeneous remote processor
> + * devices in asymmetric multiprocessing configurations. It is
> + * implemented with chardev and sysfs class, which act as interfaces
> + * to communicate with user level. It supports different communication
> + * interfaces added modularly to communicate with remote processors.
> + *
> + * RPMON_QMI: Implements a kind of communication routine for RPMON
> + * to communicate with remote processors through QMI infrastructure.
> + * At least one set of RPMON_QMI_MSG should be available and RPMON_QMI
> + * initiates with the message set(s) to provide certain servicei(s)

                                                           service(s)

> + * like stability checking of remote processors. Currently a set of
> + * messages, implemented by RPMON_QMI_MSG_V1 is available.
> + */
> +




> +
> +static int rpmon_qmi_drv_remove(struct platform_device *pdev)
> +{
> +	struct rpmon_qmi_device *rdev = platform_get_drvdata(pdev);
> +
> +	rpmon_unregister_device(rdev->info);
> +
> +	return 0;
> +}

Missing blank line between functions here.

> +static void rpmon_qmi_msg_callback(enum rpmon_qmi_msg_type type,
> +			struct sockaddr_qrtr *sq,
> +			const void *msg)
> +{


The rest of the changes to patch 3/3 look good.

Thanks.

-- 
~Randy

