Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D3FC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF6C2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579256481;
	bh=snmpxkWjNJj9XNjb6PGbKit0kLBRopgO1dzEZ4MMmjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0UwNJQ7pTJOlfOSzyTJ0VICs2Xckt5Xd/cf3p+ng6GQgD+7aIWEsaSYLwxhSbynRa
	 GfV1TwVGAWxraMmM5UR7w56A6JHCeAX8CKubax9JQ0RphDRr11SHnOO8jfTjOUL//B
	 TFgedY5dKYvfyXM/JUZGnsgB9VZgvpGIAb+EjXRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAQKVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:21:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39773 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAQKVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:21:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id y1so17916321lfb.6;
        Fri, 17 Jan 2020 02:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eaqHcAIOe4AOO/TalL4e8/rw3+XC4UIZ6k8/4PUD8ow=;
        b=AwTirvulevfHfqOelod+TeypmC1nHcwfwM4a+Kt7807sKybMntmfSYqNYbf1uhpY+h
         PiUt+r+KAlscjMTGwjbNzBx/lc6gRl+kLq7U+p6RBoJAvF7DCitwpXdxLt3FxVhNTHyh
         FDp8zA5WyulfUjLn21pTYrVqlHeZFrWO6oOORKIHaLa3SE0ZG5fkeqJmbYLERWPFYSPF
         4N1b+zFlmNgy+dTKSoVa2HEQt6EB8muMlPomFGc628P7xyIuoxtkJOtRiDwDDQ3eNbwv
         zO1K3/9u08GgEV5SkM3opNQgBuLRJb40VDhjt3bGpWSypCSy9Pnr68u6iU++Q1ialuey
         DQdw==
X-Gm-Message-State: APjAAAWf7fUW09ucCJTaq0m5E5AZzbIME/rE4gZW6DJu4H2hQIpwleZ7
        3mRQBJij3VwCu5Cz8Xl4KeHPV5Dw
X-Google-Smtp-Source: APXvYqzJQvBprQx7Ic5TrIAMUJR5Oqiu1a5ykCuEEgfOE/FHlJyXeV64gHVvKFNfZG5zSDko9pQmRQ==
X-Received: by 2002:ac2:5195:: with SMTP id u21mr4892698lfi.141.1579256477904;
        Fri, 17 Jan 2020 02:21:17 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id i197sm11929086lfi.56.2020.01.17.02.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 02:21:17 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1isOke-0003q4-Lx; Fri, 17 Jan 2020 11:21:16 +0100
Date:   Fri, 17 Jan 2020 11:21:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 592/671] USB: usb-skeleton: fix
 use-after-free after driver unbind
Message-ID: <20200117102116.GS2301@localhost>
References: <20200116170509.12787-1-sashal@kernel.org>
 <20200116170509.12787-329-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116170509.12787-329-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:03:50PM -0500, Sasha Levin wrote:
> From: Johan Hovold <johan@kernel.org>
> 
> [ Upstream commit 6353001852776e7eeaab4da78922d4c6f2b076af ]
> 
> The driver failed to stop its read URB on disconnect, something which
> could lead to a use-after-free in the completion handler after driver
> unbind in case the character device has been closed.
> 
> Fixes: e7389cc9a7ff ("USB: skel_read really sucks royally")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Link: https://lore.kernel.org/r/20191009170944.30057-3-johan@kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This one isn't needed in any stable tree. As we discussed before, the
skeleton driver is only there for documentation purposes. 

Johan
