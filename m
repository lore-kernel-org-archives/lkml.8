Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A11DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392462068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="y3sIRdlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbgEZBwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388288AbgEZBwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:52:39 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84521C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 18:52:38 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dh1so8761393qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 18:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GswiztD5rfdIx8UvdfdPn09KbqwxIb3eeCWbRm1S2fE=;
        b=y3sIRdlxL+4tpIlJT8doB4fYIhWp2YEuGEGmf31TipWhOg8V8fF23GExUU71pZwftg
         spg7/T/UmdLjvp+LKU9YTuKZS9I4aL9nnIknX84Twwgxe9ILXe22/cZmq0e2FYJqzU8K
         jntoF1eufmVOOEWUIXQhYeMgN8gYpV1bc4fohS1mJtJebAvkbAS9Ryc2sxH3b1lvpcyR
         f5L7fFrZ+V4jtfzlGyyfhtiC2D7VfwIKPUYaC0ur0kx7RcW7ZI15oxkfeIMOLXn5UYn5
         QvTtFwyFlzIkuXklnkhXZxDRt2GLS0jrtneP4Qa5/B9S8kA05m9BJHUqSz6bvBE94CXn
         lIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GswiztD5rfdIx8UvdfdPn09KbqwxIb3eeCWbRm1S2fE=;
        b=JJX3ZtCp2NXCX8IkNiJ7HhtEM5REm2lTeyfOshG+9AvAZOFf8/AfAqhDckfIC1Sbwm
         fPMvTY5AUa3yw56L7duEj8myGc3DiqloDol6SvyskCgNC+7VXj88/309bWqLQObu7kUS
         CrR8IjVZYzpRyIjcIiFte3UFcUDZf5LhQ93duTHGIVfIayxuIXNAqmMZfyJYgT3Dd5EA
         FhPPSz/HSeS92y87d6cK8ijXRIMzsN9MQorm3CvRInfmL1P06bLgXdBQ+RyUXa9R7CeU
         sbjNtuW3PtFb9Zx0dmmwFGRp9E87pSnLLCSiIC0pwuwpHkiknmpT53W8CjiIDXFbvXMo
         k86w==
X-Gm-Message-State: AOAM530xSbFvTWAvqOveKbwRqKohJzXh0nZroNw70vyul01ttCEs6Fkh
        EDzIl1Uxlx8FBY+aRlzZoGIhtA==
X-Google-Smtp-Source: ABdhPJxMzVWNomlCvv/+yQ1qqLHvamQ4vD9iRdeXGLG0fDJzF2JwvF7fKSoMv8xNCorB8rp8ETvkbg==
X-Received: by 2002:a0c:a98d:: with SMTP id a13mr2194047qvb.157.1590457957497;
        Mon, 25 May 2020 18:52:37 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id j7sm3724298qkk.63.2020.05.25.18.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 18:52:37 -0700 (PDT)
Message-ID: <b04934ab91fd57e6df35279ad8a2619afb00b452.camel@massaru.org>
Subject: Re: [RESEND] kunit: use --build_dir=.kunit as default
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Gow <davidgow@google.com>
Date:   Mon, 25 May 2020 22:52:31 -0300
In-Reply-To: <c035d65b-7e93-f948-22f9-73a56193ec36@kernel.org>
References: <20200414230950.83665-1-vitor@massaru.org>
         <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
         <c035d65b-7e93-f948-22f9-73a56193ec36@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Fri, 2020-05-22 at 16:40 -0600, shuah wrote:
> On 4/16/20 5:11 PM, Brendan Higgins wrote:
> > On Tue, Apr 14, 2020 at 4:09 PM Vitor Massaru Iha <
> > vitor@massaru.org> wrote:
> > > To make KUnit easier to use, and to avoid overwriting object and
> > > .config files, the default KUnit build directory is set to .kunit
> > > 
> > >   * Related bug: 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=205221
> > > 
> > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > 
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > 
> 
> Applied the patch to kselftest/kunit on top of
> 
> 45ba7a893ad89114e773b3dc32f6431354c465d6
> kunit: kunit_tool: Separate out config/build/exec/parse
> 
> from David's work resolving merge conflicts. Please check if it is
> sane.
> 
> thanks,
> -- Shuah

The kunit branch had some problems related to identation. KUnit's code
has mixed identation, and with that, in conflict correction, it ended
up breaking python.

In addition I found a bug: related to the creation of the .kunitconfig
file inside the default build directory. Should I send the patch again?
Or do I make a bugfix patch?

BR,
Vitor

