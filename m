Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1E1206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgEONwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgEONwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:52:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC16D20671;
        Fri, 15 May 2020 13:52:17 +0000 (UTC)
Date:   Fri, 15 May 2020 09:52:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Siddharth Chandrasekaran <siddharth@embedjournal.com>,
        Siddharth Chandrasekaran <csiddharth@vmware.com>,
        srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH] Backport security fixe to 4.9 and 4.4 stable trees
Message-ID: <20200515095216.79fccd40@gandalf.local.home>
In-Reply-To: <20200515134009.GB2046686@kroah.com>
References: <cover.1589486724.git.csiddharth@vmware.com>
        <20200515124945.GA93755@csiddharth-a01.vmware.com>
        <20200515125701.GA1934886@kroah.com>
        <20200515132943.GA97579@csiddharth-a01.vmware.com>
        <20200515134009.GB2046686@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 15:40:09 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> > 
> >   "[PATCH v2] Backport xfs security fix to 4.9 and 4.4 stable trees"  
> 
> Sorry, I see no such email in my staging patch queue.
> 
> Do you have a link to the series on lore.kernel.org?  lkml.org is a mess
> and not under our control.

That's because it Cc'd stable@kernel.org and not stable@vger.kernel.org.

Should Siddharth resend?

-- Steve

