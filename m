Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1BBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52AB2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262204;
	bh=xHVnEn8L+um93Z6eyZrHIj8jRh+WBincPKBqWKcafJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=csBLojubghewuREbfVAUWDUBwk+MGnFAenYqdjYWkvXCzHusD9Yh2ixHrklJsOImJ
	 41RQg9n78K1K4jPaSyNP7i5QDKhLGonRVKYfyFhVZQq+K0BiJLZvxwMrgj8+c05rMT
	 665bbTlYPcJ9NGSHqgfrtPwybN9s7v8+tgYhsdqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHXJnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:43:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38337 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgHXJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:43:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id k10so1144093lfm.5;
        Mon, 24 Aug 2020 02:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+sPpbAS75cGxaYopa1UoLFzKyaPQjVAHOZZ21i/IqI=;
        b=fu8wQ7QFQpFE0Uv2l3IpS1bvMo4pYxj6hnQyCsNhWJEHS6xKmP3Pdb8U6boyiSO1+3
         oEdFS0jFXaQg15GC2JLhH7X+0Su15vp1Ar+T6V8VRqpgEYPwRkjJwbfbpBfanUizjXXg
         rEvL6PUa4uQuwf/ilWe6prBafDVa6WNRHqRc2sqNii5WY7Ny3lEO//dGxFOwyBoIhBVU
         fZPYHzaayXTDViJ0IV4bg875Q+OKBG5lGQqKtXTyNaq9xWs0UtbClqya/MSH2LHjGYTI
         iKmSyNS8W/EmB5k8DkU9DWjbXqLXF+ickzVv7vfyKXw280CFgoQAWpdp9jdWGevG2WUV
         vP8w==
X-Gm-Message-State: AOAM533uasoIZKqtN5k0W/FOJXUh62mXSbPB+ZKy1gKD3l5LfgabZkWO
        WWJMt6ADvcrm2UtuM9xPrbM=
X-Google-Smtp-Source: ABdhPJwRaluAeFEm/kpc6gnTtpSDh+hopLCqZnp2vTegFRD1V8+piLnV+XMyENeg6g7FhPNgvxjnqw==
X-Received: by 2002:ac2:5235:: with SMTP id i21mr2251097lfl.96.1598262188023;
        Mon, 24 Aug 2020 02:43:08 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id b17sm2105269ljp.9.2020.08.24.02.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 02:43:07 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kA90N-0007A7-1V; Mon, 24 Aug 2020 11:43:07 +0200
Date:   Mon, 24 Aug 2020 11:43:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     "Wang, Sheng Long (EXT) (RC-CN DI FA R&D SW)" 
        <shenglong.wang.ext@siemens.com>, Johan Hovold <johan@kernel.org>,
        Sheng Long Wang <china_shenglong@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb-serial:cp210x: add support to software flow
 control
Message-ID: <20200824094307.GE21288@localhost>
References: <20200820075240.13321-1-china_shenglong@163.com>
 <97836b78-740b-cf70-4803-27305b6e0a4d@siemens.com>
 <20200824090948.GC21288@localhost>
 <f21d4cc8b12d4ec6870623472ca7df09@siemens.com>
 <faddf44e-db1d-46e5-b6db-88168b0cc808@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faddf44e-db1d-46e5-b6db-88168b0cc808@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:36:50AM +0200, Jan Kiszka wrote:
> On 24.08.20 11:28, Wang, Sheng Long (EXT) (RC-CN DI FA R&D SW) wrote:
> > Hi Johan,
> > 
> >     Thanks for your reminding. I am adjusting patch according to the latest Linux Master branch.
> 
> Use git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git, branch
> is likely usb-linus, as Johan requested - just in case there is another
> conflict due to a patch not yet in Linux master but in that tree.

The usb-next is used for new features like this one, but again,
currently Linus's master branch works as well.

> > -----Original Message-----
> > From: Johan Hovold <johan@kernel.org> 
> > Sent: Monday, August 24, 2020 5:10 PM
> > To: Kiszka, Jan (CT RDA IOT SES-DE) <jan.kiszka@siemens.com>
> > Cc: Sheng Long Wang <china_shenglong@163.com>; Wang, Sheng Long (EXT) (RC-CN DI FA R&D SW) <shenglong.wang.ext@siemens.com>; johan@kernel.org; gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] usb-serial:cp210x: add support to software flow control
> > 
> > On Fri, Aug 21, 2020 at 07:32:58AM +0200, Jan Kiszka wrote:
> >> On 20.08.20 09:52, Sheng Long Wang wrote:
> >>> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> >>>
> >>> When data is transmitted between two serial ports, the phenomenon of 
> >>> data loss often occurs. The two kinds of flow control commonly used 
> >>> in serial communication are hardware flow control and software flow 
> >>> control.
> >>>
> >>> In serial communication, If you only use RX/TX/GND Pins, you can't 
> >>> do hardware flow. So we often used software flow control and prevent 
> >>> data loss. The user sets the software flow control through the 
> >>> application program, and the application program sets the software 
> >>> flow control mode for the serial port chip through the driver.
> >>>
> >>> For the cp210 serial port chip, its driver lacks the software flow 
> >>> control setting code, so the user cannot set the software flow 
> >>> control function through the application program. This adds the 
> >>> missing software flow control.
> >>>
> >>> Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> >>>
> >>> Changes in v3:
> >>> -fixed code style, It mainly adjusts the code style acccording  to 
> >>> kernel specification.
> >>
> >> Patch does not apply. You forgot to rebase over latest tty/tty-next or 
> >> linux master.
> > 
> > That should be the usb-next branch of the usb-serial tree:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/
> > 
> > or linux-next (or, currently, Linus's master branch).
> > 
> > You can use "scripts/get_maintainer.sh --scm" to determine which tree to base your work against.
> 
> Thanks for correcting! But it's scripts/get_maintainer.pl. ;)

Heh. Thanks for catching that.

Johan
