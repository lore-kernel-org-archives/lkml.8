Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E44C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62C820772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="Sh/ZzqZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbgDARWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:22:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40737 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgDARWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:22:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id y25so718782qtv.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xTRlV/+OJrlZT0JK0WxSLE6AeDjc28F3deBsYW9Nn18=;
        b=Sh/ZzqZ+gIp2imFS6l85/eOVYyu0fnjpakqSuVDeBHB9HZgzzJE9Mdpu8huO5OUpT2
         /Jt75OewJHCjiqkJGzWJs4hSrGbGk44VJuGXQxvfNfYje3JSD/6aooOizJdXfkh+1BkQ
         9YVe57gMiD8kiYIqo4XySYo8X3CnANAPnqJp8lYVtYtHTiXQrBmsJHLxjHfAKKLFCRWZ
         JqnFjoDySrzIgEoMBdFYYvFFJJcx2lBfHRy3WQH/xW9UJmkDSBSGfMdIZ0RMgHBA3t/i
         Jg6zr1XKzxat13iKDv/x2NBBwKxLwYax/aRezAdh8g3XBoJyNnHis3lWlV4vR8oHxbbq
         Zibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xTRlV/+OJrlZT0JK0WxSLE6AeDjc28F3deBsYW9Nn18=;
        b=LPYHkflv0iE+pywaZnRVktGhQ0rfswV25hM7KWrYtcCdLtCjTWES0TG6v4Y+7yKgO9
         yt3tCF5B6WQwfHiysxI/couj3RHpr6Tq3gEXzALIU9Ov8o3K8jOZZdL6vkiWSgSm8yg5
         76YQzMHpm7ZGiM3F2NnDCnF3cs3ZOhYQYgu784NJCcSuUBQTHa+N2bjNWfb5yB34mioc
         KVd6Wzkh+De7Pp7CDv6yOlrKXJAI5Vzvd/Pfs/Z1MBT4TsNa6sdeN3m9HUXOvV3WoJ1x
         rKO5No6wfDJVe3r+OfYylR+iBy9sl0VKnKqE+6WxUdKUmuxAYybTVWE4+DNPzlk2kLal
         F/lw==
X-Gm-Message-State: AGi0PuYZD461BHWrn40e1n6OjbxVt0R+NyA0b4aDCzfqnb1ly4rqLsJj
        x4O5I0R/5jVIpMfmh7FsMlhHfA==
X-Google-Smtp-Source: APiQypK8VTn5wASrvf6hQCinJh9tWaD1/IFdVQbeVSom0dhZPO/oqNr4fTPMT4+n4w0Kk82ZKZUDiA==
X-Received: by 2002:ac8:7397:: with SMTP id t23mr676471qtp.196.1585761748385;
        Wed, 01 Apr 2020 10:22:28 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id c27sm1825241qkk.0.2020.04.01.10.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 10:22:27 -0700 (PDT)
Message-ID: <0b87192534e3b792cbefe0fb5ef771b79ee0f050.camel@massaru.org>
Subject: Re: [Linux-kernel-mentees] [PATCH 1/2] Documentation: filesystems:
 Convert sysfs-pci to ReST
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     bjorn@helgaas.com, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathew Wilcox <willy@infradead.org>
Date:   Wed, 01 Apr 2020 14:22:23 -0300
In-Reply-To: <CABhMZUUqERRO-4EWabuesK5+ZQNzOFQmaND-tw7j4q5D8UX33g@mail.gmail.com>
References: <cover.1585693146.git.vitor@massaru.org>
         <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
         <20200331165707.7c708646@lwn.net>
         <CABhMZUUqERRO-4EWabuesK5+ZQNzOFQmaND-tw7j4q5D8UX33g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 21:33 -0500, Bjorn Helgaas wrote:
> On Tue, Mar 31, 2020 at 5:57 PM Jonathan Corbet <corbet@lwn.net>
> wrote:
> > On Tue, 31 Mar 2020 19:28:56 -0300
> > Vitor Massaru Iha <vitor@massaru.org> wrote:
> > 
> > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > ---
> > >  .../{sysfs-pci.txt => sysfs-pci.rst}          | 40 ++++++++++---
> > > ------
> > >  1 file changed, 22 insertions(+), 18 deletions(-)
> > >  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-
> > > pci.rst} (82%)
> > 
> > Please supply a changelog with your patches.
> > 
> > The conversion you have done in this file is incomplete; I suspect
> > that
> > you have not actually built the docs and seen what the results look
> > like.
> > There are literal blocks that you have not marked as such, as a
> > minimum.
> > Please actually do a docs build (after adding this file to
> > index.rst) and
> > make sure that the output is what you intended.
> > 
> > One other thing of note...this file dates back to before the Git
> > era, and
> > while it has seen numerous tweaks since then, it's clearly
> > outdated.  Look
> > at what's actually under /sys/devices/pci* compared to what's
> > documented.
> > I will take the conversion without it, but what I would really like
> > to see
> > would be an effort to document all of the attributes that appear
> > there
> > with current kernels.
> 
> If you do go ahead and add/change content (as opposed to simply doing
> the .txt -> .rst conversion), please do the conversion and the
> content
> changes in separate patches.  That way the content changes will be
> easier to review because they won't be mixed in with a lot of
> mechanical .rst changes.
> 
> Bjorn

Sure, thanks for the review.

BR,
Vitor

