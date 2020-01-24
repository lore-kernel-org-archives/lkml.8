Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902542071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="D57LaX6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbgAXUKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:10:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42385 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgAXUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:10:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so3797585edv.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EW6Y/EZHZi/ttUxTUSXyYBrJLM6UmlUPE/P/09OJMp8=;
        b=D57LaX6fPIH9yUp1n9+Oi2UloLj6giH8ArlR4WpiryOjEWH0YZzmHpB7st9eYWD7TS
         3j+v+LFsCXuf38Ry79+XOYI8bX8rWiHVP83p0KFyhcNBtyplhPLMBFeQgyCznZeNhu4d
         bnUnov6ftmIi4qUTGqr5SEUrcbtZUY6nZZ2nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EW6Y/EZHZi/ttUxTUSXyYBrJLM6UmlUPE/P/09OJMp8=;
        b=bvQq6Q9wIRe0cwBAoJvCWK9FnITy1inhx9Z2pU3yYJLy6ZbJe+FVkM5UaCaIXiSaE9
         FY7Z7y953CgIoS20ao7xbu2Adlq4rJp67D/esJW+OUTgaZS4HrsIvx+0CaswEYV7MSA9
         4oUlU+rZk8iDJ0n7sAUgoW6Zj+A9+nGOf9vgtm/qxdUMvqvk4vmgtHO9PgPvZa4R9otv
         mb2hJ35rXe6SebpGhswWxeN80X26oeaMEt7IwYGd9VdQxmltZLkFwO2tESKJySA1BGtU
         04GLOXhAe0wmqMfjo+0jcrsS0Yhro7k+hf2HodqiWcrMzXsEwU9xKO7UcXVu7h2+MNS4
         iWkw==
X-Gm-Message-State: APjAAAV5IhTo0pP4veBuzu/kBdsnqi2s8dG54QU2UwteaMJiNqvPuh3Z
        6ToDx1+7GUx8kswBD0xULIKzcyPYHcrtOrRu6nTbRA==
X-Google-Smtp-Source: APXvYqwWJyOj8lNCsez+rW7XtOC4RGJBUgl+VpwoBouyvHuLrvQ3yPoOq7ALyHD46F67pPGbj4kMWn5TGsuAHVWCMdo=
X-Received: by 2002:a17:906:680b:: with SMTP id k11mr4160436ejr.0.1579896613104;
 Fri, 24 Jan 2020 12:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20200124091743.3357-1-sargun@sargun.me> <20200124091743.3357-4-sargun@sargun.me>
 <20200124180332.GA4151@cisco>
In-Reply-To: <20200124180332.GA4151@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 24 Jan 2020 12:09:37 -0800
Message-ID: <CAMp4zn_WXwxJ6Md4rgFzdAY_xea4TmVDdQc1iJDObEMm5Yc79g@mail.gmail.com>
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:03 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Fri, Jan 24, 2020 at 01:17:42AM -0800, Sargun Dhillon wrote:
> > Currently, this just opens the group leader of the thread that triggere
> > the event, as pidfds (currently) are limited to group leaders.
>
> I don't love the semantics of this; when they're not limited to thread
> group leaders any more, we won't be able to change this. Is that work
> far off?
>
> Tycho

We would be able to change this in the future if we introduced a flag like
SECCOMP_USER_NOTIF_FLAG_PIDFD_THREAD which would send a
pidfd that's for the thread, and not just the group leader. The flag could
either be XOR with SECCOMP_USER_NOTIF_FLAG_PIDFD, or
could require both. Alternatively, we can rename
SECCOMP_USER_NOTIF_FLAG_PIDFD to
SECCOMP_USER_NOTIF_FLAG_GROUP_LEADER_PIDFD.
