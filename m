Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54499C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370AB20759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590084248;
	bh=niEMPau5fW33ciK7opyh8p6Qii22izrIZJYhauAi/0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YyXAklqYfXenljAndGmoCbpRokKgGGZFtjC5e/3BgbeeGTe7rHCW7U5YSoNHeibsy
	 6Nkxd6WRc7PA3T5AQvC3lV48uuPQYGBW5uczN3/R79hi9zRfgWzuQEwNP+D8Hq6pJV
	 QyLcuTQP22rPVRjjDVyi7f5WBJO/1gdbP+St427A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgEUSEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgEUSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:04:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605E6C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:04:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l15so9042933lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Gg4b4CDCsETMIm4Edj1Xv31p6ZdZ0NWSz903G/X2Po=;
        b=C+6xQYv405ppXq81KjYUQtltgLKHhtWFV7DfKyUQgnD/o5JsMIaX3ld48tDI1ZlD7K
         U7kuhQvl7mdKFxmVsF/c3fYz37gu4oWx14U5jtAODWIsK4FqzsUCdodSWDq8PJADqJQN
         fxp/doyT7dYvEricBmr9oFTSOXixPbh/BPwNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Gg4b4CDCsETMIm4Edj1Xv31p6ZdZ0NWSz903G/X2Po=;
        b=thyBg5J7sjHJhW0RQ1nbg/16mJgOiJ8FUkcAi4EdKioyTYLVuKvZWHol3wlvAhrYHa
         kEacA8lDiBf+rCOwCy97AOoCfbob4aac4c7hhvtQXMYfJXoZWCeSzsROF/QovhhD7ukX
         ToZ2kj8O4dRYzRAfPN55WLJtrHVIABzvah8d9mZLlTSMSuntjqAx1Gkwb1uE0rHD0b6t
         eU75G0yKSLxo4a3ffmPR25MbY8RwFs4E9fGgNEfbtMM9n7gDeJ6yT+Z0WhxK2FzlcJof
         PAIrWFFOE/P84+PfjoBNJlel55qbGcBikxuSLBlHcOJJQVrvJkUjIIcuig8i4jlaP79P
         YNog==
X-Gm-Message-State: AOAM5333zQnHDaSSjZcn4PIyNhFTymSd2eca7B40MhkPQgIUO/CrJgy3
        Rdy8tJMiofYm+eFTlwkVQo2CWQ5DmIc=
X-Google-Smtp-Source: ABdhPJwbaRRtRBCXLI6jIRrYJSTBJko/5cIUUGo3OuiiVH32Sunh1hmBQhWjF3ksW8tKPkntqPXjWw==
X-Received: by 2002:a2e:9acb:: with SMTP id p11mr3449223ljj.432.1590084242571;
        Thu, 21 May 2020 11:04:02 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id n14sm1406256lfi.97.2020.05.21.11.04.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 11:04:01 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u15so9427941ljd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:04:01 -0700 (PDT)
X-Received: by 2002:a2e:9891:: with SMTP id b17mr3748342ljj.312.1590084240602;
 Thu, 21 May 2020 11:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200521152301.2587579-1-hch@lst.de>
In-Reply-To: <20200521152301.2587579-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 11:03:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQa3GNytJDdN=RKzSKfGQdPBvso+2Lmi+BpOP=BA_n6A@mail.gmail.com>
Message-ID: <CAHk-=wiQa3GNytJDdN=RKzSKfGQdPBvso+2Lmi+BpOP=BA_n6A@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 8:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> this series start cleaning up the safe kernel and user memory probing
> helpers in mm/maccess.c, and then allows architectures to implement
> the kernel probing without overriding the address space limit and
> temporarily allowing access to user memory.  It then switches x86
> over to this new mechanism by reusing the unsafe_* uaccess logic.

I could not see anything to object to in this version. So Ack from me,
but obviously I'm hoping others will try to read it through as well.

              Linus
