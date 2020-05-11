Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E6C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B3120714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgEKRLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730800AbgEKRLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:11:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EEDC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:11:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 53C852A0CAC
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        song@kernel.org, breeves@redhat.com, mpatocka@redhat.com,
        khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH v4 0/2] Historical Service Time Path Selector
Organization: Collabora
References: <20200511163910.3778467-1-krisman@collabora.com>
        <20200511170235.GA7719@redhat.com>
Date:   Mon, 11 May 2020 13:11:44 -0400
In-Reply-To: <20200511170235.GA7719@redhat.com> (Mike Snitzer's message of
        "Mon, 11 May 2020 13:02:35 -0400")
Message-ID: <85ftc6l7lb.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer <snitzer@redhat.com> writes:

> On Mon, May 11 2020 at 12:39pm -0400,
> Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
>
>> Hi,
>> 
>> This fourth version of HST applies the suggestion from Mikulas Patocka
>> to do the ktime_get_ns inside the mpath map_bio instead of generic
>> device-mapper code. This means that struct dm_mpath_io gained another
>> 64bit field.  For the request-based case, we continue to use the block
>> layer start time information.
>> 
>> With this modification, I was able obtain similar performance on  BIO
>> to request-based multipath with HST on the benchmarks shared in v1.
>> 
>> v3: https://www.redhat.com/archives/dm-devel/2020-April/msg00308.html
>> v2: https://www.redhat.com/archives/dm-devel/2020-April/msg00270.html
>> v1: https://www.redhat.com/archives/dm-devel/2020-April/msg00176.html
>
> I already staged your v3 in linux-next.  Please provide an incremental
> patch that layers on this git branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.8
>
> I was hopeful for a flag to be set (e.g. in 'struct path_selector') to
> reflect whether the path selector expects highres start_time.  Makes
> little sense to incur that extra cost of providing the time if the path
> selector doesn't even use it.
>
> Alternatively, could split out the setting of the time needed by .end_io
> to a new path_selector_type method (e.g. .set_start_time).  And then
> only use ktime_get_ns() for bio-based if .set_start_time is defined.
> Would get a little fiddly needing to make sure a stale start_time isn't
> used... also, makes more sense to conditionally call this
> .set_start_time just after .start_io is.

Oh, my apologies, I hadn't noticed it was merged.  I will make the time fetch
conditional and submit a new patch based on that branch.

Thanks,


-- 
Gabriel Krisman Bertazi
