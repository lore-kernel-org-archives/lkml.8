Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA5C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5245724658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgANQTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:19:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgANQTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:19:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5744AB7D;
        Tue, 14 Jan 2020 16:19:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 00150DA795; Tue, 14 Jan 2020 17:19:31 +0100 (CET)
Date:   Tue, 14 Jan 2020 17:19:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware
 compression
Message-ID: <20200114161931.GE3929@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zaslonko Mikhail <zaslonko@linux.ibm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200107143058.GU3929@twin.jikos.cz>
 <20200108105103.29028-1-zaslonko@linux.ibm.com>
 <75a2d45c-fd7b-9542-403d-caea7d977add@toxicpanda.com>
 <94e06859-6174-c80d-3eb6-065f67fbe95d@linux.ibm.com>
 <20200109011025.GM3929@suse.cz>
 <62a53ff3-a515-8801-d58b-b518dbe0c55c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a53ff3-a515-8801-d58b-b518dbe0c55c@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:03:29AM +0100, Zaslonko Mikhail wrote:
> Hello David,
> 
> On 09.01.2020 02:10, David Sterba wrote:
> > On Wed, Jan 08, 2020 at 07:48:31PM +0100, Zaslonko Mikhail wrote:
> >>>> +        } else if (workspace->strm.avail_out == 0) {
> >>>> +            /* get another page for the stream end */
> >>>> +            kunmap(out_page);
> >>>> +            if (nr_pages == nr_dest_pages) {
> >>>> +                out_page = NULL;
> >>>> +                ret = -E2BIG;
> >>>> +                goto out;
> >>>> +            }
> >>>> +            out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> >>>> +            if (out_page == NULL) {
> >>>> +                ret = -ENOMEM;
> >>>> +                goto out;
> >>>> +            }
> >>>
> >>> Do we need zlib_deflateEnd() for the above error cases?  Thanks,
> >>
> >> The original btrfs code did not call zlib_deflateEnd() for -E2BIG and 
> >> -ENOMEM cases, so I stick to the same logic.
> >> Unlike userspace zlib where deflateEnd() frees all dynamically allocated 
> >> memory, in the kernel it doesn't do much apart from setting the return 
> >> code (since all the memory allocations for kernel zlib are performed in advance).
> > 
> > Agreed, deflateEnd is not necessary in the error cases.
> 
> Can I consider this as 'Acked-by' from your side?

Yes, I also sent rev-by to the patch.
