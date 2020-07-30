Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57489C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A29C20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gWBXsx0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgG3XEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgG3XEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:04:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB0CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:04:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e22so5968622pjt.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jKFR4wiBx/HaHrC0VB9Ldio7vQ6cHAEOQAFHiaQMxF8=;
        b=gWBXsx0MQGZG2I79NE9hpfvFWlBw7KcZ4qm0j1q0EkUplPt832N4i3YSrKz26ss4kb
         g2XLI3zVHlek4jfeohPndHZwKOFP8HS/2JiN7Hx9XWpAPtuqo8fV6t5GTuR9Zo55Z41E
         xsfuBhUXLY5wLMJl8cns++I1VCDtixR66PnkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jKFR4wiBx/HaHrC0VB9Ldio7vQ6cHAEOQAFHiaQMxF8=;
        b=U+Grv8rENw1PP21PEFrpNX9KuQ2ZLM226jEKcqwTI11S4KOc8buXQfqatXtd1sTYRe
         alGYpmT13IJ40e60jGy7dKJs8PRdYsOk1Du5jLsdjlie0KSmzX2xS/E41pI7B8jO/Pxq
         L+hL2Wf80+p6tybYrW9avrL9YOAzG4kNtTbrTbgbUEm+8QKGUSANmDt8RrS/zbhdhxtQ
         vH2TGKtlscV/FdBtr59uUkiQzgzzgQUjjcd99wnivE68BF6ddaC/NfAxQNVw3yQ1pW4T
         J9EKiNG/zIGqp1SUlmM9aL0zzUhnKscKGl0uxbRk/9HDrNQpUyBREIS19kXERH0rRmI3
         tl6Q==
X-Gm-Message-State: AOAM5339IU5cMvTMBByWVSdWgX9gJmsLE0g4O1Mepc8oWDiUrJB5u1rl
        UQTLPoiCLpRzQ+vphDMM0iH32zLYX38=
X-Google-Smtp-Source: ABdhPJwA5UPZ3p9zHhiS0zY5Tp0+aAPoFp7RPguUJexPfma3FqXU0G8SiBMzHXu/Wu2AzJkqLod+yg==
X-Received: by 2002:a17:90a:8993:: with SMTP id v19mr1323211pjn.122.1596150288637;
        Thu, 30 Jul 2020 16:04:48 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id l62sm6953337pjb.7.2020.07.30.16.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 16:04:48 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:04:47 -0700
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
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Message-ID: <20200730230447.GE3145664@google.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-2-azhar.shaikh@intel.com>
 <20200730225921.GC3145664@google.com>
 <MWHPR11MB15189A9180898261A92DD7C091710@MWHPR11MB1518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB15189A9180898261A92DD7C091710@MWHPR11MB1518.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jul 30, 2020 at 11:02:28PM +0000, Shaikh, Azhar wrote:
> Hi Prashant,
> 
> > 
> > Please add the list of changes in each version after the "---" line.
> 
> I have added those in the cover letter.
> > 
It is good practice to add these to the individual change too, so that
the reader doesn't have to go back to the cover letter to determine
what has changed in each patch.
