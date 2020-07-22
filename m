Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BF8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC46205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595407606;
	bh=p2AtfNrtIeSpe4jvnmLZI+RHsCGtWsdSu3f/PH7HGx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cFdhyB+X39HLXvkkSLZN5PFb4uA3SQhZgSpKgiONQmUs5sqS6dHBzQ1Bsn3t63q0F
	 HlD6n7DC7Mv9GHAWCTiXjZ1BOp1Bq1HKBvqlfpc08DR48jhfiSd5ewaCYm3yxqAO+V
	 pX7ycKtohdHPzrVemfU8NHuUkowa4WjxRY3OwdQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgGVIqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:46:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39097 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:46:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id b25so1621465ljp.6;
        Wed, 22 Jul 2020 01:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GU6QMFyeFCz+FdrhT2x2cQZVfXfhXEXOQtm/Ru2/JzE=;
        b=bWGVghXRGwzKgNWfFUlMQySw06DQNzjQFjNf+9O8Fua1NwmHQbAxlO37y7EjbRP8n3
         I5ZHAl/Ux/6lF+7PJHH/hXtHIGXBpUs8ykvzGY3Fu4yU3ZIzuYYC20CLNgaxm8BdePtU
         SHu0RShKYpZdXEEPDz5MvRYyakmwxvIdE92js2cq8nUbkExP6h/W7huapcXpmSIsdePn
         3fpVAO7BLZvOdepGpayURsEFrxtsYYnaJpemEN2R5s6ZdffheXYJG/MgtmOPOHRiIUoS
         /vhIvuEe6It1F5wL7mP4jLUg9mgpZDaPZNaiHuEO+SPzeCXRbwzkQ7pRJ3wgMfD6Jwg5
         eO+A==
X-Gm-Message-State: AOAM532QMCgsP/2OgY7jZqPOUoHlHHikwjgDs2TKy19nZn9bA7qegQib
        sCZSnTU71k1cftUL4DIMrkI=
X-Google-Smtp-Source: ABdhPJxoyI+XRzOC0LJzl8+3SJWQlCLnlH16vbxMiHaHQ2Ku1PB9mI1ytIXC7WROwmtHzB8NGh/2Xw==
X-Received: by 2002:a2e:8056:: with SMTP id p22mr14668425ljg.397.1595407602230;
        Wed, 22 Jul 2020 01:46:42 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n205sm3745172lfd.59.2020.07.22.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 01:46:41 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jyAOa-0005Wv-04; Wed, 22 Jul 2020 10:46:36 +0200
Date:   Wed, 22 Jul 2020 10:46:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Erik Ekman <erik@kryo.se>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: qcserial: add EM7305 QDL product ID
Message-ID: <20200722084635.GG3634@localhost>
References: <20200717185118.3640219-1-erik@kryo.se>
 <20200721072350.GC3634@localhost>
 <CAGgu=sDBemKU4vzg5xWyWT-OoDuXrxXp2tkB5OOmNW6ncDjpow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgu=sDBemKU4vzg5xWyWT-OoDuXrxXp2tkB5OOmNW6ncDjpow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 08:15:04PM +0200, Erik Ekman wrote:
> On Tue, 21 Jul 2020 at 09:23, Johan Hovold <johan@kernel.org> wrote:

> > Would you mind posting the output of "usb-devices" (or "lsusb -v") for
> > this device for completeness?

> from usb-devices:
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#= 30 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1199 ProdID=9062 Rev=00.00
> S:  Manufacturer=Sierra Wireless, Incorporated
> S:  Product=EM7305
> C:  #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=2mA
> I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)

Thanks!

Johan
