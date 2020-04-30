Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25666C83009
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F6A21973
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD3HlL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:41:11 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:57854 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgD3HlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 506636071A6F;
        Thu, 30 Apr 2020 09:41:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bYGfR4OAvZ49; Thu, 30 Apr 2020 09:41:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EFE396071A72;
        Thu, 30 Apr 2020 09:41:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YRrMNTvwAjtm; Thu, 30 Apr 2020 09:41:07 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C4C986071A6F;
        Thu, 30 Apr 2020 09:41:07 +0200 (CEST)
Date:   Thu, 30 Apr 2020 09:41:07 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Message-ID: <1750032835.172217.1588232467635.JavaMail.zimbra@nod.at>
In-Reply-To: <20200430071137.GA2382543@kroah.com>
References: <20200119215233.7292-1-richard@nod.at> <875zdibasg.fsf@vostro.fn.ogness.net> <1537701093.171645.1588186266734.JavaMail.zimbra@nod.at> <20200430071137.GA2382543@kroah.com>
Subject: Re: Please queue ubifs: Fix ubifs_tnc_lookup() usage in
 do_kill_orphans() for stable (was: Re: [PATCH] ubifs: Fix
 ubifs_tnc_lookup() usage in do_kill_orphans())
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: Please queue ubifs: Fix ubifs_tnc_lookup() usage in do_kill_orphans() for stable (was: Re: [PATCH] ubifs: Fix ubifs_tnc_lookup() usage in do_kill_orphans())
Thread-Index: oMKit3F2zpWE9UdKHS/Y/lD2DsO63A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> I always thought havings a Fixes-Tag is enough to make sure it will
>> get picked up. Isn't this the case?
> 
> No it is not, please read:
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> Our scripts are doing better to dig out stuff where maintainers mess up
> and forget to put the cc: stable tag, but you can never rely on it.
> Please stick with the above rules that have been there for 15+ years :)

Sir, yes, sir.

Thanks,
//richard
