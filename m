Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBCCC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184072064A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583245862;
	bh=wmbmbTovEU8hELOjWtPXzf+/zz/FL+tWtekYJDhelUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQzK0oUs/a/lWQLz8DRJ6/Wudvqz+AUPSu4C8TTJpGmxfMZGEdAuoW+m2lD0nte66
	 sDqF+gEfAdVQcGDATHcVVwhzmAvcfNlJJv/PpxdxzFqLbL9ozvyVWXhBOG715QmN70
	 Y8v8coBfnxeXD1megWFEhUWd8IjnGSM8fRyJ4wcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgCCObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:31:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41522 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbgCCObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:31:00 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so3171864oie.8;
        Tue, 03 Mar 2020 06:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gVhMT74m9AGYnPITOzgx6C9VacuCfRWPLl0fMDTgg3w=;
        b=BGG8LTlUdmomRrApaOLUQGuk1o/dAO3+VVZRljgyy91RQVBfqTSkAp141XUl7AmXFA
         dOa9TsfQJKm3ikYUbkzdwYNFcYi/a2WdATvy0ZhNLe3LKjcCp8R4mfC5WtNpwpMDIbyg
         0JAV15dW0VFJdtn0zAW/jJIwsvM7IYl6v2lhCUcyCzEc0MurCmPtnRLrBeQT0RJ9vcWw
         OsXWWdXMDx6V14kF3KmWGYzfMybJ+I2S+7KU6XHmq2s//24wSZMi2BnDvVqOf36xwYZ8
         Gt/NPyJSIqp0GL/LmiqA1EKvutMysXdxjOSH/+iI8Yhg3nlbKLzfZ8yZRREa5CB53AgA
         Q5TA==
X-Gm-Message-State: ANhLgQ3enXGbywuBNeiKylJWbBUF4PLYD5sT88xIksczw8y3Ar8r/H7q
        vQ/GBjVWHa3QjznO8p4cYw==
X-Google-Smtp-Source: ADFU+vsTa1mr7f4Jb2fuSW5ZCiP5PL/NVMt+eOqKxGoC62WG7mAsN6hzWEWpqexFTc2MpmI1edzopA==
X-Received: by 2002:aca:fc11:: with SMTP id a17mr2472776oii.123.1583245860210;
        Tue, 03 Mar 2020 06:31:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k110sm5979048otc.59.2020.03.03.06.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:30:59 -0800 (PST)
Received: (nullmailer pid 24642 invoked by uid 1000);
        Tue, 03 Mar 2020 14:30:58 -0000
Date:   Tue, 3 Mar 2020 08:30:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: arm: stm32: document
 lxa,stm32mp157c-mc1 compatible
Message-ID: <20200303143058.GA24606@bogus>
References: <20200226143826.1146-1-a.fatoum@pengutronix.de>
 <20200226143826.1146-3-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226143826.1146-3-a.fatoum@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 15:38:25 +0100, Ahmad Fatoum wrote:
> Document the STM32MP157 based Linux Automation MC-1 device tree
> compatible.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
