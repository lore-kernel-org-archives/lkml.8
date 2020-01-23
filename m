Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCEDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A71214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAWPxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:53:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32990 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726231AbgAWPxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:53:52 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00NFrfhf029524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 10:53:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D1F7642014A; Thu, 23 Jan 2020 10:53:40 -0500 (EST)
Date:   Thu, 23 Jan 2020 10:53:40 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200123155340.GD147870@mit.edu>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
 <20200122193118.GA88722@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122193118.GA88722@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:31:18PM +0100, Greg Kroah-Hartman wrote:
> With the realization that having debugfs enabled on "production" systems is
> generally not a good idea, debugfs is being disabled from more and more
> platforms over time.  However, the functionality of dynamic debugging still is
> needed at times, and since it relies on debugfs for its user api, having
> debugfs disabled also forces dynamic debug to be disabled.
> 
> To get around this, move the "control" file for dynamic_debug to procfs IFF
> debugfs is disabled.  This lets people turn on debugging as needed at runtime
> for individual driverfs and subsystems.

Instead of moving the control file IFF debugfs is enabled, what about
always making it available in /proc, and marking the control file for
dynamic_debug in debugfs as deprecated?  It would seem to me that this
would cause less confusion in the future....

					- Ted
