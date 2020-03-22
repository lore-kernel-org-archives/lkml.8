Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1927AC4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 03:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78702072C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 03:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgCVDUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 23:20:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34454 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVDUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 23:20:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1F88C15AC4293;
        Sat, 21 Mar 2020 20:20:17 -0700 (PDT)
Date:   Sat, 21 Mar 2020 20:20:16 -0700 (PDT)
Message-Id: <20200321.202016.815058339704760980.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     acelan.kao@canonical.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: only disable ASPM L1.1 support, instead of
 disabling them all
From:   David Miller <davem@davemloft.net>
In-Reply-To: <78aa4db2-6dec-e23c-03f4-f76577de756f@gmail.com>
References: <20200318014548.14547-1-acelan.kao@canonical.com>
        <78aa4db2-6dec-e23c-03f4-f76577de756f@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Mar 2020 20:20:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed, 18 Mar 2020 12:09:14 +0100

> Having said that I'd prefer to keep ASPM an opt-in feature.

Agreed, too much stuff broke randomly and in hard to detect ways.
