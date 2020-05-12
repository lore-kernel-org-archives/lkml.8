Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A1C2D0F9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE7520747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589317078;
	bh=otoy9eoSSJ3uJcoDfy83bqgxGulkFzZalVIgIsLqgkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zCON44Y3y+hEARBXtEH7guT4j3E5l54IZ1gtkTHYmAi6NsDnoGi+dlPgaV52jQGD5
	 HkpivrhRAbyL4R4YH0Yrle10rbntAEqhfVPCRfNtj9VG57PBJkqOMhEfrdoTFzkfju
	 XCneBz/o0Vdz3zkMbIPmgPdA5s3zolx5faW9gNdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbgELU56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:57:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45663 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:57:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id e20so11684750otk.12;
        Tue, 12 May 2020 13:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nRtnAzBOWhIIqmG/A4c9EshgDcr6tLgMstPUXXrBWRE=;
        b=d+DrUCPldTCnQxuhhILzjUPGjsEHwGUXshHSsGziBZm3KFq91vRBjvj1vEKqjN/FxI
         2dJSGF3epYJeC9RO+oDGSukk4pGWP2/5X6vAxhXwHD/wxw2F6d8ToFSwQHUhry5gV+Ts
         8tU9DvMR06l0H/MtkNl/jhpdTk5c0aoj1VILUuCF1ntIzOh71HGQmcBnUhCHf87getq/
         l2SJEPbDEWwNzxiHWcg9xOtiGJd/gweTAArCG88ib4JKPNa9Ey4SsEmGjl8Ei0kZfZIl
         V/4VYTtPyzmow9CYQ/6A39N/2vSjayrBDdoLul75/Z59zLCy7LgoOD6L1O4u/nrEwtT8
         RmDg==
X-Gm-Message-State: AGi0PuYRauQUv5GRLt+YgfryaH3mo3AeWMapzFUuxl5oFrPk/eLxmmi0
        RL5WM5IXCsFeYJaQ2ezg0g==
X-Google-Smtp-Source: APiQypJnktRUj1yoS/aAOGR/oP5BrK34fn/VSH3yrt0yuXYwooEZE/rsmGh2FCsUMw0JWrlkQiqoyw==
X-Received: by 2002:a9d:7c81:: with SMTP id q1mr4846209otn.295.1589317076845;
        Tue, 12 May 2020 13:57:56 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r6sm3898558oom.26.2020.05.12.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:57:56 -0700 (PDT)
Received: (nullmailer pid 12867 invoked by uid 1000);
        Tue, 12 May 2020 20:57:55 -0000
Date:   Tue, 12 May 2020 15:57:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     alistair@popple.id.au, linux@roeck-us.net, jk@ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, joel@jms.id.au,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org, jdelvare@suse.com
Subject: Re: [PATCH 1/3] dt-bindings: fsi: Add P10 OCC device documentation
Message-ID: <20200512205755.GA12807@bogus>
References: <20200501150833.5251-1-eajames@linux.ibm.com>
 <20200501150833.5251-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501150833.5251-2-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 10:08:31 -0500, Eddie James wrote:
> Add the P10 compatible string.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
