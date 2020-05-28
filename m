Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6A3207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590634074;
	bh=Ijy7IJiQYYydgyqsv8N+FhCUNFyvOx6i2JAZIiXLXTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KLB70i8GKw200LLH85088rLTdpsa7ff7CrSYM+sxuTemjv0Ixs80x0gBYnQtKGTr1
	 i5QktXMnR/EpI4gc3OuxsCQG5oILRMuin7hL6yHxH3p2fEU2nkMRWrEnqV6lV/RWFn
	 o5o9zEwbkdE8jA63KKmzwY89/2M+9QTkF7BjlaMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgE1Crx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:47:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43009 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Crw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:47:52 -0400
Received: by mail-io1-f68.google.com with SMTP id h10so28387118iob.10;
        Wed, 27 May 2020 19:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nol5LcAvx2OrbeiJVipO+GziL2apDZJHtoMdVOq2IGM=;
        b=CYCmV+/u+YzCWgsJkOJkNw63q/lRZja/rxEU79678C6g7SDJDmv+RLjwvMLkIeGZtu
         89Kh1t1HmZeUE7ROBtUufls0uvD+qjAttJjwCtboiMMBGoKiLndb8ud05SpF3UXa9ytC
         GfX59vxlVHy5hZ3kdRW/i0FYMktGLfIk86q3SaZ8cz92SpCQfUidclPJ7C7oAxfyYSY6
         y1rJgDydXgSxNV3DCY09AbJukj78oiC9DUezfeXlQ6XmR1mUl7v/xnjhc987rUzgzWiG
         lg2H5a6SuGQQ2BFBGoRitAFC/cbcWrZj/XORl5YhHUNy6JfXTY4pKBkPWCywoTmKCsUg
         P/iA==
X-Gm-Message-State: AOAM532GjDpoL4+PS/5LMvb6zBG/X/NDvLk0tWwFc4febF6qG51TEGDo
        5d4IigtaT79rLa4tv0CBlyM84Gs=
X-Google-Smtp-Source: ABdhPJxh9xMEOESe4dvkIWxvoOtW9Ek+OISv9yhnZpw4mRyTGswZ2YyZpmEHk+6hwsLGim8AZaVN6w==
X-Received: by 2002:a02:1746:: with SMTP id 67mr762072jah.103.1590634071868;
        Wed, 27 May 2020 19:47:51 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v13sm2585682ili.15.2020.05.27.19.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:47:51 -0700 (PDT)
Received: (nullmailer pid 3269428 invoked by uid 1000);
        Thu, 28 May 2020 02:47:50 -0000
Date:   Wed, 27 May 2020 20:47:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        Linux-imx@nxp.com, robh+dt@kernel.org, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, s.hauer@pengutronix.de,
        thierry.reding@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: pwm: Convert imx tpm pwm to json-schema
Message-ID: <20200528024750.GA3269380@bogus>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
 <1589439259-28510-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589439259-28510-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 14:54:19 +0800, Anson Huang wrote:
> Convert the imx tpm pwm binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ---------
>  .../devicetree/bindings/pwm/imx-tpm-pwm.yaml       | 55 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
> 

Applied, thanks!
