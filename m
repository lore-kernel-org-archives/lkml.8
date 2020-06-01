Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C89C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C68D206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgFAGsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:48:03 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49038 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAGsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:48:03 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49b5N00p3Wz1rwDp;
        Mon,  1 Jun 2020 08:48:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49b5Mz70PHz1qt9d;
        Mon,  1 Jun 2020 08:47:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id K7aoiT7bHhZT; Mon,  1 Jun 2020 08:47:59 +0200 (CEST)
X-Auth-Info: UkBhxRzjMZwILyMRHsICA31NCCzeepETlHTbDM0u6PImCC/UDjHCSfqUd4AYGUzB
Received: from hase.home (ppp-46-244-183-46.dynamic.mnet-online.de [46.244.183.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  1 Jun 2020 08:47:59 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id 009D21014F6; Mon,  1 Jun 2020 08:47:57 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: fix build warning of missing prototypes
References: <7acb6dcf9975bbf3aff4be3b01320fd1b5ba30c1.1590983619.git.zong.li@sifive.com>
X-Yow:  Those aren't WINOS--that's my JUGGLER, my AERIALIST,
 my SWORD SWALLOWER, and my LATEX NOVELTY SUPPLIER!!
Date:   Mon, 01 Jun 2020 08:47:57 +0200
In-Reply-To: <7acb6dcf9975bbf3aff4be3b01320fd1b5ba30c1.1590983619.git.zong.li@sifive.com>
        (Zong Li's message of "Mon, 1 Jun 2020 11:55:32 +0800")
Message-ID: <87ftbfqo2q.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 01 2020, Zong Li wrote:

> Add the missing header in file, it was losed in original implementation.

s/losed/lost/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
