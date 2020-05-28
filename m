Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77097C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBAA207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391423AbgE1SHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391279AbgE1SHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:07:47 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E76CC08C5C6;
        Thu, 28 May 2020 11:07:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E723B1295A26E;
        Thu, 28 May 2020 11:07:46 -0700 (PDT)
Date:   Thu, 28 May 2020 11:07:46 -0700 (PDT)
Message-Id: <20200528.110746.401143968929865213.davem@davemloft.net>
To:     doshir@vmware.com
Cc:     netdev@vger.kernel.org, pv-drivers@vmware.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] vmxnet3: upgrade to version 4
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200528015426.8285-1-doshir@vmware.com>
References: <20200528015426.8285-1-doshir@vmware.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 May 2020 11:07:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>
Date: Wed, 27 May 2020 18:54:22 -0700

> vmxnet3 emulation has recently added several new features which includes
> offload support for tunnel packets, support for new commands the driver
> can issue to emulation, change in descriptor fields, etc. This patch
> series extends the vmxnet3 driver to leverage these new features.
> 
> Compatibility is maintained using existing vmxnet3 versioning mechanism as
> follows:
>  - new features added to vmxnet3 emulation are associated with new vmxnet3
>    version viz. vmxnet3 version 4.
>  - emulation advertises all the versions it supports to the driver.
>  - during initialization, vmxnet3 driver picks the highest version number
>  supported by both the emulation and the driver and configures emulation
>  to run at that version.
 ...

Series applied, thank you.

