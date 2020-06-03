Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955E72074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UrFdmmKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgFCSgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:36:52 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C176C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 11:36:52 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j7so1638630qvp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m0rQ25Og4KY67XYe+Rp/bn9zFlsT+AzGVQ1QokPo2LI=;
        b=UrFdmmKr38oQJnGeMSKPQDnYV5MOF6hN3NmIRhve2nLp8UI3hW+i5z082y6E5pvd05
         76amIpm7FGJoaVijfEGwCShv48zdZ0W4lP8GE4ukxay7gLBqddncOQAGAEUltBDEYrkk
         i0gNcX3r+zW1RpZBEr9iTJPPu0gQeO6knUXi/NOBTCHwm7elDgThK4kaGHky8FvLreTE
         10ugU8WYd9sGv7QbLMfM9agMZGbxRJruu/C0g6DB1fIgSYg2uol828JSYBRJZ+OxM2OX
         eyOnkj/D0FLfu4GB60mpPFXt1ZEvS721uTlge5+kEVvswAC7V1YeMsENm0PWvemibW5q
         Z31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0rQ25Og4KY67XYe+Rp/bn9zFlsT+AzGVQ1QokPo2LI=;
        b=psnIMA8gZBVW8MC9R9JyU2quxItp2ZjizOzsM2W6WeuYoxFRvmodE+FZ5TMBgb6jnA
         topES8RQVzA9yqmmbo6JLt6u+N4rX4j/Au/zvsoZqFo9wjgGFBzTzBRxceSe/Q0VP65M
         ZVHkG1YO6hbQ4Xl/LmZPxtiMmBDcXn9boyN1NkahqzteZX/+tdQUMSR+pWaK+tMMDHb4
         +AZwBgcfxSZ9LoMPe2jjXClpVpm3hW20WgOQIXomFFCAInGTLoDJwhnKN7nuxXm3oiBl
         LAPD1alj2Ph/s9ek2CXRwX5734gi7UOWRfEaNXx+dwIxSvlNEPuTW4F0TXsNKFK7kUus
         ffPw==
X-Gm-Message-State: AOAM5319MoW9EAfffM760EIKLaWf54zsy8mgSfHSk41q/7t02kOXhe8W
        Df08xRsTr5DmyXdWS60lHTcoKw==
X-Google-Smtp-Source: ABdhPJyszoT0ZrWarMb/dYpGDGoltgyIIt9hGLvyv5t1wF1VrmyYpDnGTIJiTHW/1DcvjIgdM6CevA==
X-Received: by 2002:ad4:56e3:: with SMTP id cr3mr1169655qvb.175.1591209411506;
        Wed, 03 Jun 2020 11:36:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x13sm2178986qkj.36.2020.06.03.11.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 11:36:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgYFu-000qna-GW; Wed, 03 Jun 2020 15:36:50 -0300
Date:   Wed, 3 Jun 2020 15:36:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: kobject_init_and_add is easy to misuse
Message-ID: <20200603183650.GI6578@ziepe.ca>
References: <20200602115033.1054-1-wanghai38@huawei.com>
 <20200602121035.GL19604@bombadil.infradead.org>
 <1591111514.4253.32.camel@HansenPartnership.com>
 <20200602173603.GB3579519@kroah.com>
 <1591127656.16819.7.camel@HansenPartnership.com>
 <20200602200756.GA3933938@kroah.com>
 <1591134670.16819.18.camel@HansenPartnership.com>
 <20200603002205.GE6578@ziepe.ca>
 <1591207475.4462.41.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591207475.4462.41.camel@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 11:04:35AM -0700, James Bottomley wrote:
> On Tue, 2020-06-02 at 21:22 -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 02, 2020 at 02:51:10PM -0700, James Bottomley wrote:
> > 
> > > My first thought was "what?  I got suckered into creating a patch",
> > > thanks ;-)  But now I look, all the error paths do unwind back to
> > > the initial state, so kfree() on error looks to be completely
> > > correct. 
> > 
> > It doesn't fully unwind if the kobject is put into a kset, then
> > another thread can get the kref during kset_find_obj() and kfree()
> > won't wait for the kref to go to 0. It must use put.
> 
> That does seem a bit contrived: the only failure kobject_add_internal()
> can get after kobj_kset_join() is from directory creation.  If
> directory creation fails, no name appears in sysfs and no event for the
> name is sent, how did another thread get the name to pass in to
> kset_find_obj()?

The other thread just guesses in a hostile way? 

Eg it looks like the iommu stuff just feeds in user data to
kobj_kset_join().

Jason
