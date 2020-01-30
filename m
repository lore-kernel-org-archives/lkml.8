Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508FEC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3035D20702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA3MCu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:02:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39866 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgA3MCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:02:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so3912381wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 04:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Eti0yRnmjwLs2yRe1krSvPdmZnl0PtvNqJ94tkjn534=;
        b=kkKsJE5o7fnQpWjt6/nrllPjmwTjb822a27IWsTqVCWCjL8A3dpa550lKZBRVj1HWw
         1mu2qLTjAx8MTOXijLsV7MqIzzcocE1zxstE+N+eJ3ZIm+hliSKsbmncfvVv2xqLW4z8
         1bvWXU/mdHtEl8ww6WPMhBCc3wAaeP+sf866Xs7ff2hR4d/BLbQ6nVgXZZUOWFAwdY1e
         KDAPLJYooe50lvtcEi4F7sFTn+ZDPmOdUSabZTiKPRfP79cptGdWB2ID1gk8dkX3MjI0
         Mdvsk0D/FqYICvTQQe3sywRaOvoOP2y8n4bR82K/gueWrZJZvxXJ1jDCD+P26RWHpL1V
         U0tA==
X-Gm-Message-State: APjAAAW5ZeRVkcRza3iSFAJAV5nwkb+dSjqrMXbNU1sD0uYpW6Cimqqw
        FVmWYvRfXowPl/R67YpPBUkGog==
X-Google-Smtp-Source: APXvYqxNJ2gaOJkwmVoFcJMWZ4ZHP8gYRIU3hwNEd8Jbog0G2JtnUuUg0Cz8MDtps+Uu5rm/vUM+/A==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr3810733wmb.81.1580385767515;
        Thu, 30 Jan 2020 04:02:47 -0800 (PST)
Received: from ?IPv6:2a00:20:8033:fc11:1c15:76bc:997f:b2bd? ([2a00:20:8033:fc11:1c15:76bc:997f:b2bd])
        by smtp.gmail.com with ESMTPSA id h8sm7282645wrx.63.2020.01.30.04.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 04:02:46 -0800 (PST)
Date:   Thu, 30 Jan 2020 12:45:26 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20200130113339.GA25426@redhat.com>
References: <20200130062028.4870-1-madhuparnabhowmik10@gmail.com> <20200130103158.azxldyfnugwvv6vy@wittgenstein> <20200130113339.GA25426@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] exit.c: Fix Sparse errors and warnings
To:     Oleg Nesterov <oleg@redhat.com>
CC:     madhuparnabhowmik10@gmail.com, peterz@infradead.org,
        mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <32DE6B3E-ADC3-49EB-888C-CABCF82330FE@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2020 12:33:41 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com> wrote:
>On 01/30, Christian Brauner wrote:
>>
>> On Thu, Jan 30, 2020 at 11:50:28AM +0530,
>madhuparnabhowmik10@gmail.com wrote:
>> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>> >
>> > This patch fixes the following sparse error:
>> > kernel/exit.c:627:25: error: incompatible types in comparison
>expression
>> >
>> > And the following warning:
>> > kernel/exit.c:626:40: warning: incorrect type in assignment
>> >
>> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>>
>> I think the previous version was already fine but hopefully
>> RCU_INIT_POINTER() really saves some overhead. In any case:
>
>It is not about overhead, RCU_INIT_POINTER() documents the fact that we
>didn't make any changes to the new parent, we only need to change the
>pointer.

Right, I wasn't complaining.  RCU_INIT_POINTER() claims that it has less overhead than rcu_assign_pointer().
So that is an additional argument for it.

>
>And btw, I don't really understand the __rcu annotations. Say,
>according
>to sparse this code is wrong:
>
>	int __rcu *P;
>
>	void func(int *p)
>	{
>		P = p;
>	}
>
>OK, although quite possibly it is fine.
>
>However, this code
>
>	int __rcu *P;
>
>	void func(int __rcu *p)
>	{
>		*p = 10;
>	       	P = p;
>	}
>
>is almost certainly wrong but sparse is happy, asn is the same.

That's more an argument to fix sparse I guess?
The annotations themselves are rather useful I think.
They at least help me when reading the code.
It's not that rcu lifetimes are trivial and anything that helps remind me that an object wants rcu semantics I'm happy to take it. :)

>
>
>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>
>Acked-by: Oleg Nesterov <oleg@redhat.com>

