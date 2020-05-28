Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD9EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0900B207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590662294;
	bh=QmH9c+o+7HRZQKINaBX3dIp8x+YZsbNYRqoLQnDzgSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dzdnejb9QLzO9CDWNzSHGAJgOTyG3WVrykJrBgz14WKZ18sTG7IXW5Ye9WMYaBO/Q
	 cTR6W8pA1oHKLIHg9jOpfrPpQNP/ok0gNyEfeSzt6jLJprMf9H6sKrqNrt8yqUoUYn
	 THGWNFUuhUlMCc8Mfxk00CgnRa22PM1Gf852dK9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgE1KiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbgE1KiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:38:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66371C05BD1E;
        Thu, 28 May 2020 03:38:12 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a23so21790574qto.1;
        Thu, 28 May 2020 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=emDCwji6yzqB6XWcm2nmGRgKBFmFlbUttEJdLroXddo=;
        b=juvACnWOxakqdNtqXbniA2Y716WAvrKMo85eCSPzcK/58thhrHJxFvVCAnhdTjEsC9
         K+DIYC6/iXiKLKpoxTtlq3fPrDH0zj4WO8c09riSXO0vqYlTyaa3br7u+Aim3FrXKNi3
         JDK8Y7pm+9tKHVT77w/ZodWhEu0P8bwlb1RfMLfFw/MPP60gcBlvvIIH4hZq+1/ABWYg
         OGXYzE8dwRLoU2caEq7nl0Wfy9z6YBtYF4VH1pLx3fGOogR3vCoh90iIx2VExVj6X4Xn
         QqjiM+pKWS5XDZMIDG8nSz7lelXowEj7C/6f9+Esj1UDigyJYkfC/eszlyFjZv3Vtle5
         MYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=emDCwji6yzqB6XWcm2nmGRgKBFmFlbUttEJdLroXddo=;
        b=pujIiBUwb5uzh+w0bePqVvkuMqYmk0kPCj1Xpmui6ZMbpQOguQn8L5Q559JipuifcF
         niUofjGkJbK+afOg0Ws6BEFhBrC89hyP8CnLk5PZUSTg7/R3y0PSgYBEjBBSWySzV4so
         pAZIGLHm5LHmVDeIyykGc0QWtXzhYYOf7H0iGwZHXrrOdot97/IlxQAv41UWYfCcgA5A
         fnOCMx+MW5RrQyib1lg6OAmTmP5XgFQpALaGBKNq4jiZsG3hv+sXZEVyZtstmXfO7+0n
         nX6M7oMltWwusLGnEYYVrZ/7dUfUX62mBSs4ujgIiSejy44H1uRP2ycWsyVGjljOHfEl
         528Q==
X-Gm-Message-State: AOAM532pq2D8GxlISgXEzOCPenI3k/hnfofk6idiFDVUcGrKck0rn6j7
        qm09ahMqog2/s1VBe8EYWBJroHr0
X-Google-Smtp-Source: ABdhPJw0VtxBM5GYncbYmh7fMALQFius+WP39LE5d1nV6HGBJAaGYzMaI6HcSnIlgf4rxi3pAr0dUA==
X-Received: by 2002:aed:221d:: with SMTP id n29mr2312329qtc.286.1590662291390;
        Thu, 28 May 2020 03:38:11 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id n25sm4522829qkk.76.2020.05.28.03.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 03:38:10 -0700 (PDT)
Date:   Thu, 28 May 2020 06:38:09 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Markus Elfring <markus.elfring@web.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjU=?= =?utf-8?Q?=5D?= workqueue:
 Remove unnecessary kfree() call in rcu_free_wq()
Message-ID: <20200528103809.GK83516@mtj.thefacebook.com>
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
 <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528095703.GH30374@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:57:03PM +0300, Dan Carpenter wrote:
> Guys, the patch is wrong.  The kfree is harmless when this is called
> from destroy_workqueue() and required when it's called from
> pwq_unbound_release_workfn().  Lai Jiangshan already explained this
> already.  Why are we still discussing this?

Oops, missed that. Reverting.

Thanks.

-- 
tejun
