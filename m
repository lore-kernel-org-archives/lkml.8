Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C3D20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="ga2vFClR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbgEZVxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389025AbgEZVxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:53:36 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1C9C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:53:36 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 066682304C;
        Tue, 26 May 2020 23:53:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590530014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J94mq7YaQchypeS8DqKys5TI5cDZkg0C76Q0ICpsLgM=;
        b=ga2vFClR52fg1Z0aEIYcI5FkqrgK8eNiQq/FW3kozrzEq4FCpvW65AsogXjiJbbRFfsbS/
        W84b3qsp3I+DfAL9fSMduwQMjUG/2Y+TV8YqeY6Ht4wZ+y5NPPU+thDUlNcF8jHyqjLigQ
        LgxFEBI/v8aLZVWKlI2RflQihSPgXQA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 May 2020 23:53:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] driver core: Update device link status correctly for
 SYNC_STATE_ONLY links
In-Reply-To: <CAGETcx_jyE2UyP4ovT3KXhjOenRhpUPQAqDtTcgfgenW5NGQgA@mail.gmail.com>
References: <20200526194328.258722-1-saravanak@google.com>
 <66f871c4c457d908ea86545c1aa871bf@walle.cc>
 <CAGETcx_jyE2UyP4ovT3KXhjOenRhpUPQAqDtTcgfgenW5NGQgA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <0b68cbd8169d1c88a850b0fda3b1cf3f@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-05-26 23:45, schrieb Saravana Kannan:
> On Tue, May 26, 2020 at 2:13 PM Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-05-26 21:43, schrieb Saravana Kannan:
>> > When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
>> > core: Add device link support for SYNC_STATE_ONLY flag"),
>> > SYNC_STATE_ONLY links were treated similar to STATELESS links in terms
>> > of not blocking consumer probe if the supplier hasn't probed yet.
>> >
>> > That caused a SYNC_STATE_ONLY device link's status to not get updated.
>> > Since SYNC_STATE_ONLY device link is no longer useful once the
>> > consumer probes, commit 21c27f06587d ("driver core: Fix
>> > SYNC_STATE_ONLY device link implementation") addresses the status
>> > update issue by deleting the SYNC_STATE_ONLY device link instead of
>> > complicating the status update code.
>> >
>> > However, there are still some cases where we need to update the status
>> > of a SYNC_STATE_ONLY device link. This is because a SYNC_STATE_ONLY
>> > device link can later get converted into a normal MANAGED device link
>> > when a normal MANAGED device link is created between a supplier and
>> > consumer that already have a SYNC_STATE_ONLY device link between them.
>> >
>> > If a SYNC_STATE_ONLY device link's status isn't maintained correctly
>> > till it's converted to a normal MANAGED device link, then the normal
>> > MANAGED device link will end up with a wrong link status. This can
>> > cause
>> > a warning stack trace[1] when the consumer device probes successfully.
>> >
>> > This commit fixes the SYNC_STATE_ONLY device link status update issue
>> > where it wouldn't transition correctly from DL_STATE_DORMANT or
>> > DL_STATE_AVAILABLE to DL_STATE_CONSUMER_PROBE. It also resets the
>> > status
>> > back to DL_STATE_DORMANT or DL_STATE_AVAILABLE if the consumer probe
>> > fails.
>> >
>> > [1] - https://lore.kernel.org/lkml/20200522204120.3b3c9ed6@apollo/
>> > Fixes: 05ef983e0d65 ("driver core: Add device link support for
>> > SYNC_STATE_ONLY flag")
>> > Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link
>> > implementation")
>> > Reported-by: Michael Walle <michael@walle.cc>
>> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>> > ---
>> >
>> > v1->v2:
>> > - Added code to "revert" the link status if consumer probe fails
>> >
>> > Greg,
>> >
>> > I think this is the issue Michael ran into. I'd like him to test the
>> > fix
>> > before it's pulled in.
>> >
>> > Michael,
>> >
>> > If you can test this on the branch you saw the issue in and give a
>> > Tested-by if it works, that'd be great.
>> 
>> with v2 I'm triggering the
>>    WARN_ON(!(link->status & DL_FLAG_SYNC_STATE_ONLY));
>> in __device_links_no_driver().
> 
> Thanks for the logs! The WARNING is due to a dump typo in this line. I
> should be checking link->flags, not link->status here. I'll send out a
> v3, but you can test with this change too.

Ahh, right. With that fix you can add:

Tested-by: Michael Walle <michael@walle.cc>

Thanks,
-michael
