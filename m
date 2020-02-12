Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B7C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7D220675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROy4OD1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBLLka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:40:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726351AbgBLLka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581507628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FfAXyeidMWXjbA4H6fILpgXDELOT1ZKn0WXC3ILBGCI=;
        b=ROy4OD1TVdf4Vs/55xD6IbH0TSWiTJtEH0pSYNo8MoaEfEMp6g5jZH0vh4Vveu+j4QMdT4
        rfkzDPSP29ng9wMqDqlJgdzkqE/FhkWq3pd3pD0DNEKNTevyCShi8DfseeXbLSFqFIwIuX
        nbDkUij2h54niePmuitpwv9poWW9Hag=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-fhmtvf6xPCWDDJ1x69FbVQ-1; Wed, 12 Feb 2020 06:40:22 -0500
X-MC-Unique: fhmtvf6xPCWDDJ1x69FbVQ-1
Received: by mail-ot1-f71.google.com with SMTP id t10so1029878otc.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfAXyeidMWXjbA4H6fILpgXDELOT1ZKn0WXC3ILBGCI=;
        b=VFt/feO04b6VW1abM998iOUOZ2X4RE7S2MOr3WjGPLwnL4MPgp+b56rYlg5Fhfgyau
         Ad4+RRyngIkL2RIhX/PkCIk89tQ8Pp6ejrVDElU4DUMEJ67/PTOJhrRtLdzkVMS9BzXo
         AJ5UEV2tLq6F5kj5RP9mkc4buOylRhcWTTZJEvMr26QyU65JBdIJfVUxWU1JU8IEMZgk
         jraWhZYYqT+SAWKxqnuxaY3kWdsFycea952pDCX0q82CopMQaDMfJW25M/QLChLf2+Ch
         qAx41VKmje9R/RZn6uuA12BAnrf9IUXsBNYXcw7l4jKP7y72MAgBZ76LgkMSP+E9XdPI
         I4zg==
X-Gm-Message-State: APjAAAXoaoUbtUxvilc55s8juEkqhn6eDIcZXkuHzqBIEq3lHPLrF0gb
        Jy/U04o2GrsJSs/kw70i3ahgw1xqNKRUTUvNuymzm6VIwmnYkJlrsxETGWYViduf0/fujymxw76
        uPdVLrvKx+kG9puBxt/sEUBB9B3A/oh0Ic/61lDDF
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr9308335otn.22.1581507621551;
        Wed, 12 Feb 2020 03:40:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmHPAusedPvn3NasHIbzIUy+Tp1fDKbJiLYR5qrXn7uN8K4/voeKPT4Ne4t4VyOHDj4v1CVWz7vv9Y1PtVlwI=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr9308318otn.22.1581507621291;
 Wed, 12 Feb 2020 03:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20200116213937.77795-1-dev@lynxeye.de>
In-Reply-To: <20200116213937.77795-1-dev@lynxeye.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 Feb 2020 12:40:07 +0100
Message-ID: <CAFqZXNsfq+JbTtEZtk-2NO8ciGLFy+n3hNP6HX9hTDOdCit5hA@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: policydb - convert filename trans hash to rhashtable
To:     Lucas Stach <dev@lynxeye.de>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On Thu, Jan 16, 2020 at 10:48 PM Lucas Stach <dev@lynxeye.de> wrote:
> The current hash is too small for current usages in, e.g. the Fedora standard
> policy. On file creates a considerable amount of CPU time is spent walking the
> the hash chains. Increasing the number of hash buckets somewhat mitigates the
> issue, but doesn't completely get rid of the long hash chains.
>
> This patch does take the bit more invasive route by converting the filename
> trans hash to a rhashtable to allow this hash to scale with load.
>
> fs_mark create benchmark on a SSD device, no ramdisk:
> Count          Size       Files/sec     App Overhead
> before:
> 10000          512        512.3           147715
> after:
> 10000          512        572.3            75141
>
> filenametr_cmp(), which was the topmost function in the CPU cycle trace before
> at ~5% of the overall CPU time, is now down in the noise.
>
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
>  security/selinux/ss/policydb.c | 140 +++++++++++++++++++++++----------
>  security/selinux/ss/policydb.h |  14 ++--
>  security/selinux/ss/services.c |  31 +-------
>  3 files changed, 109 insertions(+), 76 deletions(-)
>

FYI, I posted a related patch series [1] that should have a similar
effect on the file create performance, plus it also reduces memory
taken up by the file transition rules. It would be great if you could
test it vs. your (fixed) patch to see if it works for you.

Thanks!

[1] https://lore.kernel.org/selinux/20200212112255.105678-1-omosnace@redhat.com/T/

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

