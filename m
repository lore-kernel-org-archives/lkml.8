Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEAFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E201E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468501;
	bh=IzlFq193qa+1jAkusYfzaJahL20PlWUa2vVzADAVyQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jwTtMWvHaQ8lWpaBFkEuh7KMHwT7iR6/X1QuXO5DGvyC98WtRwkLx/VHLKqWY58kI
	 hxWO/rnPvHX8DnOHglsO+kqVhkOWLVQPNhv9vtO9YFkpReLkbi/6wXN1LKRfH6yLtT
	 S1or5vVtIrACZksgA5sl6hbiBQXQ4vgkCMIvpxw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbgF2WIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:08:19 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38847 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgF2WIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:08:17 -0400
Received: by mail-il1-f193.google.com with SMTP id s21so771514ilk.5;
        Mon, 29 Jun 2020 15:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vwvHQ+egE5FhXPLyDuX6PUzwahMGUZgE1G0XKrUbVJc=;
        b=EugHssimz1oZPZ+q201j5+m2Xbl6bqlW2q7AnqNIro1qqTk2DWeb0DV9xoPcIeyaqy
         VZmjI8hRj/lDXCk1WdmYz0I4shvAGjQOcU1As8XPZDX+swqsVd4s6/YDvkgRq0z/Amq0
         8x18krUVxqRUMTGlFIakc7F2XrJk7UJZTaGHhwP0QyvzUsU/Fy6mxWYrCapYsGVeOmFe
         11lllUYOS/IFQfVSwWniFMZdYMBeRwWmk8e0oBQ+bdewaj2cCo8IooUZeLQ4aKIpfcqO
         L0YET34/ax8V8LrD1UqFA+TBQWy2tYW+wMO8Zqm9b9bLMQUfjDocTs+jtjI2AveBOmwW
         mWqQ==
X-Gm-Message-State: AOAM530sJYRF3JE7/K0sRgPzHXHPGECZRXFr6+PlfDR1GhaIJcIB5aU3
        bs/9R1W0EWrqwEq7Cm7bxQ==
X-Google-Smtp-Source: ABdhPJxaNGKo9xiFded/KOQljwxiaUFNa/MDlL0x3tpYl14Xsnb5nlYxwmTKdu9uDJ7MiUyTxb46OA==
X-Received: by 2002:a92:8552:: with SMTP id f79mr18158073ilh.225.1593468495966;
        Mon, 29 Jun 2020 15:08:15 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id u10sm578648iow.38.2020.06.29.15.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:08:15 -0700 (PDT)
Received: (nullmailer pid 3029062 invoked by uid 1000);
        Mon, 29 Jun 2020 22:08:12 -0000
Date:   Mon, 29 Jun 2020 16:08:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        songjun.Wu@intel.com, rahul.tanwar.linux@gmail.com,
        robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andriy.shevchenko@intel.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Message-ID: <20200629220812.GA3028453@bogus>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
 <cd0692812e7f1bce365a7594b076ae0ed19d2b37.1593420979.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd0692812e7f1bce365a7594b076ae0ed19d2b37.1593420979.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 17:03:46 +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.example.dt.yaml: pwm@e0d00000: '#pwm-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reset/intel,rcu-gw.example.dt.yaml: pwm@e0d00000: '#pwm-cells' does not match any of the regexes: 'pinctrl-[0-9]+'


See https://patchwork.ozlabs.org/patch/1318996

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

