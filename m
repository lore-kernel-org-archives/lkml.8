Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F5D2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBJ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:26:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBJ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:26:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2EC8B6A4;
        Wed,  2 Sep 2020 09:26:56 +0000 (UTC)
Date:   Wed, 2 Sep 2020 11:26:55 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Mark Brown <broonie@kernel.org>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: stacktrace: Make stack walk callback
 consistent with generic code
In-Reply-To: <20200819124913.37261-3-broonie@kernel.org>
Message-ID: <alpine.LSU.2.21.2009021126360.23200@pobox.suse.cz>
References: <20200819124913.37261-1-broonie@kernel.org> <20200819124913.37261-3-broonie@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020, Mark Brown wrote:

> As with the generic arch_stack_walk() code the arm64 stack walk code takes
> a callback that is called per stack frame. Currently the arm64 code always
> passes a struct stackframe to the callback and the generic code just passes
> the pc, however none of the users ever reference anything in the struct
> other than the pc value. The arm64 code also uses a return type of int
> while the generic code uses a return type of bool though in both cases the
> return value is a boolean value.
> 
> In order to reduce code duplication when arm64 is converted to use
> arch_stack_walk() change the signature of the arm64 specific callback to
> match that of the generic code.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
