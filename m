Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B90C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECBB20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apcd/jrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgEDKZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbgEDKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:25:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB324C061A0E;
        Mon,  4 May 2020 03:25:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so5310050pfd.4;
        Mon, 04 May 2020 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9wnMZ43MKMfGfmsGbZr1Yrv0Rj1fcakpKjTV0EHXm4=;
        b=Apcd/jrQOtvxLSEHY9l71zo89xu6FhwfBU+BGiIZ58fyWkBcdEbGcVj+bg9UQfKcBU
         CPQXfzvzs0/CqfQYUtWM8pv2F6MEEdCSwfQss7VrB/LmoqBDz91D4VvwGvlZ4hiF2tOa
         flhoSIfyLfhHb3rDO9gYuyucbbTgirGqnyUy5C52JuwKtm/eorD9byBwfUbz4SQj/7US
         9DPcyD/c5fZOiIfcY9SX0qo/0ToVkw1xcQLymClixTPeo+/LwEUVJf/uW2Gp9hPwLBrm
         Vl4+e6uv/808rVzdviMUyGh6zYtL5WQ9XTr0iggWgg20l5IaZC1bp/GEcjcumoO43Q9w
         p3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Y9wnMZ43MKMfGfmsGbZr1Yrv0Rj1fcakpKjTV0EHXm4=;
        b=kR2JPIX4GSGTajok9ZyOHXS93anJmBybwE0ao3eW27aFXzDnNPviXT2qE409CfIxqa
         3OUQvSvldEuetTXX8M1Ul5punaE6GbjYaaoQHuyBIJ+wP79xE11GLuUSZYed4hp9nP8u
         dRdKy0I44mpjSjWJJsMVmmN3FUxzzifZ6R2Czh+wwf6cGS4uvcxBJnH8+PU7UabogFNA
         iOis3WHqnEERJAT2pi23HhEts6ZYRz2pszAomZScJWD7AMo5CRK07AFuxl5AToeNXJCw
         TjiytEmwXL3QdUjxSWT5uWdhvkGElGAnmxiG841H85IVcB2kf2vs5/zAw5g4f2bFQYI+
         PLUQ==
X-Gm-Message-State: AGi0PuYBlK1zcuxmskciCMvipBQf02S8LUD8MHHYJoQKW7m+PEAZXp79
        vfxWlhxHcu741aeEBnmDHyhWPn43
X-Google-Smtp-Source: APiQypICLxpZ6l320rFLm6mz0/2GQh/UZ767zlMnQDxjz8CaMmfx027gYnaOufl2FaegWAdc4gpx/w==
X-Received: by 2002:a62:4e87:: with SMTP id c129mr16678739pfb.178.1588587906241;
        Mon, 04 May 2020 03:25:06 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.67])
        by smtp.gmail.com with ESMTPSA id w12sm8428885pfq.133.2020.05.04.03.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 03:25:05 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 044AMlXC013687;
        Mon, 4 May 2020 18:22:47 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 044AMguH013686;
        Mon, 4 May 2020 18:22:42 +0800
Date:   Mon, 4 May 2020 18:22:42 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH v6] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200504102242.GA13013@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
References: <20200504082002.GA29972@udknight>
 <38251b1f-e89b-7b3a-6045-f5ce1dc2596a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38251b1f-e89b-7b3a-6045-f5ce1dc2596a@web.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 11:45:02AM +0200, Markus Elfring wrote:
> 
> >  4: Add support to check and emit sensible diagnostics
> >     info for description which spans across more than
> >     two lines.
> 
> My software concerns are growing also for the preferred dependency management.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=0e698dfa282211e414076f9dc7e83c1c288314fd#n138
>

Hi! Markus Elfring

This feature is a side effect of missing right '")' detection, so I think
it is acceptable to add it.

But I agree with you, this patch is a little big, I don't want to add more
code into it.

Joe, what is your opinion? Do you think this version is good enough to merge?

Thanks!
