Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC9EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 01:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B639E206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 01:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY7OcslR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgEEBSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 21:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbgEEBSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 21:18:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012F2C061A0F;
        Mon,  4 May 2020 18:18:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k22so410304eds.6;
        Mon, 04 May 2020 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p0UOcxbWlSK6+9fa27qUm+SWDGL9EIT24NJ6czHj5BM=;
        b=AY7OcslRaoXoQW29fSK+NEzdEwwpLDIwo88jBTvyaTdWgZ8sGFjSvZQI0dP72wGHqE
         n8+CG6gmF3y5BQu+OEsFKU45E2eMLF9nUk9JNwFlwI7DNS8/GD9ZdulW+HdA6MLja2Rx
         xAdpyqNItnqNrDnKuNVbF37pLfQLgB6L5/RvzKYnti21OFrxGnrgVzUIqYXpB6JvE+mf
         E6IIlbssNbxVAgnkaHMddpW6hwuDAT0YBS8QbEmQjVc9OJKRE6X718+/LxMHKh6Amsr+
         TjCxJ+KzW3Zu8QvOo8ZES5EEul/Jx9+Do0a+O0NdAJC/LikV7PiaT4LyZfsCNHqHJu2q
         Xm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p0UOcxbWlSK6+9fa27qUm+SWDGL9EIT24NJ6czHj5BM=;
        b=mj20DtwcFHSwwROa7g1RQZGiZ02sU53dTn5Y3zJYmCF31pIzUHlLPlGCscqI+kHdX9
         5RCPIbYGA8Wbf9hVQ6QvUU5No3jl2Ue8tJXJiDBB0ZG+R7r9SrJKz2JLpI4DUgm61a4q
         C/ORAgTQcV/DzD5uULMyp1Z18X392LcFDLCPeI+C+gbxZzP+4tt/67MAE9e8AFlQfFRL
         c3LSLafvTfGJSMNE4ddXhs5a8JSMjCK6r092160U+d4LTa+VxuZ+YljKuxPUdZP5SdrN
         JYTbzeHjAxt0IVEfkzvM27eP33TOswUKF0ycnLMzgAlvzXT23JAbTBu0hyepBWLF8gbE
         +i2w==
X-Gm-Message-State: AGi0PuZL3bHaVm1EAF0j4ij1UMTeRFjc2lzip2eBOCWwpsxhOS6CSO+K
        8ay/BhqppcFtSyGLVAbC4T5MS+NT
X-Google-Smtp-Source: APiQypJdeNCnt6nkRozY7HEr/tZW75u2GOXa4MIoD5BQ9TUo62rGgPf93Tr4tiPmLOe6ruNsBRDcmg==
X-Received: by 2002:a50:e8c7:: with SMTP id l7mr587418edn.309.1588641487550;
        Mon, 04 May 2020 18:18:07 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id u26sm81238eje.35.2020.05.04.18.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 18:18:06 -0700 (PDT)
Subject: Re: [PATCH net-next v2 1/3] net: phy: add concept of shared storage
 for PHYs
To:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
References: <20200504213136.26458-1-michael@walle.cc>
 <20200504213136.26458-2-michael@walle.cc>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <770d75c8-3afe-0b33-8129-3672122dafd0@gmail.com>
Date:   Mon, 4 May 2020 18:18:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504213136.26458-2-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2020 2:31 PM, Michael Walle wrote:
> There are packages which contain multiple PHY devices, eg. a quad PHY
> transceiver. Provide functions to allocate and free shared storage.
> 
> Usually, a quad PHY contains global registers, which don't belong to any
> PHY. Provide convenience functions to access these registers.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
