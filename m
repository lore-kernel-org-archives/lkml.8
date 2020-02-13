Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6CBC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF3D21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+H8BR2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgBMRm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:42:29 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44663 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMRm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:42:28 -0500
Received: by mail-wr1-f47.google.com with SMTP id m16so7728700wrx.11;
        Thu, 13 Feb 2020 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1rRdFx88pI/kxSZV4027SuKrkg3wbK/X0SSnP/KD1KE=;
        b=P+H8BR2W3RXELrDqPMn0NrlYbRqq4Qgn6+zGWwNidnOXP0b1DY/FXHlEdGRQuh/yGw
         F2AhqH7cxR+UwKjp1khl50vLmDTpu9IJSu0jokLipd6iH9IsPwbZIU8LUAWxKX5o/dg7
         2iS9yuz0snKF7iCf+JQ2NxRGqRIM2tEsRLuPvStkKH9ExVrtT24Q9pUAVRpyiaZt8raL
         R9P9I5ZIOylTlJ7rAeHMUby093U1ZapfBkC3jT2YSpDiM0P9+CYiJfDWfgsJaP9iO3BK
         2bVQOMnBlxaEmV04YSSAVwb/nitdRWj2vE8APKmEsFINeMBod8p3cGmcnVmRZsnys3ag
         tDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1rRdFx88pI/kxSZV4027SuKrkg3wbK/X0SSnP/KD1KE=;
        b=ST/43ajjCGgICrpjJJCal+nzIi8I765N9OBGX/1rBGEMzS1XMVdScAoK1D9QXr1Bha
         0zjr/QJLYDTP/3mk/T+5O6QtAA3OSNBXVA3Or7aa15DedqoTzGXkt6A+Cp60Ixo7gjof
         Z8ajeTtF0i8xuVF1voCLgjKNb/jFFPKwWtB+1DJmfmcnHdPgcfBGJjoCpsWjUVVqtLZh
         xZ9FRbGMWE8H1ZT7lO8kFjVrtL7nQ3IS7+/yb0ziF/DSsx9iXDTKEx1FAuLX6jy7JNwe
         /kYhShZo+BPysrymdR3K1xyco5ThlpSrMVF/uj3hHk1VS9o62CEXFypWqFkQre7J00zD
         UHVA==
X-Gm-Message-State: APjAAAWZRVY6iiqjm3ck5nSYfQNoijdQmYZyK9yOEMmkQb5vUai/f+in
        a0Uzqz4fjpb+6V3+Fub6YyqDQCibd1EP3g==
X-Google-Smtp-Source: APXvYqwy6WSPQoTbxPJQTZm66lOXl/OPjwf0AvbsjmRs/L5giK3yDroCWzZ/PI8TSyETBJUKVjR0pw==
X-Received: by 2002:adf:e610:: with SMTP id p16mr24400302wrm.81.1581615747372;
        Thu, 13 Feb 2020 09:42:27 -0800 (PST)
Received: from localhost (ip1f115f16.dynamic.kabel-deutschland.de. [31.17.95.22])
        by smtp.gmail.com with ESMTPSA id w8sm4003167wmm.0.2020.02.13.09.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 09:42:26 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:42:25 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: clk: imx: clock driver for imx8qm?
Message-ID: <20200213174225.GA11566@ripley>
References: <20200213153151.GB6975@optiplex>
 <AM0PR04MB4211AC5AB9F6A055F36040A2801A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4211AC5AB9F6A055F36040A2801A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/20, Aisheng Dong wrote:
> Hi Oliver,
> 
> > 
> > is someone working on clock driver for imx8qm? I miss at least a clk-imx8qm.c
> > in the drivers/imx/clk/ directory. I saw that you are working in this area and
> > perhaps you can give me some insights what is needed here.
> > 
> 
> MX8QM/QXP are using the same clock driver clk-imx8qxp.c

ok thx, for that clarification.

> 
> [PATCH RESEND V5 00/11] clk: imx8: add new clock binding for better pm support
> https://www.spinics.net/lists/arm-kernel/msg781687.html
> The review of that patch series is pending for a couple of months.

yes that is what I currently use. So further imx8qm development can
happen if this is integrated?

Best regards,

Oliver
