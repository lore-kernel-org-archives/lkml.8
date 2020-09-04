Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81668C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C7920772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgIDQRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:17:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29255 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726855AbgIDQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:17:07 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-Ek8Rsh5oNBSYzj7yaAiRkA-1; Fri, 04 Sep 2020 12:17:04 -0400
X-MC-Unique: Ek8Rsh5oNBSYzj7yaAiRkA-1
Received: by mail-wr1-f72.google.com with SMTP id l9so348349wrq.20
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bKYS9C1I1RTTs1Rj5JAj++kqqrTapttcqeGOOsRqCKU=;
        b=AcPmD33OqfTDhNxbBPrdn2O9s0HbwzoSIm0bBJqIeWJAx70ebVaSHND6VzsE6upFoP
         A4JCTzAHB5lwgy2GuxkOr7W8OHUFnFx7DXIK6I4uwBNqRkHyDc0n6+Bx6to8l2qOoUUM
         D+/P5eMN9asotTBKxr6329SmeByM2X5EIyJ/k0Z2cJI9ESQRd7wJePx4P+7TIskyrNc8
         Zo2MIfuAQgYQ2MK4dYUY8DihWEaeUj3S7RCMotJBZauXDYHjjyX5hZlTnAnpNvJhK4xo
         KJnfPztMnbiWoP/SPMvWvJ7IgT2plWnxR1YS45Hy1wF8v4fLke6Tc5ltnW1FzH1mGsNn
         AZcA==
X-Gm-Message-State: AOAM5316en661+kFj7C/VxXT184QTmTNTfpdY+GNqXZne6/fBtekMGdJ
        s/eYoquytW8ax7Jmkmk3P+phi5CyDVgcNNNKXrm1Fga2XHF73vLiY2t5H0hAS/29CUxISZLgKEi
        PQDt6mznxlJRoMjwQo/ieKLRp
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr8704494wmn.41.1599236223228;
        Fri, 04 Sep 2020 09:17:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIRgvYRfqIRaUPmLHD40jqHv7CLARR+1AlKKawwGP+duzuN3rk39PtcN4w8OxvXu5nZzs3eA==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr8704472wmn.41.1599236223016;
        Fri, 04 Sep 2020 09:17:03 -0700 (PDT)
Received: from x1.bristot.me (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a17sm7687867wra.24.2020.09.04.09.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 09:17:02 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCHED_DEADLINE reviewer
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
 <20200904123624.GA3552@gmail.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e39ca141-34b5-666e-ceb6-d55573e9e0e9@redhat.com>
Date:   Fri, 4 Sep 2020 18:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904123624.GA3552@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 2:36 PM, Ingo Molnar wrote:
> Welcome Daniel! :-)
> 
> I've applied the patch to tip:sched/core.

Thanks Ingo! :D

-- Daniel

