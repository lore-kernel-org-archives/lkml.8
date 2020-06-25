Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7415C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42F920781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406747AbgFYTgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406679AbgFYTgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:36:05 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E003C08C5C1;
        Thu, 25 Jun 2020 12:36:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B317813B3AC0B;
        Thu, 25 Jun 2020 12:36:04 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:36:04 -0700 (PDT)
Message-Id: <20200625.123604.1422188753260617907.davem@davemloft.net>
To:     vaibhavgupta40@gmail.com
Cc:     helgaas@kernel.org, bhelgaas@google.com, bjorn@helgaas.com,
        vaibhav.varodek@gmail.com, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1] ptp_pch: use generic power management
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200625121042.99369-1-vaibhavgupta40@gmail.com>
References: <20200625121042.99369-1-vaibhavgupta40@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Jun 2020 12:36:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Thu, 25 Jun 2020 17:40:43 +0530

> With legacy PM, drivers themselves were responsible for managing the
> device's power states and takes care of register states.
> 
> After upgrading to the generic structure, PCI core will take care of
> required tasks and drivers should do only device-specific operations.
> 
> In the case of ptp_pch, after removing PCI helper functions, .suspend()
> and .resume() became empty-body functions. Hence, define them NULL and
> use dev_pm_ops.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

A straight-forward transformation, looks good, applied to net-next
thanks.
