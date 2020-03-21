Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C517BC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 03:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9066C20752
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 03:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqfQgTAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgCUDff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 23:35:35 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:41347 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCUDff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 23:35:35 -0400
Received: by mail-il1-f171.google.com with SMTP id l14so7820712ilj.8;
        Fri, 20 Mar 2020 20:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBQCfQkS3WTWAYQguH1sVxnwlSPagHIAP6hKZIDPgQI=;
        b=TqfQgTAWqHXuOVHuMZIzdgA0Mur5/xXqN6gQvfJREa7NldULrDESwj1O4Bb6Xq4KEC
         oHskRy0BA1j6CYq0ERngEoyFnso4XuBgcyAWhpMxaMUuTChxpY9XIU0EYewQ+F8w9mKy
         5fYikTl++1hnjrd7RLqyRx95WsrGCPcMqzXnLSWrGam8tmNX6pSAVegOXvV5lguDyKyO
         mn7SnPwEj6+ShQvaDW2x0kHbjFlGmAzKp8b+a1vVls9Ux/WBiA/hFGcwHDTmn3EvvOdP
         Nh76hf9H2+VrMvF6FwjvmcB5gXinpM2fJfCnCmahMThkZPX4gwnQDydVo+n90vYIGsyO
         T5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBQCfQkS3WTWAYQguH1sVxnwlSPagHIAP6hKZIDPgQI=;
        b=uLRUDBZJJHnvI7bRR96biRxwQg6rFRKXhHYntyJsVjsWgjBsOpCl9GZ/FRDQy1WSRy
         4wIID/nVnp+DNLp9BiKpZMu8khdQwqv2SRmZqCe4KO8y9T1rdzMZw8QxxsVxFhqIReCC
         g1bVGk7GwLt8OQ0jaAvYlUkF1CYszRID6fUzyOiO2xF0n+duiGGoQXxEpWj3/4xtrfvD
         WL9ki8T8Sofzfd5771he7j50l+EkgnZlfXHMVBDjhkM+SPneVfnSOKIhYobaL9jepZeR
         Ayclg/8549c7NeBjra+zSRDLa27pfVIIeJloyleWI2qUOc69NdCIuNypNeChzhfkIcFZ
         eAiA==
X-Gm-Message-State: ANhLgQ0jat1PACk9f1kTWYp0cDYfgfR9vbfgBLol3XyHbhrEoksp7lmi
        QChYvkystyzfhi84XwwS+tmh7kzvuvxvOsSwh+s=
X-Google-Smtp-Source: ADFU+vv9q6L2fVtEhx5jplFbc+oyhmTOYl3gtK+SV/QxMxSYFVRR9HRYFbovjf5ofnNKhWGCHdvrkIoGm9A9WVed2vQ=
X-Received: by 2002:a92:911b:: with SMTP id t27mr11496024ild.142.1584761733808;
 Fri, 20 Mar 2020 20:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <1584408485-1921-1-git-send-email-laoar.shao@gmail.com>
 <158470908459.28353.7390210153247885071.tip-bot2@tip-bot2>
 <CALOAHbDGvbZ6x6pDcPah3_3YV9mwMtuFWbLhi0hTQmRro73jqg@mail.gmail.com> <20200320195540.4b50a01e601d67bb3574cf2a@linux-foundation.org>
In-Reply-To: <20200320195540.4b50a01e601d67bb3574cf2a@linux-foundation.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 21 Mar 2020 11:34:57 +0800
Message-ID: <CALOAHbBWBdWGLGVAUjZGitR8xweNGg5yDQ8hvNiGyhc_HvnMhA@mail.gmail.com>
Subject: Re: [tip: sched/core] psi: Move PF_MEMSTALL out of task->flags
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 10:55 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sat, 21 Mar 2020 10:47:05 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > This patch was aleady added into Andrew's -mm tree.[1]
> > I'm not sure whether that could cause merge conflict when both of them
> > are merged into Linus's tree.
> >
>
> That's OK - if a patch turns up in someone else's -next tree I'll drop
> my copy.  Usually after checking that the other copy was the same
> version (it usually is) and after checking whether it has up to date
> cc:stable and review/ack tags (it usually doesn't!).
>

Got it.
Thanks for your explanation.

-- 
Yafang Shao
DiDi
