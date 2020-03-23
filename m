Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0006C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DAE2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584998836;
	bh=8ZvWvYUnbTsBKhq2WS1Qm+lVF+ELwm4yo1eS1RXHLZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tsHn6Y/KOtzKjO696yLyGVj5g8byyJqJRgPr9UK5rYJzOmiWScJDqmx3xZYm88JI5
	 85/eXsyDG5OVdv0FtFcabKwGDg8FsOYbWEYc1D6EK+KTALVayHd+RjPYzXSMGRETAn
	 o/UDXPZlkwQ1I84X97K5pu0Z6gKqyTO7EXVzR4IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCWV1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:27:15 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34485 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:27:15 -0400
Received: by mail-il1-f193.google.com with SMTP id t11so4948477ils.1;
        Mon, 23 Mar 2020 14:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lw7508pxSwFWdZ6GgiPhJPtehr+dVa5xWRm6kEQBC3U=;
        b=YHHX0v1fHsj5MO5FbnRfxB1DOmQTBE2DED8b6MKI9lLT6175EeVQEQ/Ohs8ogXp3bD
         9obJaWq9D4lTQokgz4eaj4kJcCz5QGY9vbLNrXMhHDqzwCASW96ujQYhaVPFKTF5YCgx
         MKcvQ97jOpeTlBDktOqoTugqgqE2GXKI4F7hbtJwVWmGwMZh/eaJ7erYk2HL6ZIsMfEH
         090UyE9o4pS63z8yzLBetNA8K+3unwHSwhghof6optL/vKegX14GMkR4FqBpFrVs7cLx
         MqXmlQrs/aN2T4n0b5VoSkSYXS9okUpd6G9E8tBuB5K7gwyEBwfEKQsrUkMtZrtRB0Fs
         IJTg==
X-Gm-Message-State: ANhLgQ0TkIPosbbnMyee2g8bnj7O5wgl2tGb+yOcS7YHREPedLG7ebW+
        BXKdBV2sulJBxuxZrlOqGw==
X-Google-Smtp-Source: ADFU+vs2Uyo1ZpCwKXkQd76bn4sXAFZC1wLEqEru6Weyzn2F3XdHL9ui98NABrGBYJblP8ZmXm+p3w==
X-Received: by 2002:a92:b61d:: with SMTP id s29mr22883085ili.66.1584998834315;
        Mon, 23 Mar 2020 14:27:14 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p76sm983942iod.13.2020.03.23.14.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 14:27:13 -0700 (PDT)
Received: (nullmailer pid 14521 invoked by uid 1000);
        Mon, 23 Mar 2020 21:27:11 -0000
Date:   Mon, 23 Mar 2020 15:27:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] drm/panel: Add Starry KR070PE2T
Message-ID: <20200323212711.GA6856@bogus>
References: <20200310102725.14591-1-dev@pascalroeleven.nl>
 <20200310102725.14591-2-dev@pascalroeleven.nl>
 <20200310185422.GA22095@ravnborg.org>
 <280a128711458950b55b070dbf6f07a1@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280a128711458950b55b070dbf6f07a1@pascalroeleven.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:23:27AM +0100, Pascal Roeleven wrote:
> On 2020-03-10 19:54, Sam Ravnborg wrote:
> > A few things to improve.
> > 
> > The binding should be a separate patch.
> > subject - shall start with dt-bindings:
> > Shall be sent to deveicetree mailing list.
> 
> Hi Sam,
> 
> Thank you very much for your review.
> I did consider this. The reason I combined the patches, is that the binding
> depends on the display so I thought they were related in some way. Didn't
> know the correct procedure to handle this. I will split them apart in v2.

FYI, checkpatch.pl will tell you both bindings should be a separate 
patch and that they should be in DT schema format.

Rob
