Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F5BC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73502078C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szyVRdKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCZWD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:03:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53281 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCZWD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:03:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so9045719wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVqQ7MESPq+AdE5FevBfn8AolxVmIzRfASYgM+H4STI=;
        b=szyVRdKUxChTizOYbqe+xujjj60j68XNY2SNyiTfGDb2FOQdOSEPl8zDMtKzEbkOEZ
         jtQCP5i4iuVP5zMrvcycKgn+qO0lKj6TLMeJBhnVXT7oeJu21WuKDaUh+y8ixfdNBFQE
         6oFyY3Q/46KVNkl3A8NeA+LMUYdpO7Slu4Tee/ERY9zUHc82YMPuRjGkqdBeKwfxRCqI
         KqUxD+S3Z4nw18kpiJmpbKA3PX2nTDSUVzJgPVy956S23Br/VEIcdC+LK3Daw9ljv9+8
         qhXItEAmwk5k03a/QD0NnuHKpqd5PPMt7j1aOKfkpLTyiT23voWFEOtliyOSwkXqS9x8
         b3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVqQ7MESPq+AdE5FevBfn8AolxVmIzRfASYgM+H4STI=;
        b=ZpQa/5Mn4D+wnVjaEu80x31btNKQW4P0qN73ksYR+Zxeg54yg1eT7mjo7REgf2pFmn
         WLiOPUA/bjQksFlMmLegIzu1wC8AnZnqg6663g0EPErUOoectjFmHtVcuAaAYSZYfkRV
         ooOSF/VvhMZCfeDLFv9Uq6HC7cYM9tS2z+GwScYZ40sC/bo1djRb8zVFsn9Phj2By1ja
         d3jXUUwFKOvXkWERH/ziPF/5r96PYn7bFU9N7t+JStN2mNIOtk0GvItqVjnntMVhf/hH
         9Zco/3qqLh/0MnNvJ4Ut2jOOTPre5ASm8NqOW+wDn4kd+2rCbxzpQHCcx3Yt21OQbbr+
         lC5g==
X-Gm-Message-State: ANhLgQ3/Jyq42Z7BB9ocWNtDSfpHz7BDTNODHbKcwFPmZw18AIQF6fXh
        m+ZCKqBpIV8KosHWgxq1pajC2CgxDZR5eGQJXc2xlg==
X-Google-Smtp-Source: ADFU+vvMOIE+L0ZTf7lmFa3S++2BBLAB6zolh3w3IlymO56zrtRps0+OWtJzfllf8QITGyf0P7J6Gml1J+knvxy+Wb8=
X-Received: by 2002:adf:b60d:: with SMTP id f13mr12155953wre.12.1585260235721;
 Thu, 26 Mar 2020 15:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org> <20200326194448.GA133524@google.com>
 <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com> <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
 <e9093ab2-f61f-edf1-5da7-fce5101d6dbf@redhat.com>
In-Reply-To: <e9093ab2-f61f-edf1-5da7-fce5101d6dbf@redhat.com>
From:   Sonny Rao <sonnyrao@google.com>
Date:   Thu, 26 Mar 2020 15:03:42 -0700
Message-ID: <CAPz6YkXVYJBow-6G023eaDEKFORPh3AKQb6gfrM8XX8=bdXL2A@mail.gmail.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Waiman Long <longman@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        Jesse Barnes <jsbarnes@google.com>, vpillai@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 2:47 PM Waiman Long <longman@redhat.com> wrote:
>
> On 3/26/20 4:05 PM, Sonny Rao wrote:
> >> I think Tejun is concerned about a change in the default behavior of
> >> cpuset v1.
> >>
> >> There is a special v2 mode for cpuset that is enabled by the mount
> >> option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
> >> v2 behavior. I introduced this v2 mode a while back to address, I think,
> >> a similar concern. Could you try that to see if it is able to address
> >> your problem? If not, you can make some code adjustment within the
> >> framework of the v2 mode. As long as it is an opt-in, I think we are
> >> open to further change.
> > I am surprised if anyone actually wants this behavior, we (Chrome OS)
> > found out about it accidentally, and then found that Android had been
> > carrying a patch to fix it.  And if it were a desirable behavior then
> > why isn't it an option in v2?
> >
> I am a bit confused. The v2 mode make cpuset v1 behaves more like cpuset
> v2. The original v1 behavior has some obvious issue that was fixed in
> v2. So what v2 option are you talking about?

I was merely pointing out the behavior of the v1 implementation is so
undesirable that it wasn't kept at all in v2.  IMHO, it's a bug that
should be fixed, and I think it's possible to keep the old behavior if
all cpus are offlined, but since you've added this option we can use
it instead.

>
> Regards,
> Longman
>
