Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E07C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05082082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgG3XeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3XeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:34:23 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:34:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E9AAA126BEDE4;
        Thu, 30 Jul 2020 16:17:36 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:34:21 -0700 (PDT)
Message-Id: <20200730.163421.250326869200327004.davem@davemloft.net>
To:     joyce.ooi@intel.com
Cc:     mchehab+samsung@kernel.org, robh@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        thor.thayer@linux.intel.com, ley.foon.tan@intel.com,
        chin.liang.see@intel.com
Subject: Re: [PATCH] MAINTAINERS: Replace Thor Thayer as Altera Triple
 Speed Ethernet maintainer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200727094641.174870-1-joyce.ooi@intel.com>
References: <20200727094641.174870-1-joyce.ooi@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jul 2020 16:17:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ooi, Joyce" <joyce.ooi@intel.com>
Date: Mon, 27 Jul 2020 17:46:41 +0800

> From: Joyce Ooi <joyce.ooi@intel.com>
> 
> This patch is to replace Thor Thayer as Altera Triple Speed Ethernet
> maintainer as he is moving to a different role.
> 
> Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>

Applied.
