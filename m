Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74184C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD952070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgDZUAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:00:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57658 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgDZUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 16:00:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8605C2A092E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH 0/2] Historical Service Time Path Selector
Organization: Collabora
References: <20200416211336.2423618-1-krisman@collabora.com>
        <20200423205947.GA13657@lobo>
Date:   Sun, 26 Apr 2020 16:00:17 -0400
In-Reply-To: <20200423205947.GA13657@lobo> (Mike Snitzer's message of "Thu, 23
        Apr 2020 16:59:47 -0400")
Message-ID: <855zdm2f1q.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer <snitzer@redhat.com> writes:

>
> Looks like you've put a lot of time to this and I'd be happy to help
> you get this to land upstream.
>
> But... (you knew there'd be at least one "but" right? ;) I'm not
> liking making this path selector request-based specific.  All other
> selectors up to this point are request-based vs bio-based agnostic.
>
> Would you be open to dropping patch 1/2 and replacing it with
> something like the following patch?
>
> Then you'd pass 'u64 start_time_ns' into the path_selector_type's
> .end_io (and possibly .start_io).

I think it is fine.

Kind of a MD newbie question, but if I understand correctly,
dm_start_time_ns_from_clone is only for bio based multipath, and we just
pass req->io_start_time directly on request based multipath, right?  If
I understand the code correctly, start_io_acct is only called for the
bio level DM.

I will update the patches, do a quick round of tests with BIO based and
send a v2.

Thanks a lot,

-- 
Gabriel Krisman Bertazi
