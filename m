Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F248BC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D152F20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ia3p2hdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCQS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:26:05 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:45247 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgCQS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:26:05 -0400
Received: by mail-io1-f45.google.com with SMTP id w7so6740202ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fyw/0w4c822Iz8zK/btqki5MNWC2a7i6nqG8rTs3u5M=;
        b=ia3p2hdK/bH2uAcKuAtM7Vy5dqhj2+AYw5LfWCnQvi47yfSN8Qq3N/LJzxzq8efZxv
         oRY/Z4WABXRwFzLP6QndyyhvjUrECiBJ+th+ofyqm4dmeY1BgAKvEzPaomlU/rpTYXOA
         PIVq2rBnbG2V+SM3t9G6g+8gzOR6bVGb5NN/A/xgCc7pobdG/3YCo8Uz2Dp+ApzQk6bU
         Fh5Cg31ZeMUosMb2tbzeEYZNDWEeLyK/9cdFHSRGavB6zEuo+dhz3Ung5ZBCOe6UuqfC
         FPwtBcZdKoUG/BPDU//j5wUSVKVUS9nv0X+LjlILaMAcV9IjGeFxFe0A93ciOBGGL5FR
         KCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fyw/0w4c822Iz8zK/btqki5MNWC2a7i6nqG8rTs3u5M=;
        b=lS1Bkf1oiozA/DzEgg9MTVLx/6Zt6vyVpeSF9SiYhjtv4kyHJaNZvPJV9KCzX/KfRV
         daUFYZKUtf5ZLqjCAmi3mLQPy2A2dRjmA7wCsezKg3i54Bnvl1ZgwuWi4LqQdh6IfL8J
         wGEP75uE+seG6RgnprDBunKSnPX0edC7tq45NBkFFAmhoDYV2MnxQrzEsiz28LBBCnQ+
         aj/h5jUE/3WwqHYehJCgpMpZRpWtGamqFNskaD0c22X6mjgKQAJfBkq0bufYLCPosFdJ
         K2VDRebVXQUM0xFlr19IoLt1PE20WwcIm0VLUPhdeuJcSB4uNyLBQePGO9eUad87jeSO
         uKkg==
X-Gm-Message-State: ANhLgQ27EoHlArO2yNIvZ9rpnMjLBJ79NxL6ePZncrnP4qC/PsC9Qnj9
        RQi3fsodAfRDEPvFZUVgDSTABt0AFxO6VNcOKLmL
X-Google-Smtp-Source: ADFU+vu9BJTFp0PT0YUtvfkYoLZmrBS0vRz8OFdOnp46l9u7QhhVKzeQUd/fcRn/1DqCeyMgp7eVPGDcZMKvCpW0fGI=
X-Received: by 2002:a02:304a:: with SMTP id q71mr607149jaq.123.1584469563999;
 Tue, 17 Mar 2020 11:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
 <20200310221938.GF8447@dhcp22.suse.cz> <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
From:   Robert Kolchmeyer <rkolchmeyer@google.com>
Date:   Tue, 17 Mar 2020 11:25:52 -0700
Message-ID: <CAJc0_fwDAKUTcYd_rga+jjDEE2BT7Tp=ViWdtiUeswVLUqC9CQ@mail.gmail.com>
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ami Fischman <fischman@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 3:54 PM David Rientjes <rientjes@google.com> wrote:
>
> Robert, could you elaborate on the user-visible effects of this issue that
> caused it to initially get reported?
>

Ami (now cc'ed) knows more, but here is my understanding. The use case
involves a Docker container running multiple processes. The container
has a memory limit set. The container contains two long-lived,
important processes p1 and p2, and some arbitrary, dynamic number of
usually ephemeral processes p3,...,pn. These processes are structured
in a hierarchy that looks like p1->p2->[p3,...,pn]; p1 is a parent of
p2, and p2 is the parent for all of the ephemeral processes p3,...,pn.

Since p1 and p2 are long-lived and important, the user does not want
p1 and p2 to be oom-killed. However, p3,...,pn are expected to use a
lot of memory, and it's ok for those processes to be oom-killed.

If the user sets oom_score_adj on p1 and p2 to make them very unlikely
to be oom-killed, p3,...,pn will inherit the oom_score_adj value,
which is bad. Additionally, setting oom_score_adj on p3,...,pn is
tricky, since processes in the Docker container (specifically p1 and
p2) don't have permissions to set oom_score_adj on p3,...,pn. The
ephemeral nature of p3,...,pn also makes setting oom_score_adj on them
tricky after they launch.

So, the user hopes that when one of p3,...,pn triggers an oom
condition in the Docker container, the oom killer will almost always
kill processes from p3,...,pn (and not kill p1 or p2, which are both
important and unlikely to trigger an oom condition). The issue of more
processes being killed than are strictly necessary is resulting in p1
or p2 being killed much more frequently when one of p3,...,pn triggers
an oom condition, and p1 or p2 being killed is very disruptive for the
user (my understanding is that p1 or p2 going down with high frequency
results in significant unhealthiness in the user's service).

The change proposed here has not been run in a production system, and
so I don't think anyone has data that conclusively demonstrates that
this change will solve the user's problem. But, from observations made
in their production system, the user is confident that addressing this
aggressive oom killing will solve their problem, and we have data that
shows this change does considerably reduce the frequency of aggressive
oom killing (from 61/100 oom killing events down to 0/100 with this
change).

Hope this gives a bit more context.

Thanks,
-Robert
