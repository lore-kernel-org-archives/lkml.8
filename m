Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FA4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A5C20746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgEDHuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:50:07 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54846 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgEDHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:50:06 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49Fw4X1fhdz1s2JQ;
        Mon,  4 May 2020 09:50:04 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49Fw4W6xgCz1r5Qh;
        Mon,  4 May 2020 09:50:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id F_9UJHi4s1bK; Mon,  4 May 2020 09:50:03 +0200 (CEST)
X-Auth-Info: zCP8j9WucMgE0ljkVLi9b0ZsyqeoqFTivgiAMvw7NZx8rvlJXclL55S702m2QlDj
Received: from igel.home (ppp-46-244-166-96.dynamic.mnet-online.de [46.244.166.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  4 May 2020 09:50:03 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 8BB672C0B3F; Mon,  4 May 2020 09:50:02 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: Re: [PATCH v2] riscv: force __cpu_up_ variables to put in data section
References: <20200504035448.13893-1-zong.li@sifive.com>
        <CAAhSdy23jzYvZcmXoX_5F1wDenBQ8NpvNpoO41=aBGHoONPCgg@mail.gmail.com>
X-Yow:  TAILFINS!!  ...click...
Date:   Mon, 04 May 2020 09:50:02 +0200
In-Reply-To: <CAAhSdy23jzYvZcmXoX_5F1wDenBQ8NpvNpoO41=aBGHoONPCgg@mail.gmail.com>
        (Anup Patel's message of "Mon, 4 May 2020 11:55:05 +0530")
Message-ID: <87tv0w3zrp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 04 2020, Anup Patel wrote:

> Slightly improved text:
>
> This issue happens on random booting of multiple harts, which means
> it will manifest for BBL and OpenSBI v0.6 (or older version). In OpenSBI
> v0.7 (or higher version), we have HSM extension so all the secondary harts
> are brought-up by Linux kernel in an orderly fashion. This means we don't
> this change for OpenSBI v0.7 (or higher version).

  +need

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
