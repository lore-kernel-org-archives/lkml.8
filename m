Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311BAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0598F2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Yt5SwWrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgICFgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:36:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31483 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgICFgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:36:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599111409; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XAK1OwuK7kFToxaHLmfxzWG4IDIn11hNYh4jY6egkvM=;
 b=Yt5SwWrwGW7rzOxNjnEXDeB1a0CLjOGjALxTX9MVbXNG/5so5FVcZO4qVrtemsAbQHvmZLua
 TlkWbKqKZOWWnYihPgzbVHFLuNWGK5AmzqPFKXIRkz3sk3TF1kNBwwgCqy9sFuDuQEpvxu8p
 5nZ0QXripSJgDDW3pGJLwOZq6N8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f5080f0698ee477d167694d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 05:36:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 797CDC433A1; Thu,  3 Sep 2020 05:36:48 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97525C433C9;
        Thu,  3 Sep 2020 05:36:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 03 Sep 2020 11:06:47 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nachammai Karuppiah <nachukannan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, computersforpeace@gmail.com
Subject: Re: [RFC PATCH 0/7] Trace events to pstore
In-Reply-To: <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
 <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
Message-ID: <a301d1d5a18e49bcb5d27b999deb2be4@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 03:17, Joel Fernandes wrote:
> On Wed, Sep 2, 2020 at 4:01 PM Nachammai Karuppiah
> <nachukannan@gmail.com> wrote:
>> 
>> Hi,
>> 
>> This patch series adds support to store trace events in pstore.
>> 
>> Storing trace entries in persistent RAM would help in understanding 
>> what
>> happened just before the system went down. The trace events that led 
>> to the
>> crash can be retrieved from the pstore after a warm reboot. This will 
>> help
>> debug what happened before machine’s last breath. This has to be done 
>> in a
>> scalable way so that tracing a live system does not impact the 
>> performance
>> of the system.
> 
> Just to add, Nachammai was my intern in the recent outreachy program
> and we designed together a way for trace events to be written to
> pstore backed memory directory instead of regular memory. The basic
> idea is to allocate frace's ring buffer on pstore memory and have it
> right there. Then recover it on reboot. Nachammai wrote the code with
> some guidance :) . I talked to Steve as well in the past about the
> basic of idea of this. Steve is on vacation this week though.
> 
> This is similar to what +Sai Prakash Ranjan was trying to do sometime
> ago: https://lkml.org/lkml/2018/9/8/221 . But that approach involved
> higher overhead due to synchronization of writing to the otherwise
> lockless ring buffer.
> 
> +Brian Norris has also expressed interest for this feature.
> 

Great work Nachammai and Joel, I have few boards with warm reboot 
support and will test
this series in coming days.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
