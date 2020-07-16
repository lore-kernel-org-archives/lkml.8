Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697DB2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGPHYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:24:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38384 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgGPHYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:24:30 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4B6m3J2gbWz1qsZw;
        Thu, 16 Jul 2020 09:24:28 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4B6m3J1lMtz1qtwB;
        Thu, 16 Jul 2020 09:24:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id J70jrAzaypsO; Thu, 16 Jul 2020 09:24:27 +0200 (CEST)
X-Auth-Info: +GkvJW+U7a1jkwpYYtwvJGW4qb6pdIBqEmyMYF7EgbvcE/fEsu3c4+4SqZRjkrRE
Received: from igel.home (ppp-46-244-175-239.dynamic.mnet-online.de [46.244.175.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 16 Jul 2020 09:24:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id D5C4F2C28D5; Thu, 16 Jul 2020 09:24:26 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: fix build warning of mm/pageattr
References: <cover.1594880014.git.zong.li@sifive.com>
        <28365b581b04d0237e127363a63c1ad72dbea683.1594880014.git.zong.li@sifive.com>
X-Yow:  I just remembered something about a TOAD!
Date:   Thu, 16 Jul 2020 09:24:26 +0200
In-Reply-To: <28365b581b04d0237e127363a63c1ad72dbea683.1594880014.git.zong.li@sifive.com>
        (Zong Li's message of "Thu, 16 Jul 2020 14:15:27 +0800")
Message-ID: <87sgdrx6qd.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 16 2020, Zong Li wrote:

> Add hearder for missing prototype. Also, static keyword should be at

s/hearder/header/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
