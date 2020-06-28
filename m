Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D1EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9BF20768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="F5wASf8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgF1Axt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 20:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgF1Axs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 20:53:48 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C519FC03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 17:53:48 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n6so12242681otl.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsJk0nfkSz2k8aqVeyIdgKyPII2GCP1n1XDCy7YehbI=;
        b=F5wASf8Fri/sqqZ7S2mvoeuV0cp88s2puvIaVhgk9pu0s3AK85cOQNvQmuJFXIXbP0
         K5O0fqTjeahCeeR4H5+T8jsxwb9p45cXU4aPr58kx3XQr0xPZfF0VGCTCRb4XXKXYzHG
         fTn9dh/vejm9BxHLOygA1x9Ij9n1HqRbvbjyHcNJ7l7tVJnj91fp5IQOwWtatuViqJn1
         jlQv/3C20RVn7epNlE4V/jRuilY8ncA9VhUwahS6YW7s0cm6CGLafzuTNc8N9GQwMA2D
         79GJTsnSiE2fMqtSVkfzse8n4EY1ATIwlNMXzf5a1RBLzxpBEL68NexetNvHfFTEUh3n
         0rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsJk0nfkSz2k8aqVeyIdgKyPII2GCP1n1XDCy7YehbI=;
        b=KdHaD6X5BrqLN9Tzj2/jovuTNxQRjCjdFRjaZU6HpJmmRZmFzocjcoV2ZgOjzcIuOw
         SIXDVZ95i2igwdNU+UBtPaQ5s3hoPOZY5IMw+IcJhXYUb+lTUB9oLZIktoJjUNYb5v/u
         5c70OpzQ+TnRqFY5d8lkdS+VYx4xTJu5COoOUs4beo96wYp0aK2F3nuR2d36uYFVAwy6
         2nwHEYkVtEJPsJq2h+Qzp77esuqMh2/Rvk1G/cM9ySxZRC3OQvHRAIJ+swVKvLuKJd2x
         ei8v0TfLnUcMfjGmwaQ3e1GCBQfidnR9CUpxjlt4vvIZ6/S+73l6nhnwgewdnroTIy/G
         Qf+A==
X-Gm-Message-State: AOAM530Ik1LRg6EKGcTSDaEPItoyJ3jh7oaNADlMPTu9IxASknJfgbgg
        0c2doYIz/AyapcwDXkXj0UFcy/1GGYM=
X-Google-Smtp-Source: ABdhPJyBBcuzNGLXgjXTTaFdvlSaAnU4ny+EPV2T61ymbabLc9jUaNqol49OUnUhrbe5fsPKNwvoOQ==
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr8226679otr.220.1593305628000;
        Sat, 27 Jun 2020 17:53:48 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id 62sm1639011ooa.25.2020.06.27.17.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 17:53:47 -0700 (PDT)
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
To:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200626080717.1999041-1-hch@lst.de>
 <20200626080717.1999041-10-hch@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <e908f620-62b8-f106-a1a8-9887f50216fd@landley.net>
Date:   Sat, 27 Jun 2020 20:01:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626080717.1999041-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 3:07 AM, Christoph Hellwig wrote:
> The code handling non-coherent DMA depends on being able to remap code
> as non-cached.  But that can't be done without an MMU, so using this
> option on NOMMU builds is broken.

I'm working on a nommu j-core board that's doing DMA behind the OS's back at the
moment, which I have a todo item to teach the kernel about. The DMA does not go
through the cache, there's currently a cache flush before looking at the result
instead.

How should this be wired up after your patch?

Rob
