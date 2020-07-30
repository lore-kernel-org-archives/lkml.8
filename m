Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1613E20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0OOeERy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgG3XSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgG3XSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:18:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D55C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:18:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so2531095plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5W2fhM+bWCPdwfoynK2q5QFuMB7Vqk+3LnKTeN+kulw=;
        b=I0OOeERy/BuJS3lGQSUVGEa3/ADf/ndqnAL2uYgaHtibiJjlpov5pgBLJB7RzW6Vc/
         +CQs0MD7sUWYgrTbWaVkB14rKBhq9NR7wiMe5A6o4VXzzsE2JW6Ahy7nTxaQAnlsBsnD
         0m3UlH9c0bSKkkuITvN+C28tqzV4haBC7ZPRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5W2fhM+bWCPdwfoynK2q5QFuMB7Vqk+3LnKTeN+kulw=;
        b=aXDMg0dA5mfuPFQdB3rJwiKTRoSOuJhjNoQt8keJUj+fSBAgR/N1xm7oyW8StooOWD
         7alIRAUyvrupNbI81EtMwI0LWxmOqTNDlGI6LXAXc9jkskgnGPULsmy5HtsB4s3DOGIB
         jLikpmhrtAi+AOO31VTR/Khg2gf8UFXOYd1QuzRPKzf++4O1iWs9BxmbgkIMsXY4WMcQ
         LvaB3pW9xsPx9zEg8IfvXGrbl+4qcB0MykF26Tvn7zvbzQyB5aeC2MawLQAzX5d6mVFF
         HgXuf9839eGEqFTTJi+uno26pGmjZlDp7vrOpTlRdp7TltdIj1sF7ebBKyLYgoSYpYJI
         mNAg==
X-Gm-Message-State: AOAM532TkQXsG9GjhZMvCbL5lSStwhvY5gcwk6bNo/hwwE6E+5+QFZMY
        Wzxq9D8ZoOi+sBM41cEUgk7faw==
X-Google-Smtp-Source: ABdhPJyS/fGwYxkEpPhRIntINRIReNo/nz4QaZ8T7vZisD7/C8gQALuPXRXeSm5HciRx+guyUhNsoQ==
X-Received: by 2002:a17:90a:33d1:: with SMTP id n75mr403491pjb.217.1596151094609;
        Thu, 30 Jul 2020 16:18:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id g14sm5261921pgi.46.2020.07.30.16.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 16:18:14 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:18:13 -0700
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
Message-ID: <20200730231813.GF3145664@google.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-2-azhar.shaikh@intel.com>
 <20200730225921.GC3145664@google.com>
 <MWHPR11MB15189A9180898261A92DD7C091710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730230447.GE3145664@google.com>
 <MWHPR11MB1518F06A499594BCA675A5E491710@MWHPR11MB1518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1518F06A499594BCA675A5E491710@MWHPR11MB1518.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:14:39PM +0000, Shaikh, Azhar wrote:
> 
> 
> > -----Original Message-----
> > From: Prashant Malani <pmalani@chromium.org>
> > Sent: Thursday, July 30, 2020 4:05 PM
> > To: Shaikh, Azhar <azhar.shaikh@intel.com>
> > Cc: bleung@chromium.org; enric.balletbo@collabora.com;
> > groeck@chromium.org; linux-kernel@vger.kernel.org;
> > heikki.krogerus@linux.intel.com; Patel, Utkarsh H
> > <utkarsh.h.patel@intel.com>; Bowman, Casey G
> > <casey.g.bowman@intel.com>; Mani, Rajmohan
> > <rajmohan.mani@intel.com>
> > Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum
> > values to usb_role_switch_set_role()
> > 
> > 
> > On Thu, Jul 30, 2020 at 11:02:28PM +0000, Shaikh, Azhar wrote:
> > > Hi Prashant,
> > >
> > > >
> > > > Please add the list of changes in each version after the "---" line.
> > >
> > > I have added those in the cover letter.
> > > >
> > It is good practice to add these to the individual change too, so that the
> > reader doesn't have to go back to the cover letter to determine what has
> > changed in each patch.
> 
> So are you suggesting to move it from cover letter to individual patches?
> But then isn't the same thing what cover letter is for?

No, I'm suggesting you keep it both places. Each patch should have a
change log documenting what has changed in the various versions.
