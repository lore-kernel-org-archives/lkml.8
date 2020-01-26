Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A4DC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9219220716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 21:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oo8PF+bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAZVcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 16:32:06 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54930 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgAZVcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 16:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1V/T5meEi3lp3z9WtoLHDUqZu/jNnEZKliaVuzu3WMM=; b=oo8PF+bcZDKwZUU4Gc3isibiH3
        gruAkIn/CqkWJ3iGuW1cJfza2HSZcio2fNurZ2ggH/Y44++Cs7IJI9yH2UIsCBoQuC0jBCbXcR05H
        k3xmztiD0K/w3+Q1leuVi2b3zWJpICSkQX2y2et9vuDfoTeuwPZNM7j7EL1NerCYrf5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ivpVd-00032o-7n; Sun, 26 Jan 2020 22:31:57 +0100
Date:   Sun, 26 Jan 2020 22:31:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] GPIO, Fix bug where the wrong GPIO register is written to
Message-ID: <20200126213157.GA9495@lunn.ch>
References: <20200125221410.8022-1-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125221410.8022-1-pthomas8589@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 05:14:10PM -0500, Paul Thomas wrote:
> Care is taken with "index", however with the current version
> the actual xgpio_writereg is using index for data but
> xgpio_regoffset(chip, i) for the offset. And since i is already
> incremented it is incorrect. This patch fixes it so that index
> is used for the offset too.
> 
> Signed-off-by: Paul Thomas <pthomas8589@gmail.com>

Hi Paul

Please put Xilinx into the subject line. I had to actually look at the
patch to decide it was not relevant to me.

      Andrew
