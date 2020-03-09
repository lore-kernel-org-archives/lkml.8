Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97634C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDD620866
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583783493;
	bh=2lkfnUKYiBKSZD7SWDSHqKuByyrZ5Q6CG/NjhvcHtQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j4E3QrBIyiOdNhHXBzYhjtPWGLgeDgsiyZxbft5t3IpfOGi7Gk/bRX1i9Vr3Qup2O
	 /REphVKPiqjeQfGRvYZO3DP0MP7eDS/dVyQid9cYJ1uA7l6ETKOgQL0RrCj8mu0SIg
	 cWNKU4/IDVvnp/Dg08ekAuWf5eSq+cTQA0noGelg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCITvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:51:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38971 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgCITvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:51:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id e16so10515943qkl.6;
        Mon, 09 Mar 2020 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c1osNqRAKc0726dqEwHuKyvC5yuBvSfA/WeWwR//zkA=;
        b=rHHHsldRAuzPzsRgPpYEEF41npGcL20HK/bsJw2992ey9MCD1z2d/FuTLQuxE7Z7+U
         UjjRUAWlDcX/hB45O4nq7ukPOkA6tW26Rm5nFJWVe0NEtEWkRX3zjZ/MHACLc22D2njO
         gg7yxHAarOUO5a8tZGMxrF0Und3s1CJWP3XrMOgP8aqlhpsA2V00Sfovg2MMnzIz/q/Y
         z95z15IJyPmsgsifkmYCj+k22WS8M1Rk6mvHcTfr2znjU3uThKNQ0rJpr5w21p6mdZTV
         X0CVA6FjslyawUt5y/SULEsAXCb5NzFPr8XH50Ej7T3a/gbf8EqzGvn3NFjM85Xn/odz
         qGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c1osNqRAKc0726dqEwHuKyvC5yuBvSfA/WeWwR//zkA=;
        b=p5n8lX/4Nmd8sdHUs72+pAmQibZTglqdIuImuN4Tova3IrBYPO90iTauBDa4uZyxtF
         T9hfaCbeNl5AfgGhDZq/hQcrodM1ePGfQPP2YuzEZuzD2iQFCnK6tpBmuear4JsJ+sMf
         EiTjXnPVGi4NS3X5dCimTjc5xZb2Z9jPeVo1jIpcfHNcX3OmzEfcmgZY5WfJGmppZ8sW
         mpugxNQ7ugP+MRNmevaliwiQpRuX8D2NGqWPHJzEW7ERnz9AbOQX3jw6q25BQ0O+zQCY
         XY+ECbI2BjyYBql4aU0yE2H4gdxFd9Runv5WvRC1EnSW5hWa0nBNv1vYKY2Dof1TaQzO
         ynjw==
X-Gm-Message-State: ANhLgQ2juhSJdxHE2eWU1zRetvZnTfLy2+I6OHOviPCVpRzhWtZBF3zV
        XLSoQ9IyLNKN714mTqXoaSJSmAAU1VM=
X-Google-Smtp-Source: ADFU+vsrxFGCEYJDTVMLz/gnWOmey7gNRVnC2YIuYoMFujy3erMSmuTZE7gfzEqMNmid6ZzbgjBGUw==
X-Received: by 2002:a05:620a:102f:: with SMTP id a15mr11232027qkk.243.1583783490243;
        Mon, 09 Mar 2020 12:51:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::182b])
        by smtp.gmail.com with ESMTPSA id z4sm20660167qtm.69.2020.03.09.12.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 12:51:21 -0700 (PDT)
Date:   Mon, 9 Mar 2020 15:51:20 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, shakeelb@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
Message-ID: <20200309195104.GA77841@mtj.thefacebook.com>
References: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
 <6bbfc8b8c9c206d80de43a64bfe4b8083cc2c02f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bbfc8b8c9c206d80de43a64bfe4b8083cc2c02f.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 12:41:05PM -0700, Joe Perches wrote:
> If the need is to allocate from a single block of memory,
> perhaps you need a submemory allocator like gen_pool.
> (gennalloc.h)
> 
> Dunno.  Maybe i just don't quite understand your need.

vmalloc is the right thing to do here. vmalloc space isn't a scarce
resource on any 64bit machines. On 32bits, which basically are tiny
machines at this point, these allocations are both size and quantity
limited by other factors (e.g. each cgroup consumes way more memory).

-- 
tejun
