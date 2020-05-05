Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B4C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E28207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgEEPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgEEPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:54:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5919BC061A0F;
        Tue,  5 May 2020 08:54:13 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E6A8A31A;
        Tue,  5 May 2020 15:54:12 +0000 (UTC)
Date:   Tue, 5 May 2020 09:54:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Kitt <steve@sk2.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] docs: sysctl/kernel: document ftrace entries
Message-ID: <20200505095411.75d49151@lwn.net>
In-Reply-To: <20200429205801.5ce95ab3@oasis.local.home>
References: <20200429205757.8677-1-steve@sk2.org>
        <20200429205801.5ce95ab3@oasis.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 20:58:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 29 Apr 2020 22:57:56 +0200
> Stephen Kitt <steve@sk2.org> wrote:
> 
> > Based on the ftrace documentation, the tp_printk boot parameter
> > documentation, and the implementation in kernel/trace/trace.c.
> > 
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > ---
> > Changes since v2:
> >   - spelling and grammar fixes in ftrace_dump_on_oops ("outputing it"  
> >     -> "outputting them")    
> >   - "and::" in a single line in tracepoint_printk  
> 
> I didn't re-read or compare this patch with v1, but if the only changes
> were the above:
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Both applied, thanks.

jon
