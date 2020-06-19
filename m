Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7F5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526E9208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgFSDft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFSDft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:35:49 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB46C06174E;
        Thu, 18 Jun 2020 20:35:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8CD7F120ED49C;
        Thu, 18 Jun 2020 20:35:48 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:35:47 -0700 (PDT)
Message-Id: <20200618.203547.1927187219633676867.davem@davemloft.net>
To:     drc@linux.vnet.ibm.com
Cc:     netdev@vger.kernel.org, siva.kallam@broadcom.com,
        prashant@broadcom.com, mchan@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tg3: driver sleeps indefinitely when EEH errors
 exceed eeh_max_freezes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200617185117.732849-1-drc@linux.vnet.ibm.com>
References: <20200615190119.382589-1-drc@linux.vnet.ibm.com>
        <20200617185117.732849-1-drc@linux.vnet.ibm.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jun 2020 20:35:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Christensen <drc@linux.vnet.ibm.com>
Date: Wed, 17 Jun 2020 11:51:17 -0700

> The driver function tg3_io_error_detected() calls napi_disable twice,
> without an intervening napi_enable, when the number of EEH errors exceeds
> eeh_max_freezes, resulting in an indefinite sleep while holding rtnl_lock.
> 
> Add check for pcierr_recovery which skips code already executed for the
> "Frozen" state.
> 
> Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>

Applied and queued up for -stable, thanks.
