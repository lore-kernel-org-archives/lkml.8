Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D01C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D627E207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591735297;
	bh=duLQVpbtALQWLzcggIVyQsHbg8x6QVyxM3wzF2RUuaU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=x1vACSk0blPFB6zUuNauyhazW82saHakGvmey7BFVmhCPd1Q0PqgbFF9UroPfbm3f
	 XYAu4/CJyYDGkmgQMprvQCNgfJ/Yfe3jABm8Wdrv3Wapx4YyzHo20TRRx+ICMauzfi
	 jNoXMp6dVQ4Ej/n2jh5pnMxGYqqj8ZyzmmHxst98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFIUlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgFIUlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:41:32 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FDBC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 13:41:30 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s21so20056543oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vX1/6HJoQCcRM+qq9131VZla5JA4KT3mXRX75cnko3A=;
        b=BrYL37H9Bk7uAEUNaMcwXjG/MNCjhC3iNpF6ZpT63kqQij83xH0gjlVwJVXqCLTVgF
         oA+ilSfSsSO5ACPPj7GmlgxSnRXUArbtbwmKkqZhSYRuNkUcNN8UY0LzNKArLVbavEHR
         C7pTHhl94ZiniANQJg6iOCEPHGn/MDS6unvzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vX1/6HJoQCcRM+qq9131VZla5JA4KT3mXRX75cnko3A=;
        b=WJMqrzxvFc/6deqK7+Pn58PHSoeS68wdY6xDyMtBLKLKyozlWZSeTKjTt1VLfqWNLI
         r9hw91Mx4WlFNLOVUcvtyUbjtkPilLPIqnUI/UyKNJgFpqPU4J5cAcZjzKYoxhtNbw9B
         9cBLRJNZhwFIqPOyFvGOx+Gx4rapABblMWL8P7/UT4KScIuYhwAPp0RGUh0I9yDS6tz2
         FwC9HS84epNpaDbEl3Jl4XfwcmLhPPdMmo5GMtB8kjemipYNOu5zUJek4svS13M/I409
         1F3Ci5pOtW16mAXKruVpn3afrH99i9c3Zwro+mYPf+6A5DpMSN3cIS7cQZC3+fxzaKC6
         CiMA==
X-Gm-Message-State: AOAM533/4AtuOp1syaXeDcB6SF7Ay4ZaQym0+GhyEzunHE7oIbd25zxt
        csv0wKEWJOPdufSa5hezDTDvAQ==
X-Google-Smtp-Source: ABdhPJzFMYW52w9uV8RuAmlTsOq4u2EKyDf2AQRspYRj1FSp4o+2To75XIoFy3P2h0L/XxIRfYT1MQ==
X-Received: by 2002:aca:ed42:: with SMTP id l63mr69310oih.101.1591735289482;
        Tue, 09 Jun 2020 13:41:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h189sm3394193oif.10.2020.06.09.13.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 13:41:28 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
 <159115203782.70027.2241223276591824366.stgit@devnote2>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
Date:   Tue, 9 Jun 2020 14:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159115203782.70027.2241223276591824366.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/20 8:40 PM, Masami Hiramatsu wrote:
> Convert the required tracefs interface checking code with
> requires: list.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> ---
>    Changes in v2: Fix trigger-onchange-action-hist.tc requires list.

Masami,

This patch doesn't apply to linux-kselftest next

Patches 1-3 applied fine and this one failed. For now I will
hold off on applying this series.

thanks,
-- Shuah

