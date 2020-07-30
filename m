Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352432083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DNRsZoZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgG3XZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbgG3XZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:25:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:25:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so5585632pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zOkKaix4BQSMPMa3aHyYNrYytb7AheYM931Yx71jfB0=;
        b=DNRsZoZQ0tmaWoCnKg11s4d/oEnJhot4FQ0RymZcKzGOtx8nEWJpeeFmq60BUM7r+5
         6Q4yKkmslNW+LhekkazAzPF22j1ZBIPafx+spTPAY+XvZWVY32if/n3h6Pv7WCw6YPF6
         SMQMUXf+NLj+w11Ag5uL0R2IkYy6ZyCmviBq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOkKaix4BQSMPMa3aHyYNrYytb7AheYM931Yx71jfB0=;
        b=n0Czx6loZqW+ySSSBbNSHqygsUnTy8kRup5WgsWO33Qtd1cP7NUj6GRb3ig60YnPGm
         Y/2KVMXb/4wq2d7J4wY7HnHKYbvzOBSyYgVQW7n8PjOH7L5TF3eZ7hPqFHzEx3jaZExr
         boYSlZa2mWeUBwu9GuaKAc7DkbcPNKaPLy1RicaRZzc7tbkN2HR5SX1jLbT6K/huLHWg
         fkBzRGiUoTzpjECv+Amc4aIPn76QLmaEGYnXi+zbrlh+WQS/UiY9DVxTC7g5YG20uCGh
         UlEZdM9EsNb6dd9MUChLFRFPL5elzb5iaSGk+KNfpGCE5OzgyU0d01CqiajRFxtAKeV0
         IUqg==
X-Gm-Message-State: AOAM530oLn6w/yS4bSH6wdHdHyOFMl6Gx1HNGD+Aix+XxmLM8eY2JG1R
        y571AlZz2D2nUIGUQjwq6K0T2Q==
X-Google-Smtp-Source: ABdhPJwb0MoqP/rarZ2V5T2xJ1heq9ZUg5Rde0sT/CLPZJndm6vNZJ72+7iXrMkVSWjubOIODmTZiA==
X-Received: by 2002:a17:90b:470a:: with SMTP id jc10mr1369451pjb.141.1596151506077;
        Thu, 30 Jul 2020 16:25:06 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id 141sm7791485pfw.72.2020.07.30.16.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 16:25:05 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:25:04 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Message-ID: <20200730232504.GG3145664@google.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com>
 <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Azhar,

On Thu, Jul 30, 2020 at 11:06:12PM +0000, Shaikh, Azhar wrote:
> Hi Prashant,
> > 
> > Since this was the last switch being configured, please maintain the same
> > order and add this at the end of the function, after the if-else if block.
> > 
> 
> Please correct if my understanding is not correct here:
> Set the orientation , set the role, then configure the mux. Shouldn't this be the order?

Is this documented anywhere? Kindly provide the links to that if so. I
wasn't aware of any ordering requirements (but I may be missing something).

Please keep in mind that each of these switches (orientation, data-role,
mode-switch, or what is referred to here as "mux") can theoretically be
different switches, controlled independently by distinct drivers and
hardware.

We should not change what ordering is already present unless there is a
requirement to do so. The existing ordering was orientation switch, "mux" or role switch,
then the data-role switch, so let us stick to that.

Best regards,

> 
> 
> > Best regards,
> > 
> > -Prashant
