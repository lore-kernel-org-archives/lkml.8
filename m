Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1704C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7897122B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvNfU05L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgH0IfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0IfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:35:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD8C06121A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:35:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so5487480ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeswVPmekzmrrw6bRiSTb13WJGBSyw0xgU+PLohXfnY=;
        b=CvNfU05L4UH4U9C8Y7pwFszf3RS+zbqVqpGxDQK6st1Z5FllZUXgW/w5SNOJkn07aI
         nTixyXOVzKptL9HbxOmPCPJEuCRNKFbdGVVwublPgEyKgNBggESPsSYmf42QuRp1Z4PZ
         BrdBLn4cU4ZJXShj26WJ0VtpmKNtGeU6erjxAADm83FSEViQqsgvpUp55p/IPbnc3kCp
         PtwvMSqH49V0mTUOjhkPMrgG+/o0bRypl5VsQYzgG47Rmq19CQNkiNZPlWKDHKq5BQt9
         /0F+JC7Wa2AKpQqi1+ZtkWP0voViKHVTlaE41aJMz11P2obocHVsEbmytkEnajbj4wDW
         oEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeswVPmekzmrrw6bRiSTb13WJGBSyw0xgU+PLohXfnY=;
        b=bYePYTTJmOs/rJmMVqHIAuZQPxS3e0JXLzcozkTEx9n7/AWh+cjN/uhJ/JnX2VPjH0
         9EPUeccpm6el9tcJZKfWsJZDED/X+GkUgRHs8csUpbOvmq78G/JYimShueEwVLPdHcTL
         bICPOJ1MIUD7UrEtGzGo4hTcsHViGhzqSkRBRAv/rZm6kXNikZAKt/ir/9a0Ln3Swh3E
         Qt7mDaRrKgekdy/gE6im+LiqbqpNH6xsBrEpvMK7Wfz0CHHmnCOmqwDSF8J+P1huH8Pp
         4E34e5AgJ8eA36zhnJ+H/qFn5zVHBBJlX73wv+pNB+DBL1KWWQ9e8642WV8cRnQULwuE
         juKw==
X-Gm-Message-State: AOAM5339KuJCN5CAF91u+ELDY5es8duUTmWf0haMBgWqi6jrEvSzwNXx
        TB64EBmOXxn27KpNw/KJENt4D3eCRfd5+Ve/6UAx4w==
X-Google-Smtp-Source: ABdhPJzBTV2ftMYdAO96/aOUVuCaLn+hcnBdlrjN9wc36CQ9lpQwV/DwhVtwg4J6WmHxNcwGLJiDOsoXWWjUp8nEo1o=
X-Received: by 2002:a2e:558:: with SMTP id 85mr1876049ljf.293.1598517308097;
 Thu, 27 Aug 2020 01:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <1598070473-46624-1-git-send-email-dingtianhong@huawei.com>
 <20200825095726.yvg34q74xy57qhrx@mobilestation> <CAHp75VfnCRFPQ19tdQb46PvnBV3RActKn4+hSivPN8e122Q1Aw@mail.gmail.com>
In-Reply-To: <CAHp75VfnCRFPQ19tdQb46PvnBV3RActKn4+hSivPN8e122Q1Aw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Aug 2020 10:34:57 +0200
Message-ID: <CACRpkda+AMsAzeFQXatzL-sRnFGW5r2YYyXa3a_VO-N92pEt5Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: add support for new hisilicon ascend soc
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel.openeuler@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:20 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 25, 2020 at 12:58 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Sat, Aug 22, 2020 at 12:27:53PM +0800, Ding Tianhong wrote:
>
> > BTW Linus, could you take a look at my series? Andy and Rob have finished reviewing
> > it almost a month ago.
>
> I was wondering the same, but in normal cases (not closer to the merge
> window) Bart is taking care of drivers/gpio (AFAIU).

I just had too much to do, sorry folks :/
It is queued now.

Yours,
Linus Walleij
