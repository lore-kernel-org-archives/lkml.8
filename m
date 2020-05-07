Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F76C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC24C208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgEGUTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:19:02 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:35374 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:19:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CAE0D182D31F1;
        Thu,  7 May 2020 20:19:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paste82_6b8b670b6782c
X-Filterd-Recvd-Size: 3000
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 20:18:58 +0000 (UTC)
Message-ID: <3d88023b2da9ead8669d4c180b6c11ebf536abe7.camel@perches.com>
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Date:   Thu, 07 May 2020 13:18:57 -0700
In-Reply-To: <20200507154512.1065cba8@gandalf.local.home>
References: <20200507110625.37254-1-yanaijie@huawei.com>
         <jhjpnbg6lkf.mognet@arm.com> <20200507132828.1af39b80@gandalf.local.home>
         <20200507133024.18dbe349@gandalf.local.home>
         <f0e6f50e910238366b1d8f398c91d3066baac7cf.camel@perches.com>
         <20200507144534.09abd685@gandalf.local.home>
         <96fe70f11245433ce4f19bffaf2d167dbf69a2a0.camel@perches.com>
         <20200507154512.1065cba8@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 15:45 -0400, Steven Rostedt wrote:
> On Thu, 07 May 2020 12:06:56 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > People describe changes as a "fix" all the time for stuff
> > that isn't an actual fix for a logic defect but is instead
> > an update to a particular style preference.
> > 
> > Then the "fix" word causes the patch to be rather uselessly
> > applied to stable trees by AUTOSEL.
> > 
> > It's especially bad when the 'Fixes: <sha1> ("description")'
> > tag is also added.
> > 
> > It's a difficult thing to regulate and I don't believe a
> > good mechanism would be possible to add to checkpatch or
> > coccinelle to help isolate these things.
> > 
> > git diff -w sometimes helps, but that's not really a thing
> > that checkpatch could do.
> > 
> > Any suggestions?
> 
> I'm unfamiliar with how the coccinelle script is used, but I thought there
> was some discussion some time back to have checkpatch not produces the same
> kinds of warnings to code as it does to patches.
> 
> A lot of useless updates were being submitted when people were running
> checkpatch on existing kernel code and producing warnings that are not
> worth "fixing", but something that new code should try to avoid.

checkpatch already has several blocks that look like

	if (input_is_a_patch)
		warn(...)
	else if (input_is_a_file)
		check(...)

where by default, check() is not output.

I've also suggested variations discouraging checkpatch
use on files outside of drivers/staging/ multiple times

https://lore.kernel.org/lkml/0753cae7829b98998ac3f5f9fcb52ba1f2475ee1.camel@perches.com/


