Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E994C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3CB206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597939835;
	bh=DyrCEp5nrQ/CxeXFhMvsA6dwCNA1rJFhGyz1ylzDTcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KJhBhAM1wSp4jfmzmxHIsKPKWUFwRsfZkT4WCpdGAyehrkOLWj3lnu9nZa8W8A6Jd
	 8uuJGhZvyyADaqc/GHbdMlVnCEDutRxY9NxCRbjzEUENtKUX+UtJuonTDlf3EljZMm
	 4L8NHHdPV1oTkRByGBeCWE9D1tTQNAdXNm3/Z5ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgHTQKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:10:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45161 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgHTQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:10:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id z18so2525882wrm.12;
        Thu, 20 Aug 2020 09:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGXlRSR7lXq30rpskgPe8rcnGUPknRy+AGgctdPl6fQ=;
        b=cqdiASi+CcM24JXeTH6gTVz5emn8VaMKOIxgwGKH/bDlGzS8Bp+3iJjObuv12zdu07
         V8RY+eOUHPV8LQzI1G4VS01SYJ4Q7Rr5DtoPSzOmfSwsfoX3rdBI0XyWCb82KuQoftaT
         TuQXskR2244jTCfRPYXopl5xEsw0SFfuVnVF6JwfRo4E8FXhQSCRgH0BDyF0JZUnlKWv
         FvcxTnXtNLZTbg+1g53LaKdli/D4DvsqRCA/yPJykbA7B/Wy6RsX+PPPbuZBe9/Jl8fT
         +0W8+DxVB1SInJu7HX/qxgDcR6+CFQkziZK4Y+No/au3ifOMEdQbr64YunNJZJtcbLpI
         rTBA==
X-Gm-Message-State: AOAM532IO/G+1bAZAQ4cei/CDUWyEYrum/oliPRkWT8tlhRtllz4IbFd
        PvjhmtZ23ibUgPg9zHG3hD8=
X-Google-Smtp-Source: ABdhPJzzEo0e/uhopSopFUEZ1f+CHEWVnNWLPGvTmnswbcDSZQ5RTkJRIf4eysf0ZAY1iJuXv5NSqA==
X-Received: by 2002:adf:e902:: with SMTP id f2mr3860928wrm.174.1597939828227;
        Thu, 20 Aug 2020 09:10:28 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id q7sm5271008wra.56.2020.08.20.09.10.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 09:10:27 -0700 (PDT)
Date:   Thu, 20 Aug 2020 18:10:25 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: s3c24xx: Remove unused machine header include
Message-ID: <20200820161025.GA19865@kozik-lap>
References: <20200803091936.24984-1-krzk@kernel.org>
 <20200805215730.h6434lief5drnnu2@duo.ucw.cz>
 <20200820160816.GB21395@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820160816.GB21395@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 06:08:16PM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 05, 2020 at 11:57:30PM +0200, Pavel Machek wrote:
> > On Mon 2020-08-03 11:19:36, Krzysztof Kozlowski wrote:
> > > The driver includes machine header for GPIO registers but actually does
> > > not use them.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > Thanks, applied.
> 
> Hi Pavel,
> 
> I am confused because I had impression this will go into v5.9-rc1 but
> it's not there.  My further S3C cleanup depends on it [1] and now
> applying of the patches stuck in the middle.
> 
> I could take the patch through samsung-soc along with the rest of the
> series or pull from stable tag (but tag with only that patch...).

... and the missing link:
[1] https://marc.info/?l=dri-devel&m=159793916332137&w=2

Best regards,
Krzysztof

