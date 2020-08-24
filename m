Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7F0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8EA206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598260207;
	bh=M2CKAW44XvL4efl83aA37He5S/VB3b/10AdQBlkzut8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JfhZcGqokpY52YC9mH5iVc5nFXQHZwq0aREnb5Lzyp+fW0JZXLAIgA/LEsP+Cefyt
	 osJvUd7xdHVSRr2e8TiqHTTHMRaJu9Qii2S4uE+IROqdyci2j+B5h8hMe0tAk3ygUO
	 IMVBbu65G9aSQ9UWh2yskbo6T2ggaAfLBrV7OwKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgHXJKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:10:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42750 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgHXJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:09:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id t6so8739845ljk.9;
        Mon, 24 Aug 2020 02:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U7/56Iwa7YQEpMgvq8Bu6RRnpFZYJtOeNNKEyzZ2Vs4=;
        b=bCREDG9alefGYSVc907gN1FXHOUsXNA1Q6mAmND3urMoUVGBl+q+hsyT3jwaxMwj3h
         ihbAJgU4al8FpQCWcN68Ykj4/TIk2L5CnCrq/PyUVkjITYOzjhxTNiBjxvBQbspVAwDD
         masBBzyAcKtYY1m+3CnQjNebDCnmhls714yp4M51iVUuvs5OFiSHB1PKAgoPyOEdH0FD
         4Jz/F3PzVgBH/HkSb2P3P2fIpQEZEo34bZuBOmp2WC3HWkQvbjOpzgEXHYvCd+AfdIvF
         1p8zKc5K7EVw/lhVTNHO26gw4Sy+P104bPA06jqZehfywPW2k5IKS2a9SaLruBKnIeed
         ALkw==
X-Gm-Message-State: AOAM533vuHmN34lojnjRgNrTLxGPUCwyTOof2tjiYCSakoXIll2ybALR
        8iD2hS/z6dK9XyNndyyAjTs=
X-Google-Smtp-Source: ABdhPJxsZEACGW+Gr+1iJcDrYBvDRxwv78E3p+eGSbhuI//GNWtzi46G7cY9CevlA3VCeGa5SYzPlA==
X-Received: by 2002:a2e:3503:: with SMTP id z3mr2063054ljz.336.1598260190098;
        Mon, 24 Aug 2020 02:09:50 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v9sm634414lfe.10.2020.08.24.02.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 02:09:49 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kA8U8-0006v3-SJ; Mon, 24 Aug 2020 11:09:48 +0200
Date:   Mon, 24 Aug 2020 11:09:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Sheng Long Wang <china_shenglong@163.com>,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>,
        johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb-serial:cp210x: add support to software flow
 control
Message-ID: <20200824090948.GC21288@localhost>
References: <20200820075240.13321-1-china_shenglong@163.com>
 <97836b78-740b-cf70-4803-27305b6e0a4d@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97836b78-740b-cf70-4803-27305b6e0a4d@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 07:32:58AM +0200, Jan Kiszka wrote:
> On 20.08.20 09:52, Sheng Long Wang wrote:
> > From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> > 
> > When data is transmitted between two serial ports,
> > the phenomenon of data loss often occurs. The two kinds
> > of flow control commonly used in serial communication
> > are hardware flow control and software flow control.
> > 
> > In serial communication, If you only use RX/TX/GND Pins, you
> > can't do hardware flow. So we often used software flow control
> > and prevent data loss. The user sets the software flow control
> > through the application program, and the application program
> > sets the software flow control mode for the serial port
> > chip through the driver.
> > 
> > For the cp210 serial port chip, its driver lacks the
> > software flow control setting code, so the user cannot set
> > the software flow control function through the application
> > program. This adds the missing software flow control.
> > 
> > Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> > 
> > Changes in v3:
> > -fixed code style, It mainly adjusts the code style acccording
> >  to kernel specification.
> 
> Patch does not apply. You forgot to rebase over latest tty/tty-next or
> linux master.

That should be the usb-next branch of the usb-serial tree:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/

or linux-next (or, currently, Linus's master branch).

You can use "scripts/get_maintainer.sh --scm" to determine which tree to
base your work against.

Johan
