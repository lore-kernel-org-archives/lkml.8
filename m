Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA9C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E667D20836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588343288;
	bh=uc0jeKtWs3Lu3Yt9mmc+LlPjm0LoSh7dRyHqZCfrsV0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GroiIBT/9bV9+3lO5OfEAOchD9LZCPhXAr/T4gk5Br/I19alcNoHHUEEbT6EOOb5W
	 6/H1YVbsMHIOy+3wzuXLzbZdYY6MJcaMCk0AKD5fCToaywrR1Po8Sf/rIEL1TAlpYc
	 z1fBB473GfhRXlpoEJuqYySloQTtrpqLnH+AwPA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgEAO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729050AbgEAO2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:28:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C6C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 07:28:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b12so5008405ion.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qFn7gkPMpYmrr60w9n8c1qnQXMXv7MA2WqU4Vb048CQ=;
        b=FSHjDh6mE+SLHTo6uWK4BNB8pkEFPuJ3ZSajl02AKtDC/z4FJ3yaVftHc9hD7WkgRU
         oXoAj94KsBc/Q/sLhnXx/DtzkcJpdwoJ7SEAoIquOgp26bYuxGDlTNcRFgOjIlvn4G+H
         StEyTreXxgB+tJCSwnGCNmzEjAnnz+MJpCWUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qFn7gkPMpYmrr60w9n8c1qnQXMXv7MA2WqU4Vb048CQ=;
        b=FTsXKVCieqoG507nHuineZcMJ4n+K6cQs0iD7dflElKq0c89hgtO2UIr558+mMUgqI
         PqGCIauXFaNWUEEEU1wP+AnUdK/nLzuzzizvsl6sG5EB7jzDMwZX57LykO3No9jAZADY
         +4i8Z3DpYE5tuwPyreOlVcofla10FyEi1J1AjjqQC8vQfek+YwjeyR0UH4skZXnaplS8
         QyJaiF1nlUl7yycDiiO6q6cHcTfcVPTw83tCAK8kYCs3FfhqVN55rsh6oueXUD/rBBdw
         nq7DPB/u597msvvpmoNQfwAkeRI6wnj6BuX2VaguQ2EqWDZxufY9KV3apmTGPZoamc71
         rajQ==
X-Gm-Message-State: AGi0PuYU3mRwHRE2r6K44hw6zOs4hTIIksGYD+O+MUO4wV+Ua53Da3wM
        c51liA9YERrkkNMVoEWjc6v/fxxWgow=
X-Google-Smtp-Source: APiQypIV8SjoKr6rXC8O9phDKiSS9vCYzDsnS8K9NLjxFVbMq93JYaDRdRC3XWg84TcQ0M0SFZvnkA==
X-Received: by 2002:a5d:96ca:: with SMTP id r10mr4033777iol.19.1588343286616;
        Fri, 01 May 2020 07:28:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p7sm1027884iob.7.2020.05.01.07.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 07:28:06 -0700 (PDT)
Subject: Re: [PATCH 0/3] selftests/ftrace: Fix ftracetest testcases for dash,
 etc.
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
 <20200501102113.151d38c1@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5334156d-a8f8-9eeb-f6d9-299992582c6f@linuxfoundation.org>
Date:   Fri, 1 May 2020 08:28:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501102113.151d38c1@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 8:21 AM, Steven Rostedt wrote:
> 
> [ FYI, Shuah responds better from her linuxfoundation.org email ]
> 
> Shuah,
> 
> Feel free to take the first two patches of this series (I acked one, and
> reviewed the other).
> 
> The last patch I had some issues with, and is still under discussion.
> 
> Thanks!
> 
> -- Steve
> 

Will apply the first two.

thanks,
-- Shuah

