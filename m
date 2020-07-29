Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613E62078E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgG2AZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:25:55 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:44614 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730449AbgG2AZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:25:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3AA9D2473;
        Wed, 29 Jul 2020 00:25:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rock34_340ae5326f6e
X-Filterd-Recvd-Size: 1689
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Jul 2020 00:25:52 +0000 (UTC)
Message-ID: <e301110c6aa504be56ec73a355d3aa9215fc9633.camel@perches.com>
Subject: Re: [PATCH][next] greybus: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     Alex Elder <elder@ieee.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Jul 2020 17:25:50 -0700
In-Reply-To: <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
References: <20200727183258.GA28571@embeddedor>
         <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 17:37 -0500, Alex Elder wrote:
> On 7/27/20 1:32 PM, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1].
> > 
> > [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Thanks for the patch.  It looks good, but it raises
> another question I'd like discussion on.
> 
> It seems that Johan likes default (or final) cases in
> switch statements without a "break" statement.  Viresh
> and Bryan appear to be fond of this too.
> 
> It's pedantic, but I don't like that.  Am I wrong?

No, you are not wrong.


