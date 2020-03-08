Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3863CC10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D792084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCHOzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:55:44 -0400
Received: from v6.sk ([167.172.42.174]:33968 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCHOzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:55:43 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2020 10:55:43 EDT
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 45EF260FFA;
        Sun,  8 Mar 2020 14:46:08 +0000 (UTC)
Date:   Sun, 8 Mar 2020 15:46:04 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/2] irqchip/mmp: A pair of robustness fixed
Message-ID: <20200308143814.GA150394@furthur.local>
References: <20200219080024.4002-1-lkundrak@v3.sk>
 <20200308140434.18b0f947@why>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308140434.18b0f947@why>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 02:04:34PM +0000, Marc Zyngier wrote:
> On Wed, 19 Feb 2020 09:00:22 +0100
> Lubomir Rintel <lkundrak@v3.sk> wrote:
> 
> [+RobH]
> 
> Lubomir,
> 
> > Hi,
> > 
> > please consider applying these two patches. Thery are not strictly
> > necessary, but improve diagnostics in case the DT is faulty.
> 
> Can't we instead make sure our DT infrastructure checks for these? I'm
> very reluctant to add more "DT validation" to the kernel, as it feels
> like the wrong place to do this.

These are not really problems of the DT infrastructure. It's that the
driver has some constrains resulting from use of global data ([PATCH 1])
and statically sized arrays ([PATCH 2]) without enforcing them.

It's probably easier to mess up DT than to mess up board files, but
regardless of that, being a little defensive and checking the bounds of
arrays is probably a good programming practice anyways.

Thank you
Lubo
