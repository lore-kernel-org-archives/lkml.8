Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7616CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4963E24695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6ntJOgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCBHGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:06:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=e+UgOBP2C/fGrEWGLe7tJJaQdy33rX5WFPpAjGLY4fc=; b=i6ntJOgc4OfIEImyEteflOZcPZ
        AYG+UzbtSIvtt+BilEHf4GRmGpw9I81IRGpvfb0LKOXg3Y9spOzerqUgJlCqX6szl71GyI6veBNmu
        2mz683PEfZERQjHeRkYjNdbvlbrT8pWnE7YCEjv2gICYU/qczGnKWxj3eprw5OQ7WbQ3km+wJ1gHV
        7hG4voO1hWM4HAwBVaO8nEI/cZclLXwtnlcFQo/g/08ic19bybo49n1j4DgVVR4dFs9YekY0Q1i7m
        5sgf0xUGehZovAuBbkL6ic4vtrKPNFtGFfoV3CNBjrOuSa+97o3PKMEq5lBmxr+nIcoRqMB2pub+9
        VQitlLSg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8fA9-0006yk-Ii; Mon, 02 Mar 2020 07:06:49 +0000
Subject: Re: [PATCH v2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
 <158287862131.18632.11822701514141299400.stgit@devnote2>
 <972ba3a8-9dd7-e043-d2f0-8fa8620686f7@infradead.org>
 <20200302155247.93558d4865a8bcd160ef39e5@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2080a377-f03d-9df6-bb4a-c440d6f8ac11@infradead.org>
Date:   Sun, 1 Mar 2020 23:06:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302155247.93558d4865a8bcd160ef39e5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/20 10:52 PM, Masami Hiramatsu wrote:
> On Fri, 28 Feb 2020 21:59:45 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 2/28/20 12:30 AM, Masami Hiramatsu wrote:
>>> Update boot configuration documentation.
>>>
>>>  - Not using "config" abbreviation but configuration or description.
>>>  - Rewrite descriptions of node and its maxinum number.
>>>  - Add a section of use cases of boot configuration.
>>>  - Move how to use bootconfig to earlier section.
>>>  - Fix some typos, indents and format mistakes.
>>>
>>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>>> ---
>>> Changes in v2:
>>>  - Fixes additional typos (Thanks Markus and Randy!)
>>>  - Change a section title to "Tree Structured Key".
>>> ---
>>>  Documentation/admin-guide/bootconfig.rst |  180 +++++++++++++++++++-----------
>>>  Documentation/trace/boottime-trace.rst   |    2 
>>>  2 files changed, 116 insertions(+), 66 deletions(-)


>>> +Also, some subsystem may depend on the boot configuration, and it has own
>>> +root key. For example, ftrace boot-time tracer uses "ftrace" root key to
>>> +describe its options [2]_. In this case, you need to use the boot
>>> +configuration.
>>
>> Does this say that "ftrace" requires use of bootconfig?
>> It seems to say that.
> 
> Ah, I got it. The last sentence is confusing. How about below?
> 
> "If you want to use the boot-time tracer, you need to use the boot configuration."

Yes, that is better. Thanks.

-- 
~Randy

