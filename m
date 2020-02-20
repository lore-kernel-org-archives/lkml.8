Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B17C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C530C208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFZtVNKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgBTPTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:19:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43537 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgBTPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582211963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dm3+KSqOu4sLsH3LQbc/Y847P491VgJjmX/3OuC9Ar4=;
        b=gFZtVNKjcucZUQA95iiw+2W4vaZE8qWExV7mL/twquV+ReDVVq3Rp1RKTnY4obp3HkOPou
        p31SLV04OGrrtJ52jSCkkHvqkWhfxXrTA8Kvw+n59Ui4XbPyOHOOzrOKoDwYdhjPQkeT0S
        xtweZCXiJN4qXnB+W65zC3Zmm4xQQqA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-aucXsVi7Ot-526ToxeZEkw-1; Thu, 20 Feb 2020 10:19:19 -0500
X-MC-Unique: aucXsVi7Ot-526ToxeZEkw-1
Received: by mail-qv1-f70.google.com with SMTP id e26so2765762qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dm3+KSqOu4sLsH3LQbc/Y847P491VgJjmX/3OuC9Ar4=;
        b=YLQ9CrPQyiH8x4mF4mDNHAYJWM5FWKwZ73y6Vdvs+r7i7GMbV6lGqKcqs8odJZjiox
         KcXHLwrbv7PGDrga6PKTwrcGkhg8H+6PWmVNVU+aXOvqHErl8zGydVg22OEY+LhUEA4E
         Hj38zC2f0Q6yKnYb/38ks1CdcMn1fOP+rmgpV8stGTYigarMNZxVpDi9C+qQ1MRlSUiz
         Q/5z0ae+dWUfpF4/hZ66VV5la3IdZ5qnTxrGrpTWtrAwYo9euNgAScD+3BXFVJ82Os3K
         N/DWn8/RnRtCYNHDKEXn0NUKrRBJr2czlAs7/jqFImKRH1b7/V6pU6XivxSHRcegOeCt
         AnbQ==
X-Gm-Message-State: APjAAAVnVRZ/jsBOdegd9R8+fiMjFfMtVshqr+p3K2VJWIsGdy2GSJTp
        1SL+58avm+ocOwo3cdEO8u5I3kjISGZBR/LgjOKvswu7uWOnbE9KcOFjLxPr41CwFCGJCG/H8rk
        IeBiNcWBGAvuYYxiRFVc5n5pT
X-Received: by 2002:a05:6214:15cf:: with SMTP id p15mr25820243qvz.140.1582211958928;
        Thu, 20 Feb 2020 07:19:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+T8vTLmdN2/++U4rJNfFudd0so83zUcZzsZYT9e9owitUEa+8T7nH3XV8+LUs5I8cYV9Xkw==
X-Received: by 2002:a05:6214:15cf:: with SMTP id p15mr25820203qvz.140.1582211958687;
        Thu, 20 Feb 2020 07:19:18 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id y21sm1844317qto.15.2020.02.20.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:19:17 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:19:16 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Brian Geffon <bgeffon@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v6 00/16] mm: Page fault enhancements
Message-ID: <20200220151916.GA2905@xz-x1>
References: <20200220145432.4561-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220145432.4561-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 09:54:16AM -0500, Peter Xu wrote:
> This is v6 of the series.  It is majorly a rebase to 5.6-rc2, nothing
> else to be expected (plus some tests after the rebase).  Instead of
> rewrite the cover letter I decided to use what we have for v5.

My mail server fails again for me during the middle of sending this
series.  I wanted to fix this manually but it could have made it even
a bit more messed up...  I'll try to fix this all and resend the
series.  Sorry.  Please ignore this whole thread for now.

There is also another standalone patch:

  Subject: [PATCH v6 04/16] x86/mm: Use helper fault_signal_pending()
  Message-Id: <20200220150113.5068-1-peterx@redhat.com>

Please ignore that too; that's also some fallout of this misery...

Thanks,

-- 
Peter Xu

