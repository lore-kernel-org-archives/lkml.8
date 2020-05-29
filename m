Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5A2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590764682;
	bh=MOJCXSjH3bAgRJrqubZf9mUobDtcNEJreIAgMoz7pDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ni4l8X7C2kVds7R8VyqTEVtPV3S8vFSyCTUbBq0N2JE6ZJIh0Y/BiP6CxCyt22l+i
	 szOPoKWquY/3JKs3lS/+kYDqpRPBjTLGkk6l2kJNs/niA+pM6+mTVXJIwhomjFhTeu
	 9UorP2jRjweBWewRASBu8DLTOPQxty+V+nX5MBUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2PEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2PEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:04:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EA7C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:04:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h9so2139684qtj.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ztIs2CPDNHXX451aDgntLCsQHumgJ1hG2OBmVgjmqlU=;
        b=c7pxMx775UBDPcfPMI80kvhV43bjco54T2ms6jq9BKS/zA/MUEE6IuGGdc3N8QpOvo
         SS0qd82q6FGRj+JpicIcWSjOfzm+4N3PIoN1IMcKY9rnoSqpVj68M4iwYmrkgNIAFjGC
         2wt2oisde2RhMF6+u4ZznNShdvIOI7xj66bakSVMgZm+lL87ztQqgMrjoGAtvl8/B0mZ
         nCzaKKg7j7wv+jcf3MYADpJsaVldFM9VeGNV5q1o56eXkOC9mItOL8aF2B2kzbOU/s9/
         lYozQg+issAz9gYhlDeIUw2AUA9PZdQjeKLqD/Y4ORBLlgd5eR+YfkFo0v0evsdUSRjh
         OPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ztIs2CPDNHXX451aDgntLCsQHumgJ1hG2OBmVgjmqlU=;
        b=BPyOI7FNN9syyPkZZ/OdLtPcltVXJ7Zrdhkwds2kx+wJXwV4j1PzM8ih0Mn00isR+i
         qNnZon9bre9zyxF3Kg+kPDhZGY1td7VDNTQ5xp+w9nTGMMtFJmuJ5GkXaVfzaDNbAGBZ
         VEqFWzXAjNrB82GmojdxAefUAXi7q88u+t04sfKSj1ErM1diwej7A3dUCfb7HfZo1ZSy
         jCs2/mCoYNbtqnnY4TJkaoShfl67kG/ZSbEtk21FCx5ZZMd3MyHjvgWInAGnDnEOAhXz
         mvxEEwIM1tgV5bJ9WZeWnmoir8px6/pQyf3mqj7V5ygtHaxqATktuO9Cyuf+4S2qLJFp
         dVBw==
X-Gm-Message-State: AOAM533r/WYlB7Tv1opk2DsJ3hWGcJYSzdu5Z0y9byGE3oAmyS5yVXip
        Ye0aQdeBKxzaSN95eKjOUpeqMpMZ
X-Google-Smtp-Source: ABdhPJx3iF+StQITChri7Zk4pFuy0iDZ3OC+yDsguV0sIQgHjoh+E6E9KTWE0cPFHcdujPlyca0l8A==
X-Received: by 2002:ac8:4b50:: with SMTP id e16mr9763187qts.159.1590764678219;
        Fri, 29 May 2020 08:04:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5493])
        by smtp.gmail.com with ESMTPSA id j22sm7285232qke.117.2020.05.29.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:04:37 -0700 (PDT)
Date:   Fri, 29 May 2020 11:04:34 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] workqueue: don't check wq->rescuer in rescuer
Message-ID: <20200529150434.GF3530656@mtj.duckdns.org>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
 <20200529065903.1758-3-laijs@linux.alibaba.com>
 <20200529141425.GB3530656@mtj.duckdns.org>
 <CAJhGHyDXrUoOYNMPdqL1ObhCK45LWZj3z7RCjM2KQRKsq5inWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDXrUoOYNMPdqL1ObhCK45LWZj3z7RCjM2KQRKsq5inWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, May 29, 2020 at 10:58:46PM +0800, Lai Jiangshan wrote:
> I'm not sure I understood your words. And I'm not
> sure which function may use freed object in "use-after-free".
> Is it "send_mayday() may use a freed rescuer"?
> 
> This patch relies on
> def98c84b6 ("workqueue: Fix spurious sanity check failures in
> destroy_workqueue()")
> to move the kthread_stop() before the sanity check and the work
> of drain_workqueue() which guarantees there is no work item
> in the workqueue. If send_mayday() still goes wrong after
> drain_workqueue(), the user must have queued work items and
> invoked destroy_workqueue() concurrently. It is excellent
> if the sanity check can find this case out, but it is not possible
> that the sanity check can always live through it since it is
> not worqueue's internal fault. We hope the sanity check can
> find all the internal fault, but not to the extend that
> it can always work when any user uses it in a very wrong way.

Yeah, it's not fool proof but it's difficult for me to see what is better
after the patch. What does the patch actually improve?

Thanks.

-- 
tejun
