Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC554C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975E5207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK69Co/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFLIKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgFLIKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:10:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F9C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:10:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so3546879pje.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FrBOISxwKyWg3yFgNawz44Si/Jo/mcOoYEJcWJFfVoU=;
        b=ZK69Co/lXBcRsFD7SUsxis7MvrrcFiGb9wXzfn7QAfqobBYK9JDAVVUXXpRpFHMLg0
         bvEppJLtKU+QvKbxuYgo0rxwsXP9WiA9uF0rGQy43dpzucJAnjc2IyzVcZ1ElnYntB7l
         ATrDNsHmMMemgc2y/R9TU7A9JQ3Ve8RNKb8SnaShfdenzGbXzILlFzjWK9lvsREaci4G
         VYteP+8a1FKn/dMhPPSzX5EuZSXt2zkupMCmExVRxk+qmMa3SQ8qmPp74Y8Ln/IZJW5M
         g+BVoCzM2yWQoUraZtQxS5HGxkw+Jgl24vvTzDytIgPnaEyNS+OHC2lqEYxJlor1u0zK
         Q1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FrBOISxwKyWg3yFgNawz44Si/Jo/mcOoYEJcWJFfVoU=;
        b=RvHMm+vBBcACqgn5EMhZYeESQ9FH9XnJdeeoe/sByGEVuuadPjnaStCnAf7E/5BQQE
         5BOckRKngiF2FrvzirjU3SZibygFhHkreTRmxL9UVldWvArRutACDv6iAs7vOUlhVEh8
         vt1sAmrdohwxaIRHLWnhKfajEUZaGSElepn5pLip9ce0yYragNJ6/SwaznOYlTiFOnzU
         6OqlbsYJyrsF4Y3j/FkTSzC6ZUo7wFM7jxhdMTmNlqrVbdQ6+/eVlqX+byA2udJH3Pv3
         QjCQkvLmxTQzXd3Zp+kAVtJ95+23pZ4PVv+TMLNwiZq1kkbjLyXzHlvi6gurofligxwg
         AmnA==
X-Gm-Message-State: AOAM5329n64ymo2cUTT/EpSix9OJZLDFrE1zEB0zXHYEuhYHrFzb25HE
        J6ueJ1Buno3ge/KteRvYfE8=
X-Google-Smtp-Source: ABdhPJyS8XQ1B9/rurFHEaifuL86DzzigqQvEbE5slis0FR6ePbWM33oVYWhL/dvgVit13H7C4fJKw==
X-Received: by 2002:a17:902:bd09:: with SMTP id p9mr10817945pls.214.1591949409605;
        Fri, 12 Jun 2020 01:10:09 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 191sm4484589pfz.30.2020.06.12.01.10.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 01:10:09 -0700 (PDT)
Date:   Fri, 12 Jun 2020 01:10:00 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 4/4] ASoC: fsl_asrc_dma: Fix data copying speed
 issue with EDMA
Message-ID: <20200612081000.GD22422@Asurada-Nvidia>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
 <424ed6c249bafcbe30791c9de0352821c5ea67e2.1591947428.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424ed6c249bafcbe30791c9de0352821c5ea67e2.1591947428.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:37:51PM +0800, Shengjiu Wang wrote:
> With EDMA, there is two dma channels can be used for dev_to_dev,
> one is from ASRC, one is from another peripheral (ESAI or SAI).
> 
> If we select the dma channel of ASRC, there is an issue for ideal
> ratio case, the speed of copy data is faster than sample
> frequency, because ASRC output data is very fast in ideal ratio
> mode.
> 
> So it is reasonable to use the dma channel of Back-End peripheral.
> then copying speed of DMA is controlled by data consumption
> speed in the peripheral FIFO,
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
