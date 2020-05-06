Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D337C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163802070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLPzDp2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEFKnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725824AbgEFKng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:43:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19CC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 03:43:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so2075949wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8kGM2QZr0ji3lOKAwGd4O6nutmjEybLwciOOExBgdNA=;
        b=nLPzDp2NQRB3L4ieT1/ZT+s8ig5YUjtbiVv50gPxzYvx6+WeKm3aEtuH/ErfRYD/hU
         qyJRP8lul9aql8KvjEZArYPjaLi4WGb3tZDjhksUTiv7NXR+OWL+3BGh+YMIE3H3WzM8
         5ZlwVdIiQNFjsOGAdlb1YmiARwWEjzcfUukqrVQP+DnJNKYKclhgAQ7wkCnMTktiq1zS
         cZ/YFSRSGhD7z7qlxNsPf4OUMYLUOGw63RKW+8Jz1P7BkcA3ackpgWzgMykOdraiS0a2
         beerSP1nqzpPK2O/wHgtPO5pBrKe6dAvShkE4Pn+OdjK24vVVmSXnz/cVUJbVC9GVj3d
         e2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8kGM2QZr0ji3lOKAwGd4O6nutmjEybLwciOOExBgdNA=;
        b=NTf/0tDAz6gPE+1ixztA4t6tnx/8r4shnibKjjk2BnKyiRX6qDLFJoPDlVNd1ntYWe
         tqFEYgfu8Rjxc9c8n4KPYusQD+bpnAAMHh7c/S7qcgRPprKuraCYeXx7kOblrQQbFY9y
         FILNvjWwN5GLnKEuP8BKPJOJD9ypdMpTc1Jsx25gPpYMtDCxmFnTVOnPod02OqZghZzI
         n7CCyj7K90WC7C0Ef7jOOvfhmDml6g1G1T0kjkIi5XJ+w36ic/84UnzcFnprY9aZKJOf
         76/OVF/qu/OwakCJn3Vju8tAZqUcWE6bU9p9FHkM8UO3PbYte9Yzu6a95Lob7FrHWAse
         T6VQ==
X-Gm-Message-State: AGi0PuZ3jGpGo4Nro+kdfcaySfOydRL4v9BqgVDv9FaqxK4mRalbRJYt
        zGTlL+a9F8M/69UiI980H17di6T5
X-Google-Smtp-Source: APiQypKrkm8dOqjUBo6N9uzx4YIqwV7W9iFBlZcfF1Bng8zzCqEmLqOip2YNbtd7hAqVqs0FwmiyMQ==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr3899234wmy.13.1588761813741;
        Wed, 06 May 2020 03:43:33 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id j16sm2055445wru.13.2020.05.06.03.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 03:43:33 -0700 (PDT)
Message-ID: <56b06ae0d110d650e65e4ed72fd44f870997893f.camel@gmail.com>
Subject: Re: [PATCH v4 1/9] w1_therm: creating w1_therm.h
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Wed, 06 May 2020 12:43:31 +0200
In-Reply-To: <20200506065134.GA2279499@kroah.com>
References: <20200429225915.198956-1-akira215corp@gmail.com>
         <20200505144811.GD838641@kroah.com>
         <d4a8e881f2f715f17254a840a9a05b088146c2aa.camel@gmail.com>
         <20200506065134.GA2279499@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 06 mai 2020 à 08:51 +0200, Greg KH a écrit :
> > > Why is this function needed to be declared in this .h file?
> > > Why is any of this needed?  For some reason I thought you needed
> > > a .h
> > > file to make things simpler for other .c files, but if all of
> > > this is
> > > static, it's not needed at all, right?
> > > thanks,
> > > greg k-h
> > Hello,
> > Yes, you are right, header file could be avoided. But we separate
> > it
> > from .c for clarity purpose, and to ease future developpment (for
> > example adding support of new devices).
> > If you absolutely want to put everything in the .c file, I can do
> > it,
> > let me know.
> 
> 
> Keep it all in a .c file, only use .h files for when you need to
> share
> 
> it across multiple .c files, otherwise it's not needed.
> 
> 
> 
> thanks,
> 
> 
> 
> greg k-h

Hi, 

Ok well noted, I will do it tomorrow, and keep it as 8 patches.

Thanks for your time

Akira Shimahara

