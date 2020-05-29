Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7835020707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5qmBwXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgE2Oua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:50:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726838AbgE2Ou3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590763827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WlVsdWU/ye2osgRTOkw0sfktljZUBDt8IESFs68H3c=;
        b=W5qmBwXSd9YaylTVI88BcO6YWpg4tyyA0lzjfqIpPQRBAQGimTKaXa0RwtEDSEBhCrEWwn
        3syP5KS7VaVsAend0zduu6A7SIYCfcE91bHiF0DcG4AeYMno4srveM/h2QKPL7owifE5g0
        ajWIfjWt1hn2ySDEVitvH03i1ENxCW4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-NRa1JaLwNqa2cOCUUgv-0g-1; Fri, 29 May 2020 10:50:26 -0400
X-MC-Unique: NRa1JaLwNqa2cOCUUgv-0g-1
Received: by mail-pl1-f199.google.com with SMTP id d9so2160552pll.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9WlVsdWU/ye2osgRTOkw0sfktljZUBDt8IESFs68H3c=;
        b=YhsZkUDcWYuX9TzS/jVqYWeJh/kscyhNqmx+ogyBFxCEwP5yfwKcLGI8TO1G+OyaME
         Qf8O3nPwfNfb+JYd6vey1UJDGpxpab/JWTA/fijRa3OtbAVOQJrtBRe9y5WOOUwpeHvT
         UtuMhMd0SQpC1VSdj/X1q+69SoieWddzqKyqi5vqtXInbetOnkKnkSPpW4rOl0fonXD6
         21yxQ7LqdRDYKnVqhIX54cfVjG+0bghDlNkF7HhlTQyjWP8QYYHeqC+l9bgMPAsAdm8E
         EvPGx0H/WzCYhpsF3rgf9o5ox0tg0PElyHCahHxOauep0n9Yng6kdEfgBDKVPD6ZwQwl
         iBZQ==
X-Gm-Message-State: AOAM532t0K7EUMCJ6N+4l/mSoIX/OBTKRopaKHy3hC2eGSmNF+H+482A
        gqY50hFhkktXTmCjuJ4Kh1idLlZNrdXm5+F2gqFFCE3yhAz8Fqo4+mWmNWuxDgtkI7wJeY4GgI8
        NKfoj9UDZLIs/sL75HUtAOh9K
X-Received: by 2002:a63:348b:: with SMTP id b133mr8439237pga.319.1590763825022;
        Fri, 29 May 2020 07:50:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySqJRkgTPKtzGK/4jLrXMKYSnDDUt2nMIvXlgLkNKE8VG2SS2t+96tchxwhvt2Cgv3MJJY+g==
X-Received: by 2002:a63:348b:: with SMTP id b133mr8439219pga.319.1590763824766;
        Fri, 29 May 2020 07:50:24 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r1sm7054983pgb.37.2020.05.29.07.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:50:24 -0700 (PDT)
Date:   Fri, 29 May 2020 22:50:13 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Gao Xiang <xiang@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: linux-next: manual merge of the vfs tree with the erofs tree
Message-ID: <20200529145013.GA22698@xiangao.remote.csb>
References: <20200529114501.3e2ecc14@canb.auug.org.au>
 <20200529015111.GA23230@ZenIV.linux.org.uk>
 <20200529034007.GA12648@xiangao.remote.csb>
 <20200529143613.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529143613.GE23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 03:36:13PM +0100, Al Viro wrote:
> On Fri, May 29, 2020 at 11:40:07AM +0800, Gao Xiang wrote:
> 
> > I'm fine with that, although I think it's mainly with vfs changes
> > so could be better though with vfs tree. I will add this patch
> > tomorrow anyway... Thanks for reminder!
> 
> FWIW, my reasoning here is
> 	* erofs tree exists and
> 	* the patch is erofs-specific, affects nothing outside and
> has no dependencies with anything currently done in VFS or in other
> filesystems and
> 	* it does have (trivial) conflicts with the stuff in
> erofs tree
> 
> So putting it into erofs tree would seem to be an obvious approach -
> minimizes the amount of cross-tree dependencies and headache for
> everyone involved...

That is reasonable. btw, our initial thought was that relates to new
mount apis and we weren't very confident if it really went the
filesystem itself...

> 
> I'm dropping it from #work.misc and #for-next now.

I will push out for next cycle. Thanks for detailed explanation.

Thanks,
Gao Xiang

> 

