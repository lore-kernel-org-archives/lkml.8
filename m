Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA78C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282292067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584028485;
	bh=0UZegBixcyJR2eQTPQLl5os/jIw6DlEF0GVOiCD3z9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TMt6cZnWP1lPVCDNhl0hEaqHZmg4GRfuRn8qzW7UCqgk1gdXcAJwyHTFVaE06TIsl
	 g6wL65ePdi9zkkX9JfMnL2nGWv66jRtlLAIv9rIA5jjPezuEdY0B+VctKyZpGI9wia
	 Ajq72rAd9EU4FaYqtCRrrtKJGOUZJn57bKrBj4ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCLPyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:54:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39518 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgCLPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:54:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id a9so6780555otl.6;
        Thu, 12 Mar 2020 08:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQckKS4bw2Pbga6pTDzSkr9i3TfwNTVPnuQDLWOAQ2o=;
        b=GTyJrd5J18rANcdI5AGiJwgRnhjS1OToaSDJ+BJEjbfQJl/UxQgrZi1CBpmwT+Nqy6
         XYm6iMRAvd7srjSv0CoIPThYdSj3mzMY7Vvmh8cDwfXLevYWF+cq2vlegKsouPwOHK8p
         t4e4STpInmSyUzT0Ra9MTyDCUYKaubgq58Rq8SyWs3pUrLWXiss6CY7I6hYqO9PHHTot
         /Uusp/j7YVpUAsfmqvDou+Y3udi2fON1v1J7kfucCwGSNFy83yxG2GDsxPj7hRMhxpCg
         69Dh1x8HKej01Tpu02ZbjGAI1OG5GAvF0BDHbqpLo5RWmxqnSc3l3cEvS/JmyUFv6zEh
         UVpA==
X-Gm-Message-State: ANhLgQ1dVyFwqjeUKQu5Kq7Hr3IcbOktGiN/hnJ0ZKll1TaTjLEv3Gqj
        NMFQQnnS0FO6zD+60ajo+Q==
X-Google-Smtp-Source: ADFU+vsGpjXso/ZYnCWUaOJlyDF4Nk3XtOo/HVgAz+QgUT8q9zV+Axq0QTIkMiZ673RL/MJBnJmIiQ==
X-Received: by 2002:a05:6830:2361:: with SMTP id r1mr6580348oth.88.1584028482902;
        Thu, 12 Mar 2020 08:54:42 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t15sm4318535otl.62.2020.03.12.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:54:41 -0700 (PDT)
Received: (nullmailer pid 31196 invoked by uid 1000);
        Thu, 12 Mar 2020 15:54:40 -0000
Date:   Thu, 12 Mar 2020 10:54:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: i2c: convert rockchip i2c bindings
 to yaml
Message-ID: <20200312155440.GA29613@bogus>
References: <20200305143611.10733-1-jbx6244@gmail.com>
 <20200312155044.GA25292@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312155044.GA25292@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:50:44AM -0500, Rob Herring wrote:
> On Thu,  5 Mar 2020 15:36:07 +0100, Johan Jonker wrote:
> > Current dts files with 'i2c' nodes are manually verified.
> > In order to automate this process i2c-rk3x.txt
> > has to be converted to yaml. In the new setup
> > i2c-rk3x.yaml will inherit properties from
> > i2c-controller.yaml.
> > 
> > Also change document name in MAINTAINERS.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  68 -----------
> >  .../devicetree/bindings/i2c/i2c-rk3x.yaml          | 129 +++++++++++++++++++++
> >  MAINTAINERS                                        |   2 +-
> >  3 files changed, 130 insertions(+), 69 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

As this series is all binding changes, I'll take it via the DT tree.

Rob
