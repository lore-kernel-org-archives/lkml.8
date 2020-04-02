Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ABFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA342072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/Nrj35p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390283AbgDBXvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:51:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46762 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390216AbgDBXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585871472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqJ98zPhLM+tdJlzifCE4+/QdEj75kGr2F6hTOU45+E=;
        b=V/Nrj35pCrHd54ozjeoGshcHKPYYyGUZN4T6zy63a13U0h9g2nsdsF1iQNM0piKnoRWlha
        o6m2Q39P/wEemd4oKVXuTlKaAaQAhBQaBktL7x0UyzKCZ82zWPZt3Sz/JVXhIo4rAFx1hX
        coBZ1ilbpvNMPxccu71AkQOETkF65Lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-mUOBEZTRM_yz-7_vQJAxXw-1; Thu, 02 Apr 2020 19:51:10 -0400
X-MC-Unique: mUOBEZTRM_yz-7_vQJAxXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA2ED107ACC9;
        Thu,  2 Apr 2020 23:51:08 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E03A21001B3F;
        Thu,  2 Apr 2020 23:51:05 +0000 (UTC)
Date:   Fri, 3 Apr 2020 01:50:57 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: emxx_udc: Remove unused
 code
Message-ID: <20200403015057.7a972c79@elisabeth>
In-Reply-To: <20200402021706.788533-1-jbwyatt4@gmail.com>
References: <20200402021706.788533-1-jbwyatt4@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Apr 2020 19:17:06 -0700
"John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:

> Remove unused code surrounded by an #if 0 block.
> 
> Code has not been altered since 2014 as reported by git blame.
> 
> Reported by checkpatch.
> 
> Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
> index 9c2671cb32f7..bbfebe331033 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.h
> +++ b/drivers/staging/emxx_udc/emxx_udc.h
> @@ -9,12 +9,6 @@
>  #define _LINUX_EMXX_H
>  
>  /*---------------------------------------------------------------------------*/
> -/*----------------- Default undef */
> -#if 0
> -#define DEBUG
> -#define UDC_DEBUG_DUMP
> -#endif
> -
>  /*----------------- Default define */
>  #define	USE_DMA	1
>  #define USE_SUSPEND_WAIT	1

Formally, this is fine. But... think about it: this driver might be
rather buggy, so the first thing one might want to do with it is to
"enable" those two defines.

In general, that stuff has to disappear, and proper debugging
facilities have to be used, but with a driver in this state, as long as
proper debugging facilities aren't there, you might be doing more harm
than good.

-- 
Stefano

