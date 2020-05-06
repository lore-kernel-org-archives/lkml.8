Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4886C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F02420708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588779976;
	bh=zIzO6N2aIHBBQfpze5U1m0raY9nb61DLTvoRlnF4tv0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=JLN/JScx36wTXM/CGiO9abqP23DVwKAnlZVISvBAJ3vHc0PO1W9f7qypVapU+nSxl
	 sNSSq853WlDRYh3YZ6cEG+D+AbkHTgRX3cFlY9XF8WB7fI80mqcX/BlFX+jSs2P1/O
	 IjKy9alkByXPvdWojOn/CBVpFStxqc+w8mWe9UZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgEFPqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgEFPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:46:15 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6058C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:46:13 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c18so2194757ile.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QT2YN6oqKqg6700ugZaaaxIxPh7KJTUan3y27PnGKts=;
        b=J/GhKerOoarXIYXI3Rx+JWkjRs7CCOiRPgY+0225MXwMQMVB0it64dmgW6lpUI5o0Q
         yH6/E22JHPpFY7NS7CnEvTyK9tFqq1yV9g6N4rAbwlqaUOry02ETNNre4XdxElRL19F2
         pNHdP5k4fWMSt7askz6QOiDDWXSO/VoIe0Fh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QT2YN6oqKqg6700ugZaaaxIxPh7KJTUan3y27PnGKts=;
        b=n/yDQ0AQTh3RQ7cY/++6QGES2AmsFvIqQnL7WoPfMtuYf8KXngYpGEGPFsbgibi/NJ
         vfq3NFewl2S74oG/U8n2prOE4+fftqs3+eObq60Eh/mkkGrNDOevv6nb2hpj8iXMpUPR
         Ddn3Wk/b8eOIjzQTzG7ta7+T9ztNBNaRzkTqWHavVcXymZiyuZMCdo3fMXGkwwSy4XXi
         iHjUavifucuLSGOVhe0AVF0KJ0/Qq2ZyK6vkllPXjvET/Jr6ml9lm00f/jTDQcbfo6Cg
         FdJcItn+un5RTiQmdGUZatazWzBCbjwxZ/GVQ2sg37z1p6w2KQxfcqYZNTmWA/CGiTZ0
         +7YA==
X-Gm-Message-State: AGi0Pua00LNUkdHOw8t+g6gYKxAfQ+EgILh2gQhPgD00K/9zvfD9HjDP
        hvMbrbxmAhH9t0EcI/64ZP8G1w==
X-Google-Smtp-Source: APiQypIkBH8t6x3OXeefHkp9yWiD5BTjf+mpTuKXbtUT2nXa+csoEMlMwpIi8Fir10PaPz6LZpH1Cg==
X-Received: by 2002:a92:1949:: with SMTP id e9mr9877680ilm.106.1588779973174;
        Wed, 06 May 2020 08:46:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t1sm1208096iln.4.2020.05.06.08.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 08:46:11 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as
 unresolved if the test module does not exist
To:     Steven Rostedt <rostedt@goodmis.org>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>, mingo@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>, joel@joelfernandes.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200505101445.27063-1-po-hsu.lin@canonical.com>
 <20200505090912.7114f420@gandalf.local.home>
 <CAMy_GT8r8H21Ly3N5VFkiPi0qUCkPCvy8SU3Ns2vesaS8xvffQ@mail.gmail.com>
 <20200506114351.1b45e82f@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ac9c5f4a-3288-0f6a-dbb7-1b7dcd0c7a87@linuxfoundation.org>
Date:   Wed, 6 May 2020 09:46:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506114351.1b45e82f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/20 9:43 AM, Steven Rostedt wrote:
> On Wed, 6 May 2020 09:46:21 +0800
> Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
> 
>> On Tue, May 5, 2020 at 9:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>>
>>> You keep forgetting to Cc Shuah's other email.
>> Thanks!
>> I got the recipients list from the get_mainter.pl.
> 
> Hmm.
> 
> Seems like that is what get_maintainer.pl does:
> 
> Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)
> Ingo Molnar <mingo@redhat.com> (maintainer:TRACING)
> Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
> linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
> linux-kernel@vger.kernel.org (open list)
> 
> And looking at the code, it appears it will only take the first email
> address found in the file.
> 
> Shuah, if you prefer the linuxfoundation.org email, you need to update
> MAINTAINERS file to have that one first.
> 

When I updated the MAINTAINERS file, I was hoping both addresses will be
in the output. It doesn't appear to be working the way I assumed it
would. I will send in patch to update to switch them.

thanks,
-- Shuah
