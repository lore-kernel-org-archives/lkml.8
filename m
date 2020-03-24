Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05794C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6212076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="DEAfs6gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgCXV7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:59:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36165 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgCXV7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:59:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so10029690pfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYZJ5wco7JJuTDAxaIpsWcgx8KVREzLx7l31AjoBp64=;
        b=DEAfs6gW3ASPQcEXUoJf0ITDVQ6oe7LgZ3p93IWuh8Jo8EPp5BxvDh48gkmgSQbNpJ
         Gu3d/vTzT7phk8mHFXeDh/bpynDnRlCn061b/bRHN2QbVzWMmrdBJt3PPKr5KDQt8F3c
         8l/SnPsA6hVHURgUhFmdHzOJzIQUaIfVXf0Wlc9Msx9sYKhdVNaajn7LU7Db1bEcjfpc
         snzmeJk9EtiM14RiDhEY8/tNTLvbS0xJfRTtbjKxfB8nO1didpQcVuDwn2U6Y8tzH5Ku
         750K1aIH7kSsDIaEqQsL728McNdYoyzOxB6MzgnE+HN91GH8cmBH0A+bmjyLEm/M3b0F
         HPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYZJ5wco7JJuTDAxaIpsWcgx8KVREzLx7l31AjoBp64=;
        b=cKfm7kYGqXZXFMw9VK1sZrFd2N+qCmOTJQNq7SX336AgEhcSpYcDIegjcO6S0/aJof
         qUnMc8JWoxSoRavBdDE/N+kfpKMF1inGLVAxU7GEBmHx0s2L7vBb0VfaUa4DuohzCIJ+
         jzfEWU9S8BctoO4xy33RlxOEwEaUUl1Nd2kQ6ZFAk+n0c1dArMCARNHoHDdqJcJPEuRf
         6XV4zIOBJvKyruY3Kgq47FwPYPe4HMf6nbcvawvqsj7rL1XIkbFPnrC3dHyvECETNCrH
         ghGgsKtMLUNti7nadp75TR3SNJ9OZY6JCDe3xPJq3olZVR01Gek6+DbdLn3DK3PlOm94
         zNRg==
X-Gm-Message-State: ANhLgQ0RbpTy26R1vF2xNaBfSeKQPdPRkLUjQ034ZMbyMjVpdceehm5K
        WkSz1WDxKT6wLfQmvk2uiX79bw==
X-Google-Smtp-Source: ADFU+vt+M7LGCyF1UcbD0UlNws/nSWDa25m8e7ZJ4d0D7w+8K75DE9GAD7MYf9dYU+8PTrXDxfKwOA==
X-Received: by 2002:a63:7015:: with SMTP id l21mr2199075pgc.200.1585087161635;
        Tue, 24 Mar 2020 14:59:21 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id fa16sm74957pjb.39.2020.03.24.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 14:59:21 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:59:12 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Po Liu <Po.Liu@nxp.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, vinicius.gomes@intel.com,
        claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        alexandru.marginean@nxp.com, xiaoliang.yang_1@nxp.com,
        roy.zang@nxp.com, mingkai.hu@nxp.com, jerry.huang@nxp.com,
        leoyang.li@nxp.com, michael.chan@broadcom.com, vishal@chelsio.com,
        saeedm@mellanox.com, leon@kernel.org, jiri@mellanox.com,
        idosch@mellanox.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, kuba@kernel.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, simon.horman@netronome.com,
        pablo@netfilter.org, moshe@mellanox.com, m-karicheri2@ti.com,
        andre.guedes@linux.intel.com, David Ahern <dsahern@gmail.com>
Subject: Re: [v1,iproute2  1/2] iproute2:tc:action: add a gate control
 action
Message-ID: <20200324145912.657f2c9e@hermes.lan>
In-Reply-To: <20200324034745.30979-7-Po.Liu@nxp.com>
References: <20200306125608.11717-11-Po.Liu@nxp.com>
        <20200324034745.30979-1-Po.Liu@nxp.com>
        <20200324034745.30979-7-Po.Liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 11:47:44 +0800
Po Liu <Po.Liu@nxp.com> wrote:

> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index a6aa466..7a047a9 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -106,6 +106,7 @@ enum tca_id {
>  	TCA_ID_SAMPLE = TCA_ACT_SAMPLE,
>  	TCA_ID_CTINFO,
>  	TCA_ID_MPLS,
> +	TCA_ID_GATE,
>  	TCA_ID_CT,
>  	/* other actions go here */
>  	__TCA_ID_MAX = 255

All uapi headers need to come from checked in kernel.

This is an example of why, you have an out of date version because
this version would have broken ABI.


This patch should be against iproute2-next since because it depends on net-next.
