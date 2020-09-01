Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE33C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E3A2067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgIAQpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:45:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbgIAP1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5AA32ACC3;
        Tue,  1 Sep 2020 15:27:29 +0000 (UTC)
Date:   Tue, 1 Sep 2020 17:27:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Salvatore Bonaccorso <carnil@debian.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dirk Kostrewa <dirk.kostrewa@mailbox.org>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200901152728.GI16650@dhcp22.suse.cz>
References: <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
 <20200720181605.GC4061@dhcp22.suse.cz>
 <20200720200243.GA1244989@rowland.harvard.edu>
 <20200721055917.GD4061@dhcp22.suse.cz>
 <20200721143325.GB1272082@rowland.harvard.edu>
 <20200829095003.GA2446485@eldamar.local>
 <20200829155949.GA499295@rowland.harvard.edu>
 <38dfdef4-f9ab-1755-8418-2285d843af86@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38dfdef4-f9ab-1755-8418-2285d843af86@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-08-20 14:37:10, Mathias Nyman wrote:
[...]
> I can't come up with any good solution to this right now.
> Only bad ideas such as
> a. Add a sleep to the over-current case, 
>    doesn't solve anything else than the ~100% cpu hogging part of the problem 

This sounds like a better thing from the user space point of view. I do
not have any insight on what kind of other side effects this might have
so I didn't dare to try that on my piece of (broken) HW. I do not see
the problem all the time and I plan to replace it soon anyway.

Considering that tweaking the power management helps maybe that could be
done automagically after many consecutive failures.

Just my 2c
-- 
Michal Hocko
SUSE Labs
