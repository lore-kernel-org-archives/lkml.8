Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEB7C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB13F21927
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBGLAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:00:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40956 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:00:07 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F29FF1585ABDA;
        Fri,  7 Feb 2020 03:00:04 -0800 (PST)
Date:   Fri, 07 Feb 2020 12:00:00 +0100 (CET)
Message-Id: <20200207.120000.2189785171336183347.davem@davemloft.net>
To:     boon.leong.ong@intel.com
Cc:     netdev@vger.kernel.org, tee.min.tan@intel.com,
        weifeng.voon@intel.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, Jose.Abreu@synopsys.com,
        mcoquelin.stm32@gmail.com, alexandru.ardelean@analog.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/5] net: stmmac: general fixes for Ethernet
 functionality
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200207073105.9286-1-boon.leong.ong@intel.com>
References: <20200207073105.9286-1-boon.leong.ong@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Feb 2020 03:00:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong Boon Leong <boon.leong.ong@intel.com>
Date: Fri,  7 Feb 2020 15:31:05 +0800

> Thanks to all feedbacks from community so far.
> 
> We updated the patch-series to below:-
 ...

Series applied and queued up for -stable.
