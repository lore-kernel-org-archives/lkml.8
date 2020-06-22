Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AEDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C2A20707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592848429;
	bh=ByCENBapf+e7wZUtGPyV0Gp4Oa4uEA4xRBBYPbbvTcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uSFmOX66ICerC+prko1tmvkizazKG9qHKHRJPlZklANmCzFOb/4R52ldHTVJieejw
	 PBDlHtPn5bj/AqDEWH/iFcU9XyV4ZqhfjC2wXUD0MIoppiUEJv2WmjnW2VNTEjpb4y
	 pbKAiJKwQK1saO3b6SSwPYBsL0CYGWGYBYmBqLe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgFVRxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbgFVRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:53:47 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC83C061573;
        Mon, 22 Jun 2020 10:53:47 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a14so2057866qvq.6;
        Mon, 22 Jun 2020 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aI7AFW3ATWYt7qJdSuoHvMFK956GDUQlWuGNOU4nfiI=;
        b=CRWvA9PWU2ITV60zpx4EgXzCM55vziCjbaNwks/D63WzA5S+uC9bFIoRf/rrKIj+29
         SkvDtsRjgbuErDRQjQU0J30xwxIx9q6ZzyTOCT9qWjW478v2Odeo6ldUnpEDk7W4+W+m
         sLBlBSkYWta7t7EdcU1A4uRGMBOH6oRgW2QeA1aE4fA8iYBJdywSjoka2ZHJcADwd0I3
         qu7CCA5PT5Q8sIsOjY68UDesnlLy3rPe/iMEiQyZqbJF2eb6RWt4o+SyUFGUdNaTA2Ol
         zCcxR2WV9A4XFF0pr3gZ5P/uQIKywbZV+Bd5B1HXGadCdNLui3re2Qe+2FeoL1m8ls/+
         1D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aI7AFW3ATWYt7qJdSuoHvMFK956GDUQlWuGNOU4nfiI=;
        b=kuCx6XmB5A39WEY7qSOF0MRbSKad1bCn8U6NUd3PmYVDuG6SaN2k3yzu84roznOmA5
         id3+t66KtRN4WfDsJ6FSs+12HSAd7rMGZcgQQnQ5tUWGWUqRw9r4OnTdD+aonlFgbHxC
         5VYDtAiql+98FMzaQhtf4AyaBBe97PnOvDpqq+BTRMDWLjW0RNEa6dhm3aoyc9qBq1Xe
         WgmG3plwGB4fBniR5OLvjQUGR0ZYZ08f7IQoh67qAoHCSUOm45mdxlYq83UIYn4xfu8F
         Dphy4dXwOTBng7VllO++ag+p7zu3AS1U6MA/4Tb1pM7AWro395s6vd0HK95hT8C0yDIE
         NPeg==
X-Gm-Message-State: AOAM530h0HtO6keS48D49IGxmPVfZQP/zU6WtOATD+qX2dpKq/3ZatfZ
        6mx80TBoYPpQtGmWBUf0jc4=
X-Google-Smtp-Source: ABdhPJzv3P99geGSDEBfnzJ929miMpBdopbd+1+vh8L6/V432OG2iCsT4kcU5NWLwQq6Ru3OMnJHQA==
X-Received: by 2002:ad4:4374:: with SMTP id u20mr22835856qvt.144.1592848425956;
        Mon, 22 Jun 2020 10:53:45 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id u27sm14366487qkm.121.2020.06.22.10.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 10:53:45 -0700 (PDT)
Date:   Mon, 22 Jun 2020 13:53:43 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200622175343.GC13061@mtj.duckdns.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:44:29PM -0700, Rick Lindsley wrote:
>     echo 0 > /sys/devices//system/memory/memory10374/online
> 
> and boom - you've taken memory chunk 10374 offline.
> 
> These changes are not just a whim. I used lockstat to measure contention
> during boot. The addition of 250,000 "devices" in parallel created
> tremendous contention on the kernfs_mutex and, it appears, on one of the
> directories within it where memory nodes are created. Using a mutex means
> that the details of that mutex must bounce around all the cpus ... did I
> mention 1500+ cpus? A whole lot of thrash ...

I don't know. The above highlights the absurdity of the approach itself to
me. You seem to be aware of it too in writing: 250,000 "devices".

Thanks.

-- 
tejun
