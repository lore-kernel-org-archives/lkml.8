Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F8FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E17206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgEKRQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:16:38 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:34178 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728556AbgEKRQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:16:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B80131802EF0E;
        Mon, 11 May 2020 17:16:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feast86_39949ece28c5c
X-Filterd-Recvd-Size: 2164
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 17:16:35 +0000 (UTC)
Message-ID: <c4c6fee41ceb2eb4b583df37ad0d659357cd81d8.camel@perches.com>
Subject: Re: [PATCH net-next v3] checkpatch: warn about uses of ENOTSUPP
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 10:16:34 -0700
In-Reply-To: <20200511170807.2252749-1-kuba@kernel.org>
References: <20200511170807.2252749-1-kuba@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 10:08 -0700, Jakub Kicinski wrote:
> ENOTSUPP often feels like the right error code to use, but it's
> in fact not a standard Unix error. E.g.:
> 
> $ python
> > > > import errno
> > > > errno.errorcode[errno.ENOTSUPP]
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> AttributeError: module 'errno' has no attribute 'ENOTSUPP'
> 
> There were numerous commits converting the uses back to EOPNOTSUPP
> but in some cases we are stuck with the high error code for backward
> compatibility reasons.
> 
> Let's try prevent more ENOTSUPPs from getting into the kernel.
> 
> Recent example:
> https://lore.kernel.org/netdev/20200510182252.GA411829@lunn.ch/
> 
> v3 (Joe):
>  - fix the "not file" condition.
> 
> v2 (Joe):
>  - add a link to recent discussion,
>  - don't match when scanning files, not patches to avoid sudden
>    influx of conversion patches.
> https://lore.kernel.org/netdev/20200511165319.2251678-1-kuba@kernel.org/
> 
> v1:
> https://lore.kernel.org/netdev/20200510185148.2230767-1-kuba@kernel.org/
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Acked-by: Joe Perches <joe@perches.com>
> ---

Thanks.

No worries here and it's not worth a respin, but
typically the patch changelog goes below the --- line.


