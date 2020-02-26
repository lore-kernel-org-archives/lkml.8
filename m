Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43241C4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BBE24683
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582730949;
	bh=lFiUMCJybTwDM8nRr1AFkAEH1aS6pTBg1GBqY3WIfpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i4x08/KVO6+dnZ0W2TPXso2DdZ44eXE0VvGuYd1iKvYB5dI3xC6XWxw4F57h/HjR9
	 iUyD8URenMNCBmvbHU6gTQmIQXw3BNYct0KQORDq186xr1qdTM92xn6FXjBVjqfzc6
	 xasr9FgmX9DEEW/80LUW4e1CzPTZwyHtM1sdmbVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBZP3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:29:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35259 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgBZP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:29:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so3330968otd.2;
        Wed, 26 Feb 2020 07:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gnnwOAg46K96ABM0Tlqt7z83cd8v189Qw9HHsITB0Q=;
        b=tcF18gzySlVrbrXlGBkkHn6Pk+l3bXVtpa+mtMQbgPhJqf/mQW65dUWiKYuZdLIKR+
         5kO7svHhIOtOZPkiLF+j2CxNeLFW8NHqIz4EmizLFfw6SLtIfgHjtU84BPDLzSn/+vB7
         gOSW4p2mydvrb6D/DEn4NB1Fvc5uxRL6qfJXIOWHC34Ld7TyNmClB37QfAlIkOU0kF1U
         79UBvoMjpZ4HOswKz7F4IgYrv3RocC8yVTW1JC7Majyj8HQePUzbc4vMJKGBk5yiFsvv
         +Bw9xpOk2wPe7JgMokW8td9KUk8qWLYJvtb9tYQ1CY/b19NY6j3TVtInlrk3A+bX5OkA
         ROQA==
X-Gm-Message-State: APjAAAVn+e3loRZD/NL3XjI0AT9uAzwEpjCsG+q+Qy+FntjGiqpMdK/M
        P/OhBulySgz/yZUgIvZYAXTdX38=
X-Google-Smtp-Source: APXvYqyxAO7Tb6IqRKVYATE8l+4tyCwvJ2dPN2dFOyzIZrEyJqElrfMC4rzGX8bJamVzvG69mw00Pg==
X-Received: by 2002:a05:6830:16d0:: with SMTP id l16mr3686225otr.83.1582730946203;
        Wed, 26 Feb 2020 07:29:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm874762otq.19.2020.02.26.07.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:29:05 -0800 (PST)
Received: (nullmailer pid 4725 invoked by uid 1000);
        Wed, 26 Feb 2020 15:29:04 -0000
Date:   Wed, 26 Feb 2020 09:29:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 08/10] dt-bindings: marvell,mmp2: Add clock ids for MMP3
 PLLs
Message-ID: <20200226152904.GA4663@bogus>
References: <20200219073353.184336-1-lkundrak@v3.sk>
 <20200219073353.184336-9-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219073353.184336-9-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 08:33:51 +0100, Lubomir Rintel wrote:
> 
> MMP3 variant provides some more clocks. Add respective IDs.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  include/dt-bindings/clock/marvell,mmp2.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
