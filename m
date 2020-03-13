Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F0920749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8qn0HXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCMMbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:31:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:31:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id n7so5174872pfn.0;
        Fri, 13 Mar 2020 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=my1mJMBjpAuaeGSvw0SxMND06S47n3/Oc+SHOgjITE0=;
        b=t8qn0HXzdWqkby4uskVv47cSnhlPXSwmzZXiMjoZ+Gm7BU0Xt5RHSf/bC/cu1Yo2Ry
         5SN1Ipr3Wrj5+25iLlB9lhO/GV1ZwLTSI/jNBmYNyDPW0wUGMKaqcNNIqU0bPFtvMM7N
         tx8TLI0eJmEYL38MtaarAT7lT0L9QWvep6JSXSXfpJYRPwiVjvqff8Fu3iYLjLGaRaxy
         3vb87qQ0ZYOtxnk5z/5Aa3foVVySfKwG5gmWFK3ErK0gf0jxocQ1OQPXBb0IsU1J3PhY
         vbTqcIgWfNOc3y3emNoKypaKtc2AU+dTMtVOsAt/ldyQc+521r9CAJoZd1DLo6AELq7e
         yjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=my1mJMBjpAuaeGSvw0SxMND06S47n3/Oc+SHOgjITE0=;
        b=Om6tVW59/dqYmc0OpuJ+JU3137aCNP3Ebvafu4zwhWh6WshVjb85xoV00L5Nwdn1jc
         JOk8srhVFQqe+BCnTxFFIJR+aYxQ23dfFFKQl4Lbge+ItmBeCKQnwuhS7iG01pkfUG45
         N/FvoVdDho5BRrIxi1LlW3HERy7CxBPhmt+BHU87+IH/0AH2J6RZMfcG/05uQRYFAQuQ
         3uHpU9Kw3Pb4IfGyIZNPajEWhAL6c/PbJoN5WH3AJnGBHcWC6hxV7YT6dY9UlnEYR1zW
         bTQNHqK8Sffyhbm21ifzXqTN6Ys83TffKhgT0MXU6U/QxLLXGSbuK5IzO1KXMnQbQIR0
         K7Mg==
X-Gm-Message-State: ANhLgQ3Orm3dU4FjV/52NwBjKXg0z4VHy3xuD3gMByrWCwqVAzsvcj22
        YOA6PY0FgNlZC5+DPtKFD4d+cSnB
X-Google-Smtp-Source: ADFU+vsbOyAL+G1lTCTWBv7v2qzzHSK3F7e6gScJM4Koy0MlzUIc30wvRynV8GMVChz9ETO7ajZjyQ==
X-Received: by 2002:a63:257:: with SMTP id 84mr12623548pgc.304.1584102703406;
        Fri, 13 Mar 2020 05:31:43 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 184sm24898646pfe.11.2020.03.13.05.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:31:42 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:01:41 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ia64: replace setup_irq() by request_irq()
Message-ID: <20200313123141.GA7155@afzalpc>
References: <20200304004936.4955-1-afzal.mohd.ma@gmail.com>
 <20200308120350.19117-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308120350.19117-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony Luck,

On Sun, Mar 08, 2020 at 05:33:49PM +0530, afzal mohammed wrote:

> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> Changing 'ia64_native_register_percpu_irq' decleration to include
> 'irq_handler_t' as an argument type in arch/ia64/include/asm/hw_irq.h
> was causing build error - 'unknown type name 'irq_handler_t''
> 
> This was due to below header file sequence,
> + include/interrupt.h
>  + include/hardirq.h
>   + asm/hardirq.h
>    + include/irq.h
>     + asm/hw_irq.h
>        [ 'ia64_native_register_percpu_irq' declared w/ 'irq_handler_t']
>  [ 'irq_handler_t' typedef'ed here in 'include/interrupt.h']
> 
> 'register_percpu_irq' defined to 'ia64_native_register_percpu_irq' is
> the one invoked by the caller, not the latter directly. This was done
> to support paravirtualization which was removed around 4 years back.
> And 'register_percpu_irq' is invoked only inside 'arch/ia64/kernel'.
> 
> So 'register_percpu_irq' define to 'ia64_native_register_percpu_irq' is
> removed, instead 'ia64_native_register_percpu_irq' is renamed to
> 'register_precpu_irq()' & it is directly invoked. Also,
> 'register_precpu_irq()' is declared in a new header file 'irq.h' inside
> 'arch/ia64/kernel/', this header file is included by C files invoking
> 'register_percpu_irq()'.
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Seems you handle pull requests for ia64, if this change is okay, can
please consider taking this thr' your tree ?

Regards
afzal
