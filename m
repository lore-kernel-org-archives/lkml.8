Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F2CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAA920776
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJ3VM5pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgFVTbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgFVTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:31:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F12C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z9so20667374ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g/w1zkRDXUbZArondtMBfTeFeGofm5z89InDg9Quyso=;
        b=oJ3VM5pM/2tHjnJxcP81Jh55ivnWkl6fFY+9+X+TJiyMjil4v132mOLGeu0vhi6TeB
         /qHxaMHtHAteo8F1dXq9kRpDRrZmU5hnv+orbfnnL3WiWqN+hYONwgC+onaf15YPzthF
         6dMAc+M0Nh7WgLJyU289PHBAzEH5NDq1JrA/Ji5/Vzgy9l5CWho/FkTcqOpwZcSQ1ynj
         kdMALBmH9dHv9riGNXGl9+v/rtjDIQBBH2tD+MISdAAioUhTFa1oRm5ZpRGrqWFjODdx
         JkZ5j78yiX198AIs+Zx2zimMUHHjx+POQY0/pJ0PuF580jUeYoFZfNYOwJvC3lnvmOie
         Tqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g/w1zkRDXUbZArondtMBfTeFeGofm5z89InDg9Quyso=;
        b=PBRrAWJNEOVBAqEyu5TayH+4tg2416k+UO8F1+StA8sujREyaslFCHwh16XtSEUeTO
         u0xdel8n92Dx4qY/KAWh3EBUq2egi9nOmE2aUNaH+e77x0n7EKOdvv89O+1EU5+luCEJ
         k3VzjdhKBQnkwtaYjfME4hztsOUvqccdMHGILUWjfTUAXQItiAFPws04NDVlxoSrpLir
         H9mA5fedN5acV0DyaUn0ah/Pu7U9eGxxSL9OlD4KovocXAzohWyeBfx1J/s37C07giwc
         OBkoQtOaVAfoRm5HfsGHkRF3SX2oiRx1E2HXgsKLO3BEfMB54+wh6nrPva6eoEzgmlk8
         yzMA==
X-Gm-Message-State: AOAM530zQP16sW5lP7atb46I0UvNszLvjTupfndHPEhhtRI5Piy9H6GD
        YcPrb2gURIcxF+o9nXNzAcw=
X-Google-Smtp-Source: ABdhPJwisJ3x1kHWTtiWCMY3vxohYL3a96jzmxeDizqI2/hg4njRAZvIB1oxUqoxOrT/J1azaCMfmQ==
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr5656161ljc.113.1592854265047;
        Mon, 22 Jun 2020 12:31:05 -0700 (PDT)
Received: from grain.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id t13sm2868087ljg.78.2020.06.22.12.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:31:03 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 268041A007B; Mon, 22 Jun 2020 22:31:03 +0300 (MSK)
Date:   Mon, 22 Jun 2020 22:31:03 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, dave.hansen@intel.com, yu-cheng.yu@intel.com,
        bigeasy@linutronix.de, hpa@zytor.com,
        alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH 21/21] perf/x86/intel/lbr: Support XSAVES for arch LBR
 read
Message-ID: <20200622193103.GW134822@grain>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-22-git-send-email-kan.liang@linux.intel.com>
 <20200622184937.GV134822@grain>
 <3492fcad-344d-174e-7e38-46f2e543b065@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3492fcad-344d-174e-7e38-46f2e543b065@linux.intel.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:11:07PM -0400, Liang, Kan wrote:
> > 
> > The goto and "return" statement before the "rollback" label
> > looks pretty ugly. I'm sorry I didn't follow the series
> > in details so if you plan to add more handlers at "rollback"
> > then sure.
> > 
> 
> There were several handlers when I first implemented the function, but they
> are removed now. I don't think I will add more handlers in the next version.
> I will remove the "rollback" label.
> 
> Thanks for pointing it out.

This could be done on top of the series of course, no need to resend
for this sole change I think.
