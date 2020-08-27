Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EEFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6EB2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="0PbjnuIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgH0SzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:55:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53581 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgH0SzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:55:20 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 07RIt62a224689
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 27 Aug 2020 11:55:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 07RIt62a224689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020082401; t=1598554507;
        bh=OH9zkbpjL0MBDHjDPXWQXOb1vhN5fGZp2LegKbtSnU8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0PbjnuIbDP/qPWbT1W8HLZPVrsb5uulZV8L7vHJRHchDs+u9/WHTwA66ZqNTpDEcB
         WT8dzwBOaz/EiOBegSKtPDa8GUtqUOhkhHhwWJt0yH+mDECwrSYQoe0UqICucr0EyH
         SpWuZvRaC1urjhPNKXDJB8jfBwB3bwy2Y89PfS6zr3Dr8Dg2NU9nIFWNU0YJF3h6x5
         O9gNmTyHDo/PhaWjE8D2RbNdbaSeBaF3vJOgVrnPBMWhTdppH9i01uBli2BKrevw7d
         YVxyXEDFW91h+dRkqC56AZCbkVGpHAi0IzbBI83d+S2gACYagTcwwvDVjGKvswpvUI
         YTci2TsxJPb+A==
Subject: Re: [PATCH v2] x86: Use xorl %0,%0 in __get_user_asm
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <20200827180904.96399-1-ubizjak@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <53b5c10f-122f-3fb1-f371-7e1868f7384a@zytor.com>
Date:   Thu, 27 Aug 2020 11:55:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827180904.96399-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-27 11:09, Uros Bizjak wrote:
> xorl %0,%0 is equivalent to xorq %0,%0 as both will zero the
> entire register.  Use xorl %0,%0 for all operand sizes to avoid
> REX prefix byte when legacy registers are used and to avoid size
> prefix byte when 16bit registers are used.
> 
> Zeroing the full register is OK in this use case.  xorl %0,%0 also
> breaks register dependency chains, avoiding potential partial
> register stalls with 8 and 16bit operands.
> 
> The patch lowers the size of .fixup section by 20 bytes.
> 
> Changes since v1:
> - Rewrite commit message.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
