Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028EEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62272080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZz2oj0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgH0SfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0SfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:35:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02522C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:35:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o196so6341425qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=mqA0EYRZVIwLWOqPk5pwlyc1YvuGeQHgSqHXghkkHnM=;
        b=mZz2oj0+wSsZMB0AWjnl+4qg8AhwmYO4kdO1S60jA8VA3SBzIiwO3DH3P5DsCLfbaa
         aQs1elgpTpBsZseoNPTY/AZaVTY7vIgMvIhNZ+1QtULPTEn0KylF7zheYoJ+puMkl8Mt
         ufCfQRHenD51rHnaB23BlMLXUYyH1DlRDWAjroZ2m5zP/wD4LcZ5wpO/auvaaHxCi5Ch
         yQWFXlgwLYFQ8P+w2G5PI067IALkO+LAD8kpVSi+FtmjLFzXgHPOBD7KYZYQwh0WcZRQ
         pEmv2Uzcgf9zARFWxLOCDa1uLo9FQlQI11Gg/N4RVXc3RV0sQNt4XeSM2K19tWa0i7gf
         heAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=mqA0EYRZVIwLWOqPk5pwlyc1YvuGeQHgSqHXghkkHnM=;
        b=jTfufvCp6Vc2FtT5RDK+sWCBL7cbI90X0PL65vPzwJnFfQkQzwtX/oeuYvSrVnPIga
         3rYvBpubLc8bXy2hBTReosRwtOZfqtN2ZUATCNMm+Q6JEHIKTr9Kriewp+ClkZSHwhN8
         cespPlZIBKViN/Ojx0bLR25LkmVrl6nY4M9ZR98YadKLKCIHrr5lIsQ2XGjPlPvlszkz
         LB9okOeUkZyL4+vD17tUvrJtlT0CKHfTOQ8YF/L4glUA8Z9Q4FJFv64FbdLHTOYx5YUh
         JJ4WurVxJ7aMBRLE76sC+hEwP0zTzAYEqlKQ9MuFW9bEocMWm2WscTmYHGwOKka0hbA1
         EguA==
X-Gm-Message-State: AOAM532zt2HHWDdvn4nLV5QF6tUDYnmBblmO4kPkmaD3TOFdoFv/TaJV
        7FVRO+kKtRcK5Shye2+lME4=
X-Google-Smtp-Source: ABdhPJy5fetU3wuT21/nV4z+TpEhx5H+HcuTSDouRqF/O4+AAPbFy3jvsqMy+FFVvSUXwetLcnug7A==
X-Received: by 2002:a37:7407:: with SMTP id p7mr20410109qkc.350.1598553303218;
        Thu, 27 Aug 2020 11:35:03 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id k38sm2464453qtc.88.2020.08.27.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:35:02 -0700 (PDT)
Message-ID: <5f26d433abcde7cd3b4da705742e17ca6c0f0f0b.camel@gmail.com>
Subject: Re: [PATCH v1 04/10] powerpc/kernel/iommu: Add new
 iommu_table_in_use() helper
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Aug 2020 15:34:55 -0300
In-Reply-To: <e7d0e85c-c4c4-ad1d-899a-72d4fbd92852@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-5-leobras.c@gmail.com>
         <e7d0e85c-c4c4-ad1d-899a-72d4fbd92852@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-22 at 20:34 +1000, Alexey Kardashevskiy wrote:
> > +
> > +	/*ignore reserved bit0*/
> 
> s/ignore reserved bit0/ ignore reserved bit0 /  (add spaces)

Fixed

> > +	if (tbl->it_offset == 0)
> > +		p1_start = 1;
> > +
> > +	/* Check if reserved memory is valid*/
> 
> A missing space here.

Fixed

> 
> > +	if (tbl->it_reserved_start >= tbl->it_offset &&
> > +	    tbl->it_reserved_start <= (tbl->it_offset + tbl->it_size) &&
> > +	    tbl->it_reserved_end   >= tbl->it_offset &&
> > +	    tbl->it_reserved_end   <= (tbl->it_offset + tbl->it_size)) {
> 
> Uff. What if tbl->it_reserved_end is bigger than tbl->it_offset +
> tbl->it_size?
> 
> The reserved area is to preserve MMIO32 so it is for it_offset==0 only
> and the boundaries are checked in the only callsite, and it is unlikely
> to change soon or ever.
> 
> Rather that bothering with fixing that, may be just add (did not test):
> 
> if (WARN_ON((
> (tbl->it_reserved_start || tbl->it_reserved_end) && (it_offset != 0))
> (tbl->it_reserved_start > it_offset && tbl->it_reserved_end < it_offset
> + it_size) && (it_offset == 0)) )
>  return true;
> 
> Or simply always look for it_offset..it_reserved_start and
> it_reserved_end..it_offset+it_size and if there is no reserved area,
> initialize it_reserved_start=it_reserved_end=it_offset so the first
> it_offset..it_reserved_start becomes a no-op.

The problem here is that the values of it_reserved_{start,end} are not
necessarily valid. I mean, on iommu_table_reserve_pages() the values
are stored however they are given (bit reserving is done only if they
are valid). 

Having a it_reserved_{start,end} value outside the valid ranges would
cause find_next_bit() to run over memory outside the bitmap.
Even if the those values are < tbl->it_offset, the resulting
subtraction on unsigned would cause it to become a big value and run
over memory outside the bitmap.

But I think you are right. That is not the place to check if the
reserved values are valid. It should just trust them here.
I intent to change iommu_table_reserve_pages() to only store the
parameters in it_reserved_{start,end} if they are in the range, and or
it_offset in both of them if they are not.

What do you think?

Thanks for the feedback!
Leonardo Bras



