Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFC0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EC12083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sp9yPMfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHSUyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:54:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29966 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgHSUyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597870460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLbcN3vXZ9Y2wTIy0CakALnZtq7aqQjupWdhJYMTw6g=;
        b=Sp9yPMfKm0Uo3wrF9NvLpAq8sqMAGWfDvr32tlW/wg1GUdBHUsQzRqv+sxdJyIXUsJKj/l
        g7IXSea8pQYkXD3fA5Txb676dCeyCH0SuNiXZYTLEcu6EAxEFjobxLM6O8x1d1kEWgHMgA
        xMchL9XH8mKN70Y/sxT/JAPjUBDs8c8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-mKx6EMJeM_ajM3CPgSEUyw-1; Wed, 19 Aug 2020 16:54:18 -0400
X-MC-Unique: mKx6EMJeM_ajM3CPgSEUyw-1
Received: by mail-pf1-f199.google.com with SMTP id l195so15709163pfd.22
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLbcN3vXZ9Y2wTIy0CakALnZtq7aqQjupWdhJYMTw6g=;
        b=UVSLQWWJDjMfhSV6xwS8+eddtSQUuCPTcYqEw3RQvle2yIsNFminTdTgjkFTv3rEZI
         kcKpZQy8EvISFePB5DxKDHDSIRsAjbAG2ytvuG8KjmM1UpDwqsMraR+6ir3Gn1a9JKH2
         cGcr6nZJx67iruV94BWLGl/W48TdJ2POVwdnFW+szAknODHq/qcYzpyBeSIB0Fq05guM
         hRW9u2dBHFzkpBXBcwrBmx4QVGOne+Ooe+fL8DyNC35DaC8R+hYzwcl1Gkx3Z3aGC3Zi
         bdcq0R9kbKotVWXkVmsDmGCkdd3o18tLinAOsuN8pSLRSFKlk4/t3lPFAoVyilNO7kYC
         y9gw==
X-Gm-Message-State: AOAM533srMbGT8VO2eBUE56jXmxvfa8ZpgZWV5+Q3SbenzFXTiLohFQx
        JS/gRZ6Vyyb2f2n9f4rGQ7J4Lba8VyL4zoR7KB3PDaAY0Aiak1U2ImanW5nL6cJ8N76eT3mNH2M
        mlrVLoZSAVy1ss7IxZT/TRIfr
X-Received: by 2002:a63:151c:: with SMTP id v28mr143593pgl.357.1597870457462;
        Wed, 19 Aug 2020 13:54:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywvQDnMQvNa8P+hthAlsp+uhweYcJmFYGtS1L+2LN00W9j3zaiphk/gpzyn1Jn6xogphyN9g==
X-Received: by 2002:a63:151c:: with SMTP id v28mr143580pgl.357.1597870457205;
        Wed, 19 Aug 2020 13:54:17 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nu14sm3825940pjb.19.2020.08.19.13.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 13:54:16 -0700 (PDT)
Date:   Thu, 20 Aug 2020 04:54:05 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, THP, swap: fix allocating cluster for swapfile by
 mistake
Message-ID: <20200819205405.GB26216@xiangao.remote.csb>
References: <20200819195613.24269-1-hsiangkao@redhat.com>
 <20200819130506.eea076dd618644cd7ff875b6@linux-foundation.org>
 <20200819204405.GB2096425@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819204405.GB2096425@optiplex-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Aug 19, 2020 at 04:44:05PM -0400, Rafael Aquini wrote:
> On Wed, Aug 19, 2020 at 01:05:06PM -0700, Andrew Morton wrote:
> > On Thu, 20 Aug 2020 03:56:13 +0800 Gao Xiang <hsiangkao@redhat.com> wrote:
> > 
> > > SWP_FS doesn't mean the device is file-backed swap device,
> > > which just means each writeback request should go through fs
> > > by DIO. Or it'll just use extents added by .swap_activate(),
> > > but it also works as file-backed swap device.
> > 
> > This is very hard to understand :(
> > 
> 
> I'll work with Gao to rephrase that message. Sorry!

Sorry about that :( I just finished the test and went through
the related swap code and finally saw this so I think it wouldn't
work entirely for the current swap code... and Sorry about
my limited English.

Kindly feel free to repost the patch with rephrased commit
message. Anyway, I've done this task :)

Thanks,
Gao Xiang

