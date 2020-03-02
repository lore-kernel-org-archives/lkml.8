Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C0FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAC124673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVzbakQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgCBRbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:31:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51196 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgCBRbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583170283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jldB4YfZBRz97Je6/WHGQJOl1nyyviDfJaDZ8qQ1FXs=;
        b=aVzbakQI5CjF9UqLtCQHfD3xXkjoA64LyQhTP28GqMyYNpX6wyYc/TBhc/hxeLi62NCDuW
        GsnOIfwHqbkWVftgsIsEZTQ8vqgosbJSB4ogaZHydluiJ6UpJSbnl8W1cFtPHA30Hxq63r
        sqLaRMf0ei6g2vHTZAvLkrLfDt22xeU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-50KxpN82NiaP3h8CDLlg4w-1; Mon, 02 Mar 2020 12:31:21 -0500
X-MC-Unique: 50KxpN82NiaP3h8CDLlg4w-1
Received: by mail-qv1-f72.google.com with SMTP id h17so244274qvc.18
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jldB4YfZBRz97Je6/WHGQJOl1nyyviDfJaDZ8qQ1FXs=;
        b=UR/PuUSyUhL6oprQoE58Hu3QNHeP1rmQ+n1IvpuXuHrXkMms2r/slhA3B67A6oh4Fp
         O5/Up9JUVAAgoDc7r/CJw5GZU8k1PEko0oyzQEnA3gnT1YfbJ6E64P9+QmfVaLesBQzU
         SJ+OC+ktH4bqCum6BN/JCbrKzC5UknaeoY1ifNMhI1yX4cCWLxZo3o29iY583fNBirA6
         i6rCPE97c4t0P/lURrp/X5+3DgJGXeM6MsMuMKqMw1DXgn//GfxgI9YOQZOoHoMpziwv
         sAF663vS9lhFXXH0keQHlOirwhPw6xPkxOggPY0exMwX6+GjwlCWHjw2j5prVVuAq+BL
         Oi9w==
X-Gm-Message-State: ANhLgQ14lJczcCZGx4MPedq7MfDwjnv25gCvn2wCII8scSbpi0awMBfK
        4836UDI0eEPqFrRSTcNctmqnGYNalbTAkvPC9iKizx66ZpY93lH+Z7aYcqMSQ7JBU0b5I7538aU
        hmFeLF0QQlKF5zdcZXQd0y9EP
X-Received: by 2002:ae9:e8cc:: with SMTP id a195mr290504qkg.377.1583170281133;
        Mon, 02 Mar 2020 09:31:21 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv2gQ+g33X4TpuT9lUWYMS9uikxOY3kZWxAFaYX8GZYKvpySNs8kIfbyRKUQqhJafJHEYh4aA==
X-Received: by 2002:ae9:e8cc:: with SMTP id a195mr290490qkg.377.1583170280920;
        Mon, 02 Mar 2020 09:31:20 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a23sm10369623qko.77.2020.03.02.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:31:20 -0800 (PST)
Date:   Mon, 2 Mar 2020 12:31:18 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Brian Geffon <bgeffon@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH RESEND v6 00/16] mm: Page fault enhancements
Message-ID: <20200302173118.GC460741@xz-x1>
References: <20200220155353.8676-1-peterx@redhat.com>
 <CADyq12wFKwzUYipU4g4Ey9X9J3qY0S=PEhSMBAeLfzpETUWVWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyq12wFKwzUYipU4g4Ey9X9J3qY0S=PEhSMBAeLfzpETUWVWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:26:12AM -0800, Brian Geffon wrote:
> I tested the entire patchset because I'm very interested in fault
> retries with userfaultfd and the series has been stable and worked
> well on x86.
> 
> Tested-by: Brian Geffon <bgeffon@google.com>

(Thanks again for Brian's quick follow up, and adding Andrew in again)

Hi, Andrew,

Do you have plan to queue this series for linux-next?  Please let me
know if you want me to repost with you CCed for the whole series.

Thanks!

-- 
Peter Xu

