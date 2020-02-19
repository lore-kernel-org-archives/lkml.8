Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FEFC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5028324658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="R4Gfv6ih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBSDZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:25:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34841 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgBSDZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:25:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id r16so21807964otd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 19:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2GbWTOlmThm3aCwYqLI/qAi80/RcAs7bKNkpgMzjiE=;
        b=R4Gfv6ih2l/vi3D5/mozVD0HHAOX3r6KI/XFNMUpw0bZ0W883+qK/w+cHSNZRmq9N7
         JuoiAilWanaaUxT77D5bsMnLiHRQqCQoF7NyVBLeMI7EwXZq8e/YfIKau9Z5YgFXIm7a
         P4Lc/74ls4lSDopzAY99ErwSKfeQPo49jUGJMsSwOPOFkKjas/d5asMsq5Q8h4joH/1J
         b0gcseW8Hooqn1O6MCzjmVJ8XLntAU1+3xYoCeiH6AKts9JJ8KOF83BhsOb0cmyn44fg
         1XwJdja2GTdO4dsPhsgNe8ypsI3yKZ1zryNp0dY3Am942lx7gtfSO16d9JAR6J/Pp5jk
         bISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2GbWTOlmThm3aCwYqLI/qAi80/RcAs7bKNkpgMzjiE=;
        b=PRkIfgiApboE5Rz7qqqbZk8eOW/S6Mb9uxdtAqyDD1tXPQD1HD9Sj4qV3QDg0Mcxcb
         9x9pK7Tjqyo/bJKd6f7WR2Ts1M6qmCb+KlA7fFD/m3PNFoAsMAZXpfM8wavuT6J+LHS1
         grWItORrV5bc94UCM581J/zdlqdZYICQUz32JbNA+H0+2gx98i8q2nakieajKiltIet0
         yaRkpBTphaR9DpuDXIhPTipC0+vdo7YAPxipkCTZPeDHTdbcy9tFv3IdIbZM8Rs6RzMP
         USWeYAFHU8eTX3bUlK78dJqWD4KYitv9R5zctA6FPx57rk98SnbHRuNcNno2R/irVQT8
         7X3Q==
X-Gm-Message-State: APjAAAWxwEy2ig+2B5YJKSFAFi2XkgKxT/cad5zoGDfy60KnOLGNC9G5
        qembgy4eX8TtYk2ioc3C16NfzX2iRZOwfNN4gZWGxA==
X-Google-Smtp-Source: APXvYqxXSWy2SmasG885K49J545wadvMY/Bw0ZwC4KFzZZKf9xeFBXtRDKTWqbnS3vMTz+LsCoBckH2Tw+1UPsrTmP4=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr17818653oti.207.1582082726339;
 Tue, 18 Feb 2020 19:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20200219030454.4844-1-bhe@redhat.com>
In-Reply-To: <20200219030454.4844-1-bhe@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 18 Feb 2020 19:25:15 -0800
Message-ID: <CAPcyv4iZCnSpypshYpXCL35yT4KZfgXqDqS8cFDGpXC-A72Utg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 7:05 PM Baoquan He <bhe@redhat.com> wrote:
>
> From: Wei Yang <richardw.yang@linux.intel.com>
>
> When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
> doesn't work before sparse_init_one_section() is called. This leads to a
> crash when hotplug memory:

I'd also add:

"On x86 the impact is limited to x86_32 builds, or x86_64
configurations that override the default setting for
SPARSEMEM_VMEMMAP".

Other than that:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
