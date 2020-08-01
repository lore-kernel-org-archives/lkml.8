Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D00C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0CC2065C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igKbyJXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHABk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHABkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:40:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF3DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:40:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so4790817pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rLc5zOOI1X5bXSasQGNffYuU5drfsVEWlacRgXov9QA=;
        b=igKbyJXLjp3w4yW+Mn72zqJ1sh6INperqmElD6hQ3uNsGOfc2kUNHPrl+dWrZWwpKt
         l9i1kqcHM6w8r0Ls8+pguNnha95AXsaC9Au71UsPIMIN7+r4ny18cukv78hxzhSUkEZb
         gsANol0EnbUzMV/8XmdfZ0RxCMEawM5iz9aamoVijmlxC07NBdox2Atu9QbXAzBn6Apc
         +z9NAlOyIJo9FSoz0vD6KqiObTldKMo6RveMvyJAkDFg547zehfgXElMPPNTUDnukYFo
         /Tt5QPDuE8tP++2TRuRsuvnJ5CXjZwMiB+GgOGniECV4ri0wf4G+ETHEFSxwFXdt/POL
         R0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rLc5zOOI1X5bXSasQGNffYuU5drfsVEWlacRgXov9QA=;
        b=gk1oC8cQCgKgY3XVV2rUvgfSH8VIVV6vyxLQdIcbv8ZHb6xEQnsFUDDbY47xMei2Hw
         7SvylS+FoqOWnwPkazaP36H65tvNoTnH9vaJHr8g+78dQMj/OS7d0HHNVePX25cAPs18
         eS/1Icnpk5gOgseZwtzs1rgYrIsJVSAEr5x5wE6aqIc3wiCONaU2rtgwTknWip/zR4Bx
         72ehVAKKEnJ5J9URWpgNwdLs9vXP0+uWNjiyi7X+4CkpWZc6jyNuXwJkG+fhCXHeRnpm
         E4IZ6VlLw8O7xnzYOmkYbjbntIwI5hf91X+y3Po4xOBakw62gThJH4xD0CGdM6yniyCH
         vi5w==
X-Gm-Message-State: AOAM533qbftWHLI7Gwc2CVVXxwS/+bR/MojIhnX3RCPsIHp1w3vmYvmJ
        9d/S3uzBmEQSrx2GXs6fDKY=
X-Google-Smtp-Source: ABdhPJyTfd1JXapVNv0JT496w7VkrE6AOvkcwKXMDKxRJszZeE6s+kvCBl1o69uiKEs1kK3DMg7i2w==
X-Received: by 2002:a17:90a:c591:: with SMTP id l17mr6449528pjt.17.1596246025161;
        Fri, 31 Jul 2020 18:40:25 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id b12sm12214129pga.87.2020.07.31.18.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 18:40:24 -0700 (PDT)
Date:   Sat, 1 Aug 2020 10:40:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Grant Likely <grant.likely@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Replace custom spec to print
 decimals with generic one
Message-ID: <20200801014021.GC796@jagdpanzerIV.localdomain>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
 <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/31 21:08), Andy Shevchenko wrote:
> When printing phandle via %pOFp the custom spec is used. First of all,
> it has a SMALL flag which makes no sense for decimal numbers. Second,
> we have already default spec for decimal numbers. Use the latter in
> the %pOFp case as well.
> 
> Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Grant Likely <grant.likely@arm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
