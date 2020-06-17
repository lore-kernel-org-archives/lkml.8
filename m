Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9777AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76604207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NeOqkMoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFQAGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQAGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:06:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE3C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:06:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s135so374211pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Inq0XQBIIBcPId4GeWe0hYOyBL6Kjr/fvT2V/zfqIFA=;
        b=NeOqkMoMzW+2UZHeiolI5YSbLKcTlTajnnATvK/mt1IPGh49KdGqILpQCc5xPgP/p2
         EPh2qLnoiPVCh17XGrXf4JEeW+ymWMpqrqjs0yvbHGbputGaUgV4JRKcQaAL4ywDsCcp
         BhF+p1LRINYtDID1h8WMghoMsMDGAz52oM+WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Inq0XQBIIBcPId4GeWe0hYOyBL6Kjr/fvT2V/zfqIFA=;
        b=TnmOLsH/GCv2kKM5djJzXe6k17CQ4iYeLPyLsebhpMz1VE5JAei5PU3ElQf1A6ABjB
         p10UCz7b7JUSvYHSdW7sX+d4KR2mhFcrPnupXYLAuxxbD6u3oeQFNjAUR+MClKLD3neD
         Z5jG9Twcyt0ihZ+kCJYvSOG27ryl4HqBeCe+HreUoVhY6fe4SdHAzsZEqNLR9J23x2On
         W2VLKy/+C0NXq8mcghs+V2j/uTa3wcMRRCJ8TLIkY+ZIq68WArNnsWcNV1/CjgC5T/yq
         Bf1iggm1sV6CfQzrmXjHOTs0URgd7gAtqzocLJtfaBN0v/2B8j1WD/fz0Qr9EisTNADQ
         6C6Q==
X-Gm-Message-State: AOAM5326YYQaKzVSZnef4UhSHsOqi987KuQawp73IOULjHabbNKRjf2W
        ZGsm+rxnxyBiHFDiwo4feIuwTw==
X-Google-Smtp-Source: ABdhPJxIBeSWhPSAUP+/5gdhsPaOcie+WqPquZ643kQ+mj51WBlMB4Zn/PmpKAAvt5w5+ate+ZxwWw==
X-Received: by 2002:a62:8c12:: with SMTP id m18mr4367140pfd.111.1592352377287;
        Tue, 16 Jun 2020 17:06:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id np5sm3913590pjb.43.2020.06.16.17.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 17:06:16 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:06:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Gow <davidgow@google.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006161703.B2E51605@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com>
 <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:16:01PM +0000, Bird, Tim wrote:
> So far, most of the CI systems don't parse out diagnostic data, so it doesn't
> really matter what the format is.  If it's useful for humans, it's valuable as is.
> However, it would be nice if that could change.  But without some formalization
> of the format of the diagnostic data, it's an intractable problem for CI systems
> to parse it.  So it's really a chicken and egg problem.  To solve it, we would have
> to determine what exactly needs to be provided on a consistent basis for diagnostic
> data across many tests.  I think that it's too big a problem to handle right now.
> I'm not opposed to migrating to some structure with yaml in the future, but free
> form text output seems OK for now.

For a CI system, if I see a test has failed, I expect to be able to
click a link to get the log of that test, which includes the diagnostic
lines. The other reason to have them there is to show progress during a
manual run.

> > Yeah, I think it would be nice if all test frameworks/libraries for the
> > kernel output tests in the same language.
> Agreed.

$ git grep "TAP version"
exec/binfmt_script:print("TAP version 1.3")
kselftest.h:            printf("TAP version 13\n");
kselftest/runner.sh:    echo "TAP version 13"
resctrl/resctrl_tests.c:        printf("TAP version 13\n");
size/get_size.c:        print("TAP version 13\n");

Looks like there are 2 tests to convert to kselftest.h, and then we can
just change the version to 14 in the header and the runner. ;)

-- 
Kees Cook
