Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EDBC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F9A2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVCz0100"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDUCmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgDUCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:42:09 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:42:09 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 8so10818722oiy.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ct3Ljnpe9/z1RjWOGjOhNcOu//CgoEvvfkkVmP0fzk=;
        b=lVCz0100nYmTmwntpZfP2eqZmfGoipnm0z2hG5RtkzMEDcqCPVtozANt/fg/Mk2MKY
         1BTTVzYKxuUUpalFuwxmy7Jcakf1/n9T89vH5chgo3KODqqgh2gCyZsW5QrWNCpwkgd4
         7o3lomkW05BOrZ/l0QIVQ2Tb56mOxDgvNZklK68t01Rpz0pOuV5L/yUs8A7kq/wUc1Y4
         K/EDJZ78NY50cURzvmMUgYDiWtF/7Giq86tzqyGYovYI3m0pckshXen0mZ4pc8dLKta8
         AkBAG3nVHgAzK2alFWhAq4ha0f/hjkS0n6FITfGUiO4CPd2xD+G+SRCh7TR8l5V5N3I5
         rghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ct3Ljnpe9/z1RjWOGjOhNcOu//CgoEvvfkkVmP0fzk=;
        b=GmQSocX8c8J01mf8saz1TxntIR2djUg7b86DoM0tFq/8cVoQwDOKsXiQjIG9E8Z+WF
         6W+XsQHKMrKXHbu9lZRWUDMHfk+USZ+BvonO82/xPZmoSBotlFNAhUqlW7yi71pi44xb
         V7XwVqiXyQlnNU3syY+CSh+gvgM4gO8w7zWhSzDaRycTFdHLWn6TVnKQ4/1coY0Nsfgc
         USDsjlYMu+ytHzNNhVF2ki6oP6nshoWR8rgXiB2RTS8WERJEJCUlG2JQIPGBc0qdnxxy
         yYsF4d1KTHn8oLD1Q4Z88oP1A68ArnV9ozysYAPCQm83dl7JwfEYISW6t/HD9Y9w60ZX
         3Fng==
X-Gm-Message-State: AGi0Pua5wFKxoT8eMKlIB14cUoWPrzmFNqJgz52hoItDjEJeKd+OYxhs
        mFlWo+hfpFsBWHd0MNTKyW3TtFOYQxSu5pmmGGZsNg==
X-Google-Smtp-Source: APiQypLAOjo59VTUld+qUtuQ6M5SGZ8QwJvgKxsXQH7JdnCIKNuu9Idzm2AW3vNPirDm9aUuHTs5pg0PyTofCUcGaZg=
X-Received: by 2002:a54:4f02:: with SMTP id e2mr1791089oiy.10.1587436928466;
 Mon, 20 Apr 2020 19:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200415104152.4d770116@canb.auug.org.au> <CALAqxLVN_MZ7XWsg99dhy1=Vde_XSCHey78mrxRuu7a_THxYYw@mail.gmail.com>
 <20200421092935.21eeb395@canb.auug.org.au>
In-Reply-To: <20200421092935.21eeb395@canb.auug.org.au>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 20 Apr 2020 19:41:56 -0700
Message-ID: <CALAqxLUub7SqPQbKJ+OnPtcQhLiu0aFD9YudhDtDfDLNXL6smQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 4:29 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Tue, 14 Apr 2020 18:18:11 -0700 John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Tue, Apr 14, 2020 at 5:41 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > After merging the qcom tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > drivers/soc/qcom/rpmh-rsc.c: In function '__tcs_buffer_write':
> > > drivers/soc/qcom/rpmh-rsc.c:484:3: error: implicit declaration of function 'trace_rpmh_send_msg_rcuidle'; did you mean 'trace_rpmh_send_msg_enabled'? [-Werror=implicit-function-declaration]
> > >   484 |   trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
> > >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >       |   trace_rpmh_send_msg_enabled
> > > cc1: some warnings being treated as errors
> > >
> > > I don't know why this error only started happening today.  However
> > > reverting commit
> > >
> > >   1d3c6f86fd3f ("soc: qcom: rpmh: Allow RPMH driver to be loaded as a module")
> > >
> > > fixes the build, so I have done that for today.
> >
> >
> > Ah. I'm guessing the newly added rpmh-rsc code depends on rpmh being built in.
> >
> > I'll take a look at it.
>
> I am still reverting that commit.

Yea. I've stirred up some discussion on it, but its fairly
complicated. Unfortunately I suspect it will take some time to confirm
and justify the change I think is needed, so I think reverting this is
the best short term plan.

thanks
-john
