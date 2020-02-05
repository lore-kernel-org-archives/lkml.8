Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C62C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AF0217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580918886;
	bh=6QMEQlUKaz+32PwsWXJ9rj7eRivr/FeXdEAEpDIaw00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0DOmpmnJzERBX0ysXUwJyllVbdWD1xgkKqhp9aghiCTNlBc3gUZuDQOm0AMvnOR06
	 6aMlUDYM4uSJGgmq3J5/e/uuyR04pTnvUe5T9yN9gz+l181JCvCoh7/0+xlQ719X7Q
	 c3PD62jkvlxWmRE0elWHWQzK31f2iJAgUOm0YVKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBEQIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:08:05 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40403 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEQIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:08:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so2327860qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=eti/xmWoQM9zmxGk4butE/PtzRsW0oA8DEa6iFJ8+dI=;
        b=HRGOK6FIS2hl/PMtcm5v5i+7t4eUky6qd3CfU598xenohgH7fKxZD/nUu5HlTaTRor
         By2+moIAT7ah1RkL1OyRbh7qj1kM2pc5r4zPIcH2iKvU1cBjheHoJGgxQb/ov8ooP0ow
         ZbxgEgNYduPUc0R8MrtijpDVEsqJvVTCmZMPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eti/xmWoQM9zmxGk4butE/PtzRsW0oA8DEa6iFJ8+dI=;
        b=S/j3bcXsG/AL98wi5zCGt7a1VYezXeEAd8BmyWE0BNjdP2oGx2M+RIvNbuntPp2OYv
         3PH1JI2MlKOeTqUQsfj66q2pDLUTs74e5qeNYQxVjBnVMk48M8TfZr878dg8TJ+96wgV
         qojLJ1S3bqb4Nd+tH6JIPM8DYVfslgEJdXZsrW83prpdJBaeXN3qcKfda+g3Hs39j+pw
         WMn+gtAJCGvZ4Aem8sxyZiz3QprslO6IUThq5izqwQzI+ZFjLcCTq11qTmq0EhPyAirc
         RLvkW6dhO3HMjcY7XIcV+8tTaYgZKWVtigM7PYmNWiktD3qK+YvEVy4AL77Rn4TYL3GB
         ZHkA==
X-Gm-Message-State: APjAAAX8qBHOzSrf4mdlmgfuQbT9iF6YAvQRikhz6nweVFx/nCwRR+SG
        Br16necVbA2rCxkMZ0yqsunEpQ==
X-Google-Smtp-Source: APXvYqxMKXtRZimyppux/LxuB0Oo7mV4j2vSsfUxgSRvFn+rc6DaCduhr+ieI3vN1EBPQm1bppal7A==
X-Received: by 2002:a05:620a:134d:: with SMTP id c13mr33315010qkl.322.1580918884099;
        Wed, 05 Feb 2020 08:08:04 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id 17sm24744qks.84.2020.02.05.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:08:03 -0800 (PST)
Date:   Wed, 5 Feb 2020 11:08:01 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [put pull] timestamp stuff
Message-ID: <20200205160801.x3hr3ziwz2ffxltt@chatter.i7.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200204150015.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wivZdF6tNERQp+CXyz7zeN4uG9O4d7mZhCrp3anJ29Arg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wivZdF6tNERQp+CXyz7zeN4uG9O4d7mZhCrp3anJ29Arg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 06:53:07AM +0000, Linus Torvalds wrote:
> But pr-tracker-bot _also_ isn't responding to the one where that
> wasn't the case:
> 
>    [git pull] kernel-initiated rm -rf on ramfs-style filesystems
> 
> and I'm not seeing why that one wasn't picked up. But it seems to be
> because it never made it to lore.
> 
> I see
> 
>   To: Linus Torvalds <torvalds@linux-foundation.org>
>   Cc: fsdevel.@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
>   Subject: [git pull] kernel-initiated rm -rf on ramfs-style filesystems
>   Message-ID: <20200204150912.GS23230@ZenIV.linux.org.uk>
> 
> on that other message in my mailbox, but I don't see it on lore. Odd.
> Is it because the "fsdevel" address is mis-spelled on the Cc line?
> Strange.

That message-id doesn't appear to have traversed the mail system, so my 
guess would be that it didn't make it past some upstream MTA -- either 
vger or the one before it. The fact that this messages is not on 
lkml.org either seems to confirm that theory.

Best,
-K
