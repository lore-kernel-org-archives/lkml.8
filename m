Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEB52076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594279926;
	bh=kakKZcSdsSt03vkEyqiFdKJJD1UpoTlT8bIHlJigmBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FYsyK0hCnl8RziksQ9tzeCKtGUUIMLmKy6gGKI1VkFKEUmpp1eM/6+SN+QudW9Svn
	 7ZTTEnrFtzaCvVVaNrnhyYmzuDgVqOpJbv9x0xhTA6s/5E1zN7iCuZMbXhXR+iUjD6
	 3JJWd6g3gj5t6eTSvOF6hZ+CNOMepFnRKWK4i390=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgGIHcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgGIHcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:32:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2674F20767;
        Thu,  9 Jul 2020 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594279924;
        bh=kakKZcSdsSt03vkEyqiFdKJJD1UpoTlT8bIHlJigmBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HEp8AIMosA+aX0/9PHIsVTDp/+r3qiQ/04W1r98dGizruyYLq/Ta7D+cHnPBZroh
         CB8PR4wIL7Yjoy5h0nnNNEuhmFhBrWjbqtFKvoAQ/3jxuXAL9S/Ub3eXde+GqK/xMD
         cAqOs2yrTUBa4ORtQdFc4E55sk8DISnRCsAZSCSM=
Date:   Thu, 9 Jul 2020 08:31:59 +0100
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Message-ID: <20200709073159.GA27725@willie-the-truck>
References: <HKAPR02MB429186AF5DC0A187A345F3BCE0640@HKAPR02MB4291.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HKAPR02MB429186AF5DC0A187A345F3BCE0640@HKAPR02MB4291.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 07:18:01AM +0000, 彭浩(Richard) wrote:
> On Thu, 9 Jul 2020 at 09:50, 彭浩(Richard) <richard.peng@oppo.com> wrote:
> >> >Apparently, you are hitting a R_AARCH64_JUMP26 or R_AARCH64_CALL26
> >> >relocation that operates on a b or bl instruction that is more than
> >> >128 megabytes away from its target.
> >> >
> >> My understanding is that a module that calls functions that are not part of the module will use PLT.
> >> Plt_max_entries =0 May occur if a module does not depend on other module functions.
> >>
> >
> >A PLT slot is allocated for each b or bl instruction that refers to a
> >symbol that lives in a different section, either of the same module
> > (e.g., bl in .init calling into .text), of another module, or of the
> >core kernel.
> >
> >I don't see how you end up with plt_max_entries in this case, though.
> if a module does not depend on other module functions, PLT entries in the module is equal to 0.

This brings me back to my earlier question: if there are no PLT entries in
the module, then count_plts() will not find any R_AARCH64_JUMP26 or
R_AARCH64_CALL26 relocations that require PLTs and will therefore return 0.
The absence of these relocations means that module_emit_plt_entry() will not
be called by apply_relocate_add(), and so your patch should have no effect.

You seem to be saying that module_emit_plt_entry() _is_ being called,
despite count_plts() returning 0. One way that can happen is if PLTs are
needed for branches within a single, very large text section, but you also
say that's not the case.

So I think we need more information from you so that we can either reproduce
this ourselves, or better understand where things are going wrong.

Finally, you said that your kernel is "5.6.0-rc3+". Are you able to
reproduce with mainline (5.8-rc4)?

Will

P.S. whenever you reply, the mail threading breaks :(
