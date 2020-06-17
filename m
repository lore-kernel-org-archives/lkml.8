Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3AEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4614A21556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592431950;
	bh=3rdFk08bKi7OzEl5hTJw8eJyk3KLaAeFIAaT4IUqEwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jCX4yuCv7KzpUyZKbRfzS44JQB2YN6oqNNlUJbdfQPeYPW6PMbfmEPcoPoVNqTEKa
	 0lhZhYeqR0cvOW6dOMadAUEz/pKJxYvL1dlV7IfGBhWj/QMKnKTJb0Ka098tgbOrTo
	 r8cZ0z4pR1APzfkb3T0n/cn3CuDSMQSFE3ttNLVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFQWM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:12:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40845 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgFQWMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:12:25 -0400
Received: by mail-io1-f68.google.com with SMTP id q8so4802196iow.7;
        Wed, 17 Jun 2020 15:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imxMvOvJlozmeqMR5QpW6XP7ULKOHGHjkDRkymH0VEA=;
        b=k9KChIsdaE8N3DMYhJctaRblmTAv1MNh8dI26/QLnT6iijQW9USxrhty2nRRP1/OJb
         t4I4ow+1IIgawdkeeqs/sVpAFxpIe1tH25OeDbT05eYXYjZwlZu9VgJoAzxZGF8oFaG+
         fajpYhrb9NxULyF78kyKCM/3e3IAO1gHMt5xgO1MOOWH941qsCpYdsrye95VmgcRbpaE
         XVYMRP3DhEj/mzRsHarqk+3w8BTdTLMVymcaaMIiDRJtoQsxIFar2AxYVA5pf/kDVl2/
         XBkwLau0lsRP7zmPEGSdU7dC4bASxbCyfEeD7YaFjtKRR+kzJQ+tJZuwYhayGT4jjcwi
         kGXw==
X-Gm-Message-State: AOAM533f8T6orclNXiaxe1cn/MYhuyUtLkC+q0qluNK6/JaxCTtMFEVl
        Eo4qilHBeF4RdQe5Ta2a9w==
X-Google-Smtp-Source: ABdhPJzq2uOS8ulYcMFuDLYaROr9I4HefNgaPH6AZsSpm3ffnOhiZokFTfzTV7XJsIU87yka+xhY1Q==
X-Received: by 2002:a05:6602:2fc1:: with SMTP id v1mr1700468iow.39.1592431943179;
        Wed, 17 Jun 2020 15:12:23 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p15sm492523ilj.15.2020.06.17.15.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:12:22 -0700 (PDT)
Received: (nullmailer pid 2924800 invoked by uid 1000);
        Wed, 17 Jun 2020 22:12:21 -0000
Date:   Wed, 17 Jun 2020 16:12:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2 2/2] of: property: Improve cycle detection when one of
 the devices is never added
Message-ID: <20200617221221.GA2923473@bogus>
References: <20200610011934.49795-1-saravanak@google.com>
 <20200610011934.49795-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610011934.49795-3-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020 18:19:34 -0700, Saravana Kannan wrote:
> Consider this example where -> means LHS device is a consumer of RHS
> device and indentation represents "child of" of the previous device.
> 
> Device A -> Device C
> 
> Device B -> Device A
> 	Device C
> 
> Without this commit:
> 1. Device A is added.
> 2. Device A is added to waiting for supplier list (Device C)
> 3. Device B is added
> 4. Device B is linked as a consumer to Device A
> 5. Device A doesn't probe because it's waiting for Device C to be added.
> 6. Device B doesn't probe because Device A hasn't probed.
> 7. Device C will never be added because it's parent hasn't probed.
> 
> So, Device A, B and C will be in a probe/add deadlock.
> 
> This commit detects this scenario and stops trying to create a device
> link between Device A and Device C since doing so would create the
> following cycle:
> Device A -> Devic C -(parent)-> Device B -> Device A.
> 
> With this commit:
> 1. Device A is added.
> 3. Device B is added
> 4. Device B is linked as a consumer to Device A
> 5. Device A probes.
> 6. Device B probes because Device A has probed.
> 7. Device C is added and probed.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 62 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 6 deletions(-)
> 

Both patches applied.

Rob
