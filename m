Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03055C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF7920663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGOQMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:12:39 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:48024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgGOQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:12:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 02B74181D303A;
        Wed, 15 Jul 2020 16:12:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grade82_170551826efa
X-Filterd-Recvd-Size: 1637
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Jul 2020 16:12:35 +0000 (UTC)
Message-ID: <6653f2f65ec4a9cc1024b69ffe97d5dc4c7ff33a.camel@perches.com>
Subject: Re: [PATCH 01/13 net-next] net: nl80211.h: drop duplicate words in
 comments
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        johannes@sipsolutions.net
Date:   Wed, 15 Jul 2020 09:12:34 -0700
In-Reply-To: <20200715084811.01ba7ffd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200715025914.28091-1-rdunlap@infradead.org>
         <20200715084811.01ba7ffd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 08:48 -0700, Jakub Kicinski wrote:
> On Tue, 14 Jul 2020 19:59:02 -0700 Randy Dunlap wrote:
> > Drop doubled words in several comments.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: netdev@vger.kernel.org
> 
> Hi Randy, the WiFi stuff goes through Johannes's mac80211 tree.
> 
> Would you mind splitting those 5 patches out to a separate series and
> sending to him?

Do I understand you to want separate patches
for separate sections of individual files?

I think that's a bit much...


