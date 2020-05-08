Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1068DC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D632020CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588896294;
	bh=Ge3nz8WZOJFqzpXNiv8nhoHil6SjiIANRuschyeYJ1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UHe8W0VXMz/VpJR6Z5uQbCev/bvkIpvSdo8XYB+zC0vQo/qYGTHSUQvb/FvkAkglv
	 5YBu4w+hvbLZNbRTdh3UPwg/oqfLN71mtrN7BjHk9gG/2swktak4dymp/RV/j2f5Fs
	 n0QwVIPcnbbZpjGlRu6U5iW0mpvjKRikdMDprpM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHAEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgEHAEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:04:53 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B940E2082E;
        Fri,  8 May 2020 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588896292;
        bh=Ge3nz8WZOJFqzpXNiv8nhoHil6SjiIANRuschyeYJ1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rjnpwkGmtJKw/4mwFZHZOgAKysf0TfYIOxoqLbOdRr0lNDtGxLdWBH+W5B+mjNczy
         hexKcPq4DCCPhnsl/bonhuZdi7xChtTfSjJuuGJRZxTYWiAimDTLfu+a6alnuxYhvw
         +B9mhA6pqBO41LUKlJtfY88v6rq+xxISTZDx+NBc=
Date:   Thu, 7 May 2020 17:04:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH v2] stacktrace: cleanup inconsistent variable type
Message-Id: <20200507170448.661b1ef6cf8d870bb19e8cc6@linux-foundation.org>
In-Reply-To: <1588731504.7745.3.camel@mtksdccf07>
References: <20200421013511.5960-1-walter-zh.wu@mediatek.com>
        <d2a9f155-f309-0182-73c9-5c02d7014574@acm.org>
        <1588731504.7745.3.camel@mtksdccf07>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 10:18:24 +0800 Walter Wu <walter-zh.wu@mediatek.com> wrote:

> On Wed, 2020-04-22 at 18:21 -0700, Bart Van Assche wrote:
> > On 4/20/20 6:35 PM, Walter Wu wrote:
> > > Modify the variable type of 'skip' member of struct stack_trace.
> > > In theory, the 'skip' variable type should be unsigned int.
> > > There are two reasons:
> > > - The 'skip' only has two situation, 1)Positive value, 2)Zero
> > > - The 'skip' of struct stack_trace has inconsistent type with struct
> > >    stack_trace_data, it makes a bit confusion in the relationship between
> > >    struct stack_trace and stack_trace_data.
> > 
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
> Hi Andrew,
> 
> Would you know why not to be picked up this patch yet?
> Do I miss somethings?

I'd decided to pass on this because it's so minor.  We inappropriately
use signed types in soooo many places :(
