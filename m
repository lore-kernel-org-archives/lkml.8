Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E94C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2DA206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585947570;
	bh=IC6F06iWYBrCuu+GEo9Doyj2eWJtaWfT1eP1IYhiCok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0fLL+sH/Ka+33k7RQ+pcA7wOzfq+iCqiud3EjGAu9EAHu/D7+ypBA6yWVNZNm1qJL
	 bLYavDo5YIjxbMALZ0qcpkbfsHGzARWyELQfEN1IcGPrzGSFfMmcJiV8oSDw6S1ZR5
	 caJEjj1iMxYyEef5U7LdLz4dNl++xmpvJBYa9b7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgDCU7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:59:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41867 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgDCU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:59:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id z23so6950213lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CPxyFZxPc0YcfVvPFYxLsM93XxYFQGYmYW5SAM+S+8=;
        b=PwTMldcFXCyjXBv90GqkWmt5NnXcBLXrRaGeI063rXMArUMJ8dlr+c5UyGSB4Quc9t
         BgTDfblec08zcfAN5Izm0O6uJWxWcktbZckqqwVwUBAH/xDWG52bD6nh8dEVYqKHDV3i
         UXOdzpEza/hEDwO9OzlWJHZkEgL2qyxw5qTT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CPxyFZxPc0YcfVvPFYxLsM93XxYFQGYmYW5SAM+S+8=;
        b=mhMabswsXsbAblfZRyAOot9jVfX+jaKIJdZd8zHbHLvfD2CefmBGqujk2OjTlWHbG0
         QqqfASH7dDgonzxiP4zc7thSA0sF9V/AOD+E+3ksgd/8aFPRuEaemHJfms9dBzbfP3Pt
         sYUMZC5hJQLhIkVXUGgisBfSl0bvooN49ueELUP8eGljLiqe2kwG4NWy8ACvFg0Ph+mV
         zsysjQRLzYWagrlghjlyJtXiHa/XC7gQ5AQbHRTgfTQXqhNtC1unC9DSOoJ32wx61vdE
         h5l20s86ISYuOsmROUIoaK7Hh1Ox7GKCHrIdKsQnsGr+kfWzFUuMWlKlS3hsxBABsY+5
         aXLQ==
X-Gm-Message-State: AGi0Pubi7OHXQyHeuJmhkI9Y+P+twEuHaJUpCnGuxJ/8zySxkEgNpT1d
        siknZ4S59QXmwtNpdM860TgpkqS8SOg=
X-Google-Smtp-Source: APiQypKcsOnVUe5yThB8Qz4jC0LhRYfYB4vyYD1Ix+SQVuM1Ja0ZfHHnh0AdaODcCjCe2pXf0hP3Aw==
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr5283981lfl.112.1585947566383;
        Fri, 03 Apr 2020 13:59:26 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k4sm6461112lfo.47.2020.04.03.13.59.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 13:59:25 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f20so8434398ljm.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 13:59:24 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr6047340lji.16.1585947564510;
 Fri, 03 Apr 2020 13:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
In-Reply-To: <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 13:59:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
Message-ID: <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Waiman Long <longman@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 1:41 PM Waiman Long <longman@redhat.com> wrote:
>
> Another alternative is to add new functions like down_read_unfair() that
> perform unfair read locking for its callers. That will require less code
> change, but the calling functions have to make the right choice.

I'd prefer the static choice model - and I'd hide this in some
"task_cred_read_lock()" function anyway rather than have the users do
"mutex_lock_killable(&task->signal->cred_guard_mutex)" like they do
now.

How nasty would it be to add the "upgrade" op? I took a quick look,
but that just made me go "Waiman would know" ;)

             Linus
