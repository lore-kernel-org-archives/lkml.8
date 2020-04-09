Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37191C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BFE2137B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDIGxe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:53:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38473 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIGxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:53:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id f20so2994252wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 23:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=z3LfHnavLnq0BMPs1neS2PbleZudbmcvJ9Ip1XWLhLo=;
        b=bZ/R0g4qvw6lf4vFwLFFoR2pJvstq4u/HIpCmevENFXqAF9FFRCgOFOF2ICc5E/EnO
         UdG5f6WZ8fl9oCTLoeLAJ80qUr6+T+wLlWGtq4ncoJFyRj95tdDVEzWJylnnsT/NqwhF
         K3T5tpZd+9quUf9qSLPOCgWBstInWStoUaVcDmKIqxj20bb/c48IU5q0u2Rf80I6i6Wi
         hxCXCYP3v8FVmH0CPb0OzceYGFOf7vlKzDJ8n7a+5liOr+o0ehSLfkpZRaHABphzbuPR
         PQlbDmQoHlR6p7n3wlfEsxZpSdRL87UFRybfzoIdoLzGvv/n1q8iG+OGGeiElS+KTD0i
         PYQA==
X-Gm-Message-State: AGi0PuZloKV7oa2kRqQP6+zSAb4eJ/PF+PU0t0wjv3+6jthXYJwrVG+G
        IpmdkKWD2Oy4Vj9gN9g/0wqHTg==
X-Google-Smtp-Source: APiQypKFRzUdd5pfBUEted60Eprvnkvpu6I0W7XNaJj/ObWUYL2enLCnui3HA8dtzdWH0OdM5Wpjcg==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr8520174wmg.58.1586415210800;
        Wed, 08 Apr 2020 23:53:30 -0700 (PDT)
Received: from Google-Pixel-3a.fritz.box (ip5f5bd698.dynamic.kabel-deutschland.de. [95.91.214.152])
        by smtp.gmail.com with ESMTPSA id s13sm22828958wrw.20.2020.04.08.23.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 23:53:30 -0700 (PDT)
Date:   Thu, 09 Apr 2020 08:53:27 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <bb0dae48-0183-019b-b4ba-47ac6347fcc5@huawei.com>
References: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com> <20200330084845.o5jdrg44pm3uiydh@wittgenstein> <bb0dae48-0183-019b-b4ba-47ac6347fcc5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] signal: use kill_proc_info instead of kill_pid_info in kill_something_info
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
CC:     ebiederm@xmission.com, oleg@redhat.com, tj@kernel.org,
        akpm@linux-foundation.org, guro@fb.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, Mingfangsen <mingfangsen@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <45B3B268-AD16-4B8A-803C-EA911DCCF14F@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 9, 2020 5:26:30 AM GMT+02:00, Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>Friendly ping...
>
>On 2020/3/30 16:48, Christian Brauner wrote:
>> On Mon, Mar 30, 2020 at 10:44:43AM +0800, Zhiqiang Liu wrote:
>>>
>>> signal.c provides kill_proc_info, we can use it instead of
>kill_pid_info
>>> in kill_something_info func gracefully.
>>>
>>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> 
>> Thanks! I'll shorten the commit message header a little when picking
>> this up otherwise:
>> 
>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>> 
>> .
>> 

The patches are queued for after rc1. So around next week.
They came too late to make it into the merge window.

Christian
