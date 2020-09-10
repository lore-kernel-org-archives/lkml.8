Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B47C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7D520872
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599725344;
	bh=ORu/TnxdVsJJuL7gqhz4nRMXhxiTljjIrgMJy7aFgAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KF+qzMRM2NejQRaPlI97Ppt4sXXo82gH5p7pjLSQaSkD2AsFgGgif2Akyr1zMG/22
	 cA2Iyw+spbtDwFiZ2l1kdKyLSe676pvVjMwwp+VdTk2t4T9K7CSk6Og5+bE/Kdds4q
	 rGJmZmQh9iaOqyK6XWhbf5Nx0y6JBZcaswE5QQ/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgIJIJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:09:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37104 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIJII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:08:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id n25so6988132ljj.4;
        Thu, 10 Sep 2020 01:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pmRob3RYVaIomHkLhJXPXfLDXQfpL3YCNNeyPTjyLK0=;
        b=k+M1/rwKaG9pthCWpmz31sY05xfUxpZWRF0QZjsgV0HyyuSyYwYGEFQAvP4arBYHK5
         fp7Zdd+/l4UR0dm4Jv62uHdnnCZtc1AgTmnhO374yQDzoB0eCisgCIUpuFsi1Sii9ys7
         H6trm+Uk4L0gWNsn/WlCtPOZRXHVgyb4Ra1WdrsX7rx7NOPrAlUoj0rxfOOnmpxy5mvP
         JznivlnA7mKu72YsuV8dCqIQdN+mFiiE7e/BvXHX/RsvHOl15SNmp/9lEC6+uuSZ28Nu
         v8NCihq8DikrNX66g+T6JrlT0OTD5RfsVLlZhO1TtnsA2MkaexBOV/gUZM1G3lT+2E1B
         51Gw==
X-Gm-Message-State: AOAM532js+yvNHc/pUbxEd2yQFu58c0msl6DVlHh7ZU3Bq0fQVEabr6h
        qgukIG5lFlMbtiablKEvtgCTjCdEHkc=
X-Google-Smtp-Source: ABdhPJwrU6yyWj2plalDJmuv0QNjHpTvDh68TpF8qjACsiAZualjyCWkgqiOX8Zan1K1qHTanXEKQA==
X-Received: by 2002:a2e:9c52:: with SMTP id t18mr3721956ljj.65.1599725335212;
        Thu, 10 Sep 2020 01:08:55 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v11sm1169484lfg.39.2020.09.10.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:08:54 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kGHdS-0005ty-48; Thu, 10 Sep 2020 10:08:50 +0200
Date:   Thu, 10 Sep 2020 10:08:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lars Melin <larsm17@gmail.com>
Cc:     Oliver Neukum <oneukum@suse.de>,
        James Hilliard <james.hilliard1@gmail.com>,
        linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
Message-ID: <20200910080850.GD24441@localhost>
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de>
 <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:33:55PM +0700, Lars Melin wrote:
> On 9/10/2020 10:02, Oliver Neukum wrote:
> > Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> >> This patch detects and reverses the effects of the malicious FTDI
> >> Windows driver version 2.12.00(FTDIgate).
> > 
> > Hi,
> > 
> > this raises questions.
> > Should we do this unconditionally without asking?
> > Does this belong into kernel space?
> > 
> 
> My answer to both of those question is a strong NO.
> 
> The patch author tries to justify the patch with egoistical arguments 
> (easier for him and his customers) without thinking of all other users 
> of memory constrained embedded hardware that doesn't need the patch code 
> but have to carry it.
> 
> The bricked PID is btw already supported by the linux ftdi driver so 
> there is no functionality gain in the patch.

I fully agree. This doesn't belong in the kernel. If the Windows driver
breaks someones device on purpose they should know about it, and *if*
they want they can reprogram the device using the tools mentioned in the
thread. But the kernel shouldn't be playing such games and reprogram
eeproms behind people's backs.

Johan
