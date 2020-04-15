Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B00C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9730D20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896457AbgDOKSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:18:35 -0400
Received: from foss.arm.com ([217.140.110.172]:41504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896381AbgDOKPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:15:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C81D1063;
        Wed, 15 Apr 2020 03:15:12 -0700 (PDT)
Received: from [10.37.9.9] (unknown [10.37.9.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20C533F68F;
        Wed, 15 Apr 2020 03:15:10 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] arm64/vdso: Add time napespace page
To:     Mark Rutland <mark.rutland@arm.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-4-avagin@gmail.com>
 <20200414172014.GA6705@C02TD0UTHF1T.local>
 <CANaxB-yBeSmYdZL6gbe-agDAaEVcYHrxUCojQ4xaWpsWinQsyA@mail.gmail.com>
 <20200415100539.GA27339@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a0179a69-fc1b-9e81-f3f2-72f6c639f40e@arm.com>
Date:   Wed, 15 Apr 2020 11:16:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200415100539.GA27339@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 4/15/20 11:05 AM, Mark Rutland wrote:
> It's a shame we're not using OPTIMIZER_HIDE_VAR() for that, as it can
> generate slightly better code and is easier to read than bare asm.

We are not because I was not aware when I wrote this code that such a macro
existed :)

But you are right it clearly makes the code more readable. To make up for it, I
am happy to make the effort to introduce it for both the cases and replace the
assembler once this patch series gets merged.

-- 
Regards,
Vincenzo
