Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A97C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7730320767
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbgFXDbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388292AbgFXDbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:31:33 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A991C061573;
        Tue, 23 Jun 2020 20:31:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4F58D1298632C;
        Tue, 23 Jun 2020 20:31:32 -0700 (PDT)
Date:   Tue, 23 Jun 2020 20:31:31 -0700 (PDT)
Message-Id: <20200623.203131.1093463627031337018.davem@davemloft.net>
To:     vaibhavgupta40@gmail.com
Cc:     helgaas@kernel.org, bhelgaas@google.com, bjorn@helgaas.com,
        vaibhav.varodek@gmail.com, kuba@kernel.org, pcnet32@frontier.com,
        thomas.lendacky@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 0/3] ethernet: amd: Convert to generic power
 management
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200622111400.55956-1-vaibhavgupta40@gmail.com>
References: <20200622111400.55956-1-vaibhavgupta40@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Jun 2020 20:31:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 22 Jun 2020 16:43:57 +0530

> Linux Kernel Mentee: Remove Legacy Power Management.
> 
> The purpose of this patch series is to remove legacy power management callbacks
> from amd ethernet drivers.
> 
> The callbacks performing suspend() and resume() operations are still calling
> pci_save_state(), pci_set_power_state(), etc. and handling the power management
> themselves, which is not recommended.
> 
> The conversion requires the removal of the those function calls and change the
> callback definition accordingly and make use of dev_pm_ops structure.
> 
> All patches are compile-tested only.

Series applied, thanks.
