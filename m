Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F692C2BBD0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 23:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A72220DD4
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 23:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="PBOtN2/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgIEXQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 19:16:29 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:13347 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgIEXQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 19:16:28 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BkVlF0jDhz2F;
        Sun,  6 Sep 2020 01:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1599347737; bh=95+3JR3CqwQ+HDMeabQYHanSmelI1wcuc6XG64RN0xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBOtN2/qdg3JAPzUD0RrFSvhGHz113Vo7ssDMuAJPYicQX0N2CuyEveDXTOQAbNLN
         SzJsLc8QUmq0WoPngtJPQYX4nJI8HFTwdPED4Uwz3lxfSOcgY8958B+xHIhp78sgC7
         NoUBDjGneJyDt5xvfWV7UAgcbdTgLLlCnGsbPCNqvf72gPzdse5t3U0qMCf/YuU9et
         dylHU+Eb+m/UVHitqgtKyACRXr+RS8GcY7OgXN8dn8CguKVsAD6MA+zBdZ4yFH97yE
         rX4sZI3c8M33IN/ryy7yOf3ogO1DGBUDGcE37WzR79Y4kaaA3r3xO3lAl3nlqiS34z
         EMwCzE2vkYi6w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 6 Sep 2020 01:16:25 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/31] Improvements for Tegra I2C driver
Message-ID: <20200905231625.GH18554@qmqm.qmqm.pl>
References: <20200905204151.25343-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905204151.25343-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 11:41:20PM +0300, Dmitry Osipenko wrote:
> Hello!
> 
> This series performs refactoring of the Tegra I2C driver code and hardens
> the atomic-transfer mode.
[...]

Pending comments, all LGTM.

Best Regards,
Micha³ Miros³aw
