Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBA6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35F920714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1RDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:03:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:54258 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1RDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 13:03:53 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E5CAA2F3;
        Sat, 28 Mar 2020 17:03:52 +0000 (UTC)
Date:   Sat, 28 Mar 2020 11:03:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Grant Likely <grant.likely@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, nd@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Add documentation on meaning of -EPROBE_DEFER
Message-ID: <20200328110351.4e50491e@lwn.net>
In-Reply-To: <CAGETcx_0=W6P_Zf-6fvDfncXUrPvt31bf6de-RWwHaXtwJizmQ@mail.gmail.com>
References: <20200327170132.17275-1-grant.likely@arm.com>
        <CAGETcx8CJqMQaHBj1r5MhNBTw7Smz4BRHPkB0kCUCJPSmW6KwA@mail.gmail.com>
        <2885b440-77a5-f2be-7524-d5fba2b0c08a@arm.com>
        <CAGETcx_0=W6P_Zf-6fvDfncXUrPvt31bf6de-RWwHaXtwJizmQ@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 16:55:34 -0700
Saravana Kannan <saravanak@google.com> wrote:

> > > The infinite loop is a current implementation behavior. Not an
> > > intentional choice. So, maybe we can say the behavior is undefined
> > > instead?  
> >
> > If you feel strongly about it, but I don't have any problem with
> > documenting it as the current implementation behaviour, and then
> > changing the text if that ever changes.  
> 
> Assuming Greg is okay with this doc update, I'm kinda leaning towards
> "undefined" because if documented as "infinite loop" people might be
> hesitant towards removing that behavior. But I'll let Greg make the
> final call. Not going to NACK for this point.

FWIW, kernel developers have to cope with enough trouble from "undefined
behavior" already; I don't think we should really be adding that to our
own docs.  We can certainly document the infinite loop behavior as being
not guaranteed as part of the API if we're worried that somebody might
start to rely on it...:)  

Thanks,

jon
