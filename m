Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2351BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01A020644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592262469;
	bh=it/fWtfdrBLygGn4XI/oaRv8oe3LSetiwTBldgwvwck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xzy381HGPmvgQUQvSniwDHJ0VkobfllR+ZGBOyGCcd6/+PddnlJUpgQqMC6TCXi/2
	 HLTtW60UV1iFe0TGQiMlWTXvPWRDcQM6Duq7G7BJRPMVZSBouuvYG/BmbcIM/U0yPT
	 a78qxijPPjM+jjICdDOhweR2MXDYtSw27e19wCR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFOXHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:07:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF38FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:07:46 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so21259328lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaFpoo1mZCfjylbR/6JREQHN4U4G1dhmW8P2thsazM4=;
        b=Zfb11Iec1W9nJFMqICoHN9YmFkiRiFka9EQK/ZDaTynmK1pMEcsbbaStN5AA3VCTv3
         PvA8hwG2+A5Da5PtbQHHGzVzDGueijaQF/7Sq6RTUWQ9GBVoZvmksPNlXyjZAUYnnyTD
         10dNrgQI5nnTnJ5XoeH0GWfStVyvWomSqqGxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaFpoo1mZCfjylbR/6JREQHN4U4G1dhmW8P2thsazM4=;
        b=jUF5ydScbu/2HjVel7Ibr0Jm30a4vlqNINUIgatHfKZWfz906+gKiXw1IG37OZx8JK
         yRZ2ZCC/voNnLfi+DNUQ76MDl4WWsqqvJmkZG2+9OCLK3V1Fd+3FrurVD5w3qOyFYXdJ
         Vd8svcJ4SXNicGNeVqpZv7b8x7UrP4VhPYzQPomykxHe0Tgwpnl1Kh/11OWTox9a9+Gg
         FVMbUtT+NOaJroHOFfA6QWnosCK51hq8DZK+tH0vScVfmGGqsUXdtQK63zDTzvvaVYzS
         8DKRaVhOspe1FIIrL98bTH5ljfTw6ZYkbPPlnqvdlde+rEt8x9JqumPhu2mBkOSCxliJ
         +htA==
X-Gm-Message-State: AOAM530KBczhbHIzf0XWB5WsDCgki1GJFmWXexpXLONAaDIlGrWfb+XA
        PgZJSpvaacjQtEl2o7sOZBaz9TOjzis=
X-Google-Smtp-Source: ABdhPJxl5/jeGudpKy/ntkN0cNrtD4MF3xL8dTIQqi7aSKjL7L1tE81EQJU4HUAnY102CO7ZQbQ+Jw==
X-Received: by 2002:a2e:88ce:: with SMTP id a14mr4892ljk.379.1592262464970;
        Mon, 15 Jun 2020 16:07:44 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z22sm4803035lfi.96.2020.06.15.16.07.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 16:07:44 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id n23so21201008ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:07:44 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr2830lji.421.1592262463791;
 Mon, 15 Jun 2020 16:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200615203917.GA15876@embeddedor>
In-Reply-To: <20200615203917.GA15876@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 16:07:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSQV3nxTkQwO55qaLsW9CdkROFqwc1S6RX3PXe8ONPaQ@mail.gmail.com>
Message-ID: <CAHk-=wiSQV3nxTkQwO55qaLsW9CdkROFqwc1S6RX3PXe8ONPaQ@mail.gmail.com>
Subject: Re: [GIT PULL] flexible-array member conversion patches for 5.8-rc2
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 1:34 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> flexible-array member conversion patches for 5.8-rc2

Gaah. I merged this, and even spent some time trying to make the merge
message look better, and then when I started looking at the end
result, I ended up unpulling it.

It's all been recently rebased, which I might be willing to ignore for
something like this, but all these one-liner patches then come with a
boiler-plate commit message that is something like 50 lines long and
is actively misleading as it talks about "this tree-wide patch" and
just repeats the generic issues that were presented (better) in the
merge message anyway.

The individual commit messages literally add nothing specific to that
commit AT ALL except for the very first line, which is also
boiler-plate but at least mentions the subsystem.

End result: when I do "git log" after having merged this, the result
is basically two *thousand* lines of repeated noise.

Some repetition is fine. But 2000 lines of repeated boiler-plate makes
me go "that's actively detrimental to any use of 'git log'" and I
undid my pull.

               Linus
