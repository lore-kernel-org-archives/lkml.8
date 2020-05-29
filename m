Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F42C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E592067B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="RCjbk41G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgE2Rq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Rq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:46:27 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0D1C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:46:26 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id b131so1515470ybg.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T28CgoTvLzM8tz16a8eh0RZF1ywEtcGMeBF0Z28L8bI=;
        b=RCjbk41G+1YjTo3SenWTH6akCvneSVzaA7gWDTZlrVbdlg7/9ok6vdHFxJ/rq5g6tQ
         vqjmTING87wl7zjSyEsnON/65b2zeEcVBwjhg5CdANgEkQToI/0f5uC5ucvOEPQNfNvr
         bge8yBsCN6xwDtSMzb3UUCLhc4mf873+VPySRD14/30apaYoHGUadVL2SJ28hlC7S807
         ezUPy8CamLilbILTWxYBTaGSHdhez7KLfsPO4ofoX56D+n2pYcrc0xosGrM8+kWbk4Sf
         AUwPLad4UzeA284yhr4OcEnRB7Ldx6aYq9vZYX96VUhHCgM99vRvogwc0JL9Wi2HRm4R
         oDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T28CgoTvLzM8tz16a8eh0RZF1ywEtcGMeBF0Z28L8bI=;
        b=qCgt5jzHnwS+6/YgBwVn8nvhyMAwvMMHKUYJBAZezqZ/YpCXDK4YafG2sbCbeTnS8V
         mOr/oKnRL/u14xAdfDUBIe1zQx4AgIQggjk2D9y5yUXaMT7qGEH/6qBCv6hO4lBsA0Ok
         ixixjKmMgFCB2OJE67+goR9FdZgrtyeqgqbyDDNCPn5u2w8Z3v0y1pWMGOQlcMIk300k
         tX2QAYmf50VI8kxHwXhyGIZbUDdQNqJF4S+dTuz0NH7DSpYwqGRW61i7z3a3YVT5ia9d
         YngImHZ1zCYgr7dIgjbQUuJ9cAHGYpC5qXTnZt9ghDAHQaIy5wFjPgm+FYeFjGlMoUry
         DKww==
X-Gm-Message-State: AOAM531pTPn0omHNkt4s0A3o3kd3dsP8vz95BUYvTwIhzm4eFKCQlY0h
        s0Ern0gBpXjpRVg+42IdHSwgUrg+XwJ63N6NbAM+JA==
X-Google-Smtp-Source: ABdhPJzyiVpFfT+IpUlTWmIFceOxHre5znwF48nwQ4mneDd657/RkCRNpHtsXubu/XwvVBM8lVwXU/LTwR5jdbO+4Qw=
X-Received: by 2002:a25:bb08:: with SMTP id z8mr15518222ybg.129.1590774385194;
 Fri, 29 May 2020 10:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200527003420.34790-1-vitor@massaru.org> <9b12d44c-938e-b57f-d3ed-509b8e1b07bc@linuxfoundation.org>
In-Reply-To: <9b12d44c-938e-b57f-d3ed-509b8e1b07bc@linuxfoundation.org>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Fri, 29 May 2020 14:45:49 -0300
Message-ID: <CADQ6JjXsSA7YQujOWWthGFSRwwVxs1noo_Ok1LF7YVqGY+=16A@mail.gmail.com>
Subject: Re: [fixup v2] kunit: use --build_dir=.kunit as default
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 2:28 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/26/20 6:34 PM, Vitor Massaru Iha wrote:
> > To make KUnit easier to use, and to avoid overwriting object and
> > .config files, the default KUnit build directory is set to .kunit
> >
> > Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>
> >
> > Fixed this identation error exchanging spaces for tabs between lines
> > 248 and 252:
> >
> > tools/testing/kunit/kunit.py run --defconfig
> >
> >    File "tools/testing/kunit/kunit.py", line 254
> >      if not linux:
> >                  ^
> > TabError: inconsistent use of tabs and spaces in indentation
> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=205221
>
> Vitor,
>
> This patch doesn't apply. Can you change to subject to be unique
> Fix TabError and do the patch on top of linux-kselftest kunit
>
> I think you did this, but I can't apply this on top:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit
>

Sure, I'll do that.

> thanks,
> -- Shuah
