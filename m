Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CFAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E5D20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojh8bW7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFBTN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:13:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4830DC08C5C0;
        Tue,  2 Jun 2020 12:13:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x207so3661034pfc.5;
        Tue, 02 Jun 2020 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LG42b/Qu7S4z1FTwve/Hp1RSuRTRvu7/8DqPfI5B60=;
        b=Ojh8bW7DZRAgKIWWzp6pGQ2QV6jjh+JjNMLOzetekGch+0a0KWph8S19BObPX5hYMz
         LYATTGS2kD1i1kT5hTLz2kq9zsy+JD13JjGDDB2n9pXsQLBz85wG4QeE03W8GpZG/F2i
         Cll/JJEpgTrM6a3eevP/qZ44gNynEH5ezV09i/ie06JP2jKd6l70qTdD6/7CpVuvD3Og
         Db9EvfPmSygjN52eagN65C5WO+j05T9dk87OSkWkRhnlKYJ19hH90M0NUNBGyZKNW0MS
         /19N+ix4Y+DzviRnfldHPYvJ6BS98Igosc5m/Kutl80QIHD8T3cvx4t4gM3Zo0Dbyr94
         XHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LG42b/Qu7S4z1FTwve/Hp1RSuRTRvu7/8DqPfI5B60=;
        b=lTCd8sPVnbdRbL3+Rl6GOVdwJsBpg3ZjeIsF3z7YRJhAOQlMPE3xlv/Yjxxsmj5OAN
         nhoPIy4hHD/YnAyop3E5AhJorGG+JAWyAcDEj+29sRMwTPilBPIxC5PbjanhfPcnRpdX
         UUmHsVDGCz4fFoE9bXklgygOTJ6jtR22qeT/DEJrM2pUpTz/b2+WQdIbbtAltQmaDLLp
         EeC2ehDwSV4/+GW5vRUmsNp/KUFID5rBBvhfWUgsUafZRVnAfE6IIZtEGCRTidGyB2aB
         zKVPggrM+xsthhfMPXGQnsn5OvF8GrvGfn2f6wWSqOm121vepE5KHmlvKByJV/2k8ycV
         U/PQ==
X-Gm-Message-State: AOAM531TBkAU5d2NSJjGL8xHxEM860XWolhn24UhA6SY/JTpeRmtipTH
        aGWEhliy1fp1/rFvNztJVgCOwsEH
X-Google-Smtp-Source: ABdhPJzjc0YkOuAjdjSpCaLB1BrVqwiSGMRgNR2TPUCVL9x9KJkiE5Z2KKbTTXbNOHXTPgMZ5I3Ltg==
X-Received: by 2002:a63:40a:: with SMTP id 10mr26009775pge.310.1591125237939;
        Tue, 02 Jun 2020 12:13:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14sm2693076pgn.83.2020.06.02.12.13.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 12:13:57 -0700 (PDT)
Date:   Tue, 2 Jun 2020 12:13:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.6 000/174] 5.6.16-rc2 review
Message-ID: <20200602191356.GE203031@roeck-us.net>
References: <20200602101934.141130356@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602101934.141130356@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:24:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.6.16 release.
> There are 174 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jun 2020 10:16:52 +0000.
> Anything received after that time might be too late.
> 
Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 429 pass: 429 fail: 0

Guenter
