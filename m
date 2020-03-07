Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394BCC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDE120684
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGGjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 01:39:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41026 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCGGje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 01:39:34 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::f0c])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 28EE415531085;
        Fri,  6 Mar 2020 22:39:34 -0800 (PST)
Date:   Fri, 06 Mar 2020 22:39:33 -0800 (PST)
Message-Id: <20200306.223933.896880044335781056.davem@davemloft.net>
To:     mayflowerera@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] macsec: Backward compatibility bugfix of consts
 values
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200306025523.63457-1-mayflowerera@gmail.com>
References: <20200306025523.63457-1-mayflowerera@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 06 Mar 2020 22:39:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Era Mayflower <mayflowerera@gmail.com>
Date: Fri,  6 Mar 2020 02:55:22 +0000

> Fixed a compatibility bug, the value of the following consts changes:
>     * IFLA_MACSEC_PAD (include/uapi/linux/if_link.h)
>     * MACSEC_SECY_ATTR_PAD (include/uapi/linux/if_macsec.h)
>     * MACSEC_RXSC_ATTR_PAD (include/uapi/linux/if_macsec.h)
> 
> Depends on: macsec: Netlink support of XPN cipher suites (IEEE 802.1AEbw)
> 
> Signed-off-by: Era Mayflower <mayflowerera@gmail.com>

Fix your original patches so that they don't have these bugs, and then
resubmit that.
