Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A314CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6452072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgEUVh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgEUVh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:37:27 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B56C061A0E;
        Thu, 21 May 2020 14:37:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 133D4120ED482;
        Thu, 21 May 2020 14:37:27 -0700 (PDT)
Date:   Thu, 21 May 2020 14:37:26 -0700 (PDT)
Message-Id: <20200521.143726.481524442371246082.davem@davemloft.net>
To:     kuba@kernel.org
Cc:     tanhuazhong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH V2 net-next 0/2] net: hns3: adds two VLAN feature
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200521121707.6499ca6b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <1590061105-36478-1-git-send-email-tanhuazhong@huawei.com>
        <20200521121707.6499ca6b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 May 2020 14:37:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 21 May 2020 12:17:07 -0700

> On Thu, 21 May 2020 19:38:23 +0800 Huazhong Tan wrote:
>> This patchset adds two new VLAN feature.
>> 
>> [patch 1] adds a new dynamic VLAN mode.
>> [patch 2] adds support for 'QoS' field to PVID.
>> 
>> Change log:
>> V1->V2: modifies [patch 1]'s commit log, suggested by Jakub Kicinski.
> 
> I don't like the idea that FW is choosing the driver behavior in a way
> that's not observable via standard Linux APIs. This is the second time
> a feature like that posted for a driver this week, and we should
> discourage it.

Agreed, this is an unacceptable approach to driver features.
