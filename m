Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A0AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EF520748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8izmvOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGAT7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGAT7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:59:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C3FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:59:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q198so23462158qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=1KDftEyYVRiS9ZEzfScQMAJ2sbqz9RMLT/3XY4aQ61g=;
        b=R8izmvOsjShErqn7Oa8o40j+Fu8NE1UX2e9H71y/iTbqbAGQStg+JvbPgX4SJ1BiPL
         awHqBbs16V7lWIJVV9ZbdWySup4WrCttq32FRTa5dAzV/hcfauZSDlpaFXmuL8DAe8Gp
         AuBQJkGA7LiNNLGSNifvfD0KJB2vjOmWm4MAroXtMQTst0OY/qOs5xxFjXH8Uk5Byi/a
         nsZBEAWfKfF9fag6dA+oyMYAUyA+DhXdpk+LDTr32pI9IpWp2S0lbiKCSGU1k9qaTL1Z
         qspnBqSNrL4F6C96CoI2sV2MDIZXdr5jznXIVfKmJ8mQfrCcEYXdFE4jBZOGL7T7wbIN
         b5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=1KDftEyYVRiS9ZEzfScQMAJ2sbqz9RMLT/3XY4aQ61g=;
        b=qCiV3f2tT9q8usha+MJL2FGXL/fEA4uWOXljg2w/lp5P2En7P/gvoQWwwyqn3GpvYU
         y9rvgMGzi0myqD1dPYHqi2I9D0PUzcmkVlwEBA2s/LpWyyWXzofmG+3YeGzy0H3B8Boq
         TMn2NVRW4P8HTzkG1ocWIUx/EtIy5AWf8Jgmy0dFHRqJtilUsCFL7ihHm4/UnQi3NbmR
         eeXGIWVA2x8Ul/lEwC3h79BEtgOY/V9VyK5uzxs97X2V+a9NlzToHN8tkQw/uSjR0gbQ
         wJTokcg/rSeZi8o/xBwHCSuG/wo/RQ38t943ibLyZyXowlzUPe8A6mVm0O9dk7QpHIpd
         lxLA==
X-Gm-Message-State: AOAM533ty/La2E0jjPPXCu1kKnIrvoFpQ8y5zhRMjb9goPzWn00x/BEj
        AKGCAdCTT+0A5qBAARiOYdA=
X-Google-Smtp-Source: ABdhPJzpE22b15q/w6oFEQhSU2P63xA5KfnWuBl6ktUwg9E/2QuaJ/Nacnp7SIJSh5bQr2/Tp18tkw==
X-Received: by 2002:a37:b4f:: with SMTP id 76mr25159611qkl.283.1593633582779;
        Wed, 01 Jul 2020 12:59:42 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id m26sm4445117qtc.83.2020.07.01.12.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 12:59:42 -0700 (PDT)
Message-ID: <ca699edfe2382bef01d1af26b5c7264571ef6adb.camel@gmail.com>
Subject: Re: [PATCH v2 6/6] powerpc/pseries/iommu: Avoid errors when DDW
 starts at 0x00
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 16:59:37 -0300
In-Reply-To: <76047748-9ddd-5ba3-fe4d-85c7c08bd521@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-7-leobras.c@gmail.com>
         <1069466fa3a373e92d9db18957674b1d9c6e9cf2.camel@gmail.com>
         <76047748-9ddd-5ba3-fe4d-85c7c08bd521@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 18:04 +1000, Alexey Kardashevskiy wrote:
> 
> On 27/06/2020 03:46, Leonardo Bras wrote:
> > On Wed, 2020-06-24 at 03:24 -0300, Leonardo Bras wrote:
> > > As of today, enable_ddw() will return a non-null DMA address if the
> > > created DDW maps the whole partition. If the address is valid,
> > > iommu_bypass_supported_pSeriesLP() will consider iommu bypass enabled.
> > > 
> > > This can cause some trouble if the DDW happens to start at 0x00.
> > > 
> > > Instead if checking if the address is non-null, check directly if
> > > the DDW maps the whole partition, so it can bypass iommu.
> > > 
> > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > 
> > This patch has a bug in it. I will rework it soon.
> 
> I'd rather suggest this:
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20180725095032.2196-2-aik@ozlabs.ru/
> 
> Although it does not look like you are actually going to have windows
> starting at 0. Thanks,

Yeah, agree. 
I am thinking of dropping this one, as I don't see much good to be done
here.

Thank you!

