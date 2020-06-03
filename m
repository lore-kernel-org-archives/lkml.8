Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A66CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE7A207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgFCWJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:09:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38977 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgFCWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:09:47 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gavin.guo@canonical.com>)
        id 1jgbZx-0004Eg-5o
        for linux-kernel@vger.kernel.org; Wed, 03 Jun 2020 22:09:45 +0000
Received: by mail-ed1-f71.google.com with SMTP id y9so1732512edr.22
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 15:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RS2c9kZDiSJ98vsYaz9BsTuQco3vPT2+KZpRShvSiBY=;
        b=aVwsEoqTHHwUqbtzzCEcLfQpVkbmHceNvWgpToAPiCmu3Yjep5u6IbHO2T/cuoRX+g
         YRWXRmM3hr8npIhbmAMojmSYZUipMsDczdrZsrWgnAYv2aOtVGEgxUxQj54Fb4kPy+bM
         E18Ai5e6oChLpLdMwOKfo12F9fd6+lCjpZmKK4yrDiPFcFxCxhRWcQgS6rxiyywYOBL9
         bKFfdvH+kIgc+SKDXeA/8KfDZC7h03pCl2etnOzKaPwPZflTznZn3n3CrCioaCcryNGA
         A5CsFtTGYSSmLhlNBq6xOizlvaRD41ug5vZQTz5NpzGWyMVq/Ljl8zjg4zYJ08CaRjoo
         XxHA==
X-Gm-Message-State: AOAM532t10WEduTWwMuMzD7Jw0Ed/pv6e19ZsIkDjIot7t/i5emHH+OW
        8XEuDGnr7AbgrnYBFn/ifihMefOH5hM23MHwOncMcNUU7W3BZcs8YGm9BOhiQ7mncIuHraw8GNi
        2EVoQqyrm5TmT75vr/Gvo5Go9yzA8eESl0xcWut1Kg4iHFCdh9KZOyb2T2A==
X-Received: by 2002:a17:906:71b:: with SMTP id y27mr1279181ejb.537.1591222183858;
        Wed, 03 Jun 2020 15:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze5j+4hXtyvvLl0+P3Dm/KuPuBIn+oBzi1Y3gg5veClXh1O62H/4Qn2pQAXakeg4/2QBiiVAMKiYjGI+od5zM=
X-Received: by 2002:a17:906:71b:: with SMTP id y27mr1279156ejb.537.1591222183619;
 Wed, 03 Jun 2020 15:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200603065049.11598-1-gavin.guo@canonical.com>
 <14faa6c7-6701-7a8e-3e88-4febee20f56e@suse.cz> <alpine.DEB.2.22.394.2006031225100.43135@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.22.394.2006031225100.43135@chino.kir.corp.google.com>
From:   Gavin Guo <gavin.guo@canonical.com>
Date:   Thu, 4 Jun 2020 06:09:31 +0800
Message-ID: <CA+eFSM0V6nCHvwy3d5kehA4HpcP7x1zR_C95PnMFGYp9JV36ow@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: Add new kernel parameters transparent_hugepage_defrag/khugepaged_defrag
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 3:27 AM David Rientjes <rientjes@google.com> wrote:
>
> On Wed, 3 Jun 2020, Vlastimil Babka wrote:
>
> > > There is no way to set up the defrag options in boot time. And it's
> > > useful to set it up by default instead of making it work by a
> > > systemd/upstart service or put the command to set up defrag inside
> > > /etc/rc.local.
> > >
> > > Signed-off-by: Gavin Guo <gavin.guo@canonical.com>
> >
> > Well, maybe isntead of adding these handlers, we could extend the new boot
> > parameter sysctl support (handling procfs /proc/sys/) to sysfs (/sys) as well,
> > as Eric already suggested? [1]
> >
> > [1] https://lore.kernel.org/linux-api/87bloj2skm.fsf@x220.int.ebiederm.org/
> >
>
> Fully agreed, I think the solution needs to be more generic since thp
> defrag isn't special here.  With the generic support to tune sysctls and
> sysfs tunables from the command line it seems like this patch would be
> redundant.

Agreed, I'll try to investigate more on how to do that in a generic way.
