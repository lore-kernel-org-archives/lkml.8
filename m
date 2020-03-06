Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB1C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7402073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583466800;
	bh=KKTJfJcowOazNl2xl3LXrcZtQr/47qBRQ1iPwaAIkK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2kIGYl8FYcKitpa8jcvxBeQHTFopmC4dmgXZwgOWuxuG2yL+DwoUeWEaSsNt5F22a
	 xEmGNRcHnEWISkFUotqQX+NDAwCxRGNtDQONiyPug/dlP+mXx1pmJwVCAzh4BG1CpV
	 Ou2YP4LlNeKwmnPcUiS4th4fLypDjU6frrloSWRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFDxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgCFDxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:53:18 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1208120866;
        Fri,  6 Mar 2020 03:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583466798;
        bh=KKTJfJcowOazNl2xl3LXrcZtQr/47qBRQ1iPwaAIkK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=td0xkd0GEvGTfA582DFADSd26gOmYe7etXg84oNGyQi8TmtboVz1PEFqIagH0nfif
         6pTwYTgpSyMkRPSZqv1C/IAdyBUDhUPkAwoRjPdur8eBbvRaCm30t5eMIzSiRAPKR3
         fb6LPu4Ua5uaLL0NtiVZbd/7adw1nCA3I9/9rZuY=
Date:   Thu, 5 Mar 2020 19:53:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [y2038] 412c53a680: will-it-scale.per_process_ops 11.7%
 improvement
Message-Id: <20200305195317.771bd8fd1f308172d26a51fe@linux-foundation.org>
In-Reply-To: <20200305062138.GI5972@shao2-debian>
References: <20200305062138.GI5972@shao2-debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 14:21:38 +0800 kernel test robot <rong.a.chen@intel.com> wrote:

> FYI, we noticed a 11.7% improvement of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 412c53a680a97cb1ae2c0ab60230e193bee86387 ("y2038: remove unused time32 interfaces")

That patch merely removed unused code!
