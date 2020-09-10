Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D86AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111742075E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbgIJPfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:35:33 -0400
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:60906 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731335AbgIJPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:33:49 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 07CE118353A5E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 14:43:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 41FA812FD;
        Thu, 10 Sep 2020 14:42:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bomb99_3c0c88c270e6
X-Filterd-Recvd-Size: 1556
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Sep 2020 14:42:34 +0000 (UTC)
Message-ID: <73afd93d520c15edd00b7729e12f578028f8913e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: accept longer commit description lines
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 10 Sep 2020 07:42:33 -0700
In-Reply-To: <20200910143208.3837-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200910143208.3837-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-10 at 23:32 +0900, Tetsuo Handa wrote:
> Given that commit bdc48fa11e46f867 ("checkpatch/coding-style: deprecate
> 80-column warning") was introduced because nowadays most of us are using
> screens that can print more than 100 columns, most of us will be also
> using mail clients that can print more than 100 columns. Since 75 chars
> limit for commit description lines is sometimes inconvenient for obeying
> 'commit <12+ chars of sha1> ("<title line>")' style or embedding URLs,
> loosen the limit by 20 chars.

My inclination ks to say thanks, but no thanks.

My standard terminal window is a different width than
my standard editing window.



