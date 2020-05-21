Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FFCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C94420721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgEUIkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:40:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:59810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgEUIkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:40:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5B0F2AE89;
        Thu, 21 May 2020 08:40:56 +0000 (UTC)
Date:   Thu, 21 May 2020 10:40:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] Revert "software node: Simplify
 software_node_release() function"
Message-ID: <20200521084052.GF3464@linux-b0ei>
References: <20200228000001.240428-1-brendanhiggins@google.com>
 <20200520150227.GA8397@linux-b0ei>
 <20200520164156.GA1634618@smile.fi.intel.com>
 <CAFd5g47Xj6pR=CqXMtYxL6iacqxoZ9PvHxsiG8dfUML24yN1gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47Xj6pR=CqXMtYxL6iacqxoZ9PvHxsiG8dfUML24yN1gQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-05-20 11:21:49, Brendan Higgins wrote:
> On Wed, May 20, 2020 at 9:42 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, May 20, 2020 at 05:02:27PM +0200, Petr Mladek wrote:
> > > On Thu 2020-02-27 16:00:01, Brendan Higgins wrote:
> >
> > > I have found similar report from a test robot, see
> > > https://lore.kernel.org/lkml/20200303002816.GW6548@shao2-debian/
> > >
> > >
> > > I was staring into it for a while and do not understand it. The revert
> > > makes sense. I wonder if it somehow changes the order in which
> > > the release methods are called.
> > >
> > > Anyway, reverting the revert makes test_printf working.
> >
> > There is a proper fix IIRC from Heikki in driver core (no link at hand, sorry).
> 
> The fix for this patch can be found here: https://lkml.org/lkml/2020/5/13/1070

Thanks for hint. This patch helped.

Best Regards,
Petr
