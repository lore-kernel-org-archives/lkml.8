Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85894C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594D320772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593755145;
	bh=d2EpwjttqyoERhfgW5L9LNb0uqd9LdA5agMcpeTuUQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gqGJS7/heMOWlWD6jLEu1haHniqPL1IPg5SYlHp+iKM/y24wuZ4ytNOvquw4JiuoG
	 tObCZhVGhK39+J1vtrCYtp+BbvNg3gOOYcbzr+lSjSDBnBDH/wzMG7djBxJ5BJNBCM
	 luWb2LNSvbLs+nOHktPpRN30k3avK+3OGS6PxF9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGCFpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCFpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:45:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 22:45:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so35519269ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 22:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0A3vDVM1SsTuHA9lwQs5oLr1c/ypIMHHQvVuoSvrWY=;
        b=ACJ7KSWNHjIkmPj+v99ndLC48oahHjDdlpQzL4u/QJko56jn5VObA5HkpRdKTxndhw
         /eQ8PRZzG2sA0B3mCJgKb1lqxkWyhhcDpCIe6upIqKg2YLcobbJzuhLCmqf8rJzieKm2
         UTx3TUz7fE0+yuKp/LiUiTAlqsRTvp/LXbmrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0A3vDVM1SsTuHA9lwQs5oLr1c/ypIMHHQvVuoSvrWY=;
        b=FHjpYrKg6EBJtrFiozlKvTeHLWfLhDgn1h9b7InhDlVN/YbMc1GH/pI/yjlOgew9Zz
         AlzCUN7tzZORThBsJFjKGY9RRdgfUmwVFfMAj71PsJ/tDxIGKN/kAGAq8MzdBjtXlZyj
         pKMpy9tFiOdcN/hnSwGGZwrQnXutCze7YNfb6brl8aWNTR7+o2OZguxbO/JnemF/cq2F
         3jLocn4jgVZnukbIfvrcerpcJ1cTutqWk9lYQzwuPewlrywcJ5VOtUAYDH3yxdMItyhw
         XldjpnS5tEpkusQ//29WiIKbnIr6TJa4wUAy+OQ5CchlezB1oaQCLsNAiSYdCot88akF
         7Crg==
X-Gm-Message-State: AOAM530xEFJ3RArWGoPZwZT5mtGh+Pz060KWtoL9DQ2r52qnayeh2E0o
        vYQ3KOMxquwZrB9gsl3OGAupqNOPyyk=
X-Google-Smtp-Source: ABdhPJxsf4JEgcB9QVi/NYTVVxVlNfFrDxIgMETqOCGM4b6xcDsWzYyCLx+HH8X7fKnXFXkQUClo3w==
X-Received: by 2002:a2e:6816:: with SMTP id c22mr6381302lja.378.1593755141312;
        Thu, 02 Jul 2020 22:45:41 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id h18sm3712297lji.136.2020.07.02.22.45.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 22:45:40 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id t74so17784910lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 22:45:40 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr20869931lfn.30.1593755139952;
 Thu, 02 Jul 2020 22:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200702204732.1114343-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200702204732.1114343-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 22:45:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheF6DDWZa0nvopnVLbBjoL_rTmfoTmw1mJRhkR_bKH5w@mail.gmail.com>
Message-ID: <CAHk-=wheF6DDWZa0nvopnVLbBjoL_rTmfoTmw1mJRhkR_bKH5w@mail.gmail.com>
Subject: Re: [GIT PULL] fixes for v5.8-rc4
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 1:51 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> A few comments on this since doing a grep data_race() reveals that currently
> only kernel/rcu/* is making use of this new annotation and this seems to be the
> first annotation in core kernel: when this was first sent to me I was obviously
> aware of the existence of KCSAN but not whether we had established a consenus
> around annotating places in the (core) kernel where we currently have benign
> data races that KCSAN complains about. I don't know whether we have reached a
> consensus in general yet or we're just doing this subsystem specific.

I'm not sure there's any consensus, and it depends on the quality of
the KCSAN bug reports (and the reporters). There were some KCSAN
reports that seemed to not actually be real data races as much as
"KCSAN was being stupid and not understanding idempotent value
setting".

It also depends on the quality of the patch and the description. If
KCSAN patches end up being "just shut up the tool", I will stop taking
them.

But in this case, as you say, we already had the comment about the
situation, and telling the tool about it obviously won't hurt.

            Linus
