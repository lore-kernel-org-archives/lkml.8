Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E87C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1643D206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgDHVcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:32:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52956 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgDHVcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:32:19 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A5C49127D38A4;
        Wed,  8 Apr 2020 14:32:18 -0700 (PDT)
Date:   Wed, 08 Apr 2020 14:32:18 -0700 (PDT)
Message-Id: <20200408.143218.803342029034510068.davem@davemloft.net>
To:     vadym.kochan@plvision.eu
Cc:     netdev@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, challa@noironetworks.com,
        linux-kernel@vger.kernel.org, taras.chornyi@plvision.eu
Subject: Re: [PATCH net] net: ipv4: devinet: Fix crash when add/del
 multicast IP with autojoin
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200407221328.32603-1-vadym.kochan@plvision.eu>
References: <20200407221328.32603-1-vadym.kochan@plvision.eu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Apr 2020 14:32:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadym Kochan <vadym.kochan@plvision.eu>
Date: Wed,  8 Apr 2020 01:13:28 +0300

> steps to reptoduse:
           ^^^^^^^^^

Typo, should be "reproduce"
