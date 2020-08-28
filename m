Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6BDC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA73220848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgH1NAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:00:55 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57956 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgH1NAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:00:37 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kBdze-00CHCw-7p; Fri, 28 Aug 2020 15:00:34 +0200
Date:   Fri, 28 Aug 2020 15:00:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: of_match_node: Make stub an inline function to avoid
 W=1 warnings
Message-ID: <20200828130034.GA2912863@lunn.ch>
References: <20200828021939.2912798-1-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828021939.2912798-1-andrew@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 04:19:39AM +0200, Andrew Lunn wrote:
> When building without CONFIG_OF and W=1, errors are given about unused
> arrays of match data, because of_match_node is stubbed as a macro. The
> compile does not see it takes parameters when not astub, so it
> generates warnings about unused variables. Replace the stub with an
> inline function to avoid these false warnings.

Hi Rob

So 0-day shows some people have worked around this with #ifdef
CONFIG_OF around the match table.

I checked the object code for the file i'm interested in.  The
optimiser has correctly throw away the match table and all code around
it with the inline stub.

Which do you prefer? This patch and i remove the #ifdef, or the old
stub and if add #ifdef around the driver i'm getting warnings from?

     Andrew
