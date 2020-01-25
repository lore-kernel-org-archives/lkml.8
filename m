Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E53C35241
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 07:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D842071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 07:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAYHLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 02:11:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48330 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAYHLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 02:11:24 -0500
Received: from localhost (unknown [62.209.224.147])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6705115A16B9C;
        Fri, 24 Jan 2020 23:11:20 -0800 (PST)
Date:   Sat, 25 Jan 2020 08:11:07 +0100 (CET)
Message-Id: <20200125.081107.914737890991760251.davem@davemloft.net>
To:     wenwen@cs.uga.edu
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firestream: fix memory leaks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200125051134.11557-1-wenwen@cs.uga.edu>
References: <20200125051134.11557-1-wenwen@cs.uga.edu>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 Jan 2020 23:11:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>
Date: Sat, 25 Jan 2020 05:11:34 +0000

> @@ -922,6 +923,7 @@ static int fs_open(struct atm_vcc *atm_vcc)
>  			if (((DO_DIRECTION(rxtp) && dev->atm_vccs[vcc->channo])) ||
>  			    ( DO_DIRECTION(txtp) && test_bit (vcc->channo, dev->tx_inuse))) {
>  				printk ("Channel is in use for FS155.\n");
> +				kfree(vcc);
>  				return -EBUSY;
>  			}
>  		}
> -- 

There is another case just below this line:

			    tc, sizeof (struct fs_transmit_config));
		if (!tc) {
			fs_dprintk (FS_DEBUG_OPEN, "fs: can't alloc transmit_config.\n");
			return -ENOMEM;
		}

Please audit the entire function and make sure your patch fixes all of these
missing vcc free cases.

Thank you.
