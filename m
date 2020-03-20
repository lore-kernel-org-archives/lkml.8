Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E82C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D88920767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="h9BpRW81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCTPzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:55:09 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44034 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCTPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:55:09 -0400
Received: by mail-qv1-f65.google.com with SMTP id w5so3186952qvp.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kA54VswZsT5/CNlwIwZBY/H30VVL/ablHOI+ykDEfUw=;
        b=h9BpRW81+Xm0pLBVCmKH2IdQD4VSOMFNFWYiZwvPVdobwa/P6HtGQIJtQXZJXU5CLz
         qStLK2ZD5vaYWKNyFsI+0O7m7raDmTcfNQd55TxjcluITF+TqXPXWxIhrfuLMEASvnf1
         AWwe3LDrYTmqVPTDdtP3tKgwpar+TRSFwjRRXqBxfWp62gXvUBPt/nWvu9lPQhjOnOMt
         XDxekKzMPuj3xlrxEWmTLZIh3ki9YqmWRQWZZS3ILij5BEMMD4iArLkNYJPGq1hz3gr3
         YKJvqGki+efSkGuckkUDGK2qUr6vAI8G0OS72Xb530svwx80KSuJ4t1fAcZ6bsIDySzO
         TmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kA54VswZsT5/CNlwIwZBY/H30VVL/ablHOI+ykDEfUw=;
        b=O5ewxSzbO6gdZfuw3CoUpyAHA0TmDwMR+YyKj5ZRBuAWcfBj940T905/UsirdW4wyM
         HQH6R5frnnMsIQdpATuhB7qMvfmgz8vXcpXM0ucW7ov4f89kvS7Rk3XHy28uOU3XU31d
         WIOG8ypEK+nBadapCqdQzaCxVTrDQ9/fGqfY6ip0fSf+1AS7vmHkpIVs0Rc09+fxMZ1r
         6fIK+ZQZEDICXQNlMcykkVKPlwkotmkZVrznfW7CZ4jbRB9n/ezZQ8VoQw29GrsKYMmb
         Q2lMG19RgUFZQ76h8naK5g1vwEObijw7gpFMeLrTHTk997a1zUuRKj8m9PxqNvraErNu
         v4Nw==
X-Gm-Message-State: ANhLgQ0cCKtgXAg7duEjBYPNCtqkwLqsspthJduzVdQvep5nbeEQTmw6
        mvZtTaQtAe98hXntqMsuyg48W5evgqw=
X-Google-Smtp-Source: ADFU+vveo0N4CHbisUB5ArxqhCh+Kdu2UDfHtyEOWTY+K6g/iOG43vJUwa4Ie5ooLXrDSnkymo6JZw==
X-Received: by 2002:a0c:d601:: with SMTP id c1mr4222390qvj.164.1584719707712;
        Fri, 20 Mar 2020 08:55:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id c40sm5218215qtk.18.2020.03.20.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:55:06 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:55:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mateusznosek0@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/vmscan.c: Clean code by removing unnecessary
 assignment
Message-ID: <20200320155505.GA204561@cmpxchg.org>
References: <20200319165938.23354-1-mateusznosek0@gmail.com>
 <20200319171334.GK20800@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319171334.GK20800@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 06:13:34PM +0100, Michal Hocko wrote:
> It is usually preferable to Cc author of the code (added Johannes)
> 
> On Thu 19-03-20 17:59:38, mateusznosek0@gmail.com wrote:
> > From: Mateusz Nosek <mateusznosek0@gmail.com>
> > 
> > Previously 0 was assigned to 'sc->skipped_deactivate'. It could happen only
> > if 'sc->skipped_deactivate' was 0 so the assignment is unnecessary and can
> > be removed.
> 
> The above wording was a bit hard to understdand for me. I would go with
> "
> sc->memcg_low_skipped resets skipped_deactivate to 0 but this is not
> needed as this code path is never reachable with skipped_deactivate != 0
> due to previous sc->skipped_deactivate branch.
> "

Yeah that sounds good.

> > Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> The patch is correct. I am not sure it results in a better code though.
> I will defer to Johannes here. I suspect he simply wanted to express
> that skipped_deactivate should be always reset when retrying the direct
> reclaim. After this patch this could be lost in future changes so the
> code would be more subtle. But I am only guessing here.

It's a valid concern, but I think in this case specifically we're very
unlikely to change the ordering here - violate memory.low before going
after active pages of unprotected cgroups.

I indeed just kept it stupid: reset everything, then retry. But it
appears that the unnecessary assignment trips people up and wastes
their time, so I'm in favor of removing it.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
