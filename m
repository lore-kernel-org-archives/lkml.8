Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FD9C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212C520786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVX4yLyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCXLGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:06:41 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55417 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXLGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:06:40 -0400
Received: by mail-pj1-f67.google.com with SMTP id mj6so1324705pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W2zZIBrFIUdIwJtiA0rHIIgEIRNeZEGmX6yVzyUZvcU=;
        b=oVX4yLyb5aLdnDPwC6UADVmWbjxBpmsWAqZNIVQkDWjtUja3ZmwH6bPKE/lhYj1E+z
         KZHq73DSe3wsRdhB9iQwRmYAzFvLXQW0h9v8Q86SqDWGvMKkJ7p0aN05ttV0BPbHXXmb
         EW56hwB8e8dgWPV2NLU8m0mvyOFwbsTqiyDe/Jie768Nr64T9YbDj5EgYlgPShbhyyhe
         aRaWjSdG+i0mA6veN8WOGvvUr2K8jaxFuLzkz9V51b3ue0nq3qNeCL91Ram/rNqzFdaq
         9YSADk86aYG33/NL+L6aNw4kyS2HnEhF5skYdNoV87DNAuB+R9diYHZcOzYZ8R7XxaRe
         qNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W2zZIBrFIUdIwJtiA0rHIIgEIRNeZEGmX6yVzyUZvcU=;
        b=ircoqlsa4cxM3IA4LTfKxM3du1rKgHXTpgSkpuBzHPX0s1qR1+qIkE7G6vMRoKnL9b
         ovLRtdl1DiR3k3K6piNnX0d+Vo8o4MKZp88F45xg3TmYs/m2j53yVYlO2lQYet+7lTCW
         icaXOooTa2pGf0ZXRVenL7xi3N14rYzGFUGqGlSmlMFKmqYc1AFSApEnNK0BXOLcEhG3
         wMx4dWBSz+ehixhOS7LIqVuUoqUatU6XQDypQQ1v6tPkSQ2UgFV5V1AnGD6C2wi72FDY
         zyRs4dw+S0il8BvF2Gth+fTI9kgcXiwlHTcPN3wjFPO8cIOvursPHXke4s2uWLCj97Dn
         UOFw==
X-Gm-Message-State: ANhLgQ2tD6t5NzHdcBrebPiPrqr5dOQOz1jV2TvjFpU5dfXPgVIeD4Fd
        aFgMFB0dFv9qY/6LqTJ5rTo=
X-Google-Smtp-Source: ADFU+vukAws34i1riRLz0FLNUO0kB8kxFAaHg2peUeXCCNis1uXRRG22cmYupdWicicN+fxtnlNVvA==
X-Received: by 2002:a17:90a:e003:: with SMTP id u3mr2981827pjy.157.1585047999939;
        Tue, 24 Mar 2020 04:06:39 -0700 (PDT)
Received: from localhost ([49.207.53.57])
        by smtp.gmail.com with ESMTPSA id g7sm1997709pjl.17.2020.03.24.04.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 04:06:39 -0700 (PDT)
Date:   Tue, 24 Mar 2020 16:36:37 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vitaly Bordug <vitb@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] powerpc: Replace setup_irq() by request_irq()
Message-ID: <20200324110637.GA5836@afzalpc>
References: <20200304004746.4557-1-afzal.mohd.ma@gmail.com>
 <20200312064256.18735-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312064256.18735-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael Ellerman,

On Thu, Mar 12, 2020 at 12:12:55PM +0530, afzal mohammed wrote:

> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

This patch is seen in next-test branch for last 4-5 days, i don't know
exactly how powerpc workflow happens, so a question - this would be
appear in linux-next soon right ? (for last 4-5 days i had been daily
checking -next, but not appearing there).

Sorry for the query for this trivial patch, i am asking because Thomas
had mentioned [1] to get setup_irq() cleanup thr' respective
maintainers (earlier it was part of tree-wide series), check -next after
-rc6 & resubmit ignored ones to him, this patch is neither in -next,
neither ignored, so i am at a loss what to do :(

And i would prefer to let each patch go thr' respective maintainers so
that only least patches has to be sent to Thomas. Bigger problem is that
core removal patch of setup_irq() can be sent to him only after making
sure that it's tree-wide usage has been removed.

Regards
afzal


[1] https://lkml.kernel.org/r/87y2somido.fsf@nanos.tec.linutronix.de
