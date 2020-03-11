Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6720C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB1D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWyAB5A2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgCKEhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 00:37:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43657 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgCKEhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:37:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so813192wrf.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 21:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RsAa5SD/jxIxjxLPY5iqTGr1c695sVY8RqNi7sozSsk=;
        b=kWyAB5A2p4jl6vt9F69/5GNpGi5ca1s/ccS7NJMQQ9Ijy6a39+FAN9MzV1l0jfsmJv
         OYDXMichdQ3T2/3+C63yb6vgY+7BfgcTDdTPle7nkwG/fSLgJ1cABWb0wThhTo7b+gNF
         ieHkK1PTg/9a3bwjBjBZ3CAVfSVV7FfMMmN2dRMT3YWOpqm13FcHmCQ0zYKgsPLxZLvh
         MvwVxFW7fPh7J0ZrnK4qkgUqBUg/17rJsRHJieQVgnJBQ7JzIucdH4uPFxKRdaCb2WfY
         L0YPuPJtePXDURla1wizh8WjQzmV0BRJqNSB/TKOLA2hgI5VmGB5LNZ9422Af+0avoxs
         nKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RsAa5SD/jxIxjxLPY5iqTGr1c695sVY8RqNi7sozSsk=;
        b=sQNPMT4rp9GLLYv1B3Gwy/+zy9jECA+INXgIgXYVlAfGahRVZOUyPl996zstJYDZOD
         CEEKbSxuJxWUH7Z7BWKonh2ujUPlYY8ROrI0JSJPuPQp4Ll1m3DyMOh1yu7FJc5IyMh0
         S9JB8BfJP2J9j25Ej2fugTpUfJ0002UIUstsHyGNYbxjoyP/ao/MbwmZnC1mu0bvEciv
         CqLrEjRSFmvGRui5PfSEHJGzqmuWLS4wWQxjwhbIhUiqZVcxWdpi9mNwyvqbFQZdKju7
         NpJNaBCbqWJ0e5boV5z8cwL57FO40qW6r1+Db9ZBYemkJbY7lMzk+8Z7BGJ3tf0utBxt
         OtNw==
X-Gm-Message-State: ANhLgQ2MFD3Hg+uee/kmVbBHV1eyqGoHXIJeFLk3auBDYjcy72vtoSXy
        ftoZgoMLSrGciAoDqAfeHMU=
X-Google-Smtp-Source: ADFU+vvNQzgG2b/EHZcOk+Mwk0WEHdMgmkOSv8+0i6mb2RtvH/IQGRmo2qnQ5H21kX+R5Ypfonc7QA==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr1870802wrv.5.1583901448738;
        Tue, 10 Mar 2020 21:37:28 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4075:2100:20fd:9efb:5961:f66e])
        by smtp.gmail.com with ESMTPSA id u17sm45956944wrq.74.2020.03.10.21.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 21:37:28 -0700 (PDT)
Date:   Wed, 11 Mar 2020 05:37:26 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com,
        peterz@infradead.org
Subject: Re: [PATCH v6 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200311043726.kqdshlteaz27c2jn@ltop.local>
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:17:46PM -0700, Jesse Brandeburg wrote:
> Fix many sparse warnings when building with C=1. These are useless
> noise from the bitops.h file and getting rid of them helps devs
> make more use of the tools and possibly find real bugs.
> 
> When the kernel is compiled with C=1, there are lots of messages like:
>   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
