Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E79C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9A02076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAW8ZxlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHLQt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgHLQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:49:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB8C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:49:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so1372239pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cpPB12VxTBo7Gag22fvUPzJVt3FtVo3U/iyGytPOFC8=;
        b=cAW8ZxlLeFLGghZGfwil7GCsFu/Wx84qNcvTg/XVrkAbtkEOZAhlELedYvsh5OcjNn
         68hVNp3BOqsfFvCk8/DJJZFKTQTr7taYUus7ibSRInWAkhEl5MiCNKb2gyq0b0/62Smx
         kO5f0cjcqlxYRZ8oh0/CyYUw5Z08mZAXZ3o6hEnbpuI+LH347XjJUmNrpZYcqNd25EG6
         KviW0R24AmlIh3cAnWjqckORbSUJgvAXEcZP3WLbP8zDa5tnoVCOajHHO+wiUvjmrIH/
         wTWSLNRlAqEKOFpOMJ1vROmdj3yjVxUsCkSCIXJio/0OXww/VHj7q7uE2yE1vgGxivOA
         0yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpPB12VxTBo7Gag22fvUPzJVt3FtVo3U/iyGytPOFC8=;
        b=g5K3EOP3pytbDhptnDERxW/6W9IFv9a7ywKmlX3zmjM4wU2My3vkOwU4C4eJg4zkJK
         VWNkrrB1aGkfwOyZKwXwhA2XZKL3B8+oyHWlHk8W2alDd/oNvKyFiXl6PqW0/g88oWfl
         fjIngq9udQ/42UXVHItlIBA63+l6PDZvbmgtFkbYiqjeTe8i1OhWnJMvuj+0z4HWgYQw
         GHGOLEhyXBCRdp/ibFbAVFOiEa0/enQtQZwkHVJfYL52Co41VOjvFWQ2muQc/fXJgA63
         sc0g/TQcWz88NBvQFZRFydELS0nQrXBS2UGU2WsKuHK2zEhMRPrv2Y2/DlM2MHu+8hHO
         FoOA==
X-Gm-Message-State: AOAM530LTFRFAi9zu7dMKboPo+Znlj6ivFYH1W4L2pTMGS4SXv7jLdGD
        ZnSVLIgm00V85LcJDf3GhX3gaw==
X-Google-Smtp-Source: ABdhPJwO+T3uFUkBrw6Mc8DFAwiGNS0DSylwk8ov4E5dfG5nKfceh1QXYv4J7cNSK8eN1cLWjaDfWw==
X-Received: by 2002:a17:90a:1fca:: with SMTP id z10mr864830pjz.209.1597250967508;
        Wed, 12 Aug 2020 09:49:27 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id lk16sm2731778pjb.13.2020.08.12.09.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:49:26 -0700 (PDT)
Date:   Wed, 12 Aug 2020 10:49:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200812164925.GA3393195@xps15>
References: <20200811035726.10379-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811035726.10379-1-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:57:20AM +0800, Tingwei Zhang wrote:
> Ftrace has ability to export trace packets to other destination.
> Currently, only function trace can be exported. This series extends the
> support to event trace and trace_maker. STM is one possible destination to
> export ftrace. Use separate channel for each CPU to avoid mixing up packets
> from different CPUs together.

As the get_maintainer script points out, you are missing the maintainer of the
system trace subsystem.

> 
> Change from v2:
> Change flag definition to BIT(). (Steven)
> Add comment in stm_ftrace_write() to clarify it's safe to use 
> smp_processor_id() here since preempt is disabled. (Steven) 
> 
> Change from v1:
> All changes are suggested by Steven Rostedt.
> User separate flag to control function trace, event trace and trace mark.
> Allocate channels according to num_possible_cpu() dynamically.
> Move ftrace_exports routines up so all ftrace can use them.
> 
> Tingwei Zhang (6):
>   stm class: ftrace: change dependency to TRACING
>   tracing: add flag to control different traces
>   tracing: add trace_export support for event trace
>   tracing: add trace_export support for trace_marker
>   stm class: ftrace: enable supported trace export flag
>   stm class: ftrace: use different channel accroding to CPU
> 
>  drivers/hwtracing/stm/Kconfig  |   2 +-
>  drivers/hwtracing/stm/ftrace.c |   7 +-
>  include/linux/trace.h          |   7 +
>  kernel/trace/trace.c           | 270 ++++++++++++++++++---------------
>  4 files changed, 159 insertions(+), 127 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
