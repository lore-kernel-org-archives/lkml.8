Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F53C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0682E20857
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgBQC4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:56:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47990 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgBQC4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:56:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E6806153DF5F0;
        Sun, 16 Feb 2020 18:56:00 -0800 (PST)
Date:   Sun, 16 Feb 2020 18:56:00 -0800 (PST)
Message-Id: <20200216.185600.43507558643527863.davem@davemloft.net>
To:     manivannan.sadhasivam@linaro.org
Cc:     kuba@kernel.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: qrtr: Migrate nameservice to kernel from
 userspace
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200213091427.13435-2-manivannan.sadhasivam@linaro.org>
References: <20200213091427.13435-1-manivannan.sadhasivam@linaro.org>
        <20200213091427.13435-2-manivannan.sadhasivam@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Feb 2020 18:56:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 13 Feb 2020 14:44:26 +0530

> +static int service_announce_new(struct sockaddr_qrtr *dest,
> +				struct qrtr_server *srv)
> +{
> +	struct qrtr_ctrl_pkt pkt;
> +	struct msghdr msg = { };
> +	struct kvec iv = { &pkt, sizeof(pkt) };

Please use reverse christmas tree ordering for local variables.

Please fix this for your entire submission.
