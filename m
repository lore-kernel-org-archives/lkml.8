Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5087C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F2207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="xbCeYNeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgAMOkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:40:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38888 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgAMOkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:40:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so8843679wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y1L1lZjbFBN4CXswUQ+h7dh7/TRqWSLx3YSeYJ+MJZg=;
        b=xbCeYNeYVF4J3flLSfo0iblGnbGQoStjm2tacm8nZiSkPXJsCinCqMpYCo/sqpAsr8
         gpNRTU1UqVRZk0Gl2RkW8myV18RsNDY+YeMUuBan2pYd8V5HvSBBhiIlCcXej2LOMNUS
         vmothpRpGbH0f9KStvWbBmW9p+BRl7mjWwr9ir0PWSUQHsd4QWnFKzQRiKyrESc321UB
         B6d8edUa0cBkmIKdi1UOgPNkDQ14iJCEWuK+hzbUzIvHxRoExPJH23hy1DeSqCrmyUEu
         /UeAeRm4I0D58ffPAUeM7qyl+BIhtdovSSsT1kB2z5UIrm72I/s7bqKEriLhnZotGDPJ
         NFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1L1lZjbFBN4CXswUQ+h7dh7/TRqWSLx3YSeYJ+MJZg=;
        b=L2NBvpH7aVMm+pGAlrtUSRryLIbOX0x6a4Xe5Pv1OmjwjvIUpKv044i+fxPxk8W6bY
         RZIH5E5aD5PM5fuuOrv9+m/Q1oEEvOZqJ82peGZxn37Sv3SllXa+gyY/cPUP9eHOilUC
         CnFxhoCTQs87AHvzpSpkQsL0A5mt6VLD5yCFr0uf9mqvajvi910732Ija5R+QGgieSo+
         8aOVcS4ioSgpaQdW640SciknwBIF2AFczFjbwXBIpARlHhtjR2JkDhyrYcXQNv4z1NW4
         qUs9zDf4HV5tdZM71M5pCFxXchW2+eRc8bLebHBuodr9OUQfXUlwSX2RJfYeGKL/ESKD
         TE7g==
X-Gm-Message-State: APjAAAUnDhD0JevvdIIIVz58ufW6+OqSQffh5Ue9zFGW/8oCIcLRIWK1
        wHsqza9VSV7OEgKf8XiKBWAX4Q==
X-Google-Smtp-Source: APXvYqwmeDehO+UYAhxmj707LmVry5pgexW1xkdCcqcV4cnA2dzWSO+e9m4Kfgr4L/nJpY4L0CwEJA==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr19561911wru.318.1578926398566;
        Mon, 13 Jan 2020 06:39:58 -0800 (PST)
Received: from localhost (ip-78-102-249-43.net.upcbroadband.cz. [78.102.249.43])
        by smtp.gmail.com with ESMTPSA id k8sm15224959wrl.3.2020.01.13.06.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 06:39:58 -0800 (PST)
Date:   Mon, 13 Jan 2020 15:39:56 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        camelia.groza@nxp.com, Simon.Edelhaus@aquantia.com,
        Igor.Russkikh@aquantia.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next v5 02/15] net: macsec: introduce the
 macsec_context structure
Message-ID: <20200113143956.GB2131@nanopsycho>
References: <20200110162010.338611-1-antoine.tenart@bootlin.com>
 <20200110162010.338611-3-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110162010.338611-3-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jan 10, 2020 at 05:19:57PM CET, antoine.tenart@bootlin.com wrote:

[...]


>diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>index 1d69f637c5d6..024af2d1d0af 100644
>--- a/include/uapi/linux/if_link.h
>+++ b/include/uapi/linux/if_link.h
>@@ -486,6 +486,13 @@ enum macsec_validation_type {
> 	MACSEC_VALIDATE_MAX = __MACSEC_VALIDATE_END - 1,
> };
> 
>+enum macsec_offload {
>+	MACSEC_OFFLOAD_OFF = 0,
>+	MACSEC_OFFLOAD_PHY = 1,

No need to assign 0, 1 here. That is given.


>+	__MACSEC_OFFLOAD_END,
>+	MACSEC_OFFLOAD_MAX = __MACSEC_OFFLOAD_END - 1,
>+};
>+
> /* IPVLAN section */
> enum {
> 	IFLA_IPVLAN_UNSPEC,
>diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
>index 8aec8769d944..42efdb84d189 100644
>--- a/tools/include/uapi/linux/if_link.h
>+++ b/tools/include/uapi/linux/if_link.h

Why you are adding to this header?


>@@ -485,6 +485,13 @@ enum macsec_validation_type {
> 	MACSEC_VALIDATE_MAX = __MACSEC_VALIDATE_END - 1,
> };
> 
>+enum macsec_offload {
>+	MACSEC_OFFLOAD_OFF = 0,
>+	MACSEC_OFFLOAD_PHY = 1,
>+	__MACSEC_OFFLOAD_END,
>+	MACSEC_OFFLOAD_MAX = __MACSEC_OFFLOAD_END - 1,
>+};
>+
> /* IPVLAN section */
> enum {
> 	IFLA_IPVLAN_UNSPEC,
>-- 
>2.24.1
>
