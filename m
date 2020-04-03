Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D80C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7547520659
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M06xZPFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbgDCMta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:49:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47531 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727989AbgDCMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585918168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1KkZ0XRRswbgUoInokEgiAJa+KYlL2aTUCPUcSLR1U=;
        b=M06xZPFGPEV5PLlHGT1YE4Xy9lcnUp21HtM+kiIOoiVNFulb9VBm6MCCo2h0OlkfPZVdrm
        MTlzBKAU20amicwfoLDfcPZ2TfYYaePPmfbLOFH7nxFxPFZqwo8mkeLPGqoV/LAF/Tu/Vn
        rbo6XSubRmUYGju1eeiM7JD0UncH5UE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-6nMGoouJMkK4l8uYca7UpA-1; Fri, 03 Apr 2020 08:49:27 -0400
X-MC-Unique: 6nMGoouJMkK4l8uYca7UpA-1
Received: by mail-wr1-f72.google.com with SMTP id 88so357875wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T1KkZ0XRRswbgUoInokEgiAJa+KYlL2aTUCPUcSLR1U=;
        b=k1a0NMFYsm9ZAuIcKcELacjNnnAmzbaTNJR5+7WY9SBQye+39iGiQnoNkd5stS5OKs
         XdwLqCuD8ktPb9gUIvZPyohG806zZMbTyk9T4NxAOefdJF5ZgSaggrGvqBSHPWCm7qyx
         ze8ptVyInQQvWoIWF+ZgGRXq863/48jgnegnD2TF3TxB0DjnDtC+4yER2aV/UiH1rYpa
         OmenXvBOjBQl7+HBA9vtVMFFcqpp+TJFskJtPq4vHlu94acIFpJb3u2LQwYKWX4X/avq
         wFJHfM3d7hzE24Shm53cFLbz5+ZxzBEJToWmsseKxxBcOfNy3Jt0/vkzfaieVj/S5Ovy
         gnUw==
X-Gm-Message-State: AGi0PuZp0lQ1QbRww0p3iDDGhF5ZS3zC6Fg0yd1N5We9avGEDCGQmphw
        Ztos8p0P5BFPR17LKUz5NDpdP7INW2d0JvUbgHuJJYcReGrpSP6KepAgmaNb0IIMCtHhG78AJa0
        ewT9bmNIxOUWpStakCZiewPve
X-Received: by 2002:adf:e848:: with SMTP id d8mr8636717wrn.209.1585918166424;
        Fri, 03 Apr 2020 05:49:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypJoZDTst7iMtymL+le90gPhjILOuY+V5+iX0JvWp5fRv+yD08cpySH5v9ZSJ1uy7aixV4S+MQ==
X-Received: by 2002:adf:e848:: with SMTP id d8mr8636706wrn.209.1585918166276;
        Fri, 03 Apr 2020 05:49:26 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id g3sm12136573wrm.66.2020.04.03.05.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 05:49:25 -0700 (PDT)
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <20200402154919.2c6shw4hfreagchg@treble>
 <3d075cb2-8d99-5ab7-4842-efef1964247d@redhat.com>
 <20200403124107.GO20730@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <efa3b732-f102-9c4a-16e8-ffdb436cb9b1@redhat.com>
Date:   Fri, 3 Apr 2020 13:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403124107.GO20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 1:41 PM, Peter Zijlstra wrote:
> On Fri, Apr 03, 2020 at 09:01:38AM +0100, Julien Thierry wrote:
>>
>> Last I found is in qcom_link_stack_sanitization() [2], but that's just a
>> workaround for a very specific hardware. In my local tree I just put the
>> function as STACK_FRAME_NON_STANDARD. But the code just saves the return
>> address, has 16 call instructions that just call the instruction after them,
>> restores the return address and lets the C-function return normally (and it
>> somehow fixes something for that hardware).
>>
> That sounds very much like the RSB flushing we do.
> 

Yes, the piece of code you posted reminded me of this. The difference is 
that the RSB part uses a loop and counter while the qcom thing has a 
fixed amount of call instructions (which can make things easier for 
static analysis, if we'd really want to go down that road).

-- 
Julien Thierry

