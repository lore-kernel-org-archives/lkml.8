Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEEAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B14C2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590674658;
	bh=PJXHSQJR9LDniwGbOzpPoTTnRDnO3E50wMy5cZaC/mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jkXoLLYg84Zw8UZw73mIvVI8v8r9Z2EYGqO27GhcdX2IwmY8L+BQsv5hfk3q/gMOv
	 a8NoIEyMVj7F4g/WbbZxHSFaBX7KYBlbX+FHbP0/8pqI1bnUgX1EmrN8BUgzwrJhJ5
	 Q21TChlu5fpS7KhHiI4guw6HLglKz6V0EBYgjH9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbgE1OEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390644AbgE1OEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:04:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D8C05BD1E;
        Thu, 28 May 2020 07:04:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z1so122650qtn.2;
        Thu, 28 May 2020 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EBD7IPZhPK6LYEpuUm9uYZgoKSKV6F+qQYG7TUFwOBk=;
        b=qOzW1pAeJlvpU3IPXP5a+SZ03JGuxgKHseAl/bi7J7DqaZVwJa5QmrtrPr5e5etDfB
         2Zjs3Jenivlp6HhzVugJ1rvqIWm9lau58W/4Ju1loK8vxQYYSMm2G2le6dt+crmwYLi7
         2EH0IOA6U44/TDz6WEK4KEuiGeqcoPaTFcJSywkkZsUITScl6COflTq22fN89s7GSUQO
         ebJCE/xZu1wSjfoQiKNvTXy+Y7rgrpU8ysy1D5kR1eRIDNsQe0EBnBYmylOIACQNhxhR
         TUlV7kaMSEKfjzMmF6ROisX/YJ+vMXnuB0Et4Trc1jlqw0wT9KBLjLLr1OWlFtMkTM8q
         Njig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EBD7IPZhPK6LYEpuUm9uYZgoKSKV6F+qQYG7TUFwOBk=;
        b=BAQ0eueq2UtpAdwX9SAZ88AatJ5Sa+PYURFjQy8ENdkayFY7sC01eFcW/18m7a2MJg
         OXbxG/f65W1tO7F+bDgADtZ2s6+5gIBnvIOSUzpBTpew3oCd4/4zn1GsDqoj9kw/je4o
         qhAfAoS+8OFIuOoUmbelJGH0W7EH6G3J5+Iu4ioCTouyvA8LAzliycVt5erExdiEz6Iu
         1Twjo3fPR/jCxGfi5HPzDp1/l/i+mjBMncSdJbmoDjQrEGcUFePNw6eOTyzv83/hxjR6
         UCG3zVCBKCRCdckZmZlZGuoAFiqxoYwfv+C+vbKuTFE1OA4rV6hjB17z+I1/HrHFCEsy
         PB3Q==
X-Gm-Message-State: AOAM533iGZ54MpL+MkeMg4ruwdrOe9pIAeFZfmmGUgz9B6CG5uebz5yw
        8CZ0LiG67dV3wNF2pNwH+8w=
X-Google-Smtp-Source: ABdhPJxLDJSpWjyDvtA1dv/WxHHofDQc5w+PCpAkPSnNcrs107St/oCxV6bvuJPWfG09qxgbbNbq9Q==
X-Received: by 2002:ac8:4e4a:: with SMTP id e10mr3112122qtw.203.1590674640313;
        Thu, 28 May 2020 07:04:00 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id w10sm5779166qtc.15.2020.05.28.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:03:59 -0700 (PDT)
Date:   Thu, 28 May 2020 10:03:57 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Markus Elfring <markus.elfring@web.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjU=?= =?utf-8?Q?=5D?= workqueue:
 Remove unnecessary kfree() call in rcu_free_wq()
Message-ID: <20200528140357.GL83516@mtj.thefacebook.com>
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
 <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam>
 <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
 <20200528122545.GP22511@kadam>
 <CAJhGHyBUkMZ=cV+Qf-5+PMAFqgebbRLc46OZSSUSgoRROpUk2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBUkMZ=cV+Qf-5+PMAFqgebbRLc46OZSSUSgoRROpUk2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 28, 2020 at 09:27:03PM +0800, Lai Jiangshan wrote:
> wq owns the ultimate or permanent references to itself by
> owning references to wq->numa_pwq_tbl[node], wq->dfl_pwq.
> The pwq's references keep the pwq in wq->pwqs.

Yeah, regardless of who puts a wq the last time, the base reference is put
by destroy_workqueue() and thus it's guaranteed that a wq can't be rcu freed
without going through destroy_workqueue(). lol I'm undoing the revert.

Thanks.

-- 
tejun
