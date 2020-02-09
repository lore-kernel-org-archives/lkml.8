Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08577C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BE520715
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 15:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgBIPy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:54:56 -0500
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:35201 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727514AbgBIPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 10:54:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 13C4D499606;
        Sun,  9 Feb 2020 15:54:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: oven90_64c8e8bfe430b
X-Filterd-Recvd-Size: 2080
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Feb 2020 15:54:52 +0000 (UTC)
Message-ID: <c6db92330696e0e1145103b4e59bf30a982f5e4b.camel@perches.com>
Subject: Re: [PATCH v5] dynamic_debug: allow to work if debugfs is disabled
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Sun, 09 Feb 2020 07:53:38 -0800
In-Reply-To: <20200209110549.GA1621867@kroah.com>
References: <20200209110549.GA1621867@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-09 at 12:05 +0100, Greg Kroah-Hartman wrote:
> With the realization that having debugfs enabled on "production" systems
> is generally not a good idea, debugfs is being disabled from more and
> more platforms over time.  However, the functionality of dynamic
> debugging still is needed at times, and since it relies on debugfs for
> its user api, having debugfs disabled also forces dynamic debug to be
> disabled.
> 
> To get around this, also create the "control" file for dynamic_debug in
> procfs.  This allows people turn on debugging as needed at runtime for
> individual driverfs and subsystems.
> 
> Reported-by: many different companies
> Cc: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v5: as many people asked for it, now enable the control file in both
>     debugfs and procfs at the same time.

So now there can be differences in the two control files
and these are readable files are sometimes parsed by
scripts.

It'd be better to figure out how to soft link the files.


