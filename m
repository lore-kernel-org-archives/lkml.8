Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F96C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE5020658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580719352;
	bh=VrvUXXIptbtuHXxb6P9TONbryeDQgkN5yVYzJQvZo1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oRAbgHCYz7Bn+w+74WZsRH1AiQQ/k895T0x1ms8RQagBOnm9IhEs46Vzw0bo/u1JL
	 tDev0DcR+PUPBlRdaKRuvr+mmJdBK+j7hSDmhjnlPyCqHab9HHxoj6wjgiLEpFegHF
	 InmyoLspq8CYwRWgzbd5OWWUoY4Cn5ULnqAQBms0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgBCImb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:42:31 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:39550 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgBCImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:42:31 -0500
Received: by mail-lj1-f169.google.com with SMTP id o15so8126943ljg.6;
        Mon, 03 Feb 2020 00:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dtQhIi/Kp1IdGYU3ZiBM80ySVBcZQa692msaAFF44CU=;
        b=WRm+RZb34Eb86F46R/O1Dn80UN2P9Yw0GGzAcqS6km/fwVpSAaDxcN43eNWKir++ZY
         j29maVPosi2+6cIm0uUiPINpC7FITerSRav7XnB1y3K7TR6Txh4D62bQQio55uK2nqPp
         WuyufiwhxgK5evKlCZdStRcH/jeuLcRlFfMk0vL5A/u/iXcfxFRWtn1fx4ASFF47E1hB
         A9fN5Bv1TTLetLK0ezoXNs42T350Cd3GT2OUjyOQ78Tn31zegcho8FeE0edyB1gKIwK0
         tknYS+ZJg0RgruPSiNV10SxzrAyuDj3l+L8rz3s8jo18OqaiNV8EWMGVF5kaCAl/y6ld
         URiA==
X-Gm-Message-State: APjAAAXSfHu+tGstd6ToqRzrOGpp+0SMn2oGol6/lxqJRYKr/HglXTlw
        fHNJTCy43OeDhNBtX+0L1G+R4wOh
X-Google-Smtp-Source: APXvYqx7xVkbzPbEQVocWP3COPBjmixKNJdOkeidyNi07Xa/C9rpP6yAxhIg+3yi1+aRpLK0G5FgyQ==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr13279381ljb.75.1580719349109;
        Mon, 03 Feb 2020 00:42:29 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id u11sm8555731lfo.71.2020.02.03.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 00:42:28 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iyXJU-0004Ks-KC; Mon, 03 Feb 2020 09:42:36 +0100
Date:   Mon, 3 Feb 2020 09:42:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     edes <edes@gmx.net>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: kernel 5.4.11: problems with usb sound cards
Message-ID: <20200203084236.GS10381@localhost>
References: <20200201105829.5682c887@acme7.acmenet>
 <20200201141009.GK10381@localhost>
 <20200201132616.09857152@acme7.acmenet>
 <20200202101933.GL10381@localhost>
 <20200202134159.GM10381@localhost>
 <20200202202816.5a1d8af1@acme7.acmenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200202202816.5a1d8af1@acme7.acmenet>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2020 at 08:28:16PM -0300, edes wrote:
> 
> el 2020-02-02 a las 14:41 Johan Hovold escribió:
> 
> > I realised I forgot the test to match on the device descriptor when
> > applying the blacklist. It doesn't matter currently since I only enable
> > the quirk for your device, but if you haven't tested the patch already,
> > would you mind testing the below patch instead?
> 
> Hi, Johan, thank you for looking into this. I tested your patch, and it
> works! (5.4.11 and 5.5.0).
> 
> I haven't performed extensive tests, but the card is again recognized as
> both playback and capture device. Thank you!

Perfect, thanks for testing.

Do you have a full name I can use to give you credit in the commit
message for reporting and testing?

> Is this and acceptable solution and will this patch be integrated into the
> kernel?

Yes, I think so. We've already had one related report so far, and the
blacklist mechanism should be generic enough to handle any further
devices like this.

Either way, we'll have this fixed in stable in one way or another in a
couple of weeks.

> OTOH, you said:
> 
> > Ok, so the device has a broken altsetting 3 for interface 1, where
> > endpoint 0x85 is declared as an isochronous endpoint, despite being used
> > by interface 2 as an audio endpoint:
> [...]
> > Note that the broken altsetting probably should be using endpoint 0x81
> > just like the other altsettings for that interface, 
> 
> I can't say I understand exactly what you're saying, but do you think it
> could be worth contacting the company and see if they are willing to fix
> this with a new firmware?

Yes, I guess that wouldn't hurt.

The device used to work mostly by chance as two interfaces aren't
allowed to claim the same endpoint. Fortunately, this would only ever be
an issue in one particular configuration of the device (when altsetting
3 of interface 1 was selected) and that may be one that was never used
on Linux.

Takashi may know more about how/if that third altsetting could ever end
up being set.

Johan
