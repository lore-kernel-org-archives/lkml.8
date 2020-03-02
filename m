Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3092CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12D421556
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583182244;
	bh=Ju1eI11ASCoeumNUWOIdA1q+QefYzNsUdI+ZwROTQuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=av0DuxzaAM+2zFehDDUr835K5Ib1mAxY4QS/pkBnTfQlxOJTKT1Uu+T12fXACz8cQ
	 Oj535IJsbjzLUb2U1RTXUaBOL+TWUBBuzF/Aiwez6IFd/wn5VudOwVERUzMeJGZ1z0
	 U15p9kRugxn9q7vAkRNaMdFTwloZtCxJ73OWH/zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCBUun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:50:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39446 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBUum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:50:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id r16so660956oie.6;
        Mon, 02 Mar 2020 12:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yDBoT2iZyLmE/VyS3LI4bYRTEiyPlUQdoNnsH2g/OMI=;
        b=Pol7NFjokB2Ge06H1A3bYuRO/D9atB2/C4gfHV45HGo0JXqMxUPpukNtkEDzPiEC8S
         cPE5ogm7L/tSHM6d4x/F25ZyU2GN8ye96gXX8xBSkny5oLQ8s5IXVLS/hzFr+rvQ1ut3
         RnK9JpcUa4mdU7+TFRFVC3j0BaaopLzM5O0NsRtnIfP64ubZM1qB7UsNlTZDKthhZFUS
         4SXmIR9MePqRLO/CU8aIlWuQ0SYQVXIeDsPbZeYmvQS/bVTJ3MfJBCxaAG0fMNMDlpuS
         JaX8LE8pp/mJrz32VKzaPPxnpO6ltjSFm5SXgSfZ56g8zm5y6m/5TVlVqv8GHp9u65xK
         ydiQ==
X-Gm-Message-State: ANhLgQ2hYGlR1PR/E9uvh34eL/SSL/Gt76G6W8Uuf1ZCmXv00lVqbCj7
        64A9ngV4iqDqKSqz6mJRgA==
X-Google-Smtp-Source: ADFU+vt7519NjbiovGcpjkF5yZ6FnpdnihlTczsCJTnc0dGuZ5OpApPY2goE3RDVamt/UUzvEZ9rXQ==
X-Received: by 2002:aca:814:: with SMTP id 20mr182489oii.159.1583182242055;
        Mon, 02 Mar 2020 12:50:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm6945919otm.63.2020.03.02.12.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:50:41 -0800 (PST)
Received: (nullmailer pid 7042 invoked by uid 1000);
        Mon, 02 Mar 2020 20:50:40 -0000
Date:   Mon, 2 Mar 2020 14:50:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Franz Forstmayr <forstmayr.franz@gmail.com>
Cc:     forstmayr.franz@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add compatible for ti,ina260
Message-ID: <20200302205040.GA6984@bogus>
References: <20200224232647.29213-1-forstmayr.franz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224232647.29213-1-forstmayr.franz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 00:26:45 +0100, Franz Forstmayr wrote:
> Add initial support for power/current monitor INA260
> 
> Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ina2xx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
