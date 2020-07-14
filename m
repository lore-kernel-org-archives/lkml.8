Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E3BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FDA22574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="UEFCCb05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGNREH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgGNREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:04:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD6EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:04:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a1so12587343edt.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KFocyH23qRUfHuNAbjxsTyMPH4beeiu9XE4QFHWyAsU=;
        b=UEFCCb05ivGRMSxff1MIVrrOWKYkYKnmDOjaxeD/gc6NeFfjIUhnUWe7BFpLf8DUiN
         c3KaXDoQohgs7Ku/boXdZjFk8UheQeecWydhFFfDztnkZ0qnVXRowE/tdm7pgD/EWFtQ
         7Htzyv5uQZ9wm+kPhm/rSAJL/e7FB+YIMHAuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KFocyH23qRUfHuNAbjxsTyMPH4beeiu9XE4QFHWyAsU=;
        b=ULOmVBi+uEB9OcfT6+3zWARbY1iFebk2D265elBLcWSP51xcRnwsCazJjwGiCh8YAV
         XehcKXtwuO2ntFdf25NG5adzrhrxlXp8GoO30LqbpfaPXGQpB67ucxRCvTr7lDbqT1Pl
         0OhNjcM0kIHFTQbd1JTZthaUWWRnlWfWoSTV6NwHr/5KxMjlCMkus5TCiH9R/+4BQNFf
         Qpk6PuEPG7jyTNe7aBTAqwyoKkGSUEgVywkE6JKj8VrKAb933ycAeJPGUEQiXiSnthjZ
         2BYVl528BLmcNPed+rTGf5znoTNGPlZEW0V0eVhZq9zmcUT4E0AhiOqyPM3yi37J9nVe
         PFww==
X-Gm-Message-State: AOAM5309c30SceNIhJFs8JoAZE6+deSvOtrXQwuaF+kPnLt3FMib2U7x
        8O8Swnk2c6nNaSKi+Z47KADuFg==
X-Google-Smtp-Source: ABdhPJzQbkAz024pvJLVQTMaT7MdAmwnd4M05q/p3mwtjZZSnguxYUfGXsoF3mXdKO6rJFd9RogiEw==
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr5617980edb.367.1594746245696;
        Tue, 14 Jul 2020 10:04:05 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6f85])
        by smtp.gmail.com with ESMTPSA id y22sm15117932edl.84.2020.07.14.10.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 10:04:05 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:04:04 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        tony.luck@intel.com, torvalds@linux-foundation.org, x86@kernel.org,
        kernel-team@fb.com, Matthew Garrett <matthewgarrett@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200714170404.GE2080@chrisdown.name>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <20200714165621.GA3622@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200714165621.GA3622@nazgul.tnic>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov writes:
>On Tue, Jul 14, 2020 at 05:04:48PM +0100, Chris Down wrote:
>> Since the issue involves DPTF which is only supported via binary blobs, I
>> can't say for certain what the issue is. As I understand it, when the
>> throttling behaviour isn't explicitly configured by the OS kernel, the
>> default policy is extremely overeager. Matthew also had a look at it[0], but
>> I don't know if anything eventually happened there. I've cc'ed him.
>>
>> Either way, again, this isn't really the point. :-) The point is that there
>> _are_ currently widespread cases involving poking MSRs from userspace,
>> however sacrilegious or ugly (which I agree with!), and while people should
>> be told about that, it's excessive to have the potential to take up 80% of
>> kmsg in the default configuration. It doesn't take thousands of messages to
>> get the message across, that's what a custom printk ratelimit is for.
>
>Ok, feel free to suggest a fix, better yet send a patch. Otherwise,
>you'd have to wait for my vacation to end first. :-)

Sure thing, I'll send a patch tomorrow, then. :-)
