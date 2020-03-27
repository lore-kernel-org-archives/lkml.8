Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E134C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8BF20787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgC0DIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:08:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57902 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgC0DIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:08:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 14FD015CE723E;
        Thu, 26 Mar 2020 20:08:40 -0700 (PDT)
Date:   Thu, 26 Mar 2020 20:08:39 -0700 (PDT)
Message-Id: <20200326.200839.844293452319241756.davem@davemloft.net>
To:     esyr@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        vinicius.gomes@intel.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, olteanv@gmail.com,
        weifeng.voon@intel.com, ldv@altlinux.org
Subject: Re: [PATCH net-next] taprio: do not use BIT() in
 TCA_TAPRIO_ATTR_FLAG_* definitions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200324041920.GA7068@asgard.redhat.com>
References: <20200324041920.GA7068@asgard.redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Mar 2020 20:08:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Syromiatnikov <esyr@redhat.com>
Date: Tue, 24 Mar 2020 05:19:20 +0100

> BIT() macro definition is internal to the Linux kernel and is not
> to be used in UAPI headers; replace its usage with the _BITUL() macro
> that is already used elsewhere in the header.
> 
> Cc: <stable@vger.kernel.org> # v5.4+
> Fixes: 9c66d1564676 ("taprio: Add support for hardware offloading")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Applied.
