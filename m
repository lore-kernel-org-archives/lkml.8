Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFBEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC5A2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvuz8I1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGINEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGINEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:04:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB2C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:04:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so2231202wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cxtZhw5woxZcTsV2Wp7psLUxcb5BFmsKDAfOagUL4sY=;
        b=xvuz8I1/hkEAiRYpSqTwmKttCmZEzyBHvj9s7cdjEb9XBydQo+eWsCkwcy+B4QGHzf
         ORyAyKCcTWkDyxB/xjNv9enVy/G4Lj20CJBQF3Y5YkYSn2BYUnOyuX3wdGtcC1y2b2a4
         1cxExy1THorxVzUmG6rcc5Z5PpcJ/pHiXqzvxseggwm2ltJTTs0RfAdZbusZ5peXzjOm
         Ris1ljd2C2PabKM7u+pIGQy5a6IL+doDBM4r0tjJrhmA/19pHxhthE0U0o9hlXMcQSzY
         zXlOYRQipjTDlu0i8pEis/wGoAm5I5FvPWFNSYIvQyNzaM+n50VWGqxgpjEP/cMmPkqL
         TcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cxtZhw5woxZcTsV2Wp7psLUxcb5BFmsKDAfOagUL4sY=;
        b=SupWdw8V1a8ub18AKJBGFa7tF0j+eUm/UhNdH1zblYr6vYJMB7ViVXdua/cxgsgdfj
         YL+RbkvlPPN6htgSlVmb+Ec3+GsJvatqLyqAcxM7FSk5RXlYVhDjG++eSzK4LlsLswvM
         cGyix1/i7sTLjc+xBaoGLhr3/5JXiB59AMMg3Eb1zC9J+gQl+8Aqb+grUlW5H9gsQYwD
         BwynHLXf7vI5bYtVR04rzqloOjaM7HPta2MTICH+hWu1jXJcJVmsXF7S4jiwSl4BJDIX
         AuqBgiKtzVnB+ZSRWo+kC/VVVKcxlBLd8OtVCZjYlVQrWD1AGBwkqKYC9K+cJoS1ZrQn
         rhXw==
X-Gm-Message-State: AOAM533Pwc2etPkVnMsjPUF4OBhjnkZdVtw1EKhrW8nLQHCK/j/3u7ki
        GTGhXdHKdlRLR4CCHf9h+f1/nw==
X-Google-Smtp-Source: ABdhPJwbPXvCrytr2Xz5PfX6gJk8BmG2mp3z1oRGxvVN/kb8c0RGAvXpnd2AiEII9ZyPibJ1FqawSg==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr60035990wrr.333.1594299888650;
        Thu, 09 Jul 2020 06:04:48 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id j16sm5450209wrt.7.2020.07.09.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:04:47 -0700 (PDT)
Date:   Thu, 9 Jul 2020 14:04:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 08/32] usb: typec: tcpm: tcpm: Remove dangling unused
 'struct tcpm_altmode_ops'
Message-ID: <20200709130445.GZ3500@dell>
References: <20200706133341.476881-1-lee.jones@linaro.org>
 <20200706133341.476881-9-lee.jones@linaro.org>
 <ca14707c-7d40-07ac-da1d-ca27a2e93dcd@redhat.com>
 <20200706142051.GA3500@dell>
 <f2fdead0-9fac-dad3-5d76-41308d5c689d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2fdead0-9fac-dad3-5d76-41308d5c689d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jul 2020, Hans de Goede wrote:

> Hi,
> 
> On 7/6/20 4:20 PM, Lee Jones wrote:
> > On Mon, 06 Jul 2020, Hans de Goede wrote:
> > 
> > > Hi,
> > > 
> > > On 7/6/20 3:33 PM, Lee Jones wrote:
> > > > Looks as though a079973f462a3 ("usb: typec: tcpm: Remove tcpc_config
> > > > configuration mechanism") pulled out the only use of 'tcpm_altmode_ops'
> > > > last year.  No need to keep it around.
> > > > 
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >    drivers/usb/typec/tcpm/tcpm.c:1551:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
> > > >    1551 | static const struct typec_altmode_ops tcpm_altmode_ops = {
> > > >    | ^~~~~~~~~~~~~~~~
> > > > 
> > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > This is necessary for adding Display port over Type-C support
> > > on devices using the tcpm code, rather then firmware, to do
> > > the Type-C alt-mode negotiation.
> > > 
> > > I have a local patch in my tree which adds support for this.
> > > 
> > > But Heikki did not like my approach, so that patch
> > > (which needs the bits you are removing) never landed
> > > upstream:
> > > 
> > > https://patchwork.kernel.org/patch/11199517/
> > > 
> > > Which is somewhat old now.
> > 
> > Yes, that's a just a little old now.
> > 
> > If it drags on for much longer, perhaps consider taking it out for the
> > time being and adding it back when you start to make use of it again?
> > 
> > > Heikki said he would look into an approach to this more to
> > > his liking. Heikki an progress on this area?
> 
> Just a little headsup that I'm making some time now to take a look
> at solving this in the previously discussed better way, with the hope
> of that we can get that upstream. So hopefully I will have some
> patches for this ready during the upcoming weekend.

Sounds good.  Thanks for the update.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
