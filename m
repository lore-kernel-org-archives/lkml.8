Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A707C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EED623107
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgHJQ7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:59:25 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:53414 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726720AbgHJQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:59:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C4436100E7B42;
        Mon, 10 Aug 2020 16:59:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rub99_5617d8426fdb
X-Filterd-Recvd-Size: 1181
Received: from XPS-9350 (unknown [172.58.78.167])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Aug 2020 16:59:22 +0000 (UTC)
Message-ID: <17256c5e44cf5489d6eb1505077edc0910e9f3b8.camel@perches.com>
Subject: Re: in_commit_log: is the wrong token being matched for the
 MAINTAINERS need updating message?
From:   Joe Perches <joe@perches.com>
To:     Claudio Fontana <cfontana@suse.de>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 10 Aug 2020 09:59:19 -0700
In-Reply-To: <540c6741-3f22-ec85-0a14-3165115430df@suse.de>
References: <540c6741-3f22-ec85-0a14-3165115430df@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-10 at 18:45 +0200, Claudio Fontana wrote:
> We can see that in the sample patch input we are matching the line
> 
>  sound/{ => ac97}/ac97_bus.c | 0
> 
> with the regex ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/
> 
> Is this actually wanted?

Yes, If this line is found, it's not intended to
be part of a commit message.


