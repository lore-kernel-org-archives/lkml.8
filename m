Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8981C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A5C2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdVUML15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgGXHPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGXHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:15:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B055EC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:15:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so4570931pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xY8I4pf+pixvGdggE0GUWeMOFhv+/4UQbvE/fhfVRRE=;
        b=MdVUML15EvCtvB6RqedwgUH8PVDTER0vLv8exMiOSppxNU0hMnzjWPGJ6+yIPinPYZ
         USMtfYMe1Mg29OSkrh4+ncgGKoqUf84HHFMiEPNMzhqXURCJiPAj5BgUTw3nEcuSF86g
         7C6FeFA6lrdsl8WHJFwLbhhyj2tsvkDYn3GVORm2/d2ip4Du5uYld5CXGgab69JjqhrZ
         muU0epdnTXhd0Dfb5/cLq1onDvFinndst+6Kp+DonqBnXszXDA9pkkm4GADjVAseyO8u
         sx/YaSYDsGCQhqSTK52A3mUR6kEQmQIvRpMVU3mx5vI3YUZEx2Ac8SKDC+7w0ExpHkND
         j1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xY8I4pf+pixvGdggE0GUWeMOFhv+/4UQbvE/fhfVRRE=;
        b=dJp7uxe3GN4u7WHEOynMvL2/lPsGlMKz6pyeIEbzu1RDTW3USB/XCJQZM9DjRa2AkF
         JU7JH1jSpro9p6fqUyt73/W4EJtlbNbV0Z2Ptyf7Z94E8NomG2IxRNXOUo+fqwPVrZkj
         a8+wa8B/Taknjwk7rxA/hKJPG75nIdlwszNu8UHsLhZlw9rglaauljbNRA88nh/hc9Sr
         BQ5yfKtLxpOadpKsXv5mHl5DLKEcXpi3GYBGw3PgE+hbYSL0hRSdAv4BI0tzy51uTPUf
         ejtTox1YK9MqM4OFuT8K57yWqstUGl0OmV2qxWQiL3/pxOKVDJuVb3nE15gL/c0Es2nJ
         QyVw==
X-Gm-Message-State: AOAM530ntLWVf4am4Dz7Tqpad/teN41ze3nY8LcsqnpnDJrv7P2TEkxS
        awM/fXy4juinYDf/5AkluIY=
X-Google-Smtp-Source: ABdhPJy9XNSqdDfyNmh+cwRYlTex+cdfMsnGlG5GORVDB7ZAgLE5ksaLMF8GUDkGkGSqsaowboAnhw==
X-Received: by 2002:a62:a20d:: with SMTP id m13mr7914886pff.201.1595574912239;
        Fri, 24 Jul 2020 00:15:12 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.67])
        by smtp.gmail.com with ESMTPSA id x3sm5100680pfn.154.2020.07.24.00.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 00:15:11 -0700 (PDT)
Date:   Fri, 24 Jul 2020 15:14:58 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: Re: [RFC PATCH 09/16] sched/fair: core wide cfs task priority
 comparison(Internet mail)
Message-ID: <20200724071458.lah33iacywx35hdi@aaronlu-desktop>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <2d0e3da8c80c314048d598fb03ae3fe52d9619f3.1593530334.git.vpillai@digitalocean.com>
 <4229D3E1-8792-4B43-9AC4-F648D49CCC99@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4229D3E1-8792-4B43-9AC4-F648D49CCC99@tencent.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 12:23:44AM +0000, benbjiang(蒋彪) wrote:
> 
> 
> > +/*
> > + * This function takes care of adjusting the min_vruntime of siblings of
> > + * a core during coresched enable/disable.
> > + * This is called in stop machine context so no need to take the rq lock.
> Hi,
> 
> IMHO, it seems that stop machine context cannot guarantee race free. The param *cpu* maybe not *this_cpu*, rq lock should be taken even in stop machine context, and irq should be disabled too, to avoid potential races with other contexts.
> 

In stop machine context, all CPUs except the active ones are spinning
with irq disabled and in this invocation of stop_machine(), only one
CPU is active so I don't think race is possible.
