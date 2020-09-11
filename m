Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D2C2D0A7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3A721582
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599788067;
	bh=NnJvrtkiDfXCuIyhMgqGL1L+jPjnlW6MtJhts/ZUGp8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Jqlpv7cht0T/KZsA1xXxo7ehY5P//MLVEN1TDQgBywMmxAzdiMSGrI84LqdrsVdvB
	 WX9hr0CgKeiJosKZLW4BidpT5WoG0bP5jhvMx4o+MoWnut96WnkzuAFWLCcoQRV+A3
	 t3MG70blRDVypXy0fJ+Rirzs1SWGp4w08BX0BYcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgIKBe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:34:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F4DC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 18:34:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y6so7899838oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 18:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7vaJi8kgW5W7GuAXioXeaqqVAFP6TvfOLHR8jdJNfGI=;
        b=UOXfO5+x3QkkTe7v71QHlKaT4HecVi4d69p2MacHc+AZ7+9f095/my4bRjsD248HuF
         z7yI73v+W5SQzcuFd9ukjJsGi19jMAO6obblnwR6lzhvBnXL+Yd7tIPZUZewyLXBd+5y
         wQYyKOMclt6T3CdHqAlP+9eKg8ekpV8PaArzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vaJi8kgW5W7GuAXioXeaqqVAFP6TvfOLHR8jdJNfGI=;
        b=rwycLgGKYZ0tBit9xp3qYsd2epftkGgqHfkGZnDk/d9Khjn2vKIiOt2m6Ch1ZURARG
         WI60TSEe8sXSTIuaMkW9BrosrHpFNJHxovER0AtDM1S4gLnCJ/KzfqlTHLd9aaxLSLhi
         lHmhxn1Sgc0biMLQM884HqgrlMHmzhOn374X/mlitsFgCtYubY+q6LsmL0r3QmJHrXpD
         62wJs5Qy2uBn92C9p01NuVgCVhVv3wdBOYNccCzdhewQPSr7FeNpYOwtxiMONv2RApOL
         R83sWPruNK3+Lzi2dYA2cvm+66Rpn5BUFIO0WQ166Qnj47Z5FDkWkK+DBK0KWVbmXSNz
         WS2g==
X-Gm-Message-State: AOAM532qH2iNdWjT+n+5oiBo9Eo21eBkAZGmoptNyY83gubYs7hL7RGp
        yVDb/jGl9fWrVkkmEOh0tD5F3A==
X-Google-Smtp-Source: ABdhPJzhxoPLlARsfWWzICedHKinD4e+Wl5kxwU9KCyJ7cF4pceSjcf5McnrNvjDJe6hjaLxHsQfzA==
X-Received: by 2002:aca:5605:: with SMTP id k5mr1864936oib.21.1599788052935;
        Thu, 10 Sep 2020 18:34:12 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 111sm131877otc.15.2020.09.10.18.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 18:34:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] tracing/boot: Add new options for tracing specific
 period
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159972809455.428528.4737752126800169128.stgit@devnote2>
 <20200910193433.236cf081@oasis.local.home>
 <20200911102743.de29a1f09bcb361f8d6556f6@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f386dbb5-eca7-fba4-b36f-d71bbdf64591@linuxfoundation.org>
Date:   Thu, 10 Sep 2020 19:34:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911102743.de29a1f09bcb361f8d6556f6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 7:27 PM, Masami Hiramatsu wrote:
> On Thu, 10 Sep 2020 19:34:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Thu, 10 Sep 2020 17:54:54 +0900
>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>>> Hi,
>>>
>>> Here is the 3rd version of the series to improve the boot-time tracing to
>>> support kretprobe and tracing_on option. Previous version is here:
>>>
>>>   https://lkml.kernel.org/r/159894698993.1478826.2813843560314595660.stgit@devnote2
>>>
>>> This version adds uprobe %return suffix support ([5/8]) and the testcases
>>> ([8/8]), and update kprobe %suffix support([4/8]) and the uprobe event
>>> document([6/8]).
>>>
>>>
>>> The combination of tracing_on and kretprobe allows us to trace events
>>> while a specific function call period. For example, the below bootconfig
>>> will make a function callgraph in the pci_proc_init() function at boot
>>> time.
>>>
>>> ftrace {
>>> 	tracing_on = 0  # off at start
>>> 	tracer = function_graph
>>> 	event.kprobes {
>>> 		start_event {
>>> 			probes = "pci_proc_init"
>>> 			actions = "traceon"
>>> 		}
>>> 		end_event {
>>> 			probes = "pci_proc_init%return"
>>> 			actions = "traceoff"
>>> 		}
>>> 	}
>>> }
>>>
>>> Here is the example output;
>>>
>>
>> [..]
>>
>> Hi Masami,
>>
>> This looks really great! I just got back from a 10 day holiday, and I'm
>> drowning in "catch-up".  I plan on looking at all this relatively soon
>> (in a week or two?). I just don't want you to think I'm ignoring this.
> 
> Hi Steve,
> 
> Thanks, I hope you enjoyed the holiday!
> BTW, this series includes some document update and testcases.
> Since we can not decouple these updates, I think it is better you to
> pull the series.
> 

Hi Steve and Masami,

selftests patch 8/8 in this series looks good to me. My ack for
it to go through Steve's ftrace tree

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
