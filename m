Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00F520658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585015937;
	bh=vIX3tHFAx/hb9jO3Yfjn2tf5HJ8jGnDTBy6+RNXlgps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1YKFE927wfVqmWR3SNfegbnvkbEXeF7LuPkdrBle33DZmMxkEr+tjg5PkN/rBkr1B
	 oGElr3IhdXPE26yaE44NXFJu/sapUHP4mBedLL3/AiSb3GdaXCTcUa7lLFCTUREoOy
	 kTnWV3ailR1QaWzHfHCE3lA2sSRF7gYeT1qvRh6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCXCMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 22:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgCXCMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:12:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2C22051A;
        Tue, 24 Mar 2020 02:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585015935;
        bh=vIX3tHFAx/hb9jO3Yfjn2tf5HJ8jGnDTBy6+RNXlgps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SPyIEi4vkVu4m1Vha3wtARhomeuEyxJozvXFV2ca6mYGGi9SlR9F0K283pmtsJZP2
         /71LVu/LuMBHCodny2FlhGyRto/IB8rg+hSOQC2pYy7diC4Zt3vFHxN4jSyjytP5FT
         SYkzNY8/6QDvCgGuphxjFySH/00evY6w/P8ZVQ4Y=
Date:   Mon, 23 Mar 2020 19:12:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass
 check_kill_permission()
Message-Id: <20200323191214.81a60c4ae1a59fdbd5c5d46d@linux-foundation.org>
In-Reply-To: <87imivc92n.fsf@x220.int.ebiederm.org>
References: <20200322110901.GA25108@redhat.com>
        <87lfnsh3tm.fsf@x220.int.ebiederm.org>
        <20200322202929.GA1614@redhat.com>
        <87imivc92n.fsf@x220.int.ebiederm.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020 11:47:12 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:

> I really just want to be certain that things are fixed well enough that
> we don't risk a regressing again the next time someone touches the code.

That would be nice ;)

But as Oleg indicated, please let's have something minimal for -stable
backporting friendliness.  A more comprehensive change can then be
merged following the regular processes.
