Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F60C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DB72078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599222996;
	bh=MwzxdKHUg9teIgGqF5TR8b0dp/TMvkXmK35E0MMnmQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kUit7ioovigK6s0KKCY6G+l/IFCzhISmSRgUuYAo70/YxmAEL4/tfz8pr5Q/qQEQo
	 deJQ6XnBrXNSDYKa6R3lp4VJsttMzwrt6Nfbi65jwLwmuj2iNFzVeiVab3rHm/7C0k
	 d3jmuqT+5cZzm6WvqVz8y24FRc+oL9DvFeLrWeaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgIDMgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDMg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:36:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94AC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 05:36:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so5929466wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vfv4yM+SStFDIe7OBhyMliN8elYJvGGKotSeRXgb0gM=;
        b=naRFOVVaDv9VsR8bno2+3JHgkMxRkxre196AgGgdr9TyFAPlH1cBstCAD3fSNe6EP0
         gC0X81ehU84p685Bystdv4/S+W6RDTdTZLfQQrUlNExkJrt/JzxBVT2sYdjJ5IjWfdSG
         bouvZiDr5XtIWwz12l3CfO+BxBJAAju3H+HYo5DD99dKp3dSnnrBF38eaQmD7WicAlOe
         bP7F739+IKj5xXbqWCdfMa578xZWWWbmst5cH78mvKzkmyTV34yeypdEma+dbcnCzGVO
         ZMkTy199FI3uU0PlzrV0XqPE0R6zBsDrMcGnc7AZxOnYWAB8cDUL2RB3pko/xyx9AM2U
         3mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vfv4yM+SStFDIe7OBhyMliN8elYJvGGKotSeRXgb0gM=;
        b=sVg206+iaSEzfV/+yRGkVZy9V8j6r35TnNltIiLM3cSCl/2xd5WfeHyS+E5chivhBQ
         35lDy8G6su3J2MmuhVh/bZz4Z+jeExCm1x+CrGd8wG5J9Kqmtpj4jldmzRo2xYoe8ZMk
         PWYq5ninyuICZDy1KFy0mumzTNJ8swnF57dKmmTViflbjpIBokiwdXUITShH71PW5Srn
         s2tZpMNofTmd4DAHKPGs2k1N5UKSJSLC0N1SQzpcRbX66jhb3vtga2nEvi3dsmAJZCyr
         JiKMEbdkdOWvxLPCoN1uou69eqWQv6MVCPMhgSmKTTltpa59RWVQh2rEbCcTR+z1DMMB
         ocyQ==
X-Gm-Message-State: AOAM533iICfY+BfR92Rs0HrtEuqpq2cta1TTK+iOPZuEV4vYRn4lj+UA
        AcmMMiUclx0/ovASHRjBPSs=
X-Google-Smtp-Source: ABdhPJzqqmQBXQBK9XH/eqgG8tS7F55/RfJFY3Aaop0I3LTYLAB8sb0mxlFO12TcJHxO/g7n+eX1cw==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr7139669wmj.138.1599222987188;
        Fri, 04 Sep 2020 05:36:27 -0700 (PDT)
Received: from gmail.com (51B7BB2B.dsl.pool.telekom.hu. [81.183.187.43])
        by smtp.gmail.com with ESMTPSA id b187sm10980223wmb.8.2020.09.04.05.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:36:26 -0700 (PDT)
Date:   Fri, 4 Sep 2020 14:36:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCHED_DEADLINE reviewer
Message-ID: <20200904123624.GA3552@gmail.com>
References: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> As discussed with Juri and Peter.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Welcome Daniel! :-)

I've applied the patch to tip:sched/core.

Thanks,

	Ingo
