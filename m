Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C4BC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A94D208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCIRxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:53:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59092 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCIRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:53:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 83CF01593EEDE;
        Mon,  9 Mar 2020 10:53:06 -0700 (PDT)
Date:   Mon, 09 Mar 2020 10:52:57 -0700 (PDT)
Message-Id: <20200309.105257.687115756240472950.davem@davemloft.net>
To:     mayflowerera@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] macsec: Support XPN frame handling - IEEE
 802.1AEbw
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200309194702.117050-1-mayflowerera@gmail.com>
References: <20200309194702.117050-1-mayflowerera@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Mar 2020 10:53:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the future, please fix the time on your computer.  It is inaccurate and this
shows up in the email headers, and thus makes your patches appear out of order
relative to other submissions on this mailing list when they are queued up in
patchwork.

Thank you.
