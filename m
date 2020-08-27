Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC092087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/LX6jW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgH0Qlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgH0Qle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:41:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761EC061264;
        Thu, 27 Aug 2020 09:41:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so3752598pgh.6;
        Thu, 27 Aug 2020 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bliB1023sdj3aVwTJNlYRjd1ewQEAeyLSLCuQayJAjY=;
        b=O/LX6jW3Q1owUemH+ORqZxREhcmC4Tf9sc59qQUxz1eV6D1PEexrtS7HKA9gDAAwN/
         6ZjPIAANWXCGdm/GhZKZ5Y34UVp2agMfpeHcQrSegriMLj3RxUxQTpqQjtAcascxW5z/
         UaDYdM8dNMbL7RycsDJVxvNGtnPq5QG2GTKLeCVc+JphNoz2c6Ev7slanxLt2Brz5LeZ
         y3uedDiM9SWIEBPjhtKaJuJ8t0tU6ZV618y3qNN6N2x+pfAPw4Tqb4tRktEjhaQqtinP
         WhXgJt1e6rWMKe5S2dNIMomtIWAVFYWqXSrkubOm5Nt+S3OMvZ1z1S0ghGRIWxQkwCyF
         8yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bliB1023sdj3aVwTJNlYRjd1ewQEAeyLSLCuQayJAjY=;
        b=sxPBFhsQYZCmRN4sg5/4M5++dy9recofmFOf7dGKjC/73Za9sL6tWcrfnqhXoq8Ohl
         BbPFyHsijJ73N5E4VQ/U+dDfD0kTwu1c0JxdV8N2nFC98CaIk0/zG5TGprxrYIoNSGBi
         t2BdaG36GMcrJewztj7MfFJYv9DKQKfUn8UoW64oyWuyxw7d8J6IvvCEbndmkAgbT7PF
         VphiUCfNplJtigPGwt2DVqTrg8oUaIfyWiDjo/ByLhcX7WRPFJ4xeVizUHeBGTyq6GoM
         yB/nqQnS98vbPc7Z7YvQ2VXPq0dr80l8xHw8ukxfES2j466C/l0GIzXAZNZ63k1494Ta
         FbLg==
X-Gm-Message-State: AOAM531He9JmoLalw/Gi+qRPOjxABvOng9LpVC5VBQh/kJ+a4EMRnZP4
        +B/44fYmWjxZVcz79PJaEXKNqjNxCaE=
X-Google-Smtp-Source: ABdhPJzxsq/DfBtHgBlz3wlVDsTjBSAiejy26z59L26K47Ecf5fOnNwebJGKqFdOnEwaXfRIPFwAvw==
X-Received: by 2002:a63:1521:: with SMTP id v33mr11635537pgl.374.1598546493237;
        Thu, 27 Aug 2020 09:41:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a200sm3356631pfd.182.2020.08.27.09.41.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 09:41:32 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:41:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     cy_huang <u0084500@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, heikki.krogerus@linux.intel.com,
        cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb typec: mt6360: Rename driver/Kconfig/Makefile
 from mt6360 to mt636x
Message-ID: <20200827164131.GA86149@roeck-us.net>
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
 <1598527137-6915-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598527137-6915-2-git-send-email-u0084500@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:18:56PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> 1. Rename file form tcpci_mt6360.c to tcpci_mt636x.c
> 2. Rename internal function from mt6360 to mt636x, except the register
> definition.
> 3. Change Kconfig/Makefile from MT6360 to MT636X.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  drivers/usb/typec/tcpm/Kconfig        |   6 +-
>  drivers/usb/typec/tcpm/Makefile       |   2 +-
>  drivers/usb/typec/tcpm/tcpci_mt6360.c | 212 ----------------------------------
>  drivers/usb/typec/tcpm/tcpci_mt636x.c | 212 ++++++++++++++++++++++++++++++++++
>  4 files changed, 216 insertions(+), 216 deletions(-)
>  delete mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c
>  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt636x.c

Maybe Heikki is ok with this change, but I am not, for the reasons
mentioned before. So I won't approve this patch. Note that, either
case, it should be merged with the first patch.

Guenter
