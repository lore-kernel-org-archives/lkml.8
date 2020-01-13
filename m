Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C6CC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69040207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="gPDZVhMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAMP2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:28:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37529 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgAMP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:28:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so9047228wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DJdu1SM2rViHKC/+EMs2F2c88FpqWZzqdGPMLRlXoQg=;
        b=gPDZVhMugRdH49x1x628A84U0dPj4aP4Ji+p0zvjmHvMHldyKIjMecomXk4G3uuYRP
         d8f1llFles5L8AF5LSGDO4jVa4XaG3Vnuhh3sRRruhGoDmsxgFPkHD5VY5Pfl18a4ha1
         Zdfx2yZUZOKbDtwYa0ZXQ3NPhVlB8rcavv8JhcJ6W2nSipndmIDrqk9CLlkHSOcBA096
         XH27bmG0OJuQbd9JFdXqVmN1ptV0g7PI7Fj6WMHm+uFGUdD+WPHlZo7MPXK++vVzvHLH
         2ourELDw2jG8W5mlk4fg33e4+tQYPBLnppaz9m4QzOBUbocWlDf8D0KxO/X3cL9NOFR0
         Sdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DJdu1SM2rViHKC/+EMs2F2c88FpqWZzqdGPMLRlXoQg=;
        b=Q6s7qt6pO8CkGmXzOOb4csM0Je8ElUwRXPxmKCXzhhZq05V+AVheiMFogfYZtwLWaP
         zFgGHfjK52p5QCL3pKjHGszktXyhVIeu16QVMx6CKhU+a4EL/jIcOfsdawu1irsnF2ox
         VPEhlhFU7+RknJYdGyWZIsqEgF3utwXgHDKb3BjUPLCdCenI9JtVGcDp3h4e7TbFIj8k
         8IEP7HJHENZFwgwHMaKg8CdYWMtmaSe4grkM0p64iBpCcDelaALmwdRHV7MSS/1t+vm8
         LMcufEdMJXUjDRR29UkIQPsPn2OsiPaqgXnYnub0QFcDbuJxGEE9waQ2jhnhnguOsAhr
         gDbA==
X-Gm-Message-State: APjAAAVqZ+irNjzJkwcdxUFvK9Kfvjc+qG4yp8kqCmuCEGHZ1RPIs0cb
        JFfPEWbB0obzdodbFyP69Y548g==
X-Google-Smtp-Source: APXvYqwWk74G/dbwyegRFtKtj+L+iByYxySuLcEymQD8fP2ZZbObP+K02R+VX5mc6fL2NbrBeWWRfQ==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr18642169wrv.86.1578929315237;
        Mon, 13 Jan 2020 07:28:35 -0800 (PST)
Received: from localhost (ip-78-102-249-43.net.upcbroadband.cz. [78.102.249.43])
        by smtp.gmail.com with ESMTPSA id i8sm15878983wro.47.2020.01.13.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:28:34 -0800 (PST)
Date:   Mon, 13 Jan 2020 16:28:33 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        camelia.groza@nxp.com, Simon.Edelhaus@aquantia.com,
        Igor.Russkikh@aquantia.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next v5 06/15] net: macsec: add nla support for
 changing the offloading selection
Message-ID: <20200113152833.GD2131@nanopsycho>
References: <20200110162010.338611-1-antoine.tenart@bootlin.com>
 <20200110162010.338611-7-antoine.tenart@bootlin.com>
 <20200113150202.GC2131@nanopsycho>
 <20200113152048.GE3078@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113152048.GE3078@kwain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jan 13, 2020 at 04:20:48PM CET, antoine.tenart@bootlin.com wrote:
>Hello Jiri,
>
>On Mon, Jan 13, 2020 at 04:02:02PM +0100, Jiri Pirko wrote:
>> 
>> I wonder, did you consider having MACSEC_OFFLOAD_ATTR_TYPE attribute
>> passed during the macsec device creation (to macsec_newlink), so the
>> device is either created "offloded" or not? Looks like an extra step.
>> Or do you see a scenario one would change "offload" setting on fly?
>> If not, I don't see any benefit in having this as a separate command.
>
>That would be possible as well. When we discussed offloading selection
>we thought allowing the user to fallback to another offloading mode when
>a rule or a set of rules isn't supported by a given device would be
>useful, even though updating the offloading selection at runtime isn't
>fully transparent for now (this would be a nice follow-up).

Okay. Thanks!

>
>Thanks,
>Antoine
>
>-- 
>Antoine Ténart, Bootlin
>Embedded Linux and Kernel engineering
>https://bootlin.com
