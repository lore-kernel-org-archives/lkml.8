Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB06FC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3C220659
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBUKvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:51:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44230 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBUKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:51:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so1766642eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 02:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zUs+q2XTJgmZqzi2EcjcLPs/D8n9r+lfPhLqHZHggX8=;
        b=qaOMEFly+VIZ3jBwOpxItwRZJY5WKn4eytSjLoSz4UPLqkzHqLuiYCqfGkVZfRlmWn
         tcUVsyxBI2rzzIv0S8ZZtcRcvF/DMl37kwQlwRN8rFJC98XIrxzCYRsz4frmZo10LLeq
         Mysw1ykO1aptCPiedwgsVkcs6cQO1B0CBqHMZcugSUqKRcZkFJMvKsnxq2uJKzY0l4vG
         5A7RUwBwkICx65rVgG4vK86RQKWmh4h1YIXCbc2gNSBmVpiJGA8ZO/I70HKvi2nDgAZI
         3R0QXre21vhUC3lbdZCDUqEnOXxaAfaXy+MlhR0+tXzp7HJJ3UVFy9zqw48mhdjEKI5C
         gqTg==
X-Gm-Message-State: APjAAAUH2AY4QN4IU2IQ8GRHfeP5/nhRzmll9NpgZW4xPDlXKJsMHStw
        BPAaYeRhURIAwFuP3I/LNZc=
X-Google-Smtp-Source: APXvYqy+xFFz5cPNCaLt7lvgI1tU3VcFQg84RwQOmXrW1oEnb9aeBDNR9AkCB/KBhy3CIMAXyx2tEw==
X-Received: by 2002:a17:906:c444:: with SMTP id ck4mr32964085ejb.224.1582282290179;
        Fri, 21 Feb 2020 02:51:30 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (54-240-197-235.amazon.com. [54.240.197.235])
        by smtp.gmail.com with ESMTPSA id cw10sm176653ejb.56.2020.02.21.02.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 02:51:29 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH] x86/mm: fix dump_pagetables with Xen PV
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200221103851.7855-1-jgross@suse.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <e0f82927-919b-e93b-c07f-bfe4d5b85fe9@xen.org>
Date:   Fri, 21 Feb 2020 10:51:28 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221103851.7855-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

On 21/02/2020 10:38, Juergen Gross wrote:
> Commit 2ae27137b2db89 ("x86: mm: convert dump_pagetables to use
> walk_page_range") broke Xen PV guests as the hypervisor reserved hole
> in the memory map was not taken into account.
> 
> Fix that by starting the kernel range only at GUARD_HOLE_END_ADDR.
> 
> Fixes: 2ae27137b2db89 ("x86: mm: convert dump_pagetables to use walk_page_range")
> Reported-by: Julien Grall <julien@xen.org>
> Signed-off-by: Juergen Gross <jgross@suse.com>

I can confirm the crash has now disappeared:

Tested-by: Julien Grall <julien@xen.org>

Cheers,

-- 
Julien Grall
