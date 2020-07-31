Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37FAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B891B21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NVVxcC3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgGaRsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387541AbgGaRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:48:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7EC061756
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:48:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so29539165qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgavFM9fv9RyVhfrzNoVsCZw1UsAPzbtBmN1LRCEpDI=;
        b=NVVxcC3PrAhlWdWZAWXxQH3YnlOFLgOFSt9l4fAQh5s9CGD+7SfmnH7YtjzVCrmpAL
         /yoy1xD/5Y3ppQ/nvRTkHrv4u9eJ2hIDdvbPZvVyBWzSnVn4Q1ZI6Ogru6RAZXtl9WNZ
         jHZQMgE64oC3noQpXLWf3N6gOB4ERfg3ihC16yTOCMhwlAvGABhNAPpSfLKnWw2rdN2l
         ATEDeLEF7WEbyWs3zItzJaX/FLJuVcoO3JorFxvMhgyU24GVw2xIRGKxJ8Bh12drH+w0
         /ZR4XSjBm0Hr4fb7q1NoZQ/bqna8kQn6OutHIE+wtJzCRTc29vF8cZQKnO/JZK9zM+dl
         kQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgavFM9fv9RyVhfrzNoVsCZw1UsAPzbtBmN1LRCEpDI=;
        b=G8eQdhCD/dAHd5vO+95tE45pq0Z5DgJF9lgslZqsFSiEgSVovakHDlR2o3I5YiP0Oj
         0nlKRRgemJBwD+mz3XMjC/EBzPLhqs7mtsNL3yad3E2OEBxDzlkkt/Bb/SNe+KYo3uFs
         ol9n3tslFnm7wBf9yZ7OMSZ3ALBGD/BUGsQp50DFK2C8y/Pr4qZVWfMvJBiFXA890K00
         WIx/nRweeSoNR804+57SSPqtWTh+S5SzP74HHYY0HM+0CzeyGePKjKyBLzaP0Oy69ra3
         aHdV4KHeyK66H2Kjfn/68vkfQt8uvOyxhplm37EKX924lL12nMh8pdtZdOwEkLgv9oCa
         digA==
X-Gm-Message-State: AOAM533Ap3rVCposQalEbPmtXI4XgWbstsMudhP8OISDx4frChnEkv+L
        ZQVNIiAfTpQjAl4QBC2eSGJHDQ==
X-Google-Smtp-Source: ABdhPJz0MnmxY5FGxiJd/Rlf5vNi7glj7xvlTjk3q/iCWrbWoe08wUQotvFp9C66WBoUIiITj3nu9g==
X-Received: by 2002:a37:b942:: with SMTP id j63mr5170964qkf.138.1596217718437;
        Fri, 31 Jul 2020 10:48:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 22sm8910314qkd.64.2020.07.31.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 10:48:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k1Z93-002AAS-77; Fri, 31 Jul 2020 14:48:37 -0300
Date:   Fri, 31 Jul 2020 14:48:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200731174837.GH24045@ziepe.ca>
References: <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
 <20200731165649.GG24045@ziepe.ca>
 <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 01:15:34PM -0400, Steven Sistare wrote:
> On 7/31/2020 12:56 PM, Jason Gunthorpe wrote:
> > On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
> >>> Your preservation-across-exec use-case might or might not need the
> >>> VMA to be mapped at the same address.  
> >>
> >> It does.  qemu registers memory with vfio which remembers the va's in kernel
> >> metadata for the device.
> > 
> > Once the memory is registered with vfio the VA doesn't matter, vfio
> > will keep the iommu pointing at the same physical pages no matter
> > where they are mapped.
> 
> Yes, but there are other code paths that compute and use offsets between va and the
> base va.  Mapping at a different va in the new process breaks vfio; I have tried it.

Maybe you could fix vfio instead of having this adventure, if vfio is
the only motivation.

Jason
