Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3FC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35BE20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z02zTU+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgD2N7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgD2N7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:59:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DEDC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:59:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g13so2645446wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=L0M/Hz7+I/UdXagK18Ce5oXQfj/0Us5ua5HiciPb9/I=;
        b=Z02zTU+ku9Z4N9IIyBF7M8br48PlpCDLnYqyg6V3L7Zraj3QRcCeurxDdRObZeGXyo
         jlTxIpCMgkPzHAHlsa59c9XOnPLb4CtL80bMc9vNKKxcOy4RXVJG2rtlryFewS/LNJeT
         lx+UvLYTnSO2dbATVMufvN6qB7G+fjRTBfFEWMe93ssUCoeCKHsu+roc6rwUpObAoXOD
         hE5o7opauPhARywCFhaoqjyLSZmR8JpwhoHlNcihpWCg1aUn8398CfCUtGBNtjBHGpDF
         J4hSOurEaw+mb6sga3VPbxxWOq8bYzfDdPiGXE5I1RCsMLsu8GEHvhwcPAjBy0xz/yDb
         RFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L0M/Hz7+I/UdXagK18Ce5oXQfj/0Us5ua5HiciPb9/I=;
        b=tE5IgXOqLvej0vK1+SLrCxunsI/HPqdAXQsmY6JuOTFj7Jsk6/XEyoZiAbwoAtRqf7
         mvqGXXruFrlgc8X2PxtKHQffttYsWctgzMAb5wI/kwZaZC07fZv9+05aQKjFlljkFXt3
         2eNPfpwvRt65TdNNBlKRrFXX90kHScNUz1zqsjawJ/M5LOe5F8PfPXDhtZMRG7DKVOmn
         bV4Cgczcg4USrH8o15TPYqvBO/EeepkIuii09ns7Cjkmup2NYJSOoahvdpmQgZEI+KFj
         /EI1lLjXU4X5wdZE70DzvyuwcsvYzRCIYSCaoors/KXzoOUt44NYv49Fp1AvDVPUpFvP
         bsrA==
X-Gm-Message-State: AGi0PuZsvl8OEvQtBc3cR2hX64TC7GIf9LZSPBQ4b99Jn2sWHTc64ui9
        LM6Y9wOZEdV9G+ckq7zzQ/c=
X-Google-Smtp-Source: APiQypI6xXPHMUUK1cXtj5FA+qrSY5wl1KCB+ldMqDTMpColnWvnEjH2AUDSQoX6ZDwjC5iOW7K7vg==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr40581816wrx.345.1588168756572;
        Wed, 29 Apr 2020 06:59:16 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id w12sm29796245wrk.56.2020.04.29.06.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:59:16 -0700 (PDT)
Message-ID: <972773563574efe8db63d2fc245c822cc420dde5.camel@gmail.com>
Subject: Re: [PATCH v3 3/5] w1_therm: Optimizing read timing by checking
 device resolution. Updating documentation
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Wed, 29 Apr 2020 15:59:14 +0200
In-Reply-To: <20200429134728.GC2132814@kroah.com>
References: <20200429133320.140458-1-akira215corp@gmail.com>
         <20200429134728.GC2132814@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 29 avril 2020 à 15:47 +0200, Greg KH a écrit :
> On Wed, Apr 29, 2020 at 03:33:20PM +0200, Akira Shimahara wrote:
> > Patch for enhacement of w1_therm module. Added features :
> >  - Optimized conversion time regarding to device resolution
> >  - Dedicated sysfs entry for, resolution set/get, eeprom
> > save/restore,
> > 	and additionnal temperature entry to ease user data collect.
> >  - Code optimization to mitigate bus traffic
> 
> When you have to list different things you did in a single patch,
> that's
> a huge sign it needs to be multiple patches.  Please break this up
> into
> one-logical-change-per-patch.
> 

I will try but this block is hard to split as everything is connected.
I will separate it, but some some patches will be useless if applied
without the next ones.

> thanks,
> 
> greg k-h

