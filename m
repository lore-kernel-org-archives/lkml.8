Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CCDC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5677A21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg1uMgVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDSRzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:55:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbgDSRzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587318951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mX8cAWtGVYcEAdopl0xBwG41RjLtOiyjKvK1kLIQc90=;
        b=Sg1uMgVI4IlTbWyGU4vSNxIK9gevpGRotkQ5dGNMMEpxE+sCcbG6gCAl1IEvKxjfUKNFxx
        b8Ku+SR4zVPeP2j9NAxs9itMhRrGMCJItDV7RLCS5t/KaNgvUL6+Ri+X7/VLZtsVEe4TKU
        r1enCs90MsL14WRSvMahOb6+Se78nfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-0PbGig6FOwmZgAQBZC7YiA-1; Sun, 19 Apr 2020 13:55:47 -0400
X-MC-Unique: 0PbGig6FOwmZgAQBZC7YiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50C4C800D5C;
        Sun, 19 Apr 2020 17:55:45 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C2E3A1055;
        Sun, 19 Apr 2020 17:55:40 +0000 (UTC)
Date:   Sun, 19 Apr 2020 19:55:34 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        "John B . Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Refactor the vnt_ofdm_min_rate
 function
Message-ID: <20200419195534.1463ddcd@elisabeth>
In-Reply-To: <20200418134553.6415-1-oscar.carter@gmx.com>
References: <20200418134553.6415-1-oscar.carter@gmx.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

On Sat, 18 Apr 2020 15:45:53 +0200
Oscar Carter <oscar.carter@gmx.com> wrote:

> Replace the for loop by a ternary operator whose condition is an AND
> bitmask against the priv->basic_rates variable.
> 
> The purpose of the for loop was to check if any of bits from RATE_54M to
> RATE_6M was set, but it's not necessary to check every individual bit.
> The same result can be achieved using only one single mask which
> comprises all the commented bits.
> 
> This way avoid the iteration over an unnecessary for loop.
> 
> Also change the return type to bool because it's the type that this
> function returns.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/card.c | 11 ++---------
>  drivers/staging/vt6656/card.h |  2 +-
>  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
> index 9bd37e57c727..adaf93cf653a 100644
> --- a/drivers/staging/vt6656/card.c
> +++ b/drivers/staging/vt6656/card.c
> @@ -248,16 +248,9 @@ void vnt_update_top_rates(struct vnt_private *priv)
>  	priv->top_cck_basic_rate = top_cck;
>  }
> 
> -int vnt_ofdm_min_rate(struct vnt_private *priv)
> +bool vnt_ofdm_min_rate(struct vnt_private *priv)
>  {
> -	int ii;
> -
> -	for (ii = RATE_54M; ii >= RATE_6M; ii--) {
> -		if ((priv->basic_rates) & ((u16)BIT(ii)))
> -			return true;
> -	}
> -
> -	return false;
> +	return priv->basic_rates & GENMASK(RATE_54M, RATE_6M) ? true : false;

priv->basic_rates & GENMASK(RATE_54M, RATE_6M) is already true if
non-zero and false otherwise. Note that I haven't checked if the
rest is correct.

-- 
Stefano

