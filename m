Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D52C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967BB20717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgGRBeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 21:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:34:31 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B5C0619D2;
        Fri, 17 Jul 2020 18:34:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B3EB111E45910;
        Fri, 17 Jul 2020 18:34:30 -0700 (PDT)
Date:   Fri, 17 Jul 2020 18:34:30 -0700 (PDT)
Message-Id: <20200717.183430.1402481465462087135.davem@davemloft.net>
To:     rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tgraf@suug.ch, herbert@gondor.apana.org.au
Subject: Re: [PATCH] rhashtable: drop duplicated word in
 <linux/rhashtable.h>
From:   David Miller <davem@davemloft.net>
In-Reply-To: <392beaa8-f240-70b5-b04d-3be910ef68a3@infradead.org>
References: <392beaa8-f240-70b5-b04d-3be910ef68a3@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 18:34:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 17 Jul 2020 16:37:25 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled word "be" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thank you.
