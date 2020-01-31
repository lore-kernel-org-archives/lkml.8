Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CCFC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB96520663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JIWxTUI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAaXdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:33:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33760 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgAaXdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 18:33:20 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so10218055ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ChijQNeSygMOIiBqfGiSq2wlNXLnTaZ9Nyhp4udsy8=;
        b=JIWxTUI+1SF3ugFBPxVc0/fq5SlHBtOZxuLqEbLkSNWVHsZY+u+RvEoLNOnzZpaZlf
         gyq2HcFrbEZ/DXl8FU5HdC7H9YVti9EZzGxxfp2dVqSEiQD5LzF2TKTOWfRRRyv8m+a+
         Nttu7gtFMN63gECpaOImS+yueKiWrOewOdcGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ChijQNeSygMOIiBqfGiSq2wlNXLnTaZ9Nyhp4udsy8=;
        b=rQlLn/aV9rusEuHXlc7A6CD1LpHjp0xhsFdpKPcdXbSHmHgNyCjaDDnggSWawuH2e5
         j4Ba6vG+19v7fGFnR4oI8/MqSFYaqCb+AMDavoSF8SeoGvPHe1u0XU35U15N9WNesUj+
         umtE2qX8BBbsLba395DnzVufSdSxJC7M5vjWps0di/fbuSg4V8LfFaa6mC9jNSlMewUo
         FuvSRdsk5GhmgP0JIxC9mntS4XycKdYnE2clID2an71ZH97MVTPzcEmRiemXu+ioqNS2
         IpqeFzJWnValQmoclfhIra9qWmHNrQH9Jrl3DlVIcttqyLhH1+GaUUsfiCN8D7SRwcFa
         P8+Q==
X-Gm-Message-State: APjAAAW/jjmfmK/IqIo4FEmNfVD9H/Ap/0qAea1dzdqwhhgLVYainya2
        /ORnj1zjc8u3rUYt8286VlnOBlKUkJM=
X-Google-Smtp-Source: APXvYqx5MlhNODdJb/eRfg68qyeStR5KoP8lcg0/PEZAbl/moydcAQNYD0KtV0nv4zTs4CJe+djzpQ==
X-Received: by 2002:a5d:8b11:: with SMTP id k17mr10681085ion.290.1580513599859;
        Fri, 31 Jan 2020 15:33:19 -0800 (PST)
Received: from chromium.org ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id v63sm3740657ill.72.2020.01.31.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 15:33:19 -0800 (PST)
Date:   Fri, 31 Jan 2020 16:33:17 -0700
From:   Daniel Campello <campello@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: Add SEMTECH SX9310/9311 sensor driver
Message-ID: <20200131233317.GA208488@chromium.org>
References: <20200121150658.1.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121150658.1.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Are there any updated regarding this patch?

Thanks for your time!
Daniel
