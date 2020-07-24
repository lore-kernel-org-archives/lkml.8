Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FBBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C6020748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGXGa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:30:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51974 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGXGa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 02:30:57 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jyrEM-0004iy-L0
        for linux-kernel@vger.kernel.org; Fri, 24 Jul 2020 06:30:54 +0000
Received: by mail-ed1-f69.google.com with SMTP id a4so2487072edr.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 23:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f5Bi1N9eHmzbwm4KZS+jcd4luzKCa17r9gngXjYNYvc=;
        b=sTT9Z79WjxVFbi6VmzhnJJR2iGq7m9N3+u9V5Lgww6fjnYkUqzRC+0MbLf4PRKxgfl
         qxraVlPiRjH0NQA7tjIMOnK0Bu/r3HOafmyK/feiS0X3+tjI9Nj3/ZO3PrpXNIf9nYOO
         BzVPtbMPgzPwR0OcZLsQTkWlZRH6FoNXt6mPDCJsGHAMF78R4/rO8lcXlAtysxypj3Sh
         hNRa8vSNYsqtUVjx2TPXUXFUz+tP1PWAgQJyUTD00tYGV7xME71sJjW87aAvgjwzSA1P
         ADeOLk/auUUeojgaFf49QYiQPMRrfnd6S9E9wE45qAKHzzSXbHEFMZxdpF8MoqAcZU7z
         W5Ew==
X-Gm-Message-State: AOAM530Kged2f5VIMto3COtnulGMFaKezy/sfs8ExnGRPkndGBo8bAfT
        XwVlss202/VJsnlBusvhjmB2/pBS3o0NmhlJMt/bmijDUKaL3VcwK80j/o6GRtaoZoBOOcH0F/y
        U66vZ0M46FEO2f/Bwy9CPx6erpREvuXQya0CPUcuhKw==
X-Received: by 2002:a17:906:3bd5:: with SMTP id v21mr3756079ejf.329.1595572254321;
        Thu, 23 Jul 2020 23:30:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXO1++pFVwTCL/tYfrIs0xm/tuHNlxlyRivKJ5/9QT5Rk/9NHc5BZDVgyqSnOH54Jo7XttPw==
X-Received: by 2002:a17:906:3bd5:: with SMTP id v21mr3756053ejf.329.1595572254072;
        Thu, 23 Jul 2020 23:30:54 -0700 (PDT)
Received: from localhost (host-87-11-131-192.retail.telecomitalia.it. [87.11.131.192])
        by smtp.gmail.com with ESMTPSA id r19sm48005edi.85.2020.07.23.23.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 23:30:53 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:30:52 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     David Miller <davem@davemloft.net>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, kuba@kernel.org,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen-netfront: fix potential deadlock in xennet_remove()
Message-ID: <20200724063052.GG841369@xps-13>
References: <20200722065211.GA841369@xps-13>
 <20200723.145722.752878326752101646.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723.145722.752878326752101646.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 02:57:22PM -0700, David Miller wrote:
> From: Andrea Righi <andrea.righi@canonical.com>
> Date: Wed, 22 Jul 2020 08:52:11 +0200
> 
> > +static int xennet_remove(struct xenbus_device *dev)
> > +{
> > +	struct netfront_info *info = dev_get_drvdata(&dev->dev);
> > +
> > +	dev_dbg(&dev->dev, "%s\n", dev->nodename);
> 
> These kinds of debugging messages provide zero context and are so much
> less useful than simply using tracepoints which are more universally
> available than printk debugging facilities.
> 
> Please remove all of the dev_dbg() calls from this patch.

I didn't add that dev_dbg() call, it's just the old code moved around,
but I agree, I'll remove that call and send a new version of this patch.

Thanks for looking at it!
-Andrea
