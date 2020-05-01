Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712DC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35A2208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588343172;
	bh=/XImzuFB8xXVEiWaVlEDRJ9CEFVrRvmrBFB6YUmsG0E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=X9bbuLvYwqAZWUynwblrqoflEC1aU9q2T5GfmLhWTegQGRwXppaf1JOpFputde/hm
	 r7gNoYhAA7uw9UUglmBHaRt/0NQSFqvIeDOzomVTv+wO9AfDVCnqe4nnXCwrEfhmW9
	 vBx6xMIKDy6IbaQ6XR/gso7TUCfkxEOSCf3k6PtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgEAO0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgEAO0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:26:11 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E55720836;
        Fri,  1 May 2020 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588343170;
        bh=/XImzuFB8xXVEiWaVlEDRJ9CEFVrRvmrBFB6YUmsG0E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e9YbOMUEUPT/yeea91IBch131SXRmSieVBodlXyVWsr9ckrqVOiB4o3c07v9VaPBI
         vs8CiE/vZv09NVHcn+Ra/EFRn/3SdTu+X3kquAnNLZR2WR2Ri59utSWA7/vYbPFtQP
         /lrXwq+5wN9eXbZG5eMyWrVGTXILbv1aZ7X8zD9w=
Subject: Re: [PATCH v2 2/2] ftrace/selftest: make unresolved cases cause
 failure if --fail-unresolved set
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
 <1582104810-12983-3-git-send-email-alan.maguire@oracle.com>
 <20200219203941.eb0fb66aee13f6d7a47513ac@kernel.org>
 <20200501184208.2529cac8081a34de0b48617f@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <75fc65c3-a639-41cf-0a10-554e632e9612@kernel.org>
Date:   Fri, 1 May 2020 08:25:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501184208.2529cac8081a34de0b48617f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 3:42 AM, Masami Hiramatsu wrote:
> On Wed, 19 Feb 2020 20:39:41 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> On Wed, 19 Feb 2020 09:33:30 +0000
>> Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>>> Currently, ftracetest will return 1 (failure) if any unresolved cases
>>> are encountered.  The unresolved status results from modules and
>>> programs not being available, and as such does not indicate any
>>> issues with ftrace itself.  As such, change the behaviour of
>>> ftracetest in line with unsupported cases; if unsupported cases
>>> happen, ftracetest still returns 0 unless --fail-unsupported.  Here
>>> --fail-unresolved is added and the default is to return 0 if
>>> unresolved results occur.
>>>
>>
>> OK, this looks good to me. One note, with this change, ftracetest doesn't
>> fail even if your test environment is not well prepared anymore.
>>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Hi Shuah,
> Could you pick this up?
> 
> Po-Hsu Lin seemed to face same problem recently. If this applied, it will be solved.
> 

Sorry about this. I will get these in

thanks,
-- Shuah
