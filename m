Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D189C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626662146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgCEK6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:58:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38033 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgCEK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:58:06 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1j9oCb-0003ec-44
        for linux-kernel@vger.kernel.org; Thu, 05 Mar 2020 10:58:05 +0000
Received: by mail-wm1-f72.google.com with SMTP id t2so1430718wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 02:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=udGZa6zUTBnjvV9RDovAxlAbvCOTgp2vn9poHckj0LU=;
        b=JuvRsjlwqWc8P3SGaiIZHusITEVNBryCQqjEt81oytLSGvYY40Nkpy+6INmjH9htC3
         ZF20R9ibYZi6q8Uf33J9i450P9Jqyn+GBTOdac4JFSK0fxws6/FRuF2f6tZiLdMs+F4M
         qGSE7hh6a7iPGt1SzcgwSmtpp8yb/0gOZyhFvdCH2sBVqtoy0HlT3MgiHk8w7KGBDGZG
         ca+l4jgoNCRuJrnbLObDG6s6H9UhN4J9vn/IyluZMIMCDa/nItaAJOa21yoGTegaXBT7
         611JHgfo2avpcIceKkSLDLNH5erECdd/cGpIBHmiRF+h5iki3cRNlSzTV7fcUYgTv6Nz
         KCQg==
X-Gm-Message-State: ANhLgQ30TGM+vJRrx0elu3p2cJaR9b/MyZRYk50l7D34yG35TccwQNk+
        QKpZerndy8v4PLAF7W39Ywt4q4Wq1NtqoSEb3bk5GT2OMNcOGFO8lOHxP9ZOVvz5NaKzXWP6out
        xpGW+m3HaRlBKV6C/kHKSvjC1I2ZiOjB/izDNAhrouA==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr8893029wrq.90.1583405884725;
        Thu, 05 Mar 2020 02:58:04 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv4iMXGTqqE+qve6h7wkGy0rppGrS96fNmwqzfIXN3ymTQ0oUkPnpqY9TxcelI6qvl2thhWSQ==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr8893000wrq.90.1583405884377;
        Thu, 05 Mar 2020 02:58:04 -0800 (PST)
Received: from localhost (host96-127-dynamic.32-79-r.retail.telecomitalia.it. [79.32.127.96])
        by smtp.gmail.com with ESMTPSA id w17sm12798445wrm.92.2020.03.05.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:58:03 -0800 (PST)
Date:   Thu, 5 Mar 2020 11:58:02 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: free ptp clock properly
Message-ID: <20200305105802.GD267906@xps-13>
References: <20200304175350.GB267906@xps-13>
 <1830360600.13123996.1583352704368.JavaMail.zimbra@redhat.com>
 <20200305073653.GC267906@xps-13>
 <1136615517.13281010.1583405254370.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136615517.13281010.1583405254370.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 05:47:34AM -0500, Vladis Dronov wrote:
> Hello, Andrea, all,
> 
> > > I would guess that a kernel in question (5.3.0-40-generic) has the commit
> > > a33121e5487b but does not have the commit 75718584cb3c, which should be
> > > exactly fixing a docking station disconnect crash. Could you please,
> > > check this?
> > 
> > Unfortunately the kernel in question already has 75718584cb3c:
> > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/commit/?h=hwe&id=c71b774732f997ef38ed7bd62e73891a01f2bbfe
> > 
> > It looks like there's something else that can free up too early the
> > resources required by posix_clock_unregister() to destroy the related
> > sysfs files.
> > 
> > Maybe what we really need to call from ptp_clock_release() is
> > pps_unregister_source()? Something like this:
> 
> Err... I believe, "Maybe" is not a good enough reason to accept a kernel patch.
> Probably, there should be something supporting this statement.

Indeed. :) I've asked the original bug reporter to repeat the test with
this patch. Let's see if we can still reproduce the failure...

Thanks,
-Andrea
