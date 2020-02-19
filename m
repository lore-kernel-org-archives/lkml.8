Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B00C761A1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE1924670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582149674;
	bh=5ibRBZm2o3OsBOafpactqizyrPdabLnn26Eajqh9/qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lTG+EC9nFqltC5uejexJLFmLFcPv+TFMoU3OSgWXaaQe8Jk8mQgoiCLaMHtC5WxXE
	 epMZsJjlZ+0n79HO2PlJaGzK2zE9mUnyJeJLECWn3PhjWTwsHDl5iN06A36xFnFo2M
	 /XVKDWWMM8EtN8RgwBEcSMj52mfZZIwAp95WxVPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgBSWBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:01:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36083 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:01:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id j20so1730448otq.3;
        Wed, 19 Feb 2020 14:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGyOjkge91SQbfrzXim9rbGo7PLjTkG0M1L94MYw0r8=;
        b=OWFYf8kDu5dL7O5QjP98UYJ3WghQq/L8Z6fj10VWfG2msbX5dstECQ9o+2bQZ9soyh
         JlfuuXrnKLv2QsMnirdciKm+ErLpL+z5CZ1CvpuZ6ccTj/mpHPa8zSRKN9MU7pq5fmre
         NvaSqRUOA2WgDyEJjqdCW48x4/F6POSoFJ1e0OSRKykK6p79QB5yMnQd5u+fQS0w12NW
         RXMrHLXiuDxL5n8urIyE2YbKlysddMhEuJkUjX+VHIoy/V8KubhG4RpukaANY/Wow+nU
         noaWmpd1FMX6CTqm4mWURwlc6zs95pKqhqAAKKR6+NNMNMn4YYLgdzZ2EPvNVjeCWG9n
         S9tg==
X-Gm-Message-State: APjAAAVvPVobx3xtjgdNVgEsItTGno/DstYiusX0a5GLsDqz0fS8Cf17
        HINC+eT4rPGp5dZI2jGg0hobIaY=
X-Google-Smtp-Source: APXvYqy51NRJch2sHB4+XDMbzjUA1EEZ5/PvXRCgza6XulwmduWMFpSBLhIi0HIfrADNWHh7u9SpCQ==
X-Received: by 2002:a9d:6a2:: with SMTP id 31mr20777530otx.313.1582149671782;
        Wed, 19 Feb 2020 14:01:11 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l207sm409515oih.25.2020.02.19.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:01:11 -0800 (PST)
Received: (nullmailer pid 14284 invoked by uid 1000);
        Wed, 19 Feb 2020 22:01:10 -0000
Date:   Wed, 19 Feb 2020 16:01:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Jones <michael-a1.jones@analog.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, Mike Jones <michael-a1.jones@analog.com>
Subject: Re: [PATCH 2/2] bindings: (hwmon/ltc2978.txt): add support for more
 parts.
Message-ID: <20200219220110.GA14227@bogus>
References: <1581032654-4330-1-git-send-email-michael-a1.jones@analog.com>
 <1581032654-4330-2-git-send-email-michael-a1.jones@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581032654-4330-2-git-send-email-michael-a1.jones@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Feb 2020 16:44:14 -0700, Mike Jones wrote:
> LTC2972, LTC2979, LTC3884, LTC3889, LTC7880, LTM4664, LTM4677,
> LTM4678, LTM4680, LTM4700.
> 
> Signed-off-by: Mike Jones <michael-a1.jones@analog.com>
> ---
>  .../devicetree/bindings/hwmon/ltc2978.txt          | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
