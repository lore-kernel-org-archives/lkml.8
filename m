Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C94EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 667C9206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgEZXdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:33:12 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:45352 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEZXdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:33:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 59788837F24D;
        Tue, 26 May 2020 23:33:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hate02_240191e26d4d
X-Filterd-Recvd-Size: 3226
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 May 2020 23:33:10 +0000 (UTC)
Message-ID: <fd6892ca0191b67491416318958d1ece23e840ff.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 26 May 2020 16:33:09 -0700
In-Reply-To: <ea204501-84a3-badb-63f6-0a9d2fe12b19@linuxfoundation.org>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
         <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
         <661f53a3-b15c-76b0-f220-0d292b0843d5@linuxfoundation.org>
         <b0854ec2906323d34514875a58a79d4cb74e44b0.camel@perches.com>
         <ea204501-84a3-badb-63f6-0a9d2fe12b19@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-26 at 16:54 -0600, Shuah Khan wrote:
> On 5/26/20 4:27 PM, Joe Perches wrote:
> > On Tue, 2020-05-26 at 11:04 -0600, Shuah Khan wrote:
> > > On 5/22/20 8:26 PM, Joe Perches wrote:
> > > > On Fri, 2020-05-22 at 20:19 -0600, Shuah Khan wrote:
> > > > > get_maintainer.pl picks only the first email address found in the file.
> > > > > Reorder my email addresses so it finds my linuxfoundation.org email.
> > > > 
> > > > OK.
> > []
> > > Sadly, people that don't run get_maintainer.pl, leave alone running it
> > > with --noremove-duplicates option. So your suggestion doesn't really
> > > help me.
> > > 
> > > My preference is to get patches to both Inboxes if possible which isn't
> > > possible unless -noremove-duplicate is default. Having this option as
> > > default probably will annoy lot of people . So I am not asking for
> > > that.
> > > 
> > > That being said, I don't understand your comment. Are you recommending
> > > using just one email in these entries?
> > 
> > Yes.  And maybe set an autoforward rule in that email to
> > forward the received email to your other address.
> > 
> > 
> Sounds good.

Another option would be to write your name
slightly differently in the 2 entries.

For instance, add "(LF)" to the linuxfoundation.org entry like:

CPU POWER MONITORING SUBSYSTEM
M:	Thomas Renninger <trenn@suse.com>
M:	Shuah Khan <shuah@kernel.org>
M:	Shuah Khan (LF) <skhan@linuxfoundation.org>
L:	linux-pm@vger.kernel.org
S:	Maintained
F:	tools/power/cpupower/

and then the get_maintainer.pl script won't
collapse the equally named but with different
email addresses into a single entry:

$ ./scripts/get_maintainer.pl -f tools/power/cpupower/
Thomas Renninger <trenn@suse.com> (maintainer:CPU POWER MONITORING SUBSYSTEM)
Shuah Khan <shuah@kernel.org> (maintainer:CPU POWER MONITORING SUBSYSTEM)
"Shuah Khan (LF)" <skhan@linuxfoundation.org> (maintainer:CPU POWER MONITORING SUBSYSTEM)
linux-pm@vger.kernel.org (open list:CPU POWER MONITORING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)



