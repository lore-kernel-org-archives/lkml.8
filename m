Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACA7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AC22073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590125319;
	bh=3/Qw199TaaOSz09el6CHrOo6cxTMwFMe6Pv94shcQ1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E95kWWcjTpjyToc/EKCtGAi06ukyoC3JIggoxbiVJ35zLzEyecUpEDSEjpjBbyHzI
	 XKiZguer6mXqiaBayV5Qr+TqTFbmP35NT/lpf3aG3jJ/Fl95a9LCLyfuBDotHZ7tLt
	 /LGioU/vZ+A2JzagkrYZMSz36uXAhG+XYeZKrF0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgEVF2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:28:38 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34685 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgEVF2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:28:38 -0400
Received: by mail-pj1-f67.google.com with SMTP id l73so1896044pjb.1;
        Thu, 21 May 2020 22:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BLhBQjWh3vPdreTupUs7bFFVPIKBNLytXsVa4L/6vRQ=;
        b=PbAGRW1LWNiuep/TbmHgGLzAf0+t2xayDfi1Nswh9NDtEGWbvh3helQ4sUKb2aXJi2
         u6oje7u29DXermOee+uyZzr5j3VLbDvOKV1jOMLTIpKxP5/EaDBYoZhmhiZ9caTsRLSi
         DlY4piyQNDGC8APuMXxtxvWtBAAEtbU4hLwTtfj3loqcehWmDr3XLp3THbRM7kRhFCW6
         rNOBgDwRgSsKdA3U5Bq6+xs2rKWcJ5p3trE2ITiesXl4fo8wgdv9aO3axc8qu0MlBrEJ
         YJAnaspfy5GNrrZVI6xJR/W+5XQDvpc+B3fmOC2cy5V2hYSKwCj9t9FxMGSQJgz7xsNe
         Ju/w==
X-Gm-Message-State: AOAM532k/S82oYxSablhu6uaCNbr8AStf54YBULRoNbToa7SjdirIS8K
        hhxzN2jUi4b18x9uNxvJ6Fs=
X-Google-Smtp-Source: ABdhPJyL+iPBCUgerW0KeYpl+ZPhlXZhTxk9OFxI4cmQwymiPSbYoX7S12u1wl9qyCnzI7PIKsTt+Q==
X-Received: by 2002:a17:902:ba8d:: with SMTP id k13mr12987095pls.290.1590125316267;
        Thu, 21 May 2020 22:28:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v22sm6422400pfu.172.2020.05.21.22.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 22:28:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 845C94088B; Fri, 22 May 2020 05:28:34 +0000 (UTC)
Date:   Fri, 22 May 2020 05:28:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alex Elder <elder@ieee.org>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, aquini@redhat.com,
        cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>
Subject: Re: [PATCH v2 10/15] soc: qcom: ipa: use new
 module_firmware_crashed()
Message-ID: <20200522052834.GA11244@42.do-not-panic.com>
References: <20200515212846.1347-1-mcgrof@kernel.org>
 <20200515212846.1347-11-mcgrof@kernel.org>
 <0b159c53-57a6-b771-04ab-2a76c45d0ef4@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b159c53-57a6-b771-04ab-2a76c45d0ef4@ieee.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 05:34:13PM -0500, Alex Elder wrote:
> On 5/15/20 4:28 PM, Luis Chamberlain wrote:
> > This makes use of the new module_firmware_crashed() to help
> > annotate when firmware for device drivers crash. When firmware
> > crashes devices can sometimes become unresponsive, and recovery
> > sometimes requires a driver unload / reload and in the worst cases
> > a reboot.
> > 
> > Using a taint flag allows us to annotate when this happens clearly.
> 
> I don't fully understand what this is meant to do, so I can't
> fully assess whether it's the right thing to do.

It is meant to taint the kernel to ensure it is clear that something
critically bad has happened with the device firmware, it crashed, and
recovery may or may not happen, we are not 100% certain.
> 
> But in this particular place in the IPA code, the *modem* has
> crashed.  And the IPA driver is not responsible for modem
> firmware, remoteproc is.

Oi vei. So the device it depends on has crashed.

> The IPA driver *can* be responsible for loading some other
> firmware, but even in that case, it only happens on initial
> boot, and it's basically assumed to never crash.

OK is this an issue which we can recover from? If for the slightest bit
this can affect users it is something we should inform them over.

This patch set is missing uevents for these issues, but I just added
support for this.

> So regardless of whether this module_firmware_crashed() call is
> appropriate in some places, I believe it should not be used here.

OK thanks. Can the user be affected by this crash? If so how? Can
we recover ? Is that always guaranteed?

  Luis
