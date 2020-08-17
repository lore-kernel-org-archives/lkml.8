Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EB12078A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHlkQh/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHQCDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgHQCDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:03:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7533C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:03:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so7442066pfl.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g5HDuGeUVDk8sqM9/o9Q4NUmETeOwP25OuVRGMdbePY=;
        b=UHlkQh/6diYYltxpDHOf9F6jhol14EbQYUrpGuhjvkcO8jon5uiJ4TImBdetaDSwv2
         XEawf1DrPtHMEfmKHTXnLkZFvqmqbO8rYrd37X3aiOk8vBrEoWL+G94nVoT5aJsXmQsm
         Go9KlFt4aN3b9hWucnpcRpB/NQcLN+vX0Rd/Kk2MiJ036vl7dnnQ5XeO7DpTKnnqG2qU
         dsifEdi4HLaQk8lmm5b++5gcyTKSwaKiXkqPnyUKhJs4NEYLhAzQCN8n84QpQZDV3p/u
         7wtsBbqByBqeEXfd32Q33LqFtpwduLcrA857QLGv4wcraYoxWiGFxmK/u0O2z5OTkvzn
         d95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5HDuGeUVDk8sqM9/o9Q4NUmETeOwP25OuVRGMdbePY=;
        b=Tu1+xEHICBolinz2+WAqApMUwGL4kW6XMxOVaWVTRrW8Mlyf/OmgphDWNDyHPgN+FC
         HPAolGLwX3qzaXPBK1g0qTQjweR/s0HinsNEaLsdI8aYOQJxNWR2eIuSoi+LQOzyvSrf
         ibNM29T9loAdzQxJDT3KvuZOQgtJuVbaZDs9ISOFUEh711PPkPYU81s6xlxOrkfC+fBO
         Azdjxo9GEad23Sfk7DeYk/BU4PptKSp0fki8ncR2KBIDrwW1Wzuo7265FdASnoxPVlPQ
         jqxVit9qspslGV7MixDm+iKuwkBN4xaq2SeRHAz9RHOS56tIEWZbPsz+F+rwG3FxgECT
         oW0w==
X-Gm-Message-State: AOAM532w3U95Q3q839VjL9Senpwy1sfWeNqJAH85H36V7zBaqFdVJXM6
        lRdoNS2KxjPiufR/uTxazCU=
X-Google-Smtp-Source: ABdhPJwQc+l1piKsFZa/qTebQhuu4bbc4URcZ9WtR1gAqur0rzEPvsvBexYaTUpz1Zlk7YJhLE+qJg==
X-Received: by 2002:a62:2c0e:: with SMTP id s14mr9881030pfs.289.1597629791959;
        Sun, 16 Aug 2020 19:03:11 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id na16sm15433091pjb.30.2020.08.16.19.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 19:03:11 -0700 (PDT)
Date:   Mon, 17 Aug 2020 11:03:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        suleiman@google.com, joelaf@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
Message-ID: <20200817020310.GA1210848@jagdpanzerIV.localdomain>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/21 13:17), Sergey Senozhatsky wrote:
> Hello,
> 
> 	RFC
> 
> 	We noticed that in a number of cases when we wake_up_process()
> on arm64 guest we end up enqueuing that task on a preempted VCPU. The culprit
> appears to be the fact that arm64 guests are not aware of VCPU preemption
> as such, so when sched picks up an idle VCPU it always assumes that VCPU
> is available:
> 
>       wake_up_process()
>        try_to_wake_up()
>         select_task_rq_fair()
>          available_idle_cpu()
>           vcpu_is_preempted()    // return false;
> 
> Which is, obviously, not the case.
> 
> This RFC patch set adds a simple vcpu_is_preempted() implementation so
> that scheduler can make better decisions when it search for the idle
> (v)CPU.

Hi,

A gentle ping.

	-ss
