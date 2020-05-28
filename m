Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499BAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205F7206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9eumBDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbgE1Mtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:49:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21875 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389860AbgE1Mt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590670166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N44YvMNoS2XEf8I1F7cjr6cLz8BwzDvWheszxZeZLbQ=;
        b=J9eumBDYNrJ/ziAmT/7OUVDP/8oRLVoKS4hIPwc+rN/xvQ3plnU3EOzfdbqmfKiLaxbF3I
        jpOQVY7l34u6pMx/iTgtE7Gd1kDazpAaR2futDsT+/Eyo/rJvu1ktW7d/4Qa/OIr1gZi4m
        UO/4j+zZeO+HGkcrW34mnpC64+2tJUM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-Y0oHpMRwNbySY2uojqCwQA-1; Thu, 28 May 2020 08:49:24 -0400
X-MC-Unique: Y0oHpMRwNbySY2uojqCwQA-1
Received: by mail-qk1-f200.google.com with SMTP id x22so2648693qkj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 05:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N44YvMNoS2XEf8I1F7cjr6cLz8BwzDvWheszxZeZLbQ=;
        b=ZSObU/+tnW0DSB6Fy7zyP/8B84JjHnH+PGJMurKZajlmn5wQsdAyoBbe3In65njMIF
         qvAVbBsN1lWB+3HNAPeJfhMmW5kwg2QTtJq6CTRdwS87LQmM4x94oS/06+P6PG7KbL4U
         0bjwip3sSod4GQrK8IeHPQrRu+rkz90mfSHpROowfLsLcdPrlkSeGI2v23K7cKMZS5Zf
         YxrroyCvo+q8kMuqa6MYooXv1zc0rh0joN5BC3miHfbJvy5glONzgHg3Pv1xqXvS/Aiy
         ypaavRrHs2OcVAyr415N7HiGXeXA9AEsDgFD/syRNBM6l+3CPr5MvdtN6YNhv6/9FRd7
         jPPw==
X-Gm-Message-State: AOAM5308lgvlQDt/4D1n/TmHkBzcnLFZyszhin79AAshwTm4JGnXaXaA
        7TRY3q0n1czofcBC0GuJQw4+H/LPunv7BaYrRrv5DAIk/rEWsBsH5O8LwxHqycL4agCkMDJYdfH
        nfcNX45t3D02b/NBOlNkXFtQx
X-Received: by 2002:ad4:44e3:: with SMTP id p3mr2862070qvt.166.1590670164167;
        Thu, 28 May 2020 05:49:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwovYH78tr5tgBrTOAWggHNiKsHz8eXOmiGYvJVn+7sSN5nHeoV8F9duhW1+pF2zVYv321wCA==
X-Received: by 2002:ad4:44e3:: with SMTP id p3mr2862037qvt.166.1590670163851;
        Thu, 28 May 2020 05:49:23 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d56sm5440421qtb.54.2020.05.28.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 05:49:23 -0700 (PDT)
Date:   Thu, 28 May 2020 08:49:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org, cracauer@cons.org,
        dplotnikov@virtuozzo.com, gokhale2@llnl.gov, hannes@cmpxchg.org,
        hughd@google.com, jglisse@redhat.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maxime.coquelin@redhat.com, mcfadden8@llnl.gov, mcgrof@kernel.org,
        mgorman@suse.de, mike.kravetz@oracle.com, pbonzini@redhat.com,
        rppt@linux.vnet.ibm.com, xemul@virtuozzo.com, keescook@chromium.org
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
Message-ID: <20200528124919.GK1194141@xz-x1>
References: <3b64de85-beb4-5a07-0093-cad6e8f2a8d8@huawei.com>
 <20200527142143.GC1194141@xz-x1>
 <a5aa7dfd-b4a9-0ab2-9392-d7889897382f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5aa7dfd-b4a9-0ab2-9392-d7889897382f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:50:49PM +0800, Xiaoming Ni wrote:
> Since userfaultfd and vm are more closely related, will there be
> consideration to move fs/userfaultfd.c to the mm directory in the future?

Xiaoming,

I don't think so - userfaultfd is still interfacing the userspace as a file
object, so I think it's proper to have fs/userfaultfd.c handles the fs part of
userfaultfd.  There's also an mm/userfaultfd.c which handles some internal
logic of userfaultfd syscalls, please feel free to have a look.

Thanks,

-- 
Peter Xu

