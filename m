Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2ACC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD2F2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587565537;
	bh=7BVUN63VWZNVFnEQZlKO9vvNmgunrNhrI3/ZyHqQDKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rByBxs/A9vVeMqTh5jlW2bETea529ZxI9hCd5uxrCTwKEfsGMKeckonqa9jt0/tTh
	 IifKB/IomayV3h0MgOlVERZDaM5qHjQapjFxBc/YGdErcCVX1rCTC2HwCleTcA+3YE
	 jvo5aprTyprKsoDOW/3OVC3zlTnGk2g1AOyT7lbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDVOZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgDVOZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:25:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B8C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:25:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so2664771wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlnQLGftXC8kajYxAAXvIWGpQNjPXxu7iCKzOB8GQsY=;
        b=F6eF333DW3fM6O5dci88xIRpFdcSmNfxPezR/R8u6zWETi54Lz0O47/Cr6uNSa6dyb
         S2ljr6DGF68lqYosgrK22is8WzkPZvv6aoUWpLKxH/I4yU0+9mKzGyNAwqGNeusSCC5P
         hT2RBZHEqYBFoaQv2/s9O6CIhjg2Mc/vbxhgb34jRrNIAl8xBOSADa34ShXZVqDJk3Ds
         EMp4JXItjlEvOyPOBDBNqgY6Dqg3bgO+zfbepOChlHoh2zypAqTfFGbYyywWMMXqfMs0
         oo7EZ5bP15Acsh7ccGV0S+I0ARGeUG/NlreGZsTyNGFDUgwvnxpA2S38Uqye9tYoi06G
         7b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlnQLGftXC8kajYxAAXvIWGpQNjPXxu7iCKzOB8GQsY=;
        b=d+RbILPz9Aiue9D3w1mzS8Y8q9j6b9a9C2y5QSD8u/6f2QHg2Vle5oJnzGcoj0KgSL
         Iinx6jyUhzGH+87W3fUMFp288nsbFQLO+v5LtF+4wCO4wDhPzaYkgLGlltQX+hxzGq2K
         pd15ZPY6AfsF1bXMupwz9UHHq3rOka/BFOS/ALfZ2oSRrlnv6U767uxIDDUjmFaV7yVh
         D/Oqd08+RIGfruJcY9yUIxW6vcUktrnJhbOvaosmxT08tOQmZCwjufvG5ggn4RS+FHOb
         UduRGNeEFia/x0OmXp0sOsCsXOcFiTh8uM0x43SxJgEu5bZE4zLBxwg4iMmOpa3XNNt5
         Zd2A==
X-Gm-Message-State: AGi0Pubo+fyjfF98OpeGTQPKbY9wp0Yjb6rxtBUwQ9Yc9TTGsYc11+wb
        bavmoytkXmIG6MxsdRYdWKk=
X-Google-Smtp-Source: APiQypLSFnrxzzjfqAhhjluDe9x7w2ambTC1CyR7T62vZAxiQ1x7RESCYFjhvNc78QwriIC+b1mHrw==
X-Received: by 2002:a5d:6688:: with SMTP id l8mr32067965wru.179.1587565532422;
        Wed, 22 Apr 2020 07:25:32 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c25sm2475026wmb.44.2020.04.22.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:25:31 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:25:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, axboe@kernel.dk,
        daniel.lezcano@linaro.org, sudeep.holla@arm.com,
        airlied@redhat.com, broonie@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 23/23] sched: Remove sched_set_*() return value
Message-ID: <20200422142529.GB2840@gmail.com>
References: <20200422112719.826676174@infradead.org>
 <20200422112832.590341262@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112832.590341262@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Ingo suggested that since the new sched_set_*() functions are
> implemented using the 'nocheck' variants, they really shouldn't ever
> fail, so remove the return value.
> 
> Cc: axboe@kernel.dk
> Cc: daniel.lezcano@linaro.org
> Cc: sudeep.holla@arm.com
> Cc: airlied@redhat.com
> Cc: broonie@kernel.org
> Cc: paulmck@kernel.org
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
