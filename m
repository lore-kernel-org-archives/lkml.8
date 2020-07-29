Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E87FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E4E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mve4bl2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgG2OIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:08:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgG2OIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tSDnY3FzGhTn/u6Pww0mdVOV9X0S2Fmn3lliAT+Fx3Y=;
        b=Mve4bl2GFbwDvP7Jg5gLLLaba0zovwdyHA8l+v5YQu5Q0IdNcyZg+M0hVfxglPqNWbZn9b
        uAEPK2zB9TFZ35n8gWYmEFzYNhDRN+QICSRpibSxknzsgf++EFp4joBITj+l+knBDdZtrB
        rWgbpAOGfoQekostSJ2lyJqGG6EGLJc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-RkHD3W68MHCCGsWEhuXi7A-1; Wed, 29 Jul 2020 10:08:17 -0400
X-MC-Unique: RkHD3W68MHCCGsWEhuXi7A-1
Received: by mail-wm1-f70.google.com with SMTP id h13so621331wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tSDnY3FzGhTn/u6Pww0mdVOV9X0S2Fmn3lliAT+Fx3Y=;
        b=UqjmOw0b6NXGeSNXIn6wyMBSmzOlvktw//ZP6Dfy/Hcy9UVNbn87+X1w2nTwKfc/CN
         3p1S1U1Poywh5xk/QwVRN+WvsY/Omh/f8K7oGVqYt/XAOqlXIUyc9oy+R/H6wJF83otm
         aUOprVa1Z+03+Cnzhs/fdHgj6BxhdyAmxVCTqq7s0uUxsbfhqa0slFXRKqSfCJnCwms1
         0M3iXk9Bwq7WsJoJaKgRTmg8I37pUzNS3FaYmj9QrvVAHEpGvydgq4NYSrJp5rT6WlNL
         51hq9nXWEiecytXQWb4hbKJ+IJBhkPGN8/kCAKaD+a6jbq+xoZ2EYb5Dv9q6GOyHs0lX
         Foqw==
X-Gm-Message-State: AOAM531nKm8BhnHUrUnf9gfVJW204UbcNWV5CfCHW2G1zx7waCFEyC1k
        o0b6Z4ckEIM/c9nOnNNZpXtOftWb4Hsz0BfKBmIt0n1zcpc6wgHHVq04K63MJFb8unnhQJADzpv
        XZI5tWZwIK4eCGfZcWMwSx1ky
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr6450730wmg.69.1596031696040;
        Wed, 29 Jul 2020 07:08:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZx2GDeOT4xiXXkyJbtLRy1H/T+pPmI/LpfhQCdBFqN5vPspeNyXF/MgS2kwoyjVW/b1BjZA==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr6450724wmg.69.1596031695863;
        Wed, 29 Jul 2020 07:08:15 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id y2sm5487847wmg.25.2020.07.29.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 07:08:15 -0700 (PDT)
Date:   Wed, 29 Jul 2020 10:08:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20200729100754-mutt-send-email-mst@kernel.org>
References: <20200728181132.55476e07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728181132.55476e07@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:11:32PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from drivers/virtio/virtio_vdpa.c:17:
> include/linux/vdpa.h:43:21: error: expected ':', ',', ';', '}' or '__attribute__' before '.' token
>    43 |  bool features_valid.
>       |                     ^
> 
> Caused by commit
> 
>   fee8fe6bd8cc ("vdpa: make sure set_features in invoked for legacy")
> 
> I have used the vhost tree from next-20200727 for today.

Sorry by bad, pushed to a wrong tag.


> -- 
> Cheers,
> Stephen Rothwell


