Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DF1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076A6206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmQEDJ+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404560AbgFXPyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403931AbgFXPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:54:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:54:34 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dp10so1245460qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=lmNn6SOg+iGo/AZoFdJRg2LN4pLoxSmdOUox+oISJgI=;
        b=pmQEDJ+evGmXzq1+gJkbVL1QfKvG/jhYeTJnUDByq4d3dSEiR+GIzjvMRHY0QO1TzM
         Fic33wfWhRKKoCkOP6ef+MJH3IVc8GwIh9x9K6kSYXPl6fuHKT/2MGj957huw2sDoY5+
         c10g11WvbRegXG3+mlIJhcxU6k3FEhnRVdYBJbaEv6kINwZJgi0lh71mh1c6dMnm7vGN
         ajF9QmMxJeLwuT44jSfHdyZRQTRC4ug8XQvwJDGN1y5XmUXWHHCYN1KyBgWfr6ZlGZUC
         NZhWDmJ5xkZ4LG5vatUfzkN3l6KYUz4kRyoYv8tpt6JMZSkOUz8PUelWNcysK+Sy6gSq
         aXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=lmNn6SOg+iGo/AZoFdJRg2LN4pLoxSmdOUox+oISJgI=;
        b=LFvGgDgtHuf049J5kJ40Gb+ohR100X+SQ/drH8+HL+BaObIODcJczCIGTJmve5YsnX
         SaBmwQ1wi+VA8lmkQcOQ3asJ1wmthMQIbT+oJJlUz/f5DvBbhmGG7GGVIMJ9LseYggL7
         Z/A0RYbsakx7K7yzTJTKDhUA0g783RgAeoMkk22g+Nxit3fQpS7IgpyCUgxWMFbPGppo
         f++3FSJpcwqYFHYJX5EylWjtyWldM1EffuN1Wa4Twz+AAPDzbOoO1x6WMxbGYW4H9jZX
         Q69zlczCVGByv42c6VjNp0P8SCYHEg1KbJVOpFazvha2ry5/W12SFGvo0RpLp+P3dFqj
         b+pA==
X-Gm-Message-State: AOAM533TFxQiTlb9zvyhOb0DBUNp35Wxna1H08iI/ObxR2/5scoYhZuv
        tah23my08e4BrrP57J9Z6XQ=
X-Google-Smtp-Source: ABdhPJxloKYFmRNGH+D28ZTAD7Xjz77cZ2kdySGmmSCoWbHRrbHgLzdbfPq8C1HSE2qYw1m/UqaW2Q==
X-Received: by 2002:a0c:a9db:: with SMTP id c27mr20043813qvb.204.1593014073765;
        Wed, 24 Jun 2020 08:54:33 -0700 (PDT)
Received: from LeoBras (200-236-242-115.dynamic.desktop.com.br. [200.236.242.115])
        by smtp.gmail.com with ESMTPSA id 16sm3427740qkv.48.2020.06.24.08.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:54:33 -0700 (PDT)
Message-ID: <3d821b4d2a348519e212f44108662da39a9fbdbb.camel@gmail.com>
Subject: Re: [PATCH v2 0/6] Remove default DMA window before creating DDW
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Jun 2020 12:54:27 -0300
In-Reply-To: <20200624062411.367796-1-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 03:24 -0300, Leonardo Bras wrote:
> Patch #5:
> Instead of destroying the created DDW if it doesn't map the whole
> partition, make use of it instead of the default DMA window.
> 
> Patch #6:
> Changes the way iommu_bypass_supported_pSeriesLP() check for 
> iommu_bypass: instead of checking the address returned by enable_ddw(),
> it checks a new output value that reflects if the DDW created maps
> the whole partition.

Patches #5 and #6 were sent more as a RFC, but since they depend on the
series, I decided adding them here. 

