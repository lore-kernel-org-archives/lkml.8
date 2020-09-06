Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C6C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 00:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002EA2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 00:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="cHfRm7CS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgIFAHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 20:07:24 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40577 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgIFAHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 20:07:23 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BkWt16pg0z2F;
        Sun,  6 Sep 2020 02:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1599350794; bh=Ax4f9iOJXW9avhFhLBq4v+EzJf1PKIncuwGvhnk6Pe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHfRm7CShJkpbRUg/1eugman5T9p5CHPFf4QfDG+aUNrEqqk1UpdJPO9BLlYM3sk4
         w1FR2/v7J7gDjREK3D5JeOFnQj+N8uHJCla1L4ed89TC/hFsSI6h1ahZiWx5h8r6ay
         SNrb01f9rZKLCg4SkQW10fMOBk4rzY5sZMpWN3ywQvwStOjYm+jtNTUWUSWkrXdDBk
         aWekzTbh7VqsQUbH7vTJsUEHRGvr36JsgoyAHTqym2W/EVYuk7+JYLcajQCQYdpQKE
         weyW15dR8+l5lT4dDDRvLQ5k0+/FYqw113Th0sgzpfywbAsz9A0dGLdKLmFfOuwxoS
         of8wfPz0oKgKQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 6 Sep 2020 02:07:17 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 0/3] regulator: unexport regulator_lock/unlock()
Message-ID: <20200906000717.GA3731@qmqm.qmqm.pl>
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 06:33:30AM +0200, Micha³ Miros³aw wrote:
> This removes regulator_lock/unlock() calls around
> regulator_notifier_call_chain() as they are redundant - drivers
> already have to guarantee regulator_dev's existence during the call.
> 
> This should make reasoing about the lock easier, as this was the only
> use outside regulator core code.
> 
> The only client that needed recursive locking from the notifier chain
> was drivers/usb/host/ohci-da8xx.c, which responds to over-current
> notification by calling regulator_disable().

I can't see the series in regulator/for-next and got no comments.
Should I resend?

As a side note: this is a step towards fixing regulator-coupling-related
locking issues.

Best Regards,
Micha³ Miros³aw
