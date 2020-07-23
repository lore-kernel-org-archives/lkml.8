Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80524C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F46B206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595518933;
	bh=t/FsGNH1SS/qkGkjppISShve4TWHx01yCVIwqCDWFcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kpshg7eGk0r+vJsTiTarvzdpKUnULvH4xkh1oooDe+HJ7gaHnx+5wzEUbFT+Ut2wN
	 xiKFoF6qBzomtXx+Xm+26hNWZ18xsfrC8DXdpLTjonfzW4K5Sfn7/pSBIyt2qVjr9R
	 igNktHkw2vTEm4MY44bgL6JBs2TBD3//mq/YG6lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgGWPmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:42:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45590 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgGWPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:42:12 -0400
Received: by mail-io1-f65.google.com with SMTP id e64so6680576iof.12;
        Thu, 23 Jul 2020 08:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4/r//SGeOvyYqdm3KFCJEPRLwChEzcw9P3j+tQ9l1GM=;
        b=krSqcU7bZtXWedvVrbKlFTG2CvLEgbj66hpBwn36kgq0iXczVaWAkp+sgmZTSeYX2k
         Z1C7fi+tCOzlWUm8woA5Xl8j4bkSvB48SnAp+uVEibQT9IN8VIDMAi50eBrLlApRhiif
         LptkYEBCLIBYmk01+hO4NwQV3r5EYyHGpn6eiRVYHKXsCKNf1LWZJvVRII9HFGNc85Fk
         TMCgd7XGV6cBxOyS44Cqpaz88N07vv+5eduCzZAtZPi4sL+5mm8f9/27rUoMEtQRvlHz
         LaIhQSBMipHXozYfGTUaf9HTFpYPyl9SZpJ1uvA01jq/CXvR4AL5C/Et4udVv9c7hjfb
         5heA==
X-Gm-Message-State: AOAM530cu0DQNXeXqClNff0vktMI9LDLZ0uMsBR/xAtLKJTHR8QNXbfF
        cIqVPAj6fbzCEhM7hzGRHA==
X-Google-Smtp-Source: ABdhPJyu7dCC40pS3m3VGtulYcPWj9w5pZwdD/pIp2nf+CHvZH/74gGY6dIlYDld1KB4rGo2fLuU8Q==
X-Received: by 2002:a02:c903:: with SMTP id t3mr5494425jao.30.1595518930907;
        Thu, 23 Jul 2020 08:42:10 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d9sm1602131ios.33.2020.07.23.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:42:10 -0700 (PDT)
Received: (nullmailer pid 424433 invoked by uid 1000);
        Thu, 23 Jul 2020 15:42:09 -0000
Date:   Thu, 23 Jul 2020 09:42:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        rahul.tanwar.linux@gmail.com, songjun.Wu@intel.com,
        linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, u.kleine-koenig@pengutronix.de,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        qi-ming.wu@intel.com, p.zabel@pengutronix.de
Subject: Re: [PATCH v5 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Message-ID: <20200723154209.GA423699@bogus>
References: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
 <4e975206fcbddedc746e8d39b620336d5fab8b14.1595489518.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e975206fcbddedc746e8d39b620336d5fab8b14.1595489518.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 15:44:17 +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reset/intel,rcu-gw.example.dt.yaml: pwm@e0d00000: '#pwm-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.example.dt.yaml: pwm@e0d00000: '#pwm-cells' is a required property


See https://patchwork.ozlabs.org/patch/1334579

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

