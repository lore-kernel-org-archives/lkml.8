Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5C6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FD220772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GGh6loAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFDAXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgFDAXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:23:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975CFC03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 17:23:18 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so4331866qkh.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FPRtEKt/Sf9m/+5i8pJQSFuKcKvaJeO/DgaLGboQUFw=;
        b=GGh6loARcWWsrtZZN3VwkXtpUI5030V12zOA4fv+m1KstYA6JjLng+O2J7XgFjXIr+
         TBVhJIznea7WA6ElVmsyCjKC6PCGnhf5GvHwfClOXgxdYz06WFzRZRRqKFgzt13L8k1+
         620h8Pb/B1kmxltydPXhDlojYMW1Qae1C5nnhhsk6bklDOLVYrr3phnMhFQA1d7FVp5y
         ARuTeHkPmVqRQEbjwgx25T0BLEaSCi8ghgqMY98fo/pNg1j/N80B4KzTuD/wxl2WeHvk
         9FY4gcr7fUthb56zNV6r8qrFIoiJSwrMiwsUJRf7bw/YiKYMGJHcBwDCexTTWoqkNIRQ
         ApBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPRtEKt/Sf9m/+5i8pJQSFuKcKvaJeO/DgaLGboQUFw=;
        b=YBjjntmbNOPoFOv31UCxrCBLhm3WjYEqQkhxCYatLAFMyHUHGU0YH+lnmjEc0dQSvD
         HVRYqxqjuDkfEHxtjWe6fJbZsVoreMc9O+7uMNBkZmij0URfzvURBWwnbvtzZVvz46WL
         TLWwcCBqG14Cmuv9YQFejyvMk8ZkGze6sjIc+VKj6z8GWoGkMK/1eGWn15chdoqpHN1k
         zeFjh0XIFZgkYaN+59tDlrP/ktWhMs9glaYpkHaOX9TstGs0ebJKv+xf+FWuVFf0c3ta
         mLmarEindUrFA+lHEhBhSWLWgkYLPwF0xV15Hj1uFMzi1rJgCeKmSY4dklztUVciJcoc
         eDag==
X-Gm-Message-State: AOAM530xwnv03yCN/cRMouluzhE8ZWLoYqBtxmgxIDSw3+lwXqWjOz2V
        giCTaAbWkQKcvRsyFD64eEst9Q==
X-Google-Smtp-Source: ABdhPJy7KTjWaqGSJlumwFqqm8BNdf14u29uZGDqN/mlCUnoedIFJr7qzbjYfD1WCRJdp7ewwz9ATQ==
X-Received: by 2002:a37:555:: with SMTP id 82mr2256165qkf.279.1591230197836;
        Wed, 03 Jun 2020 17:23:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 6sm3049832qkl.26.2020.06.03.17.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 17:23:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgdfA-0010pG-Bs; Wed, 03 Jun 2020 21:23:16 -0300
Date:   Wed, 3 Jun 2020 21:23:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: kobject_init_and_add is easy to misuse
Message-ID: <20200604002316.GM6578@ziepe.ca>
References: <20200602173603.GB3579519@kroah.com>
 <1591127656.16819.7.camel@HansenPartnership.com>
 <20200602200756.GA3933938@kroah.com>
 <1591134670.16819.18.camel@HansenPartnership.com>
 <20200603002205.GE6578@ziepe.ca>
 <1591207475.4462.41.camel@HansenPartnership.com>
 <20200603183650.GI6578@ziepe.ca>
 <1591210928.13983.24.camel@HansenPartnership.com>
 <20200603193013.GJ6578@ziepe.ca>
 <1591217780.13983.56.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591217780.13983.56.camel@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 01:56:20PM -0700, James Bottomley wrote:

> The store of state_in_sysfs is already done in kobject_add_internal(). 
> It's an existing flag people already use to tell if the kobject has
> been exposed in sysfs.  However, it's set after the sysfs directory
> creation succeeds.  This is the code with some debugging removed:
> 
> 	error = create_dir(kobj);
> 	if (error) {
> 		kobj_kset_leave(kobj);
> 		kobject_put(parent);
> 		kobj->parent = NULL;
> 		...
> 	} else
> 		kobj->state_in_sysfs = 1;

I was thinking most probably this will need a lock or a
smp_store_release() ..

> > It feels more robust to stick with the put though..
> 
> possibly ... like I said, the only concern with the put path is that
> ->release has state expectations that aren't met if
> kobject_init_and_add fails.

Certainly error unwind bugs related to put and release will exist, but
I suspect switching to kfree won't solve them, just move them to the
next function that fails and needs a put based unwind?

At least the patches I reviewed for RDM a from Wang Hai were all
correct and didn't seem to have release based errors.

Jason
