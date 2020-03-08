Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9971C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B013C206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgCHQTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:19:10 -0400
Received: from v6.sk ([167.172.42.174]:33998 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgCHQTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:19:10 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 890AA60FFA;
        Sun,  8 Mar 2020 16:19:07 +0000 (UTC)
Date:   Sun, 8 Mar 2020 17:19:03 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: mmp: replace setup_irq() by request_irq()
Message-ID: <20200308161903.GA156645@furthur.local>
References: <20200301122243.4129-1-afzal.mohd.ma@gmail.com>
 <20200308145348.GA7062@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308145348.GA7062@afzalpc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 08:23:48PM +0530, afzal mohammed wrote:
> Hi Lubomir,
> 
> On Sun, Mar 01, 2020 at 05:52:41PM +0530, afzal mohammed wrote:
> 
> > Hi sub-arch maintainers,
> > 
> > If the patch is okay, please take it thr' your tree.
> 
> get_maintainers doesn't show any maintainers for mmp, but it specifies
> you as the sole reviewer, please let me know the route upstream for this
> patch.

Olof,

I'm wondering if you could include this in arm-soc?

The patch is here, if you don't have the rest of the thread:
https://lore.kernel.org/lkml/20200301122243.4129-1-afzal.mohd.ma@gmail.com/

It has been
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Lubomir Rintel <lkundrak@v3.sk>

(afzal; I believe I've responded with the Tested-by before; please don't
forget collect those when resubmitting patches in future. Thanks!)

Thank you,
Lubo

> 
> Regards
> afzal
