Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E3DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD2C20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCRDzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:55:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35360 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:55:01 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 024FE13EA9467;
        Tue, 17 Mar 2020 20:55:00 -0700 (PDT)
Date:   Tue, 17 Mar 2020 20:54:58 -0700 (PDT)
Message-Id: <20200317.205458.363428814998635583.davem@davemloft.net>
To:     chris.packham@alliedtelesis.co.nz
Cc:     andrew@lunn.ch, josua@solid-run.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] net: mvmdio: avoid error message for optional
 IRQ
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200316074907.21879-1-chris.packham@alliedtelesis.co.nz>
References: <20200316074907.21879-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Mar 2020 20:55:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Mon, 16 Mar 2020 20:49:05 +1300

> I've gone ahead an sent a revert. This is the same as the original v1 except
> I've added Andrew's review to the commit message.

Applied, thanks Chris.
