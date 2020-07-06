Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A55BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF3E206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGFW2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGFW2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:28:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D5EF206E9;
        Mon,  6 Jul 2020 22:28:21 +0000 (UTC)
Date:   Mon, 6 Jul 2020 18:28:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, torvalds@linux-foundation.org
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706182819.3467fa32@oasis.local.home>
In-Reply-To: <717030b7-ecba-2ca4-39ff-6a5a04a732d4@gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <1cceba0f-c8ad-260d-9a09-5417bee32d50@gmail.com>
        <20200706181052.174c290a@oasis.local.home>
        <717030b7-ecba-2ca4-39ff-6a5a04a732d4@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 01:17:47 +0300
Pavel Begunkov <asml.silence@gmail.com> wrote:

> Totally agree with you! But do we care then whether two _devices_ or _objects_
> are slave-master? Can't see how it fundamentally differs.

The term slave carries a lot more meaning than subordinate. I replied to
someone else but later realized that the person sent me their reply
offlist, so my reply to them was also offlist. What I told them was,
back in college (decades ago), when I first mentioned "master/slave" in
conversation (I think it was about hard drives), a person in that
conversation stated that those were not very nice terms to use. I blew
it off back then, but after listening to more people, I found that
using "slave" even to describe a device is not something that people
care to hear about.

And in actuality, does one device actually enslave another device? I
think that terminology is misleading to begin with.

-- Steve
