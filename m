Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814C8C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9C72067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCLQmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:42:38 -0400
Received: from poy.remlab.net ([94.23.215.26]:54856 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCLQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:42:37 -0400
Received: from roundcube.remlab.net (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 9E9CD5FADD;
        Thu, 12 Mar 2020 17:42:35 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 12 Mar 2020 18:42:35 +0200
From:   Remi Denis-Courmont <remi@remlab.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        maz@kernel.org, linux-kernel@vger.kernel.org, james.morse@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH] arm64: move kimage_vaddr to .rodata
Organization: Remlab Tmi
In-Reply-To: <20200312164035.GA21120@lakrids.cambridge.arm.com>
References: <20200312094002.153302-1-remi@remlab.net>
 <20200312164035.GA21120@lakrids.cambridge.arm.com>
Message-ID: <e87d4a759618c13dfc9d814112e6352a@remlab.net>
X-Sender: remi@remlab.net
User-Agent: Roundcube Webmail/1.2.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2020-03-12 18:40, Mark Rutland a écrit :
> On Thu, Mar 12, 2020 at 11:40:02AM +0200, Rémi Denis-Courmont wrote:
>> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
>> 
>> This datum is not referenced from .idmap.text: it does not need to be
>> mapped in idmap. Lets move it to .rodata as it is never written to 
>> after
>> early boot of the primary CPU.
>> (Maybe .data.ro_after_init would be cleaner though?)
> 
> Can we move this into arch/arm64/mm/mmu.c, where we already have
> kimage_voffset:
> 
> | u64 kimage_voffset __ro_after_init;
> | EXPORT_SYMBOL(kimage_voffset);
> 
> ... or is it not possible to initialize kimage_vaddr correctly in C?

Good question... I'll check tomorrow.

-- 
Rémi Denis-Courmont
