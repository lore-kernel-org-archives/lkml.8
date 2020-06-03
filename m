Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3353BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF40206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cyJgKLA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgFCAWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCAWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:22:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59FC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:22:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w1so448633qkw.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DRD7YwKwRFVA3B7g0OFuzsnYknxQvOSoNwCph4a8ztU=;
        b=cyJgKLA6ugqfSABxXXPRe8dx2rMgQbVMym1YRt0QjZfer40tx1GKUOiD4U2QTjjGHY
         6LBUJfel2veh1e9nty/6xrBOfWKNzGA+3GAdi0FHZU8k/hdUDMvs9wZA9KyTFfZmw2OH
         IY9kIsolEq18co4zZFyOMe3Z1pYS779I3BUrE3adDtlFR6rfE7B5KRAlw3vxuu5q5GwE
         TzBqYJtcY1ZToG73rIOZBnFzpvswIQdRIyTfGCQ8PZO4WxkkHcbouM7dijuBxAOVMOaK
         l4Krb/CwMD+RtxFc9M+tIwekOOCcKHD9NUAJoXPi24V7MQjUOF48D7f9MBk3MKjcAVB/
         sm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRD7YwKwRFVA3B7g0OFuzsnYknxQvOSoNwCph4a8ztU=;
        b=fplUdLkGBrZs0py2V4tv+Seirx76dy0moaUxy4lPMeidUFa708rE4mG13211eNx7Ne
         oPAU+8VySUOk8yDjbZdMMAg7ikDRGXqcznok1TxMEmMBusR4BRcUv1gqZhnWDzfrxPBa
         abWzGrGfKp9OoArc/FiRPZle6WEw/O8PWnfI5OlRlNyZHzTDQ1WfdEytjMgoN8k5tYyd
         diOwR9Sigd4biX7IT4kWgoGFERUEJqW8fGA8qd7wTR0WdvvD2Ne2V4Waxk19uZjFE76J
         KlSTlLmWdz9DHf90IL4kAlMek2Pm2GjI47PthBwLJBqSUpQ7o+MoRKE8W8iNefXcDYAg
         pAMQ==
X-Gm-Message-State: AOAM533gA0kII2TmAppRbddNGhalNz11Azno6ZAg7tHtN/RGxo9f7ePo
        /qflEH9tEwUOX6lNc/dsTpXyHQ==
X-Google-Smtp-Source: ABdhPJw9dIODI1VMIz7ZY7uYdbgoUa3gNBH/roXr+qSQ6H4FbDKjGaauBBlYNcKV/KSXKFfwudGycg==
X-Received: by 2002:ae9:eb83:: with SMTP id b125mr29243448qkg.85.1591143727204;
        Tue, 02 Jun 2020 17:22:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n85sm258001qkn.31.2020.06.02.17.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 17:22:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgHAT-000YFn-J0; Tue, 02 Jun 2020 21:22:05 -0300
Date:   Tue, 2 Jun 2020 21:22:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: kobject_init_and_add is easy to misuse
Message-ID: <20200603002205.GE6578@ziepe.ca>
References: <20200602115033.1054-1-wanghai38@huawei.com>
 <20200602121035.GL19604@bombadil.infradead.org>
 <1591111514.4253.32.camel@HansenPartnership.com>
 <20200602173603.GB3579519@kroah.com>
 <1591127656.16819.7.camel@HansenPartnership.com>
 <20200602200756.GA3933938@kroah.com>
 <1591134670.16819.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591134670.16819.18.camel@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:51:10PM -0700, James Bottomley wrote:

> My first thought was "what?  I got suckered into creating a patch",
> thanks ;-)  But now I look, all the error paths do unwind back to the
> initial state, so kfree() on error looks to be completely correct. 

It doesn't fully unwind if the kobject is put into a kset, then
another thread can get the kref during kset_find_obj() and kfree() won't
wait for the kref to go to 0. It must use put.

Jason
