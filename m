Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F1BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607D620753
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XPHD3K7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCQTck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:32:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40110 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCQTcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:32:23 -0400
Received: from MININT-65B7IF6 (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 783E120B9C02;
        Tue, 17 Mar 2020 12:32:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 783E120B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584473542;
        bh=3tZiwgRbA7qaKAe36493vOXQ/2f0fxvWfm7urZH36NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPHD3K7EWZ+mS0qZXH0ge72ggRiwWX6nRvHt72ANWaqbC8OmVn2LjKqixY8ag2Fjw
         EGRdhxjY69j/YNfezP7P+zIRC4gUZ1UBG02IcB0knYCwcdLuv8i+oDMwne0Cx4MI5p
         FSMYYKhKFszKonv59NhC+kZLStRNzXYLyGiDugv0=
Date:   Tue, 17 Mar 2020 14:32:20 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v2 1/1] firmware: tee_bnxt: remove unused variable
 assignment
Message-ID: <20200317193220.GB708@MININT-65B7IF6>
References: <20200317095037.22313-1-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317095037.22313-1-rayagonda.kokatanur@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-17 15:20:37, Rayagonda Kokatanur wrote:
> Remove unused variable assignment.
> 
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
> Changes from v1:
> - Address code review comment from Sergei Shtylyov,
>   Correct the commit message.
> 
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
> index ed10da5313e8..6fd62657e35f 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -143,8 +143,6 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
>  	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
>  
>  	while (rbytes)  {
> -		nbytes = rbytes;
> -
>  		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
>  
>  		/* Fill additional invoke cmd params */
> -- 
> 2.17.1
> 
