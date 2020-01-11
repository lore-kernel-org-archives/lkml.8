Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA58C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0602064C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jPyxKfrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgAKBFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:05:00 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37460 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgAKBE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 20:04:59 -0500
Received: by mail-il1-f193.google.com with SMTP id t8so3265933iln.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 17:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oGchJ2QhW6lEKHr0EcwdcOBniXTxW0gJ/C9Tswq1R5g=;
        b=jPyxKfrPRhG1+zzESdjIpFwo7eC842EPfR2noA0IPLOvFMzR9A5QTsQO2cTEzmwA1e
         iSpf0VAE/ZA87u7BlrdSz/n4xual1ShORNusYdswkmXhlnLxFhYtzkyiHH3tcBGfzTru
         67jC+toBVemvSLle7d9azKvrwpbdnXCejMG8PlDAfQnHiMJulEhmZw7IXXpRDSYOhVC5
         W74Yi9O++enJJ7nukEqpfna7zY0Q0tlTAoaxjvKkZ3+h8IgZdAeY3V/CJ9s57gEwHCre
         SNhQOAmt+4X+PZNI/ULOOYlbtAwkHJogQbtNDgPAFAQdOCYJH2Llfs58mnVum5OsJBCk
         uv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oGchJ2QhW6lEKHr0EcwdcOBniXTxW0gJ/C9Tswq1R5g=;
        b=Vj6mdp+kk692LxWrauWSU2jL4O1kqWCOqA/+G1w7gDJDhi+GOhqd8SFjoPviUzcDqM
         9xPcxpM7OetkLfnR1poATiDgFa/2ayVyYujYlQSCnTR0rG0THEGY8qQlLk+woZv3KupO
         f2Qvr2X7Un/HYP81Odzx4kGatcTyQiRBSOEksVbORKH61pOcecAuAS+bu8FuLDjMxebY
         1FDqgWvd+Si9wUtDpO7/k8C5sYnqTrEjPzfkQLQmGXep+tMYFoTi0Qzv7VBDUVJ66jSl
         ugjPbhL22Bl6qXF856BXBHwOG9USE/fw9HUdXvG5tNxXHEtQDuxwqd8dSOKzbV4FLSpe
         hGmg==
X-Gm-Message-State: APjAAAVqDrneh1FOEMFOURBhbmzC5ZSNoo8y1tXqlNXw3J6jjLmnbRC5
        +7Tuh01z/Uz1OIHgZm0vAUPp9w==
X-Google-Smtp-Source: APXvYqzopQQofRLrTlQmFON2Y7R+LIl8tdlZalcACPY9NCb/x3as6rU2+Xn7Ke3eGOWVov5gfP96dQ==
X-Received: by 2002:a92:914a:: with SMTP id t71mr5417305ild.293.1578704699180;
        Fri, 10 Jan 2020 17:04:59 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b1sm1190156ilc.33.2020.01.10.17.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 17:04:58 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:04:56 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.h to include/soc
In-Reply-To: <1578463746-25279-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001101704440.32308@viisi.sifive.com>
References: <1578463746-25279-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020, Yash Shah wrote:

> The commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc")
> moves the sifive L2 cache driver to driver/soc. It did not move the
> header file along with the driver. Therefore this patch moves the header
> file to driver/soc
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Thanks, queued for v5.5-rc.


- Paul
