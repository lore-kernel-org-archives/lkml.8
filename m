Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BC8C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009362145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ceDuzW14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDTRGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:06:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB98C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:06:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u9so5228168pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c8ZXcCGyaOKw+Ozb6O6bftY8giwA2pivW+jGUiqARaA=;
        b=ceDuzW14kbIZ2i0eQwyeRjXpeFLA37N/sOZVm/wg+k11CjEifTp/ga29eBOeIrGe44
         yS2uGs4Misq8OUxFCQ5+VmhINn7W+Ahb4Mz4SbDNMMq/1TP0qeU/J48I4AOekIlLRrne
         zc1zc/hacZT4ljGtO8cHQ2J8w54tHxbpKnC1q2Qus4PkK2hZP59KVUwSCAvlYJLXOQMl
         xRiqkSOytKWWTdWjscJfLjDYaMU+VEjJRdgxaooMoQVbqKJsmymCw5hDMDk+RpVV2rm9
         Pc2jV61EflOu0Vx8whUtyg5hKD7ZvPPh4EtG3dOxIWqWQ51G1lwkYDzhjCBRVubUJawC
         dITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c8ZXcCGyaOKw+Ozb6O6bftY8giwA2pivW+jGUiqARaA=;
        b=HNYk1V40YBBGUsEI7U6O5fnYqh3YHb5tSGxupY+XO7iGrrWhjCdRoSg4BXZGBGd/Yr
         hs91yjX/BvqaH9JS19Z4wYZOetICPTrtarZ426U9E9hhMHD2AMaaB/yfo25c7koC+8P8
         d+kazLJJOouC5QX7xuVrv5LtjsjVAvCINeH+yG2XCJAL4VrmrF888XsNq7EoX1M1U/cV
         8sGpr1xXUbQL8ICIqUygEeFulqOlEOU+zYCZAdo30Ytv1aOMCY+o+9ZKy1TjuoCPMKy7
         tbSTdXjiqvDWWN/i+Nj3YHOsQolbQJGITjyps+t/oHpB3kcEIUmDKVpyaL4uutpCamjj
         dTZw==
X-Gm-Message-State: AGi0Puax5gCwwCQJTcn1D2LtNcNKCbRQWvCWDUtiQYxPpUsC4ajqGWAN
        +TRZ4VNQCqtY1eoWrzloSP+Rrg==
X-Google-Smtp-Source: APiQypKuyVVHqIYvsIWKtWzA0+g4/2oga3POfBR+VhvJnYBpmh1SmDpP7GPNGKWBwfv8Pv1ID71P+w==
X-Received: by 2002:a62:1a53:: with SMTP id a80mr18468354pfa.157.1587402394962;
        Mon, 20 Apr 2020 10:06:34 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id 6sm1696189pgz.0.2020.04.20.10.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 10:06:33 -0700 (PDT)
Subject: Re: [PATCHv3 24/50] openrisc: Add show_stack_loglvl()
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-25-dima@arista.com>
 <20200419205728.GT7926@lianli.shorne-pla.net>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <b42b19e0-823c-dc7b-2a72-b6ad0a02b26a@arista.com>
Date:   Mon, 20 Apr 2020 18:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419205728.GT7926@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/20 9:57 PM, Stafford Horne wrote:
> On Sat, Apr 18, 2020 at 09:19:18PM +0100, Dmitry Safonov wrote:
>> Currently, the log-level of show_stack() depends on a platform
>> realization. It creates situations where the headers are printed with
> 
> Instead of realization I would say "Implementation".
> 
>> lower log level or higher than the stacktrace (depending on
>> a platform or user).
>>
>> Furthermore, it forces the logic decision from user to an architecture
>> side. In result, some users as sysrq/kdb/etc are doing tricks with
>> temporary rising console_loglevel while printing their messages.
>> And in result it not only may print unwanted messages from other CPUs,
>> but also omit printing at all in the unlucky case where the printk()
>> was deferred.
>>
>> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
>> an easier approach than introducing more printk buffers.
>> Also, it will consolidate printings with headers.
>>
>> Introduce show_stack_loglvl(), that eventually will substitute
>> show_stack().
> 
> Will you do the work to replace show_stack(), when is that planned?

In the patch 50/50 from the series:
https://lore.kernel.org/lkml/20200418201944.482088-51-dima@arista.com/

> 
> Other than that small comment this looks fine.
> 
> Acked-by: Stafford Horne <shorne@gmail.com>
Thank you,
          Dmitry
