Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9345521D81
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599802692;
	bh=q1ttzbaMsno4185K3k/pX3ixx7jLK/b7xyq+vzgJ0LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Is1Qw9nArZQDYzVJQKTTMsiIePpizwCQjCGnkQ4LIpiUk+uKkaxYLpObMlclcLvkb
	 yytglhymPJscJoWDmb7Q4I5jYbG/ZNXoTY20rQSig1JXDo1ddldx53CevckFqsSFS9
	 aLk2y9VGzzN1pg3vS2AQFOOAzc9tpZsAZpHysQhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgIKFiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:38:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33735 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIKFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:38:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id g4so8727996edk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 22:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e38HYxI/waZ1R5NKoXcqXfiD3DBeLlkMMvGttYW9bvA=;
        b=UN6e9Rf1EgcfyQoz2+h3Z19fPy9sNiXp+p+Q6TStdW7RcnYgh/UuFpwlHcmKekMmVD
         tJNLDv4TYd4TnsK4/gHb2s9oBnm/r7uLyzKWqJhi9QA/mkYJY/zhAx8FwtIxl+3NNH0w
         oSksasaibY577tvJf8vJdEefg+WfPd20SsRtna8hq8gvtHCsHkbO7OijfFzRtJZOnvh3
         ojQes8deFrTelMX0bIVZ5jIVPAAnmaBWTfBT06/z1sMt+xr0MFCvv0dxdYGC8y9fsXTt
         oMUuKpn7Ph9iUNoF+DdeUC1LjWhK0GDpCwg2DZuL+jJsVDKVjgqtkmTqDokZAJ2HMRj/
         aLRg==
X-Gm-Message-State: AOAM533/IvSxauEcb5BU+rJ03sAcAv90gFKkMG7PppvLgPbTYbSPCQ2g
        GIJt81/x10zBMI9a+HABEDc=
X-Google-Smtp-Source: ABdhPJw9z/GZ9wfCSfBz8YK+P8wwihAIjpQVXpdPmshpaX7kllWUR/JXRB0ryObyHcK0MMS3yVWsqA==
X-Received: by 2002:a50:cf46:: with SMTP id d6mr258144edk.339.1599802688264;
        Thu, 10 Sep 2020 22:38:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id i17sm792178ejy.79.2020.09.10.22.38.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Sep 2020 22:38:07 -0700 (PDT)
Date:   Fri, 11 Sep 2020 07:38:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] extcon: ptn5150: Use defines for registers
Message-ID: <20200911053805.GA2954@kozik-lap>
References: <CGME20200909172007epcas1p2fe01380c62ca112a19283f2dc63e75f9@epcas1p2.samsung.com>
 <20200909150129.12476-1-krzk@kernel.org>
 <7571e535-f0ff-2371-1669-734c3996aacf@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7571e535-f0ff-2371-1669-734c3996aacf@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 12:14:19PM +0900, Chanwoo Choi wrote:
> On 9/10/20 12:01 AM, Krzysztof Kozlowski wrote:
> > The register addresses are not continuous, so use simple defines for
> > them.  This also makes it easier to find the address for register.
> > 
> > No functional change.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/extcon/extcon-ptn5150.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> > index dda5b3a3a908..1b68f56d8372 100644
> > --- a/drivers/extcon/extcon-ptn5150.c
> > +++ b/drivers/extcon/extcon-ptn5150.c
> > @@ -19,18 +19,16 @@
> >  #include <linux/gpio/consumer.h>
> >  
> >  /* PTN5150 registers */
> > -enum ptn5150_reg {
> > -	PTN5150_REG_DEVICE_ID = 0x01,
> > -	PTN5150_REG_CONTROL,
> > -	PTN5150_REG_INT_STATUS,
> > -	PTN5150_REG_CC_STATUS,
> > -	PTN5150_REG_CON_DET = 0x09,
> > -	PTN5150_REG_VCONN_STATUS,
> > -	PTN5150_REG_RESET,
> > -	PTN5150_REG_INT_MASK = 0x18,
> > -	PTN5150_REG_INT_REG_STATUS,
> > -	PTN5150_REG_END,
> > -};
> > +#define PTN5150_REG_DEVICE_ID			0x01
> > +#define PTN5150_REG_CONTROL			0x02
> > +#define PTN5150_REG_INT_STATUS			0x03
> > +#define PTN5150_REG_CC_STATUS			0x04
> > +#define PTN5150_REG_CON_DET			0x09
> > +#define PTN5150_REG_VCONN_STATUS		0x0a
> > +#define PTN5150_REG_RESET			0x0b
> > +#define PTN5150_REG_INT_MASK			0x18
> > +#define PTN5150_REG_INT_REG_STATUS		0x19
> > +#define PTN5150_REG_END				PTN5150_REG_INT_REG_STATUS
> 
> PTN5150_REG_END should be (PTN5150_REG_INT_REG_STATUS + 1)
> for regmap operation of PTN5150_REG_INT_REG_STATUS.

Why? This goes to regmap's max_register which is the last register
allowed to read:

  drivers/base/regmap/regmap-debugfs.c:   for (i = 0; i <= map->max_register; i += map->reg_stride) {
  drivers/base/regmap/regmap.c:   if (map->max_register && reg > map->max_register)

  regmap_get_max_register() - Report the max register value

Best regards,
Krzysztof

