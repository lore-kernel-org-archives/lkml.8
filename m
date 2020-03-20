Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291ADC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE29820767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P40kBnaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgCTJT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:19:59 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:34154 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:19:58 -0400
Received: by mail-io1-f53.google.com with SMTP id h131so5267017iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJsVOgGPqb/q2iRd8gn1ZD5qGfpeyHF3Le1yJsRuXmA=;
        b=P40kBnaTd399NxpP8B3CDrW2EqNichDXtrwhLFk1eoZSf2Xyn5OM0CPypIcVOaDqSp
         +x1x31mXzMGtZkwDScNBn5nCcLTPCQJSRzy6q3EedUh6RzFglQmEhIH2jqqL60HGKPih
         /o6GdHksAfcosoZUgZo9fMBLQTmQECxCj8ZeJbLpSk+YHw4SR3PPewjR0BQKJjLVyRE1
         SlPBPoJwZmRSWyEZXQ1AuClL3fFUywRZRG9K+ZzgMMkLhJq29ZnrTcnnUCq7HZyQR2dA
         4acUhas9LpD3+GvA+Qlq1yXuoug0IYoGmlbiTIPu2C6nuXHPXDyem9mBZS7LP2+GydiM
         r/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJsVOgGPqb/q2iRd8gn1ZD5qGfpeyHF3Le1yJsRuXmA=;
        b=UW9qlSdayQOPuWcHIpjZ3cDvazHTa1qe8dFoK6AdFZDcNbkgeCNKd62hsODHy0Ty6S
         f33pbPcRC0vHBu35fxUqK0iOmR5VvhoQIQTM4eA1me85KR9a3Hphxcnez4LdwrXD/bNR
         zDZ83eYlZ2wYCTBiHjAsbEU8neeRdzsi5YSRRypmUEguF3RXyBKu+Q69wtyxMrMIfBNF
         FQJeq1DoSQM47DCFw1bfa2lRmVaSMgKstwtQv6ZphP5/2YJsQu7mXEfTFyWdXKFQaY1h
         kzSJ4SCtJZ72REwr1WRNFOamS7jrVF1zhK4CbatoUEymIbhjylSEbRY2O06y+krW9w4U
         pZ7Q==
X-Gm-Message-State: ANhLgQ3WosOUg9WKmGvzaSuatIZDPURK2B7a0cX15chQwwNFA2Q4mgCF
        4SZxs77AX5ZWGXuv/S/FyYsY5tGV/eQ5hmel+A==
X-Google-Smtp-Source: ADFU+vvxzskkGRY542ktgfC4s1OwlBZVf3HnaW3+tx6X2uncrz/ptEmG7mjDOPJc15oL/YXIk+UmZhf/l6iqeWNK+z4=
X-Received: by 2002:a5e:d512:: with SMTP id e18mr6593451iom.209.1584695997679;
 Fri, 20 Mar 2020 02:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <1584333244-10480-3-git-send-email-kernelfans@gmail.com>
 <1584445652-30064-1-git-send-email-kernelfans@gmail.com> <a4e7dc4d-9925-b0c4-e543-4626b94d6f9a@nvidia.com>
In-Reply-To: <a4e7dc4d-9925-b0c4-e543-4626b94d6f9a@nvidia.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 20 Mar 2020 17:19:46 +0800
Message-ID: <CAFgQCTt8KpzOTrLfiSLQhy1kOo10-fxdVD+WQky_ynQoqun+AQ@mail.gmail.com>
Subject: Re: [PATCHv7 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 6:17 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 3/17/20 4:47 AM, Pingfan Liu wrote:
> > FOLL_LONGTERM is a special case of FOLL_PIN. It suggests a pin which is
> > going to be given to hardware and can't move. It would truncate CMA
> > permanently and should be excluded.
> >
> > In gup slow path, slow path, where
>
>
> s/slow path, slow path/slow path/
Yeah.
[...]
> >
> >               /*
> > +              * Huge page's subpages have the same migrate type due to either
> > +              * allocation from a free_list[] or alloc_contig_range() with
> > +              * param MIGRATE_MOVABLE. So it is enough to check on a subpage.
> > +              */
>
> Urggh, this comment is fine in the commit description, but at this location in the
> code it is completely incomprehensible! Instead of an extremely far-removed tidbit about
> interactions between CMA and huge pages, this comment should be explaining why we bail
> out early in the specific case of FOLL_PIN + FOLL_LONGTERM. And we don't bail out for
> FOLL_GET + FOLL_LONGTERM...
>
>
> I'm expect it is something like:
>
>                 /*
>                  * We can't do FOLL_LONGTERM + FOLL_PIN with CMA in the gup fast
>                  * path, so fail and let the caller fall back to the slow path.
>                  */
>
>
> ...approximately. Right?
Yes, right. And I think it is better to drop "We".

Thanks,
Pingfan
