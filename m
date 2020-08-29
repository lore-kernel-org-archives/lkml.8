Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE9C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691FB2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgH2KhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:37:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgH2KhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:37:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67321AD1F;
        Sat, 29 Aug 2020 10:37:49 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 0EBFE60737; Sat, 29 Aug 2020 12:37:15 +0200 (CEST)
Date:   Sat, 29 Aug 2020 12:37:15 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Bart Groeneveld <avi@bartavi.nl>
Cc:     linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] net: Use standardized (IANA) local port range
Message-ID: <20200829103715.iofmvtisabjl5hqb@lion.mk-sys.cz>
References: <20200828203959.32010-1-avi@bartavi.nl>
 <20200828204447.32838-1-avi@bartavi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828204447.32838-1-avi@bartavi.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:44:47PM +0200, Bart Groeneveld wrote:
> This change will effectively halve the available ephemeral ports,
> increasing the risk of port exhaustion. But:
> ...
> b) It is only an issue with more than 11848 *outgoing* connections.
> 	I think that is a niche case (I know, citation needed, but still).

You don't need 11848 simultaneous connections to run into problems as
you may also have timewait sockets left after a connection is closed.
If there are many shortlived outgoing connections to the same server,
you may run out of ephemeral ports even without having too many active
connections at any time.

Michal
