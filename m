Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40CEC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A2920639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529095;
	bh=+aCesZvNxMYJVUX1yJDY4XY+cGFCNW61nA046OfyXsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bCAm/rUTx0eaaFOHcq3wXLQ93uGuR4g6k7y2/XL8S2yrkGkf35yFf3yPxESCzezjW
	 Hz7bcRRPX6RokVdeTICgOk8IYc8rGBcVknU0Vzy9sXM4GYMkiQQwYVqqqER5YQa9WZ
	 XDIXRp2X1z0d0JxqCqNeTC64SZ1i2UMyDD3BCx0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgHOWEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgHOVuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E60C008688;
        Sat, 15 Aug 2020 10:09:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so10994535wrs.8;
        Sat, 15 Aug 2020 10:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=029UH3B1a9Lf0jL+nGrPJWLfG2l0sqy5BcJufnEFRSo=;
        b=kfx/scPTYqEZ17u+ZFYo/wkli9c1602Eer/O88A9MASU/rJP3AEPexy218pL0WUJH7
         AuKP62sIMRIW+iqc9N18xUsyqZsGIwldexljmnd+06UmvCnqBqmRalou/IFBdd1iVbU3
         WUmpF6JFMlQcq6yRIpBI4IYmvKuumYcvesugBzbe0lkvaUU/7nbJ2G2wCDtTXTAM1Xcy
         Y6ofNi8o/VYFJKVkdycaYU1L36eAdhAlIRbVnnO3uhWwVnZqqzcXlRWNscckmajhLomo
         gSaVVfhR25jU0jOY72zMf5SS5mtRiPJ9z8161lt3ufLf4m52IpWtln8Rb5secVxHeFMP
         kEQA==
X-Gm-Message-State: AOAM5316gtq6MqmCtJTzV4t6DkCK7hN5Y8shdWbJDZ2n4yXOt2FXePT+
        lij/H4mil8J+PI+YNSOpQIc=
X-Google-Smtp-Source: ABdhPJz7Ays+EpnOkkjlDYLn2zhH8aBQpPRgvq1Kw/IIQOZykznexU2T++RMSld9txkKP52bTQT3QQ==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr7773149wrt.67.1597511342690;
        Sat, 15 Aug 2020 10:09:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f15sm24370989wrt.80.2020.08.15.10.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:09:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 17:09:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v2 1/1] Drivers: hv: vmbus: Add parsing of VMbus
 interrupt in ACPI DSDT
Message-ID: <20200815170900.5hye5xdnrhwlhwyp@liuwe-devbox-debian-v2>
References: <1597434304-40631-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597434304-40631-1-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:45:04PM -0700, Michael Kelley wrote:
> On ARM64, Hyper-V now specifies the interrupt to be used by VMbus
> in the ACPI DSDT.  This information is not used on x86 because the
> interrupt vector must be hardcoded.  But update the generic
> VMbus driver to do the parsing and pass the information to the
> architecture specific code that sets up the Linux IRQ.  Update
> consumers of the interrupt to get it from an architecture specific
> function.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.

Wei.
