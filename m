Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398DEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FD82072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7eEdIWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgHVQWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgHVQV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:21:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD2AC061573;
        Sat, 22 Aug 2020 09:21:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so2448926pgl.10;
        Sat, 22 Aug 2020 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v6Eq/Tjzvf6HcWrWSGQuyz+ZESZxc7q+AWHXE8G7it4=;
        b=N7eEdIWHuVFHn9O1UpKk07XIIsTcR0EkQaLdMqF5pmBD/yq3NWLAwT/UBG2Ns9vC38
         3ZrlV0+SSHodm25DGLmpf8mWArgx3zTwZrDuBS1xPFqBa6QQVBKG/w9In8z+Pa103r4+
         nFrIzd1wLlIDVJ/ZoIYHs2bN3EuA2glX8W3t+P2JId2nfbzqLylYocGZzDUPYyKLFZxN
         X3NO6yaUSrbYuML6hCb04FpDCuUT57Wyh9YE/ktJaI0rwKNle+bRAzA+NNy6kvwq9VUR
         Xx7n6KKf7dhbpi4GCGjwhgaYIL11kaYi6Dm6r7TRFRJvy/N5v/sW2dp6+RY2H3VLm+/0
         vYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v6Eq/Tjzvf6HcWrWSGQuyz+ZESZxc7q+AWHXE8G7it4=;
        b=ZxPyIio7BxDLPzSqRDTtxNcwUey7CzG3ZHM3OCntS7r44E9dhaa5wSSiwgg1/EymvW
         09KVWyHBhtCJkeK6hcNhR86qjO7bLC76O4Rlj+cU0rq3u4HS138GsniYv0iMc49XUykx
         RJZaA6ji94p2MWMU6esUGfkuyBzOKP1gE4fYzuIhnyH4uBuI7mk43gM3tzcSA2/vf3oD
         y3R/oP3eugbJoIxSQPWgEx3lLJFHxDQadha6kL++I7rR8k2GDAG7PJ4RxcatQk5XRKyT
         3iNrVf1DH+JOJLBDDv2lqng5X+Bd772RV6w47shD9xwZrZEDxHP221eKDlJJtoM3FOUs
         EN9w==
X-Gm-Message-State: AOAM532KMS2L4+Q5r3pTo9gWC2oP49tVIepI8ZajN/dLzCiX2Ho8qOPf
        bmiSYmRdorJDkjvvwgyl0QM=
X-Google-Smtp-Source: ABdhPJypqbX4OK3Q0iEmI9LZm142cRGsviKzvBZudFj8Hv8MT4tTGBp9E6XjbWCUjGwz2zjVeVy65g==
X-Received: by 2002:a62:206:: with SMTP id 6mr6555079pfc.228.1598113319092;
        Sat, 22 Aug 2020 09:21:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k125sm5143259pga.48.2020.08.22.09.21.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 09:21:58 -0700 (PDT)
Date:   Sat, 22 Aug 2020 09:21:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v8 0/6] hwmon: pmbus: adm1266: add support
Message-ID: <20200822162156.GA258960@roeck-us.net>
References: <20200812142055.9213-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812142055.9213-1-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 05:20:49PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add PMBus probing driver for the adm1266 Cascadable
> Super Sequencer with Margin Control and Fault Recording.
> Driver is using the pmbus_core, creating sysfs files
> under hwmon for inputs: vh1->vh4 and vp1->vp13.
> 

Series applied.

Thanks,
Guenter
