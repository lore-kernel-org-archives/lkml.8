Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAA6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791882078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE0WIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0WIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:08:15 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66634C05BD1E;
        Wed, 27 May 2020 15:08:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CA152128CEF78;
        Wed, 27 May 2020 15:08:14 -0700 (PDT)
Date:   Wed, 27 May 2020 15:08:14 -0700 (PDT)
Message-Id: <20200527.150814.495554320366388162.davem@davemloft.net>
To:     jonas.falkevik@gmail.com
Cc:     marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        nhorman@tuxdriver.com, vyasevich@gmail.com, kuba@kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: fix typo sctp_ulpevent_nofity_peer_addr_change
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200527095943.271140-1-jonas.falkevik@gmail.com>
References: <20200527095943.271140-1-jonas.falkevik@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 May 2020 15:08:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Falkevik <jonas.falkevik@gmail.com>
Date: Wed, 27 May 2020 11:59:43 +0200

> change typo in function name "nofity" to "notify"
> sctp_ulpevent_nofity_peer_addr_change ->
> sctp_ulpevent_notify_peer_addr_change
> 
> Signed-off-by: Jonas Falkevik <jonas.falkevik@gmail.com>

Applied to net-next, thanks.
