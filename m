Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6585C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C554F2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgDIGxw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:53:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33745 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgDIGxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:53:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id v8so1784479wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 23:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=t3JE+/sR3iLSFPRwnLZ9+4mg38UzzpABfn85lTFhzWo=;
        b=LtVmB5emDcI4VOBOSSKJlPMQcj3jZgX1p68bYYraoWIRF/LMT2M8aWhbItr98D6GAJ
         jHzMVeBKI007LVW/sGFyKN0H+3B8Y0ElIvf15HWaTm3P0+tQ6luW5qRUOjma/3mmIYwi
         DnOupyTey+OWhKm6bL2oDL8chCXu4nLcro/M9b7rCO7c13lG8h8SzaPCysPRU84CZMWM
         8gC0+tGIb57FiHWv602ekUXlx1zgeWPuz14kldhWkQD0w/t6GabD7SwQTtQNEnds9IHp
         P5SWo37TneYn415YvwSYsjuqdlEkcaFSSw6Oz9S9ZJXTbh/TXd+fAaSSlVWgp5aErQF0
         nT4g==
X-Gm-Message-State: AGi0Pua1VLRZg8Moh/iT1ruWx9onqG+LCpWzof64aZb4esoXrvyPPZpr
        esvMkeAUesry5GU40pRy6odwEQ==
X-Google-Smtp-Source: APiQypKA5ttzv3gC9XiCNgckuIBpQ8MVI7lUcS4NpW3Q0zg37ISgSnyAnvrapszr7GD/eT+CgM02lA==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr8455866wmf.103.1586415230083;
        Wed, 08 Apr 2020 23:53:50 -0700 (PDT)
Received: from Google-Pixel-3a.fritz.box (ip5f5bd698.dynamic.kabel-deutschland.de. [95.91.214.152])
        by smtp.gmail.com with ESMTPSA id s6sm2506614wmh.17.2020.04.08.23.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 23:53:49 -0700 (PDT)
Date:   Thu, 09 Apr 2020 08:53:47 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <2d00096f-94f7-753e-c05f-14860fed2abe@huawei.com>
References: <f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com> <20200330084415.p4v5g6s24innsjrc@wittgenstein> <2d00096f-94f7-753e-c05f-14860fed2abe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] signal: check sig before setting info in kill_pid_usb_asyncio
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
CC:     ebiederm@xmission.com, oleg@redhat.com, tj@kernel.org, guro@fb.com,
        joel@joelfernandes.org, jannh@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <EFD902AA-B999-4E13-AC1E-1A28E93435BB@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 9, 2020 5:26:08 AM GMT+02:00, Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>Friendly ping...
>
>On 2020/3/30 16:44, Christian Brauner wrote:
>> On Mon, Mar 30, 2020 at 10:18:33AM +0800, Zhiqiang Liu wrote:
>>>
>>> In kill_pid_usb_asyncio, if signal is not valid, we do not need to
>>> set info struct.
>>>
>>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> 
>> I'd have done:
>> 
>> if (!valid_signal(sig))
>> 	return -EINVAL;
>> 
>> instead of setting ret to EINVAL above but that's mostly a matter of
>style.
>> 
>> Picking this up unless someone sees a problem with it.
>> 
>> Thank you!
>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>> 
>> .
>> 

The patches are queued for after rc1. So around next week.
They came too late to make it into the merge window.

Christian
