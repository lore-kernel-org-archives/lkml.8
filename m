Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA69206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8nyKnMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgFIMSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:18:20 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5E8C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 05:18:20 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b8so18548737oic.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 05:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diyIqg/YdYbqBJPOkwtPueBHlI8972XoeD1BVsHLbSU=;
        b=l8nyKnMC7hhus1agO0lNbRDnFc9/loLYlG/KrH6hup+C+q4TFx3cxcds2pr/j8QDPM
         CcEIh15lt+pnPkTiwtOuriZ8bc/P0HHSX9cAK0DJ1BXrHjquME6C1+GbzJKgAzRoxbvU
         4iPOli1lKZBx5oUC8FPokD2znTrQOWld8GrdZBa3NMoh0RF/dEPpBoYEn8qItkJcoq8I
         KVdyPZcIbMx5J7hxzTMH3HYW54QNc3x3DVZZH4/+EkEDIeCGDO5io0V0S41ks0Jkn0lK
         iHNFmGDTE1uWLHm9EkXlP8CXXY7AgTFIP0Z8/k2mtAFm5u4CofQU+NM3Sgy4VfzlIFMo
         XnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=diyIqg/YdYbqBJPOkwtPueBHlI8972XoeD1BVsHLbSU=;
        b=YaBsnkBcDdjDp55CQShmaIffNYSvhcNEPAKHuwhZNWJdsxtzwhpcpmgHPlgsOpHv9O
         9SRfJy+R7zDR2pGP2Dqt5QWXXhgWWhfSULDueNTDHgvYPXKxHY24GF5uc5Sl9uDPvMwi
         a7qnuvFUv6nFXGxsE1+nq+ITS0RgNAosEG8kXn7ySUNedK80xyKAlK9XYO3r4Unqs8w6
         gUgoqR0H58TbqhILJayVQZ1ftNYeQgBP6rwes4G+oILOVBrXdgc5cvQ3tM34QyM2cjRN
         v8tlJ0vTx2uqN9V+KB6CU90sLMf+zP5MNi0OUzSJ8yT8j5jkPuLOesawhtulCjGrJGuj
         o4Fw==
X-Gm-Message-State: AOAM532L6u6f5opZ8stvvueuuCJfQr2sUnT7f+7YSdMF70yvauPr3emA
        0vf4cwyhEbXNAbl0f59mAA==
X-Google-Smtp-Source: ABdhPJyvR7IKu301M8N4TqZSYI6ZEFPj/D5Lldpot8l0vp+QUU17Eb/9LI6ff0nkiZqBVb/NrExfBQ==
X-Received: by 2002:a05:6808:b35:: with SMTP id t21mr3189220oij.86.1591705099437;
        Tue, 09 Jun 2020 05:18:19 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id o4sm3130595oib.53.2020.06.09.05.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 05:18:18 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:fc6b:eb5f:1e23:4ea5])
        by serve.minyard.net (Postfix) with ESMTPSA id AA196180050;
        Tue,  9 Jun 2020 12:18:17 +0000 (UTC)
Date:   Tue, 9 Jun 2020 07:18:16 -0500
From:   Corey Minyard <minyard@acm.org>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: code cleanup and prevent potential issue.
Message-ID: <20200609121816.GS2880@minyard.net>
Reply-To: minyard@acm.org
References: <20200609060410.29700-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609060410.29700-1-wu000273@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 01:04:10AM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> All the previous get/put operations against intf->refcount are
> inside the mutex. Thus, put the last kref_put() also inside mutex
> to make sure get/put functions execute in order and prevent the
> potential race condition.

No, this can result in a crash.  intf and intf->bmc_reg_mutex will
be freed by intf_free.  In fact, every call to kref_put() on intf
better be outside any mutex/lock in intf.  If you saw any, that
is a bug, please report that.  kref_get() is fine inside the
mutex.

Plus, this is not a race condition.  get/put is atomic.

-corey

> 
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index e1b22fe0916c..d34343e34272 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -2583,10 +2583,11 @@ static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
>  			*guid =  bmc->guid;
>  	}
>  
> +	kref_put(&intf->refcount, intf_free);
> +
>  	mutex_unlock(&bmc->dyn_mutex);
>  	mutex_unlock(&intf->bmc_reg_mutex);
>  
> -	kref_put(&intf->refcount, intf_free);
>  	return rv;
>  }
>  
> -- 
> 2.17.1
> 
