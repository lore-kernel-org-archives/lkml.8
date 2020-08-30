Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCD320691
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598831828;
	bh=gTS860zeymUv7HdtMvktcC4egztkBbMbo4um3YptEeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qRp+hPSfoIIEh24oggleOb58ycCl+LCh4oKO1ofg+yJ6ZppT0AYjDO8PshW+pBnGW
	 8qgZ941BAgeWRvJMRdesIkWv+m983PgNZiSkZnHz9HDWMuiHSm6nGPhK11vRVeKXGO
	 V0sLubgs4B0RMOijYfmbr94KKUBn06IJQViYX2Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgH3X5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 19:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgH3X5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 19:57:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C31C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:57:03 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so519165lfn.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbqTxayYdEKFwTTPsKBS5GQgDW4l2M1+45CpiWLzyKk=;
        b=Xfdd8DW7zc1BCKZ84sqwyj3rgTAL1CZb8K8UY2ILrx6ma+VppzZhTo/bW/uZaJ3Hhr
         5lbykuiH5pndn6WqYoi61odyO/hK/kl5PcX2MRc4ftIh1ZcXkIVY5qSAzO/QFpSs8K87
         eCVCRzEPtqy5kntFEDsFQ5VqVAJqNJ89HUxOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbqTxayYdEKFwTTPsKBS5GQgDW4l2M1+45CpiWLzyKk=;
        b=Kch95hTYF5E4EWpi0YA09glJVhtTsTP4lMVh/Det2NczCxh+vOqMCSnRRczyLrXRfS
         3zmQs4IszLH4CvwZMo8+YizsrfeMbcCtFvtVi6TsGWXznp1dyTacynAkuCa9ET4AuDbq
         VJYHQL/bmXlczU6nmsr0wD3ODj7VEIbdJs7LFsz9XkrLxtCLqB1sMdjOwV4EA751XUcG
         zRbTTjF6F5EMhtt2t2djUfJnpamXNZlVKVF0x9gwrauSDDTnoOOhP/80yS8yEzFp1r9R
         ZmEtJlbzZEf4hGoKlHnQWcX6EvI+336tZntGEe7fxZW4gO+2jz7px5B0JnvS+Bf17o0z
         LECA==
X-Gm-Message-State: AOAM531m/PDDSMg8WIjoJuvT/IO/d1wyiFUErk5erzlTHXaWiZsnnk/8
        jl7uz3QDeQ49JOgMS/Lz7g/47kU6C8C1YA==
X-Google-Smtp-Source: ABdhPJyx46SlQlNwj/yTgFuN7YdfVZJZ9rbZwYcAQCDQC/Lff19K3xl+yjAND22QaIdeIfCe/9RJUA==
X-Received: by 2002:a19:8bc2:: with SMTP id n185mr4447655lfd.211.1598831819397;
        Sun, 30 Aug 2020 16:56:59 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id g63sm1535855lfd.28.2020.08.30.16.56.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 16:56:58 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id c8so2505751lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:56:58 -0700 (PDT)
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr4413944lff.125.1598831818243;
 Sun, 30 Aug 2020 16:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiD1yujm_WvWLYL7gZsWMvZyWMg1rfU7dWmnYYc3a7Gsg@mail.gmail.com>
 <20200830234659.GB8670@sasha-vm>
In-Reply-To: <20200830234659.GB8670@sasha-vm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Aug 2020 16:56:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBtfMQDm9YRzSG7xCvVKx6YMScJ-_P+=hCT31op-CVig@mail.gmail.com>
Message-ID: <CAHk-=whBtfMQDm9YRzSG7xCvVKx6YMScJ-_P+=hCT31op-CVig@mail.gmail.com>
Subject: Re: Linux 5.9-rc3
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 4:47 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Is it possible you've forgotten to push? I don't see the tag/5.9-rc3
> commit in your repo.

Indeed. Thanks for noticing. Fixed,

           Linus
