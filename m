Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D76FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6929822475
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="GK6BeinH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGNQEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:04:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EFAC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:04:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so17798141edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QNkqiOUgJealJ+aqGyWYINO3OM5Bn9l95tI0ji4/MXc=;
        b=GK6BeinH4QL05qvyRn3NaaCSL5P1p7YE5mctJ4rDTstjSSHzjdkCpHdWRyKnid50JA
         2KNah87vArFLFmEOItsFuhWkxbv/Wm0sogVgLpnUETzE/MzhnFGgrDgCQKULZnsltnZW
         tj17Ejt9aI8GpLYiLjPbfJmvuGOzAYay5iA3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QNkqiOUgJealJ+aqGyWYINO3OM5Bn9l95tI0ji4/MXc=;
        b=OeSCfiI5K9sfPbuNukTCboOaclfewFBRtyTQ2sYjesBdnNEKSQfFqjy17qJUGZUe2M
         QHbR6c0/HN3mFc95lg2KEsq9l5oPdxTL2Zae0nlL5jenb4wMFnJxMubMbhm39to+iFsg
         dW6AQgz39esxUhayrxJDoRYFEfwebkMjKPWaR2IzFRS61CKHjJ31hniMrvMmGWYZdraF
         lnlqYT3CFYcpkkxKJ+uUlMVXwDDO8K3p5lU1flJQP5mpeiZU+LSdMy2BgjwV4gcYgCl2
         8VSP1HQ2XgZsqCwI3obPH1++Uz4sugqPVOD+AOfSxIG9tBmfskrvVbn/PV/MYraHHdEP
         s1yA==
X-Gm-Message-State: AOAM530dknCGcSEm42F9knBFwBqzkdygx4p9yBtNgC2yaGeJUYDNwN7W
        KS2iE9aqMFiFt8UcU5tmfpX9Mw==
X-Google-Smtp-Source: ABdhPJy442cDyO9gS9p/rC89JqSCiEeFFiZMzgETSjGrEOZsFPXIueHqlfa5mUAhS9zMljsumeHvgw==
X-Received: by 2002:aa7:dd8e:: with SMTP id g14mr5404475edv.208.1594742689715;
        Tue, 14 Jul 2020 09:04:49 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6f85])
        by smtp.gmail.com with ESMTPSA id cz2sm14488626edb.82.2020.07.14.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 09:04:49 -0700 (PDT)
Date:   Tue, 14 Jul 2020 17:04:48 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        tony.luck@intel.com, torvalds@linux-foundation.org, x86@kernel.org,
        kernel-team@fb.com, Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200714160448.GC2080@chrisdown.name>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200714154728.GA3101@nazgul.tnic>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov writes:
>On Tue, Jul 14, 2020 at 01:19:55PM +0100, Chris Down wrote:
>> That is, even with pr_err_ratelimited, we still end up logging on basically
>> every single write, even though it's from the same TGID writing to the same
>> MSRs, and end up becoming >80% of kmsg.
>>
>> Of course, one can boot with `allow_writes=1` to avoid these messages at
>
>Yes, use that.
>
>From a quick scan over that "tool" you pointed me at, it pokes at some
>MSRs from userspace which the kernel *also* writes to and this is
>exactly what should not be allowed.

I don't think we're in disagreement about that. My concern is strictly about 
the amount of spam caused for some of those existing use cases during the 
transition phase. People should know that their tools would break, but there 
shouldn't be so many messages generated that it inevitably pushes other useful 
information out of the kmsg buffer.

>As to the "MSR hack", please describe what the issue is exactly so that
>we can get the proper people involved. If anything, this needs to be
>fixed in the kernel properly. If people are waiting for a year for a
>BIOS fix, I'd say there's a very slim chance for that to ever happen...

Since the issue involves DPTF which is only supported via binary blobs, I can't 
say for certain what the issue is. As I understand it, when the throttling 
behaviour isn't explicitly configured by the OS kernel, the default policy is 
extremely overeager. Matthew also had a look at it[0], but I don't know if 
anything eventually happened there. I've cc'ed him.

Either way, again, this isn't really the point. :-) The point is that there 
_are_ currently widespread cases involving poking MSRs from userspace, however 
sacrilegious or ugly (which I agree with!), and while people should be told 
about that, it's excessive to have the potential to take up 80% of kmsg in the 
default configuration. It doesn't take thousands of messages to get the message 
across, that's what a custom printk ratelimit is for.

0: https://twitter.com/mjg59/status/1034132444201582596
