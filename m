Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B62C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C880D204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZtXESXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgHFQcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:32:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24772 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728207AbgHFQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596731413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0hRjxIYgtYoy/h39f3PiFZ6a4d+4DkToJeydt3cH9g=;
        b=iZtXESXtVYz10VmHreFwC22BNjliTNzd81kbPEN7/+3dBgwyMWYaOhsniO9mSVUNFArjzl
        x90ovgo6CjLZ2rO/L0p9/Y3aBFobK/nPS3wEu1SmToTs0G9DT2iZWHysY574tAvNjxHHCg
        i7TfiR5jkbD3fs6I1i4+ZFGA7ZlDiQY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-0ULF9YdJPSOq6V_mIsxuMQ-1; Thu, 06 Aug 2020 11:09:52 -0400
X-MC-Unique: 0ULF9YdJPSOq6V_mIsxuMQ-1
Received: by mail-qk1-f199.google.com with SMTP id d131so33791010qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y0hRjxIYgtYoy/h39f3PiFZ6a4d+4DkToJeydt3cH9g=;
        b=B6rrzip0HiRf5CsEXSqhTZblkrVRZ2koI17vVziksRCqq1erFgHufAs3e+tITJ4vDb
         hpEJ30yOr0Rwt66OzWyNNURAOrz4AeoV7SruhyV4FLWuRh6QY+EAcarxA//y7U53XHlg
         zbFjmMQ+b8eYP68z6Y5767Ca37dy2mt3+eq1NX0YNA9856bqaN7PD7vPQ4YPJVDvLtbw
         fD6fxfvb1UvImDSyv09yscGNkwy7icwf27RY/aY2/gaqLFPti79/YMNx4wdzUhJiV2GJ
         YqfKFdFaEGeXPdxnP4lLzc6Ma8xKmNLdIpHSlJ0bcRLO8jE1QXkJ+Ix0ynwDVBOJwauu
         u1xg==
X-Gm-Message-State: AOAM532pARuZQdEfW7zkUG9oN7nmd1vWLKMoXka9L/XpKA10CgnA2slw
        NZm9XUt8FdeL6/3JHNvQRDe4DRJAL1u8AlL/388ZAoF3fMqOON+hBrvHrGU2ZAOD0x0f6GUi0Tq
        rj9DWOUbdbtgjirlhsVUyfUql
X-Received: by 2002:a37:4d09:: with SMTP id a9mr7354943qkb.157.1596726591372;
        Thu, 06 Aug 2020 08:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy805HTIuuD4jVfreBGZ/exggS77Pp3EK2TvUaU5b2qywpfHQSnY0gYW5+tnwJiE06+MrWX0Q==
X-Received: by 2002:a37:4d09:: with SMTP id a9mr7354918qkb.157.1596726591081;
        Thu, 06 Aug 2020 08:09:51 -0700 (PDT)
Received: from x1.bristot.me (host-87-16-204-193.retail.telecomitalia.it. [87.16.204.193])
        by smtp.gmail.com with ESMTPSA id q13sm4607376qkn.85.2020.08.06.08.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 08:09:50 -0700 (PDT)
Subject: Re: [ANNOUNCE][CFP] Real-Time Micro Conference at LPC 2020
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        =?UTF-8?Q?Luis_Claudio_R=2e_Gon=c3=a7alves?= <lclaudio@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Tom Rix <trix@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christian Brauner <christian.brauner@canonical.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <72353caf-c2aa-f2e4-fe2d-778f04625b70@redhat.com>
Message-ID: <d0a0ef26-f24d-a5bb-5812-4ef4efe82704@redhat.com>
Date:   Thu, 6 Aug 2020 17:09:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72353caf-c2aa-f2e4-fe2d-778f04625b70@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/20 6:51 PM, Daniel Bristot de Oliveira wrote:
> Proposals must be submitted by August 2nd, and submitters will be notified of
> acceptance by August 9th.

Because some people asked for more time to work on their proposals, we ended up
leaving the submission open during this week, postponing the deadline to August
9th, with notifications not later than August 16th!

[Feel free to ping me in case of doubts]

Thanks!
-- Daniel

