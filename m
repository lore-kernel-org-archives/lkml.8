Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D67BC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2F424676
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAWQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:12:40 -0500
Received: from muru.com ([72.249.23.125]:52084 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbgAWQMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:12:40 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 805C4810A;
        Thu, 23 Jan 2020 16:13:22 +0000 (UTC)
Date:   Thu, 23 Jan 2020 08:12:37 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am43x-epos-evm: set data pin directions for
 spi0 and spi1
Message-ID: <20200123161237.GZ5885@atomide.com>
References: <1579433339-10663-1-git-send-email-raagjadav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579433339-10663-1-git-send-email-raagjadav@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Raag Jadav <raagjadav@gmail.com> [200119 11:30]:
> Set d0 and d1 pin directions for spi0 and spi1 as per their pinmux.

Thanks applying into fixes.

Tony
