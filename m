Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B32C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDE4206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgFEWV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:21:58 -0400
Received: from trent.utfs.org ([94.185.90.103]:45822 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgFEWV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:21:58 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 2E6B95FCDB;
        Sat,  6 Jun 2020 00:21:56 +0200 (CEST)
Date:   Fri, 5 Jun 2020 15:21:56 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Subject: Re: 5.7.0 / BUG: kernel NULL pointer dereference /
 setup_cpu_watcher
In-Reply-To: <a467c2db-e72d-9a27-9fbd-9bcf8770de20@citrix.com>
Message-ID: <alpine.DEB.2.22.395.2006051519430.13291@trent.utfs.org>
References: <alpine.DEB.2.22.395.2006050059530.13291@trent.utfs.org> <a467c2db-e72d-9a27-9fbd-9bcf8770de20@citrix.com>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020, Andrew Cooper wrote:
> PVH domains don't have the emulated platform device, so Linux will be
> finding ~0 when it goes looking in config space.
> 
> The diagnostic should be skipped in that case, to avoid giving the false
> impression that something is wrong.

Understood, thanks for explaining that. I won't be able to edit 
arch/x86/xen/platform-pci-unplug.c to fix that though :-\

Christian.
-- 
BOFH excuse #134:

because of network lag due to too many people playing deathmatch
