Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD85C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D562173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiGbvW0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHSjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:39:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHSjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588963146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXBRgjOwY+dvVSQ4b8KNQAdFl7K/2dDkBF+n7DPUAd0=;
        b=WiGbvW0TvJ6dluOdscrBrtG2f3+Riy0AQPpI/7iX8F16sItwh2aGu9eeZKCQSEv0R8jz7P
        347IpP9eKcj2Bo3sBlJbnd87H47p/tQx7wdQKe2ec+BGA4zHAGJzMgdb21A2VNFRDqcZyX
        RUs8kXC+2oWv5mFWDJJWO8aJ3m3fP7I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-EW0JgO7pP1WJc6dJSdfcYw-1; Fri, 08 May 2020 14:39:04 -0400
X-MC-Unique: EW0JgO7pP1WJc6dJSdfcYw-1
Received: by mail-qt1-f197.google.com with SMTP id n22so2913851qtp.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXBRgjOwY+dvVSQ4b8KNQAdFl7K/2dDkBF+n7DPUAd0=;
        b=fTqS7AxLG9CJ0oQnbz2xp5hjfEf/x9NfGntuDR2fONMdZk0CKJA2nGVVcIStwW7TFJ
         Sy8NWbhd51s5jDzgFtbwBEG1+XHXEhsT7K0/U+0WfoGTKcBggkpsx3/sW28WWC6VZzRG
         cl3zMFiBiuBIk/J2JWyCP439JGekOQteoWB7pa84EmclOWyaVKrRYGx3ZtiUi0J8aRCt
         jERUC/eVR/yOVrnzZCUKlncMuJ8jjrDlEefKqqUpN2Ih3ZzLpmwRhz/9xTRLTZQOcs06
         M8lNTCVechCyIk2sDuRVqkMAoPVAWGxeGTqJ7+l5rbH4HluWzCDaOX9zNo8YdLEZgRBZ
         4kig==
X-Gm-Message-State: AGi0PuYgkYfX2rXSjuUwzjX0Rndi+01fGQFRmWIUMiSB5vxEmc8PdkCe
        FF+N8X945PbWxIaTdanua8ZloA8yPY10XATLXIQzlx9idKxo8QYjNRu0QQloZMKGMQOfUbXCpIV
        omn8v6hmZmKA20IWkc0gk9DV1
X-Received: by 2002:a37:8186:: with SMTP id c128mr4175549qkd.455.1588963143839;
        Fri, 08 May 2020 11:39:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLAr9Bm1koeUWkBXdivXMQD24n6jI17gBz0LpLaBEJYM0Mlc3/QNdh4XtLoIYudJtbnYdNUSQ==
X-Received: by 2002:a37:8186:: with SMTP id c128mr4175527qkd.455.1588963143546;
        Fri, 08 May 2020 11:39:03 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i4sm1719360qkh.66.2020.05.08.11.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:39:02 -0700 (PDT)
Date:   Fri, 8 May 2020 14:39:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 1/3] vfio/type1: Support faulting PFNMAP vmas
Message-ID: <20200508183901.GC228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871568480.15589.17339878308143043906.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158871568480.15589.17339878308143043906.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:54:44PM -0600, Alex Williamson wrote:
> With conversion to follow_pfn(), DMA mapping a PFNMAP range depends on
> the range being faulted into the vma.  Add support to manually provide
> that, in the same way as done on KVM with hva_to_pfn_remapped().
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

And since after the discussion...

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

