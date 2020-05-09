Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96966C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6BA21775
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgEIXli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:41:38 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:51344 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728842AbgEIXle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:41:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 47A3518029120;
        Sat,  9 May 2020 23:41:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: magic98_64b48ef0ebc31
X-Filterd-Recvd-Size: 1718
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 May 2020 23:41:31 +0000 (UTC)
Message-ID: <1870db200ffa03e3fce935b5e35e4562989d2dcf.camel@perches.com>
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, christophe.jaillet@wanadoo.fr,
        fthain@telegraphics.com.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Sat, 09 May 2020 16:41:30 -0700
In-Reply-To: <20200509.163217.1372289149714306397.davem@davemloft.net>
References: <50ef36cd-d095-9abe-26ea-d363d11ce521@wanadoo.fr>
         <20200509111321.51419b19@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <fc5cf8da8e70ebb981a9fc3aec6834c74197f0ed.camel@perches.com>
         <20200509.163217.1372289149714306397.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-09 at 16:32 -0700, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Sat, 09 May 2020 15:42:36 -0700
> 
> > David, maybe I missed some notification about Jakub's role.
> > 
> > What is Jakub's role in relation to the networking tree?
> 
> He is the co-maintainer of the networking tree and you should respect
> his actions and feedback as if it were coming from me.

If he's committing drivers then presumably then
he should be added to this section as well.

NETWORKING DRIVERS
M:	"David S. Miller" <davem@davemloft.net>
L:	netdev@vger.kernel.org
S:	Odd Fixes

