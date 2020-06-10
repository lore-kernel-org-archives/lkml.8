Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2347C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C7C2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="aIOxarc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgFJOKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgFJOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:10:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB58C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:10:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so2429734wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jDzQUCHqj4/VutT+HVFOwWkG8Uh4SllFoScBijUwQp0=;
        b=aIOxarc2FNcSmm/L8rU4tA90jHE+cz4t9kk7bpZtiaGSujg0xmMgMJBZOQOguIVse8
         5fwf59eWAX8VwcxLit4Fiq6/co0RMaLEiXbf3/NvfevHt89V9LKT8u2SMBaYKtT5zBDL
         ZenLzM2vCz5r2XgLVdx/jkzX5ZknqsPoX3IlA2uJ5B4spdDuXITgb18a8C7ewM0ZRAbt
         m2zCqTzHJR9g3c5U7LHRv2zpL+1wnCjZdNKuD8y2FDudOyomowKr6nPxnnq5m01ca4if
         lI8oqCmNOqsLrmEl58ICFzqmIxxePikNpipEUkrjd8S1lfZNAdFA57eAjun2I4cL63aE
         O8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDzQUCHqj4/VutT+HVFOwWkG8Uh4SllFoScBijUwQp0=;
        b=WlgXhf2vCl4sbEwmUbQpM6iK9wNXSxj8v9icACm5kaEfY+Uhm8bcGYu7NWdZuZ5nF4
         lYau35aaxPp4OxKZFaSw8GtKdLq2KldXOAy1xMCtYu9uKfia9oKwZoPK5McTct3MQTQI
         DtsHns/a4Fmw4R/bFuy8q21+l/oi4bfDXj9WFntctM1pjzsekAwNoptNXSf5fQsjT4Fe
         ZGmsQ1N4MLWoEi74IXdVcxRrlDpao515tyY3ZbXXtB4ofXJov/sjAb8/WlPQd4p7m2UC
         aIrs1A9HIWleiFopGaJ+PoTZ+jtq6bNzjWg6Q6ULaNAJgVGj//KfWdfMLV0ZOh5hORUA
         ERQA==
X-Gm-Message-State: AOAM530d5+Z/Ncegmv/ft+Fo2VVHz3LifE64bxc6J5xU+ARNfShwnqkm
        thiYmZ99usBeUI0MbJZgOBr05Q==
X-Google-Smtp-Source: ABdhPJxATs3KuDuMWEAjMghq03E7YQc+yJOkKpJRvtozd+hszZ6Zi3/yMlvy5TQf/Hwpj1yxDx4NdQ==
X-Received: by 2002:a5d:6cc1:: with SMTP id c1mr4135678wrc.144.1591798227154;
        Wed, 10 Jun 2020 07:10:27 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:c9f2:94f0:24f6:185d? ([2a01:e0a:3cb:7bb0:c9f2:94f0:24f6:185d])
        by smtp.gmail.com with ESMTPSA id b185sm7446792wmd.3.2020.06.10.07.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 07:10:26 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] riscv: Introduce CONFIG_RELOCATABLE
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Zong Li <zong.li@sifive.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Cc:     Anup Patel <anup@brainfault.org>
References: <20200607075949.665-1-alex@ghiti.fr>
 <20200607075949.665-3-alex@ghiti.fr>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <b588dd9e-dff8-3458-0c7d-149e3990bca7@forissier.org>
Date:   Wed, 10 Jun 2020 16:10:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607075949.665-3-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/20 9:59 AM, Alexandre Ghiti wrote:
[...]

> +config RELOCATABLE
> +	bool
> +	depends on MMU
> +	help
> +          This builds a kernel as a Position Independent Executable (PIE),
> +          which retains all relocation metadata required to relocate the
> +          kernel binary at runtime to a different virtual address than the
> +          address it was linked at.
> +          Since RISCV uses the RELA relocation format, this requires a
> +          relocation pass at runtime even if the kernel is loaded at the
> +          same address it was linked at.

Is this true? I thought that the GNU linker would write the "proper"
values by default, contrary to the LLVM linker (ld.lld) which would need
a special flag: --apply-dynamic-relocs (by default the relocated places
are set to zero). At least, it is my experience with Aarch64 on a
different project. So, sorry if I'm talking nonsense here -- I have not
looked at the details.

-- 
Jerome
