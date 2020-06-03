Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C850720829
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVRA/AEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFCMA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCMAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:00:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C3C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:00:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so2081643wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xTDVs9sQITF8PtVFEimxH6R+QQ7jkpl/DjppsVLboHk=;
        b=SVRA/AEzNxpf6JeGg45AzqA5FnEm+cjIatVo7SjKYVUfPYilY1zQFr/z9lM42UFwDa
         UAZqwKy0UEGRzVWddeYEj0nA4IP3nnTVub7qjwFNTy79TmsAo0LxsA/SV8rcQ9QY6Vb4
         IX/jxKG3h4mnxwOBsqYCNMjn1tW4mDh5HU2SR/jCpv3z05RJrjsWEuTokGxkH5Rna1Rq
         SvWSZ+qUPfmfJluGz0YMcEt7HjgUGAiQM2curUW37O4NlnHWfRR73a5N5ipW2EH7XJXc
         nwPStCI+Vi9wp/MRP3R64XisUI7pzIQFKQjpozkbxVgG58p4SLIvMI9T6DwmxN77bdTS
         arPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xTDVs9sQITF8PtVFEimxH6R+QQ7jkpl/DjppsVLboHk=;
        b=cxIPo+HstoewzG5wqxavCkIDK38fiFUxpVINKvFvRL2E9Tts2xw11edZH44uzyzfQ8
         R24M9xz6elJPm0pwaJfbqe5vkImZhwUpmpieqkywr2xjI0XrXaIgDGrZotnmoQfCj9ud
         ZoiBT+EzT2m1PjB/tbJa41GwImFiVxBpMaDf34CN87IsmN7wbWdcNIJnkSNIA2xniq2V
         wdwr5GtUJ4Upq+Pdr3wqn3xKQE/2SNAUWkLHmWXxaxaczQFgStXrMEIcvNmPopJrMEL3
         6IKLNCELdjRBWHRYflS56mqCTmKxr0oxIkC+J7hLloiqSEYbW6bWeSPbt99FBfqB1yQn
         herw==
X-Gm-Message-State: AOAM532Xz/MVT3BaG5Uddn+gkl8h7jjZ2ddwPis+u9HuhjHD6oPUWOSs
        W6h4NuwQiAGrQ8IFhgcmm06Clw==
X-Google-Smtp-Source: ABdhPJzu/bnyi+AE+YNlwp0XT03QeNp72jC1XtT2CGSdSHBFClcTUXIDmgM+UuXmqvjSFx8yHb1D9w==
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr30832324wre.421.1591185654096;
        Wed, 03 Jun 2020 05:00:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d191sm2301565wmd.44.2020.06.03.05.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 05:00:53 -0700 (PDT)
Date:   Wed, 3 Jun 2020 13:00:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kgdb: Avoid suspicious RCU usage warning
Message-ID: <20200603120051.dxpavvsxvsxnvuct@holly.lan>
References: <20200507153444.1.I70e0d4fd46d5ed2aaf0c98a355e8e1b7a5bb7e4e@changeid>
 <20200519104151.6evv3hizm5dbjjq2@holly.lan>
 <CAD=FV=XCFxgO-s--jw9CTgQUxtQfteoQ4XSL_bbjW4s82Wd3pg@mail.gmail.com>
 <20200601161952.3hx6sv5hzdnjnvtj@holly.lan>
 <CAD=FV=UJLTuMp0uvTY0rC51ir_GgRKYxiPCK_w8TY+MBzkqjeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UJLTuMp0uvTY0rC51ir_GgRKYxiPCK_w8TY+MBzkqjeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 03:56:33PM -0700, Doug Anderson wrote:
> > > 2. Perhaps remove the whole irq saving / restoring in kgdb_cpu_enter().
> >
> > Are you feeling lucky?
> >
> > I think there will come a time when bravery is called for but I'd rather
> > see this as part of a bigger rewrite instead of a single high risk
> > change.
> 
> Hrm, maybe.  I guess it depends on whether we want to take baby steps
> there or try to do it all at once.  If we take baby steps we will
> occasionally fall down but we'll slowly start getting things cleaned
> up.  If we wait for a full rewrite then we might be waiting for a long
> time.  It'll also be harder to figure out which of the big changes in
> the major rewrite broken someone.  ...or if the major rewrite comes in
> 20 small/bisectable patches it may be hard to revert patch 2 out of 20
> if the future patches all build upon it.  If we do one small high-risk
> change and then wait before building upon it then it'll be easy for
> someone to bisect and then yell for a revert.

My views are a bit too nuanced for me to agree or disagree with this.
I'm not against baby steps and I definitely *don't* want kgdb to
continue to be preserved in aspic.

However I'm still reluctant to start our baby steps with a "let's see
if this breaks something" patch given we know it could be a very large
number of kernel cycles before we get an answer. I would be much
happier if those baby steps started, for example, with refactoring to
decompose the beast into clearer (and dare I say better documented)
functions.

Or put another way, even if someone sent me 20 small bisectable patches
in a single kernel cycle I'd still want the high risk bits to be
towards the end of the patch set.


Daniel.
