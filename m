Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C4BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0782420717
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCEW7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:59:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57434 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:59:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E2D0215BF42F3;
        Thu,  5 Mar 2020 14:59:38 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:59:38 -0800 (PST)
Message-Id: <20200305.145938.2059614345989381629.davem@davemloft.net>
To:     tangbin@cmss.chinamobile.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet:broadcom:bcm63xx_enet:remove redundant
 variable definitions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200305122259.6104-1-tangbin@cmss.chinamobile.com>
References: <20200305122259.6104-1-tangbin@cmss.chinamobile.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Mar 2020 14:59:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogdGFuZ2JpbiA8dGFuZ2JpbkBjbXNzLmNoaW5hbW9iaWxlLmNvbT4NCkRhdGU6IFRodSwg
IDUgTWFyIDIwMjAgMjA6MjI6NTkgKzA4MDANCg0KPiBpbiB0aGlzIGZ1bmN0aW9uLKFyZXSiIGlz
IGFsd2F5cyBhc3NpZ25lZCxzbyB0aGlzJ3MgZGVmaW5pdGlvbg0KPiAncmV0ID0gMCcgbWFrZSBu
byBzZW5zZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IHRhbmdiaW4gPHRhbmdiaW5AY21zcy5jaGlu
YW1vYmlsZS5jb20+DQoNCkFwcGxpZWQgd2l0aCBTdWJqZWN0IGxpbmUgZml4ZWQuDQo=
