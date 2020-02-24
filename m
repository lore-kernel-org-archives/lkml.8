Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC49FC38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D32080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXTEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:04:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36708 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXTEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:04:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6E40F15AD58C7;
        Mon, 24 Feb 2020 11:04:22 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:04:19 -0800 (PST)
Message-Id: <20200224.110419.2062154027865158345.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     mlxsw@mellanox.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net/mlxfw: fix spelling mistake: "progamming" ->
 "programming"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200224152101.361648-1-colin.king@canonical.com>
References: <20200224152101.361648-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Feb 2020 11:04:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 24 Feb 2020 15:21:01 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks Colin.
