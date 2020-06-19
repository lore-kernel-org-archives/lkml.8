Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78117C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FC120776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbgFSOOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:14:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFSOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:14:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 5A77D2A3738
Date:   Fri, 19 Jun 2020 16:14:28 +0200
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     syzbot <syzbot+6bed2d543cf7e48b822b@syzkaller.appspotmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: null-ptr-deref Write in media_request_close
Message-ID: <20200619141428.6j2xcfsxleyvi7af@rcn-XPS-13-9360>
References: <000000000000aa674005a845bbc5@google.com>
 <CAAEAJfAOnTv1J-iSqEo3JdHr-JOZyWVGZcjnduJQOqaVhhx3kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAEAJfAOnTv1J-iSqEo3JdHr-JOZyWVGZcjnduJQOqaVhhx3kw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On jue 18-06-2020 15:38:16, Ezequiel Garcia wrote:
> Adding Ricardo.
> 
> Are we seeing this due to the recent syzkaller media controller additions?
> 
> Thanks,
> Ezequiel

It seems like it, yes. The MEDIA_IOC_REQUEST_ALLOC ioctl was defined in
https://github.com/google/syzkaller/commit/c5e085d96d1cdc855365b7fd9c1825b886f266f6

It's impressive how quickly it started yielding some results, especially
considering that the description was very basic and that there's no
other specific info about this api guiding the fuzzer.

Thanks for letting me know!

Cheers,
Ricardo
