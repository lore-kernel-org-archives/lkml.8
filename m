Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC90C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC492073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCEPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:21:42 -0500
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:48150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726243AbgCEPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:21:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id EEE36100E7B45;
        Thu,  5 Mar 2020 15:21:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: love54_65c8d50a17e50
X-Filterd-Recvd-Size: 1591
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Mar 2020 15:21:39 +0000 (UTC)
Message-ID: <256881484c5db07e47c611a56550642a6f6bd8e9.camel@perches.com>
Subject: Re: [PATCH][next] zd1211rw/zd_usb.h: Replace zero-length array with
 flexible-array member
From:   Joe Perches <joe@perches.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Mar 2020 07:20:04 -0800
In-Reply-To: <87k13yq2jo.fsf@kamboji.qca.qualcomm.com>
References: <20200305111216.GA24982@embeddedor>
         <87k13yq2jo.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 16:50 +0200, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
[]
> >  drivers/net/wireless/zydas/zd1211rw/zd_usb.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> "zd1211rw: " is enough, no need to have the filename in the title.
> 
> But I asked this already in an earlier patch, who prefers this format?
> It already got opposition so I'm not sure what to do.

I think it doesn't matter.

Trivial inconsistencies in patch subject and word choice
don't have much overall impact.


