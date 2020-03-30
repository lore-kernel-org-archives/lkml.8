Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF55C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F71206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXK3KCRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgC3BDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:03:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44304 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727815AbgC3BDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585530214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhDQmK8knMvx7axTYBvMjdkY5zqMjvS+uVG/7sLvC9M=;
        b=dXK3KCRXzXmJZHLOwjpOiumso155Yb2xQXDkOyYA3lQmeZtWEklk4tJZ34YDyuXss3uru9
        1PfrIpRuIz4L+V1SQb583jE0te9h0F8m8ixH5Xft3gMGpDUHeIlYNfKOsioOWZhwQ8Ac4H
        Mhc1/i1uoAkHyN2wT0ahqL2hjzl4UGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-XgmSHP17MXGpFKZV1LnHWQ-1; Sun, 29 Mar 2020 21:03:30 -0400
X-MC-Unique: XgmSHP17MXGpFKZV1LnHWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E9AB1005509;
        Mon, 30 Mar 2020 01:03:29 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1609660BEC;
        Mon, 30 Mar 2020 01:03:26 +0000 (UTC)
Date:   Mon, 30 Mar 2020 03:03:21 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Simran Singhal <singhalsimran0@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove multiple
 assignments
Message-ID: <20200330030321.73bab680@elisabeth>
In-Reply-To: <20200325142226.GA14711@simran-Inspiron-5558>
References: <20200325142226.GA14711@simran-Inspiron-5558>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 19:52:26 +0530
Simran Singhal <singhalsimran0@gmail.com> wrote:

> Remove multiple assignments by factorizing them.
> Problem found using checkpatch.pl:-
> CHECK: multiple assignments should be avoided
> 
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 61a9bf61b976..744b40dd4cf0 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -194,7 +194,9 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
>  
>  	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((SIZE_PTR)(pcmdpriv->rsp_allocated_buf) & 3);
>  
> -	pcmdpriv->cmd_issued_cnt = pcmdpriv->cmd_done_cnt = pcmdpriv->rsp_cnt = 0;
> +	pcmdpriv->cmd_issued_cnt = 0;
> +	pcmdpriv->cmd_done_cnt = 0;
> +	pcmdpriv->rsp_cnt = 0;

I think this is better than the original because the original exceeds
80 columns (and looks horrible in general). But the second hunk:

>  
>  	mutex_init(&pcmdpriv->sctx_mutex);
>  exit:
> @@ -2138,7 +2140,8 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
>  		goto exit;
>  	}
>  
> -	psta->aid = psta->mac_id = passocsta_rsp->cam_id;
> +	psta->aid = passocsta_rsp->cam_id;
> +	psta->mac_id = passocsta_rsp->cam_id;

I would leave this alone, because psta->aid is really the same thing
here, it's not just a value that happens to be assigned to both by
accident.

-- 
Stefano

