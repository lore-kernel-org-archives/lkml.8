Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35A8C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B042087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MuXkSZQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgDPSsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbgDPSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:47:57 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6BDC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:47:56 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id s18so2589365qvn.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=En8a9OfgFteW3m95ox2NXgQt0GaK2x1PYnYvAasaCWs=;
        b=MuXkSZQiiVR1PEk7+YTmlEUZCK3yGEHFaQqPh4S5joJgqa3VjvuC0DWIz6x4Rt9Ypd
         Cw4VLEhbCS4MbfQXPkvt0yAUibmK3z54SmoKM7bAR6xmm0Neyj6RvQTq3GqTrs6XRnXT
         HE+Ffi67KVZExUAm2dZQJemGW2fdTd2kzl8vPSz7QRcnaowoj5XVYuUj2cKUZ3AyowPa
         ie5A6Oksfy/1bByzcPxLjyDKCJHPOH6ihIPOsPN2ZNSJKvSRBgdv8SfjNXbGCPdk4pUB
         k15sY3dgRtQw23US1RIFflpCYm2SGEEeQa4VPqzr6Yb+3sm73/hDUESLbX04TYC8tXI3
         yK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=En8a9OfgFteW3m95ox2NXgQt0GaK2x1PYnYvAasaCWs=;
        b=ItJiKq2E32sNnoqNBhfDz/sE3/o8YsXHuyDeXqhGwWLtQyyQwTTJa7RlFwTP535RNp
         LEgck7E/BFJ0wewmCo0dAgo9DnPfRAr5tNJOd7bKmgB5HxklNgyRzWvJg/1du3d1To7j
         EIvAzDvyJZ86Ow6vWIFpme1X0YwdAKw1ksA54p23hmum9XGKIjHF8rqDEWYyYwzzRQOd
         fxvxF1zDVkPpaBkx1YEqBI+eLbgatzJe6+psK5mcOGM+sCaCjXb2UYIru4Px6QCbBwEY
         ZosBYugW/OoYogH4FNp0Q663oOtGKZXdpvwHG5ojuOlRp3x7jwq1Rov7d+FHBYIlQQiY
         +Ulg==
X-Gm-Message-State: AGi0PuYpcYY2fu8EiL0cPaZ7+bX4TiZWx6D/rFxVO+vPI0O2cz8EiF5H
        16I4oTxqcproriG7bLMtoqU0xQ==
X-Google-Smtp-Source: APiQypLvuE2d6rubB0KnxOEgCaaDxfB/k5+UjRfHvtWXX0MOWfVSGEEw7sQa8qPkBXmtVzJHhKKb5g==
X-Received: by 2002:a05:6214:17ce:: with SMTP id cu14mr11534107qvb.51.1587062875176;
        Thu, 16 Apr 2020 11:47:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h3sm1005577qkf.15.2020.04.16.11.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 11:47:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP9YI-0006rv-2e; Thu, 16 Apr 2020 15:47:54 -0300
Date:   Thu, 16 Apr 2020 15:47:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        roland@purestorage.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200416184754.GZ5100@ziepe.ca>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <20200416130847.GP1163@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416130847.GP1163@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 04:08:47PM +0300, Dan Carpenter wrote:
> On Tue, Apr 14, 2020 at 03:34:41PM -0300, Jason Gunthorpe wrote:
> > The memcpy is still kind of silly right? What about this:
> > 
> > static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> > {
> > 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> > 	int cpy_len;
> > 
> > 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> > 	if (cpy_len >= len || cpy_len < 0) {
> 
> The kernel version of snprintf() doesn't and will never return
> negatives.  It would cause a huge security headache if it started
> returning negatives.

Begs the question why it returns an int then :)

Thanks,
Jason
