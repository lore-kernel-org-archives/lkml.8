Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C18C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5050F20774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="tPwEMj6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgDVPWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgDVPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:22:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B0C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:22:36 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h26so1651885qtu.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/28R1sGK3+4tkWRg1nQ9VN24FGuw/7gkVIffhG3ews=;
        b=tPwEMj6zwG6nfDpAp7JPbz5T8v5PSIyp1b6w5YDaBjAXhk4LUgl6MjkiOssn5gLYpa
         Bzto6WMYQVAv09/g7zeTF3vmYHV1SLdoR5oqdt8OaTxXrAbsgsRveFQWFFdKd4pSiQG4
         WsEkuWUcYjkdX3pZtIOG5gadk4WmWclJr6dmEfk7QRmgCsWgoux+7idDSLtawF8FFXSX
         cFJLeMXgoOBJombQDxlanDNi98FplO231+4UFrwwANzKIIbDjXl4JXDsxDF91eZ9Gnbz
         3vcgilyK91oZwJ+oq44GfUjo0p7czgVCeoj4PODN8lY59zWmGyd7mIkXc6sNePLJ/qSa
         uP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H/28R1sGK3+4tkWRg1nQ9VN24FGuw/7gkVIffhG3ews=;
        b=DWpTmyvd218VTu8oM8gXUzRGJVyGnbDWkLu41DRNeO51nmtFtnBAxJktIuQ94eB+13
         +LOWR40a+PmcBtrg7cIVd3KdwVPvowibaDKpCNOJamLyt0Wu34K3MsP3clFblT90mVnB
         c9LrFF5WdDuIcyuiFtd+TvhC+Gt3PZ8ydoTQw1mSjlfarn5d+vN6LjeqBSbIK7PQ1qSw
         eC6RlM4FYt96/NyzcoSEqwHcEvWE1sMY0K389AUbNbuotf/a0839akTfDN8TamXHLbdW
         b4O1+FcxuYf7aAWsrqin1sh/wcCV/3oZP7arwjPmzp0JA7ACF8zT2d4sep6L0JEJLVPB
         JrfA==
X-Gm-Message-State: AGi0PubRRl3HXfEDQFljfurPPF3kQeQrMqyaaxsUDBOAra+b7H8/+RED
        oQ2i5rlv2Utu1uV2/DZza7VPbQ==
X-Google-Smtp-Source: APiQypIbqYykracNUBS2hJnE1z0ti85yeHPuSREdDKsUOf4gxNUml3Hx7QVKjiauiPVbl1sJfzh2Vg==
X-Received: by 2002:ac8:3459:: with SMTP id v25mr24798077qtb.229.1587568955220;
        Wed, 22 Apr 2020 08:22:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id e133sm4051525qkb.128.2020.04.22.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:22:34 -0700 (PDT)
Date:   Wed, 22 Apr 2020 11:22:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH 21/23] sched,psi: Convert to sched_set_fifo_low()
Message-ID: <20200422152233.GA364282@cmpxchg.org>
References: <20200422112719.826676174@infradead.org>
 <20200422112832.465990342@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112832.465990342@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:40PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively no change.
> 
> Cc: hannes@cmpxchg.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
