Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD0DC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8602E20578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml8+pFE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgC3RPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:15:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28931 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgC3RPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585588507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OVuub6JvUfi96XLhyjTFYsOF46LcBuVZlqMIFo1MoSI=;
        b=Ml8+pFE4jDA+wLHq48LOK6tJKXQUaYZenYGC5k3ZQ9HoT3KLph0LGUPurjJGun7MPnwJN5
        HAtZA2Xqi4cXshU/uqDeIQEtyoErMcwHr+pAEoykqsBhLEdInwBSO+wMQ1Iqylu5PiwLOU
        lZofQ2ni+gNyP/dGnkV27CHFiKJSAgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-dH9LHYWXOq28ZFMRDrrxlA-1; Mon, 30 Mar 2020 13:15:03 -0400
X-MC-Unique: dH9LHYWXOq28ZFMRDrrxlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1691E149C1;
        Mon, 30 Mar 2020 17:14:54 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A17195C1B5;
        Mon, 30 Mar 2020 17:14:47 +0000 (UTC)
Date:   Mon, 30 Mar 2020 19:14:39 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v4] staging: vt6656: add error code
 handling to unused variable
Message-ID: <20200330191439.3bfcb658@elisabeth>
In-Reply-To: <20200330164530.2919-1-jbwyatt4@gmail.com>
References: <20200330164530.2919-1-jbwyatt4@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 09:45:30 -0700
"John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:

> Add error code handling to unused 'ret' variable that was never used.
> Return an error code from functions called within vnt_radio_power_on.
> 
> Issue reported by coccinelle (coccicheck).
> 
> Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> Suggested-by: Stefano Brivio <sbrivio@redhat.com>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> ---
> v4: Move Suggested-by: Julia Lawall above seperator line.

Actually, as Julia didn't suggest this patch, the place where you had
this in v3 was the right one.

>     Add Reviewed-by tag as requested by Quentin Deslandes.
>     Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> 
> v3: Forgot to add v2 code changes to commit.
> 
> v2: Replace goto statements with return.
>     Remove last if check because it was unneeded.
>     Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> 
>  drivers/staging/vt6656/card.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
> index dc3ab10eb630..239012539e73 100644
> --- a/drivers/staging/vt6656/card.c
> +++ b/drivers/staging/vt6656/card.c
> @@ -723,9 +723,13 @@ int vnt_radio_power_on(struct vnt_private *priv)
>  {
>  	int ret = 0;
>  
> -	vnt_exit_deep_sleep(priv);
> +	ret = vnt_exit_deep_sleep(priv);
> +	if (ret)
> +		return ret;
>  
> -	vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
> +	ret = vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
> +	if (ret)
> +		return ret;
>  
>  	switch (priv->rf_type) {
>  	case RF_AL2230:
> @@ -734,14 +738,14 @@ int vnt_radio_power_on(struct vnt_private *priv)
>  	case RF_VT3226:
>  	case RF_VT3226D0:
>  	case RF_VT3342A0:
> -		vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> -				    (SOFTPWRCTL_SWPE2 | SOFTPWRCTL_SWPE3));
> +		ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
> +					 (SOFTPWRCTL_SWPE2 | SOFTPWRCTL_SWPE3));

Note that you broke the alignment here: the ( should be aligned with
'priv'. By the way, those parentheses are useless, but it's not
something you should fix in this patch.

>  		break;

Unless gcc whines (or checkpatch, even), you could replace this break
by the if (ret) return ret; below. If some tool is not happy with this,
though, you should still move that here: ret will be checked only for
those values of 'rf_type'.

>  	}
> +	if (ret)
> +		return ret;

Another thing that should be considered in this function is to restore
the previous hardware state on failures, but I think the way you're
handling this is possibly the safest, without hardware to test on.

-- 
Stefano

