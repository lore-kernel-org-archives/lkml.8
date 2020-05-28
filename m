Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59367C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286322073B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590691905;
	bh=ET8yM6AWMNpDjaCHAyz3Kke+AsO4jCxWygmB2OrK0MQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dy3mFP7fFBLq3Fr3qT2z+E0dfm/Sb91DLwvg4KQBVt95UNLASTGw8SK9LsSUSGg4g
	 uwdWHyUpZTSeRpdBsht7cU152R6I1YdyImozieJSK4wKfV7ZpLGvGBy1RVyaA07U+2
	 TNIxWaBGkKlUwS3n5x8oB8B+1QAElCjvWsT5k1B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406023AbgE1Svo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405912AbgE1Svm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:51:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25344C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:51:42 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h188so17215441lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhLg0g9nIVFkh8Xej4e2gvlmNSMTD4F2E/T/7QsRMv8=;
        b=AYcUjneN2MB3Dg+M1pugzVZJdxa872FQyc0afbyKSWW1oWb/d1rwk9bn7+CzdK3mHa
         tArLlEWWcS0pmgUdgvh4UhxapiHNyCYitzgmuPpFaFrB1CcK1PCfLpwMLGY/rt9ZbGVr
         HuHNIUVtpMtoMJZ4AirU8Bfo1+H2VgFd0PSHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhLg0g9nIVFkh8Xej4e2gvlmNSMTD4F2E/T/7QsRMv8=;
        b=TmtW2Q2VuIBBHDZb7ervpJiomM7C404v48sYeSk9R5Y9vRvu5cqj2ss3CJpZemY1sp
         e7P/sNSjWZ0hvBApqHsrc/o8TkLa/ekpVCRF52IJcPOQjCZbEmJQCap2g3RtQihJWX5C
         ResyRMF4LPWO326HAU26I0RWZWUAZ2/XHqBdfkhhwp7yF+6P2sobCSU+zmiNDpIRkcBi
         K4Mp8D/b2PcxI7cAxwQ3CdZsJUwjeTyUFS90ECyT/IEWqqevsX5M3R+3PZ4i6pLNlki/
         uHLHhh9XMiz0HM44QJThOXQQJtgoQ/wymghBbadCQ85rImUfRVFF6dGbOYoYNWvBDrM5
         yYYQ==
X-Gm-Message-State: AOAM532wCEDsSexoAFVzGHKgfGyUbLKNU9z94lG0JXcWDp4rWHR8pqar
        RmBe/5Vpjix7psp8h2OGuhL7pKXqVZw=
X-Google-Smtp-Source: ABdhPJwa1FpS0DRwMuLBTUQ0DKTRbTkwWsYIKwtAdiUNu0x1kvG+suniU544SgiBLKhe2u5/8wPPoQ==
X-Received: by 2002:ac2:4114:: with SMTP id b20mr2355166lfi.34.1590691898972;
        Thu, 28 May 2020 11:51:38 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h2sm1805648ljb.45.2020.05.28.11.51.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:51:38 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v16so34766561ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:51:37 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr1927771ljg.421.1590691897249;
 Thu, 28 May 2020 11:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054043.621510-1-hch@lst.de>
In-Reply-To: <20200528054043.621510-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 11:51:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
Message-ID: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
Subject: Re: clean up kernel_{read,write} & friends v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> this series fixes a few issues and cleans up the helpers that read from
> or write to kernel space buffers, and ensures that we don't change the
> address limit if we are using the ->read_iter and ->write_iter methods
> that don't need the changed address limit.

Apart from the "please don't mix irrelevant whitespace changes with
other changes" comment, this looks fine to me.

And a rant related to that change: I'm really inclined to remove the
checkpatch check for 80 columns entirely, but it shouldn't have been
triggering for old lines even now.

Or maybe make it check for something more reasonable, like 100 characters.

I find it ironic and annoying how "checkpatch" warns about that silly
legacy limit, when checkpatch itself then on the very next few lines
has a line that is 124 columns wide

And yes, that 124 character line has a good reason for it. But that's
kind of the point. There are lots of perfectly fine reasons for longer
lines.

I'd much rather check for "no deep indentation" or "no unnecessarily
complex conditionals" or other issues that are more likely to be
_real_ problems.  But do we really have 80x25 terminals any more that
we'd care about?

               Linus
