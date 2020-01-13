Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB24C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3544206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="wcJVBNGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMQBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:01:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39425 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgAMQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:01:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so9144855wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VJ2I8bVjh406gtJuNrBH16DaMI1Itvx05/c74M6wft8=;
        b=wcJVBNGQcVPQ0xvdGtG2k2J38F+daqvgDEWf9Oyeul9ot4a52KywkpkM4M13AipHLu
         GI388SfURNeNCjXxXI5C5l8p6ik+pW0ztjmKChcm5CUrj+R7dgx34VMdXff3cvT3K+3b
         jvCYgG5J0tful/gOCIc89D8XdCNiIk1sd4lZ1d3i2J72kzqr7dMJOdenE5yIxmOebUoN
         CvArh3Sh6+t0pm494NwZgNGczFWiMDCjWpExune2b7vr3FDw1AMf1H7O0O/TjtZiMODL
         00h32HfxgbHGZRIwKWHOeywxQrvU5J5h+9tla/KVLgwocrmLRhWd2em9v5Kt9J/3MkMj
         e4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VJ2I8bVjh406gtJuNrBH16DaMI1Itvx05/c74M6wft8=;
        b=k7gcRfNsGSy/mFtAp5ZxBufio0qTBgRHhDtbGdlKmV5Z4L2qGF+W2GzRWuwAoOZaM7
         rH6lcbH3P531Dfgtgh3vBva1eH7GpCqyFIn6uNRecttAR/XF2T6qSu153RHJoR++76ck
         ae3T/Wku/GTHFRktI3OlPEV7MFjFaRALfYqPmW1CfZtLL4b/pKxJX/HaxdOsK1hVSNkN
         lx+WPJP65aWSyoJS3fSPM3VlU156GCmoxi+5V8M6MT74iSwgb7Nku6GenvhoMmzSmvA5
         3kB9+HLOQAcC+vcl8v2whhrITaL6uKzD/SjLE3kwzHhAXsWJ51R7sCrpkwCPvCN8jV1o
         oXtA==
X-Gm-Message-State: APjAAAX7B614tvHc6nrBa9TSbrs2PO97kxfVpGE6O2haS8bQwDI8IHYO
        ECFCvMHLVVcDl7b2Ytti5n2xDQ==
X-Google-Smtp-Source: APXvYqz+wIKpxexS9htZEf5ylW4xVlVtWBFDIb7X9/vCrhz4wjrU+PeGtBByqJUS5lDOlv9N3+huyw==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr20115727wru.112.1578931273141;
        Mon, 13 Jan 2020 08:01:13 -0800 (PST)
Received: from localhost (ip-78-102-249-43.net.upcbroadband.cz. [78.102.249.43])
        by smtp.gmail.com with ESMTPSA id p7sm14332600wmp.31.2020.01.13.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 08:01:12 -0800 (PST)
Date:   Mon, 13 Jan 2020 17:01:11 +0100
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
Message-ID: <20200113160111.GF2131@nanopsycho>
References: <20200110162010.338611-1-antoine.tenart@bootlin.com>
 <20200110162010.338611-3-antoine.tenart@bootlin.com>
 <20200113143956.GB2131@nanopsycho>
 <20200113151231.GD3078@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113151231.GD3078@kwain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jan 13, 2020 at 04:12:31PM CET, antoine.tenart@bootlin.com wrote:
>On Mon, Jan 13, 2020 at 03:39:56PM +0100, Jiri Pirko wrote:
>> Fri, Jan 10, 2020 at 05:19:57PM CET, antoine.tenart@bootlin.com wrote:
>> 
>> >diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>> >index 1d69f637c5d6..024af2d1d0af 100644
>> >--- a/include/uapi/linux/if_link.h
>> >+++ b/include/uapi/linux/if_link.h
>> >@@ -486,6 +486,13 @@ enum macsec_validation_type {
>> > 	MACSEC_VALIDATE_MAX = __MACSEC_VALIDATE_END - 1,
>> > };
>> > 
>> >+enum macsec_offload {
>> >+	MACSEC_OFFLOAD_OFF = 0,
>> >+	MACSEC_OFFLOAD_PHY = 1,
>> 
>> No need to assign 0, 1 here. That is given.
>
>Right, however MACSEC_VALIDATE_ uses the same notation. I think it's
>nice to be consistent, but of course of patch can be sent to convert
>both of those enums.

Ok.

>
>> >+	__MACSEC_OFFLOAD_END,
>> >+	MACSEC_OFFLOAD_MAX = __MACSEC_OFFLOAD_END - 1,
>> >+};
>> >+
>> > /* IPVLAN section */
>> > enum {
>> > 	IFLA_IPVLAN_UNSPEC,
>> >diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
>> >index 8aec8769d944..42efdb84d189 100644
>> >--- a/tools/include/uapi/linux/if_link.h
>> >+++ b/tools/include/uapi/linux/if_link.h
>> 
>> Why you are adding to this header?
>
>Because the two headers are synced.

It is synced manually from time to time. (October is the last time)


>
>Thanks,
>Antoine
>
>-- 
>Antoine Ténart, Bootlin
>Embedded Linux and Kernel engineering
>https://bootlin.com
