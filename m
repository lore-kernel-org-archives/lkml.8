Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B136BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D3820738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594136557;
	bh=hr38wgMutfMGTpekv4ezIfOihbtCBbZW1UcI/OZNZkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ay5ihX3a27BDhD/9B4o8owMXuKv0dgmIBtYQmy9Iv+78mZCR0wUq6r91LPQQ44Tk5
	 3js1FI+K7GAHmEVsRMGtvts1LQZVtAj0uopj3u6LVT0aOL9rhFFP7Npd5gitApfkFH
	 44H4pCSz9uKDCBrrGef6NRJMDLel/oDCAoy0HTgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgGGPmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:42:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34346 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:42:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id q7so37200293ljm.1;
        Tue, 07 Jul 2020 08:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iR4VaYswoAnXPjooTZoTs9PU3wqwFbU66rauZOgyjWk=;
        b=m2C0k37yNh4vVCrI3hVkBQmaj1Rz01W5wKDoyWgAc97xcVSLq4dPtBjeWib6Ffq/10
         c2Yuc74iMWIZFh2L1Ut2dRTogwIvg+Ma2gKjcVCgTvwLIEQ1hhGb869zerGkkqAGcpeD
         au3291NGlOE1nS3dr/q2jETIKyT4mWM9+QyDDNHpHTDLwxkj/93y3PQ6YscKu81au4ie
         7CQF9zRpziWeVVoh13TNwSZoraP8PGKa0kydgSPhTH7h+2HQPuGEsGJbumgzdXWtOZQi
         NudJ7u5OmdW3dv53NmjzwwfofG8Y9dQzitKtSObMm75XYZR8WsFGJL4mItcJYNylLCfN
         Vjug==
X-Gm-Message-State: AOAM532L5H42jesr53rpNnB5f53XfGe3qjtHu3+8FwM+YAmWoUwIiYp3
        i492rn4ldFNeDlLzW80uVHg=
X-Google-Smtp-Source: ABdhPJySxVDCE379q4up4Sy1hjjH7ON4Ipjss79G23C302z/RKqMx9vVoo36fNMEhCg+2lIgfYN7Fw==
X-Received: by 2002:a2e:9654:: with SMTP id z20mr25467012ljh.189.1594136553536;
        Tue, 07 Jul 2020 08:42:33 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id a2sm263537ljm.126.2020.07.07.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:42:32 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jspjp-0001fS-E6; Tue, 07 Jul 2020 17:42:30 +0200
Date:   Tue, 7 Jul 2020 17:42:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel EG95 LTE modem
Message-ID: <20200707154229.GM3453@localhost>
References: <20200707081553.1064456-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707081553.1064456-1-acelan.kao@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:15:53PM +0800, AceLan Kao wrote:
> Add support for Quectel Wireless Solutions Co., Ltd. EG95 LTE modem
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  5 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0195 Rev=03.18
> S:  Manufacturer=Android
> S:  Product=Android
> C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>

Applied, thanks.

Johan
