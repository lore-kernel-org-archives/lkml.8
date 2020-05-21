Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA22C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA1B206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXDVGe19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgEUCMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 22:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgEUCMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 22:12:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A61C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 19:12:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so2153885plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 19:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x/AMjJPZ9ca0EQ/k39Jt0+UZiNTPRUDUcKl7X30gDSk=;
        b=PXDVGe19msLyRGvQBp4A4eB46RzDUpGigTDGf6C3weoSwKoT0r9DrYDrOVaKHJuXRd
         xF8dHzc1Jotes4OMAlUtiiuj7insxZ+Zpplab6B6qhKzcrhYKLQCycYrMZewfW4NFs9U
         9MZe+pl4I/Z81u7oLwZKxBaQeB1jqDFix7xifVnYfAWmBWx1vZfe5iCr/3T5PDPxdOm4
         NBwiWydpshjOHuTHdFxQ8MjbKIKa4QRlgHmVttdDlhx6GxW9GK6h0HLjhuIyeoE+NQnf
         WF7aCm8Dp0t9S5N40mIpCOtYotMU00/cgkeP7cNtb/R1g6PC2KX6Iv4BZQDDFr/ncydq
         TPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x/AMjJPZ9ca0EQ/k39Jt0+UZiNTPRUDUcKl7X30gDSk=;
        b=IMZqKOfpnWshZ2yuFGEZxWHbu/rLKuFz5KqP2Omu7cT9yi/arj3AxUwmen0hPg8Bu2
         12W5feUBRRJj+lWieVQwOQSkZH5DitjUuWQsBwAgtpKCRywQgcyQ8+Id2HEZTO6jn34o
         7jOYruabp/Wy5ZBX5PU0ItJTz2AxYQEAyNzWJR/qcWLAq/4kfE5rFaI/RUpytSsdxMMO
         oxOzf6X+8rNxIQ+1icYk+S6nJUAFugchyUbGk1fUHK9lVrW+MIlTEgXi+HBAl+660u+O
         JIrVijA5y7cb5kzS0R6sJmM4YSt0+qX7mJm8yXfCiZC08WvvKfxuWrFeBz8JVKEkfekG
         FOig==
X-Gm-Message-State: AOAM5337Sq2Jg+moYgvj3eh5tLmzZRPaGrVSj6diSylR3vAXulDeC1nZ
        gQb0DB4iesUYBzoTJcHm09VVzw==
X-Google-Smtp-Source: ABdhPJyeLB5Qb2vkg8Q3jWD9yVJFKTshzMKAqcIf821w359NR9Rie2whjLfyfR2pn1OTdjvY8zKu+Q==
X-Received: by 2002:a17:902:9681:: with SMTP id n1mr7513676plp.152.1590027142335;
        Wed, 20 May 2020 19:12:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id 1sm3200480pff.180.2020.05.20.19.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 19:12:21 -0700 (PDT)
Date:   Wed, 20 May 2020 19:12:17 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     clang-built-linux@googlegroups.com, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] x86/boot: lld fix
Message-ID: <20200521021217.yqsulqwfrhqorp7p@google.com>
References: <20200520225654.4144534-1-nivedita@alum.mit.edu>
 <20200520233357.GA4160490@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200520233357.GA4160490@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-20, Arvind Sankar wrote:
>On Wed, May 20, 2020 at 06:56:53PM -0400, Arvind Sankar wrote:
>> arch/x86/boot/setup.elf currently has an orphan section .text.startup,
>> and lld git as of ebf14d9b6d8b is breaking on 64-bit due to what seems
>> to be a change in behavior on orphan section placement (details in patch
>> commit message).
>>
>> I'm not sure if this was an intentional change in lld, but it seems like
>> a good idea to explicitly include .text.startup anyway.
>>
>> Arvind Sankar (1):
>>   x86/boot: Add .text.startup to setup.ld
>>
>>  arch/x86/boot/setup.ld | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --
>> 2.26.2
>>

I found your PATCH 1/1 on https://lkml.org/lkml/2020/5/20/1491 

-	.text		: { *(.text) }
+	.text		: { *(.text.startup) *(.text) }

The LLD behavior change was introduced in
https://reviews.llvm.org/D75225 (will be included in 11.0.0)
It was intended to match GNU ld.

But yes, orphan section placement is still different in the two linkers.

Placing .text.startup before .text seems good.
In GNU ld's internal linker script (ld --verbose),
.text.startup is placed before .text

Reviewed-by: Fangrui Song <maskray@google.com>
