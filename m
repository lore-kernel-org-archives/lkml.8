Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73CEC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF90207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599101030;
	bh=wSdnK9EK3cn9BWVceilg/laGb14SLihQHTT+htVISis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V/jxD5ZoqN5bTaUjw5vo0WbG9p3d1ZpjiexwMZ6m4ZO7Zmx5kzSwkRRBPSE1j1URa
	 pmYvi/CRiEGcHrU27zxUJBmg6f03/6llwYHnDMQ/IPm9eXDXqFC0z6Whbz7yXAeBeu
	 A8pZh8kBF2Ns2nDAos5Krvht9cXyU59LNZ5VYIso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgICCnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:43:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:17934 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgICCns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:43:48 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 0832hHWY027036;
        Thu, 3 Sep 2020 11:43:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 0832hHWY027036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599100998;
        bh=T86p3R1UH15ZPoKGCOPyksmepZB9QQB30q3jQAGkwRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fV/JumyRvG8kodg5McCAZLsnkb1n5nP8xONCgYzdUr4ntano6BjPuu52cRhTcnJuN
         1XFb0Kc1u5NqxbCunIveZs4wmdICx+N351PtrxPDUhkCBBsIq/1Mh39yCfVfVnTCfd
         g+ZIYGRci3JLMsyAEZPU7aR7n/82eWXLsGCspzKdIv9nQXR1PmRY5LkIXTpPUm5C1P
         GTZaxBpSarQ+0NXqiDLFQXdFpNqz56bAaQxW1Y96r6ncl4JwFSgRmVnsUjP7Tj6D8L
         4ICJu4fa+15yMxo1w33F7s3kPMkNkLeFRZAJz5/cEZwG+jmkewwrSiswOjtoTCfufP
         cOHFIHLalgdrg==
X-Nifty-SrcIP: [209.85.215.177]
Received: by mail-pg1-f177.google.com with SMTP id d19so860558pgl.10;
        Wed, 02 Sep 2020 19:43:18 -0700 (PDT)
X-Gm-Message-State: AOAM530OXpBLsYE0b8s7QRVhXxFx+MKfOuJ/u9KSryuAqm9BkG35cqgZ
        odJE3HGJGty9698b1yMSGJMp4FxhYUDm7Abz4BA=
X-Google-Smtp-Source: ABdhPJzWZumYo+YwOqw2M5VZl8AaHtf7nEfOU3fo5VFC0j5NrdhFt1CSGIFbvlah7dSMPqXRlDT8nfl8QHu77ZME7Iw=
X-Received: by 2002:a63:541e:: with SMTP id i30mr937750pgb.47.1599100997560;
 Wed, 02 Sep 2020 19:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <be80ceda-596b-03aa-394f-166cc6388aa0@infradead.org>
 <CAK7LNAQekh08D6=+CqRWiB7F4KCLOgSK9oof8ArVUvMc7B1YXQ@mail.gmail.com>
 <CALaQ_hq01BCA7=sVJjm6LQrjjBFy1V79uUXcRXeLBB5g3k9M1Q@mail.gmail.com>
 <CAK7LNARp41EXMmT+ghGVw0Ew8wgHND+Ufn_uCevaVk+OP2-UFQ@mail.gmail.com> <CALaQ_hrs8piRh2-JacEkmrHZQ=rM7yvZUStWfO0YPhNRRYiSBw@mail.gmail.com>
In-Reply-To: <CALaQ_hrs8piRh2-JacEkmrHZQ=rM7yvZUStWfO0YPhNRRYiSBw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Sep 2020 11:42:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWLbH2+01_-Z6ts899FbA0SWndXAc4mjzNT7_BNT_Uwg@mail.gmail.com>
Message-ID: <CAK7LNAQWLbH2+01_-Z6ts899FbA0SWndXAc4mjzNT7_BNT_Uwg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: streamline_config.pl: check defined(ENV
 variable) before using it
To:     Nathan Royce <nroycea+kernel@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 11:18 AM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> Heard, but all the same if it isn't important (which I'm assuming),
> I'd just as soon be left out of it. That's just the way I am in
> general, not wanting to be seen unless I have to be seen. Thanks
> though.

OK, I will drop your tag.


-- 
Best Regards
Masahiro Yamada
