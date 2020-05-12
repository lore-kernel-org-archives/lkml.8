Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD24EC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 03:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A142072B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 03:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0nlPSr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgELDjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 23:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728751AbgELDjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 23:39:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06275C061A0C;
        Mon, 11 May 2020 20:39:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so21626356wmh.3;
        Mon, 11 May 2020 20:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m46tD1xihj8K1wVKVnYefZB1w4yWGqnKPKV+IWqzhwM=;
        b=F0nlPSr7hnumYvS8gAT2F8bDZJPkgucxaB8hyZh7eJWY0/86DX1l0NLs0r7DYQfH3E
         nECE/Ie+o2ZyBJUFR8fIu9niPg+Yw+smfS00pRDnPMh/Miphj0nNm+M+QPCaPhTnP+Z1
         hbtBuVvIa8B4u2ioUl1rzGMP6U973z27TKjASas508WkvDtwOEyIiYmYXjvAuB+jWDlW
         fWSJg3kL4Fgp7kWMTTfRXZelPmagLM3Wq4h1yz/llukpDuSp3ARizkIE++SUJHusV3UF
         C9aq62WvvomVFvCML95VxPOU7MaNDLhMVM90I579TB7Un+AK7PWv37h3IWI7ZME0qtr0
         1S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m46tD1xihj8K1wVKVnYefZB1w4yWGqnKPKV+IWqzhwM=;
        b=XYgYdkrkTUI4C5lKYYNVBLXcZqTZZkN+nzkS1jKJ10NTW2j2J6IQTjeMFhBUzMUtcu
         adKrHQo2fo1UPSYAQJAu8K1S6UH5XF7TmloPPHay2iGzqafMnGQiFX//E6Z+YlnwJIR0
         b+SMkIA3SCGDmAHKmSXRygVpbd0gFDNn0mDxTWesEbXnJM1mvcojYxfPDM5Wtv4l1XT1
         dkEPcKgywTO32+quti6J9d/Lipdcbr8gy+nP5OMa6E5GsJyU7Cq1Ov7YVv/r3Y5u8vEF
         SZ6paWSjR2CNLFS2m0ywMzH6dUH+01744RxEMT8bxDkxPzbTWFZqp1/JCd/5BOwsRSbd
         VVfA==
X-Gm-Message-State: AOAM5321jraKZpu0fS7EX0R393LhqkvWckg8e+hF1z8wstmD27qB4dR5
        9zIW9k4EFfwbys6RS/PgBzg0286E
X-Google-Smtp-Source: ABdhPJyMtTXvPDZB3VdpATuj5kCujd/P0/tSbmQYB16sm6CNRZDGIY7tTea3MgIvemMYrYb+1bwqjQ==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr1075873wme.120.1589254758562;
        Mon, 11 May 2020 20:39:18 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w18sm20994080wro.33.2020.05.11.20.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 20:39:17 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 13/15] net: dsa: sja1105: implement a common
 frame memory partitioning function
To:     Vladimir Oltean <olteanv@gmail.com>, andrew@lunn.ch,
        vivien.didelot@gmail.com
Cc:     davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com,
        idosch@idosch.org, rmk+kernel@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200511135338.20263-1-olteanv@gmail.com>
 <20200511135338.20263-14-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a1277880-1778-5fef-9a9d-6cd9f08ef3f9@gmail.com>
Date:   Mon, 11 May 2020 20:39:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200511135338.20263-14-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2020 6:53 AM, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> There are 2 different features that require some reserved frame memory
> space: VLAN retagging and virtual links. Create a central function that
> modifies the static config and ensures frame memory is never
> overcommitted.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
