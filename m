Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E13CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A1E20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366897;
	bh=lQhl9VjPpQqPHD07ccAprin/eMBfjjoE6H6u38WkXG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qHMV58Zj0tKwRYkRCBLg45rNXyxBCU1TcXD5xDrNqFW9lvXNFKfdTFvjXqm27OwrB
	 exhZh4FxpsNr6ozxdqSzGcAUzRBjzzlPtg1AoA1L39nby9QSVJ8cWMfCn6hVN5EH+B
	 7NNRVAAjDDkVt+vBzyiqyRUdW8yXLn3kMRlKOpqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgFEOV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgFEOUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:20:15 -0400
Received: from linux-8ccs.fritz.box (p57a23121.dip0.t-ipconnect.de [87.162.49.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F392A208A9;
        Fri,  5 Jun 2020 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366814;
        bh=lQhl9VjPpQqPHD07ccAprin/eMBfjjoE6H6u38WkXG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1bANglDGNNAxIm0D9lBYOGI2a3GiqmxrciDb1YXY62MpCrwmyvnZ0UUHn99RQxRC
         funpZ/+Xjg/7isnDOsQkO1gbdu7SXGgfi1ab41YnAwhfM8JG4vMPvUhHKmDIJfZCaw
         MR5vvR3PNQleUjcEPg3nh34HLCQ+Y0eA0bL7IeMw=
Date:   Fri, 5 Jun 2020 16:20:10 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 11/11] module: Make module_enable_ro() static again
Message-ID: <20200605142009.GA5150@linux-8ccs.fritz.box>
References: <cover.1588173720.git.jpoimboe@redhat.com>
 <d8b705c20aee017bf9a694c0462a353d6a9f9001.1588173720.git.jpoimboe@redhat.com>
 <20200605132450.GA257550@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200605132450.GA257550@roeck-us.net>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Guenter Roeck [05/06/20 06:24 -0700]:
>On Wed, Apr 29, 2020 at 10:24:53AM -0500, Josh Poimboeuf wrote:
>> Now that module_enable_ro() has no more external users, make it static
>> again.
>>
>> Suggested-by: Jessica Yu <jeyu@kernel.org>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>> Acked-by: Miroslav Benes <mbenes@suse.cz>
>
>Apparently this patch made it into the upstream kernel on its own,
>not caring about its dependencies. Results are impressive.
>
>Build results:
>	total: 155 pass: 101 fail: 54
>Qemu test results:
>	total: 431 pass: 197 fail: 234
>
>That means bisects will be all but impossible until this is fixed.
>Was that really necessary ?

Sigh, I am really sorry about this. We made a mistake in handling
inter-tree dependencies between livepatching and modules-next,
unfortunately :-( Merging the modules-next pull request next should
resolve the module_enable_ro() not defined for
!ARCH_HAS_STRICT_MODULE_RWX build issue. The failure was hidden in
linux-next since both trees were always merged together. Again, it
doesn't excuse us from build testing our separate trees more
rigorously.

