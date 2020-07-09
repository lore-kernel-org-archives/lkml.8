Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9CCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9F2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGIQfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgGIQfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:35:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519D62077D;
        Thu,  9 Jul 2020 16:35:18 +0000 (UTC)
Date:   Thu, 9 Jul 2020 12:35:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, torvalds@linux-foundation.org,
        Tibor Raschko <tibrasch@gmail.com>
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200709123516.3972dee8@oasis.local.home>
In-Reply-To: <20200709161351.GF4960@sirena.org.uk>
References: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
        <e41ded21-1432-afa8-2e42-e509539281c4@gmail.com>
        <20200709124327.369781a0@coco.lan>
        <93fc3afb-8c3f-0fb9-3b92-adfb6571e060@linuxfoundation.org>
        <20200709161351.GF4960@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 17:13:51 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jul 09, 2020 at 10:01:18AM -0600, Shuah Khan wrote:
> > On 7/9/20 4:43 AM, Mauro Carvalho Chehab wrote:  
> 
> > > For coherency, if "blacklist/whitelist" won't be used anymore, an
> > > alternative to graylist should also be provided.  
> 
> > What is "graylist"? Does it mean in between allow/deny?  
> 
> Yes.  Typically it's used in situations where you don't want to deny
> something but might for example want to do extra checks to verify that
> things are OK.

The only time I use greylist is for postgrey, that when an email comes
in, it will initially reject it, expecting the mail server to try
again, and the second time it lets it through. This does stop a lot of
spam, at the cost of waiting up to a few hours for email :-/

-- Steve
