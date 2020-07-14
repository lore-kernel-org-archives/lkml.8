Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343B3C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F296221897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594720551;
	bh=UZOjWIi4ijWMn0kwgVNiDSyEpzUzl1JpAqKYWgcOB40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nP87lupUckHTx9h0Np/o4Yo7vKSR6paXX6aAi0tiPktN6wuL5KZ20OY0sDUqH/A+Y
	 34/PYl271OpsbsOlFtKM3kcfkZ85yBKjtazX1gqRSlqH0Xf6XxJ8aWluaU3425t5uu
	 fshCGjQTMBNgBzjZaA2Fi+EvofFnSMXyYdLUIRo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGNJzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:55:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37290 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:55:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id e4so21675164ljn.4;
        Tue, 14 Jul 2020 02:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7JmZ94tGXd3SBERSIl141jP1/VBkw6bU6NXbKGZdMJg=;
        b=awiqCBwi2yEHBbm1tUDSr1Ew3guPnVN911Hl2pQ6osvLWHAPEY4zmDCz4AZKDIUZt8
         Rb+NftBDiZGGYO4ZFr4o/TV++E3NWkgFuFtZstUuL4+jAAn4uBMf7aTaiEuDYXh/zwrq
         bsNmEAvZxbxpTxDLArl1ebKy0o3biORCkSNS8mYamKiz+rQRxjasID/PjQdrAZUR0wYT
         WYv/KPoOKRrZbMlexp/s7/B2DoesA8x1YDWtHPpmS9VSwUrjI/fcu8TA9wcDBINQtgbe
         gnAlZ+r/3z1JCgC8W16CrbKDUE5mzSj22kUjehoa4ypYDYn1AF8PJqUSV11I8onjPDKQ
         /uIg==
X-Gm-Message-State: AOAM533xU9tHfQWLkrQHMmEGX+8SsQ1kXKqrSGQjXfyZFNaG5G5vAVTf
        CmVG5kWFqYUX8LNqtN/Mmgg=
X-Google-Smtp-Source: ABdhPJxLtJsIeNMTvo9ZG9iKC5VbDUDDIZGbPfkIjQ7Ej4GcXMYqme/5bUL+2WJ5Hv5DT9oydNSH6w==
X-Received: by 2002:a2e:b88f:: with SMTP id r15mr1792878ljp.355.1594720546216;
        Tue, 14 Jul 2020 02:55:46 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 16sm4524652ljw.127.2020.07.14.02.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:55:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jvHfI-0006UA-DQ; Tue, 14 Jul 2020 11:55:56 +0200
Date:   Tue, 14 Jul 2020 11:55:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: sierra: clean up special-interface handling
Message-ID: <20200714095556.GA3453@localhost>
References: <20200713153936.18032-1-johan@kernel.org>
 <20200713155127.GA267581@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713155127.GA267581@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 05:51:27PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 13, 2020 at 05:39:36PM +0200, Johan Hovold wrote:
> > Clean up the handling of special interfaces that either should be
> > ignored or that need a larger number of URBs.
> > 
> > Commit 66f092ed3b94 ("USB: serial: sierra: unify quirk handling logic")
> > replaced the previous is_blacklisted() and is_highmemory() helpers with
> > a single is_quirk() helper which made it even harder to understand what
> > the interface lists were used for.
> > 
> > Rename the interface-list struct, its members and the interface-lookup
> > helper and restructure the code somewhat in order to make it more
> > self-explanatory.
> 
> Much better, that was messy, thanks for cleaning this up.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Now applied.

Johan
