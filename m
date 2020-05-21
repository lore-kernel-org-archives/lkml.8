Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B310EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AAD920756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b/hWi2PD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgEUUhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:37:32 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48008 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:37:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LKbSm1048692;
        Thu, 21 May 2020 15:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590093448;
        bh=9xP5vfoBO+4BJ4jvW3objaO6eouH59qs+QM52qR8o3M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=b/hWi2PDFf0VSW2yJawZ9W2H2iAfh74UixmbprqMb+4CTu8dY2EItfrV99ePrzmQ0
         jjNwTxIHNdFt4t/UElwxtNZUE29emuVrZoyBtbhEG38MoxAvRHKeq+9o5AikPB+I/b
         W7BtoKvEPU6yNq2Ly0UldLf0/P1lnMT0t4p7f410=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LKbSLW089527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 15:37:28 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 15:37:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 15:37:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LKbSOO098116;
        Thu, 21 May 2020 15:37:28 -0500
Date:   Thu, 21 May 2020 15:37:28 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     <kjlu@umn.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix runtime PM imbalance on error
Message-ID: <20200521203728.GB25575@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200521073547.18828-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521073547.18828-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 21, 2020 at 03:35:47PM +0800, Dinghao Liu wrote:
> When copy_from_user() returns an error code, a pairing
> runtime PM usage counter decrement is needed to keep
> the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/usb/musb/musb_debugfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
> index 7b6281ab62ed..837c38a5e4ef 100644
> --- a/drivers/usb/musb/musb_debugfs.c
> +++ b/drivers/usb/musb/musb_debugfs.c
> @@ -178,8 +178,11 @@ static ssize_t musb_test_mode_write(struct file *file,
>  
>  	memset(buf, 0x00, sizeof(buf));
>  
> -	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count))) {
> +		pm_runtime_mark_last_busy(musb->controller);
> +		pm_runtime_put_autosuspend(musb->controller);
>  		return -EFAULT;
> +	}

Thanks for catching the bug. Can you please instead move these lines to
the beginning of this function so that pm_runtime_get_sync() is not
called if copy_from_user() failed?

-Bin.
