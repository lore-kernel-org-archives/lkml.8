Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86696C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAA220772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgGBMTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbgGBMTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:19:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D989F20772;
        Thu,  2 Jul 2020 12:19:50 +0000 (UTC)
Date:   Thu, 2 Jul 2020 08:19:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        John Warthog9 Hawley <warthog9@kernel.org>
Subject: Re: [for-next][PATCH 8/8] ktest.pl: Add MAIL_MAX_SIZE to limit the
 amount of log emailed
Message-ID: <20200702081949.2bfd2417@oasis.local.home>
In-Reply-To: <20200702074103.GA1076415@kroah.com>
References: <20200701231717.757834010@goodmis.org>
        <20200701231756.790637968@goodmis.org>
        <20200702074103.GA1076415@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 09:41:03 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jul 01, 2020 at 07:17:25PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Add the ktest config option MAIL_MAX_SIZE that will limit the size of the
> > log file that is placed into the email on failure.
> > 
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  tools/testing/ktest/ktest.pl    | 12 +++++++++++-
> >  tools/testing/ktest/sample.conf | 13 +++++++++++++
> >  2 files changed, 24 insertions(+), 1 deletion(-)  
> 
> Interesting, but I like full log files for my reports :)

I can add an option to do that if you want. My full logs end up being a
few hundred megabytes. Perhaps I could add a compress option too.

> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

-- Steve
