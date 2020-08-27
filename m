Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327ABC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26C920791
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaSyKh7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgH0Q7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Q66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:58:58 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A166C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:58:58 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x7so2929029qvi.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=4lP1m2wCcvTQNwrrvMb+fUlGbZ8odWO50SoVe80zCxo=;
        b=kaSyKh7HI3u4s0eBdtnJNK0ZUKE6CNMcz+NZdiygEczZb899X3Nk/Y6QgofhiDNtz9
         AjV8YF7raIJLEextGFFfITIIjqIvH6s9kQK0CVxQxXxy0EfmVa/YEfxinqX2HWivu5Lj
         gUbULS7BK9n9c9SzSBvy+j4xZWiHZ2/xSDDq9bQy5qb5/UlSxJPQbBmvK8A2BY0sZBi2
         RQGIjkmM+VEhFDPQXBbtdQ7dG8YE4R2xLWyxw7cNKXJEEeuHWFL10o4mOoJ4XU7w1Bjg
         5GYuBWtoBK0gYnrfUv09mQAI9lKl6FPhWfxG4lkUe/H3zgH9FR+vfyNh8suI34rZZYGo
         oKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=4lP1m2wCcvTQNwrrvMb+fUlGbZ8odWO50SoVe80zCxo=;
        b=AswpP6+z9weOhsK735k56Rmrai25kpHh1Cn03YIMUXVOxji8pgAH7FiokFNhlWy5HP
         J0QS1ziAvyFK5ntNC47dY7WmpNH9AP9+Kiq83HSWxJbxjoFOU+n18PtAkJIrdkw4yc85
         JqCh/3J0my6/xaLe172Rmial45ihESql0Yfy/57fUfKwQQUYMDF0wiiTMi/Po4JpRVhY
         uiPUJZLVVPThP3HIPLhXuKqF2786OEoc1629RKjo9SgH+nJbMfjYOkBYEClIFxEr6wb5
         RP8yBTa9wXThbTvmlwgLoz0mnO4h151voatLFPUkt0YCy6KjZoB++sRc52wmXuYzOnVr
         34mw==
X-Gm-Message-State: AOAM533Do2nNx1QeuOJS9FXfc2BTkDixH/lsce/Ud6PFrelaQ4X17a/l
        Ok1mESsrtYsybitMsWRxI8Q=
X-Google-Smtp-Source: ABdhPJzX3nUlPhvQfJkPj4YVC3ZQ/pGZthIDM2Mr08cuHyjfc7B0y0K2pF7+ktofBB5ccGMqeaY/kw==
X-Received: by 2002:a0c:ca86:: with SMTP id a6mr19570503qvk.209.1598547537653;
        Thu, 27 Aug 2020 09:58:57 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id g13sm2119490qki.62.2020.08.27.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 09:58:57 -0700 (PDT)
Message-ID: <c2d2974f7fd46f54c2cf690b48b9ace35257baed.camel@gmail.com>
Subject: Re: [PATCH v1 03/10] powerpc/kernel/iommu: Use largepool as a last
 resort when !largealloc
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Aug 2020 13:58:51 -0300
In-Reply-To: <75fb1e8b-2506-ffd8-64af-4abfefe03d2f@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-4-leobras.c@gmail.com>
         <75fb1e8b-2506-ffd8-64af-4abfefe03d2f@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-22 at 20:09 +1000, Alexey Kardashevskiy wrote:
> > +			goto again;
> > +
> 
> A nit: unnecessary new line.

I was following the pattern used above. There is a newline after every
"goto again" in this 'if'. 

> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thank you!


