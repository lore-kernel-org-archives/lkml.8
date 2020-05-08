Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F04AC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774B6208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEHAv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEHAvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:51:25 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0ACC05BD43;
        Thu,  7 May 2020 17:51:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DE2761193777F;
        Thu,  7 May 2020 17:51:24 -0700 (PDT)
Date:   Thu, 07 May 2020 17:51:24 -0700 (PDT)
Message-Id: <20200507.175124.699169292892309991.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, t-kristo@ti.com,
        netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 0/3] net: ethernet: ti: am65x-cpts: follow up
 dt bindings update
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200506181401.28699-1-grygorii.strashko@ti.com>
References: <20200506181401.28699-1-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 May 2020 17:51:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Wed, 6 May 2020 21:13:58 +0300

> This series is follow update for  TI A65x/J721E Common platform time sync (CPTS)
> driver [1] to implement  DT bindings review comments from
> Rob Herring <robh@kernel.org> [2].
>  - "reg" and "compatible" properties are made required for CPTS DT nodes which
>    also required to change K3 CPSW driver to use of_platform_device_create()
>    instead of of_platform_populate() for proper CPTS and MDIO initialization
>  - minor DT bindings format changes
>  - K3 CPTS example added to K3 MCU CPSW bindings
> 
> [1] https://lwn.net/Articles/819313/
> [2] https://lwn.net/ml/linux-kernel/20200505040419.GA8509@bogus/

Series applied, thanks.
