Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F891C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D00D2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsCjYmj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgHCLkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgHCLjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:39:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC125C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:38:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f24so17771237ejx.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O9riAtpnZsXZYMYAWZXHUomxas17kKt30ViN9Unzczo=;
        b=IsCjYmj0HOsxFKkAst1v/bphm4A5sTZ7/YkW4N/lJpSsjiQq83cc+0k8rHp9Z9nCpK
         6l3Aau3/3hwoV8mUXLftvezQpRaQwVZfSoQdO8gogYgcAgatTwHgkxZr6ttwc18mEW73
         WomPmAmpNCGi+ecWT/2xP0PLEVh2GEHpBRjXJ7pVUetBapN9FhS590UX1qzbCxM4+oos
         QPeemvHbx/U8dIV00cvlFo81gmlbyHy+WjvYuHlJAXxRLHBLooyHQK87L3m3AH41rDfg
         s85/IKGa58wkA9ZYsGVQHlPzlmFFcejEZGt05FfaHFnolVVKjJ/o2q2tdUM+XygycIBp
         OBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9riAtpnZsXZYMYAWZXHUomxas17kKt30ViN9Unzczo=;
        b=rqqFl/fjTVU3rJlz01DWMyxGoov+htYYi9cx+tMzaJ7c/4Ld41sdHNTqSuuEBPbpnB
         NHMeyZ+6YmamfcHHxjO8Pu7BaaQGY4O+h7b/uhH5WD+H3yYxKZ3oGBfA3YmPPOPbTpXU
         fF7kyRnDaPWXLdC9zsY3db2qsquq049SgTphEVDsg+DK9yI6z6TrJOJEMLf/XoBSucAA
         RZlARUpHSN/WlahJXJUUTjbSeHVxXBI1oMnoJLNa2i6u9Dcpzn568/SvujrCES606ict
         GLBhClb3AJC0uibc79EvJH9AWdlvvj043mpi/8FElBkxha4gqvT7CkvenS3dtoDLQwAL
         T3yQ==
X-Gm-Message-State: AOAM530aqRUYDj72H8dtb23qyYrQ85hDNytz3t41glri0zgoJr+aJVhB
        5as8yWyvlH6EBnXDlqBDR+0=
X-Google-Smtp-Source: ABdhPJwEP/nxFwmTpcZmgyAgKks+9LKeFj+7d4EN+YeK+eEOf+CiYvpzO8b551KWI4U04pjsa2Rg1A==
X-Received: by 2002:a17:906:1414:: with SMTP id p20mr15698545ejc.247.1596454724868;
        Mon, 03 Aug 2020 04:38:44 -0700 (PDT)
Received: from skbuf ([188.26.57.97])
        by smtp.gmail.com with ESMTPSA id n5sm16087952eja.105.2020.08.03.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:38:44 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:38:41 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        paulmck@kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>,
        catalin.marinas@arm.com, Alison Wang <alison.wang@nxp.com>,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        vladimir.oltean@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
        mw@semihalf.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200803113841.pqqpo4hqfwru3upq@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com>
 <877dumbtoi.fsf@kurt>
 <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
 <87mu3ho48v.fsf@kurt>
 <20200730082228.r24zgdeiofvwxijm@skbuf>
 <873654m9zi.fsf@kurt>
 <20200803081625.czdfwcpw5emcd4ls@skbuf>
 <f61560f5-c4e0-a40b-5845-af3f6d98c7ad@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f61560f5-c4e0-a40b-5845-af3f6d98c7ad@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 10:51:32AM +0100, Robin Murphy wrote:
> 
> Having glanced across another thread that mentions IRQ accounting
> recently[1], I wonder if the underlying bug here might have something do to
> with the stuff that Marc's trying to clean up.
> 
> Robin.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200624195811.435857-16-maz@kernel.org/

Thanks Robin. I've applied Marc's "[PATCH v2 00/17] arm/arm64: Turning
IPIs into normal interrupts" series and the LS1028A I'm debugging hangs
in absolutely the same way.

-Vladimir
