Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F2C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A5F20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N7rbAGxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgEHFrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgEHFrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:47:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13DCC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 22:47:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so256986plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 22:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ktBlo73Jw5CNcN/vgvXAmN9qqf3G71SadtNeIh5UVH4=;
        b=N7rbAGxHd1xFlmkvpJrFn0ZRApCwnO1j7WiuFU8e+kb3V5wpBpZvedwpGwP3Tsj4rS
         +USqVD5/1YvlwcW9irIFGnnpEolkOgUSVlwg40HK7jfYWt4GqX2SuiPu40QxIZuyHub/
         GMVgMfV9IFsRfoIx4M+wGQ7+7P+KBm4rp8eYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktBlo73Jw5CNcN/vgvXAmN9qqf3G71SadtNeIh5UVH4=;
        b=Y3LsP5c0emy7g/0JGT4HbpAlcThZ/0wK05BOdspyp4L1bvQ8Vq+4gRQMPyxzQVJQZ/
         gPJTjVmzZOBL031KLw9HZLS2zblkLz8RCmgUffzy1qGYPoNaRtu7cHYNo8ueNxoclHQ+
         PWEMFpKkIQ3HBL8TENV58r63L5VMtZFoQAnGjs6QftDggyKuaw7RXQqp5lKI0rEJ0vjf
         EJCkLelTtwi0No97x3QxnuHFntfo3A67NToYAOikjDvINYRWzn5PLjzUY7gtsrf8OT8s
         SVxn+pK2jwRsLyfZ7zPkBxLqUrY6D92Dgn9+Wf72JKex0HEfhtkpOwT4EME20ERaGjgG
         SDFw==
X-Gm-Message-State: AGi0PuYE0HGr/FXfeFQCu3MroPK81hLpPXZ51SlHvdLNA9bJaxKHKy3V
        pFqyMH7KBC2aYkKdARqhV8oNxQ==
X-Google-Smtp-Source: APiQypKeyu+9J0AZJ39edu4kWajGpktWn2BdzoMIWDoDZqCwqp/BDYP/gtakVb8IzNIpE09DU4gT6w==
X-Received: by 2002:a17:90a:69e1:: with SMTP id s88mr4240516pjj.199.1588916831215;
        Thu, 07 May 2020 22:47:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67sm591198pfx.108.2020.05.07.22.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 22:47:10 -0700 (PDT)
Date:   Thu, 7 May 2020 22:47:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, aquini@redhat.com,
        cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, daniel.vetter@ffwll.ch,
        will@kernel.org, mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <202005072244.F2E0286@keescook>
References: <20200508021438.4373-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508021438.4373-1-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:14:38AM +0000, Luis Chamberlain wrote:
> Device driver firmware can crash, and sometimes, this can leave your
> system in a state which makes the device or subsystem completely
> useless. Detecting this by inspecting /proc/sys/kernel/tainted instead
> of scraping some magical words from the kernel log, which is driver
> specific, is much easier. So instead provide a helper which lets drivers
> annotate this.
> 
> Once this happens, scrapers can easily scrape modules taint flags.
> This will taint both the kernel and respective calling module.
> 
> The new helper module_firmware_crashed() uses LOCKDEP_STILL_OK as
> this fact should in no way shape or form affect lockdep. This taint
> is device driver specific.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Below is the full diff stat of manual inspection throughout the kernel
> when this happens. My methodology is to just scrape for "crash" and
> then study the driver a bit to see if indeed it seems like that the
> firmware crashes there. In *many* cases there is even infrastructure
> for this, so this is sometimes clearly obvious. Some other times it
> required a bit of deciphering.
> 
> The diff stat below is what I have so far, however the patch below
> only includes the drivers that start with Q, as they were a source of
> inspiration for this, and to make this RFC easier to read.
> 
> If this seems sensible, I can follow up with the kernel helper first,
> and then tackle each subsystem independently.
> 
> I purposely skipped review of remoteproc and virtualization. That should
> require its own separate careful review and considerations.

This all seems reasonable to me. You might need to break these up into
per-maintainer patches to get appropriate review. Perhaps land the
infrastructure and some initial patches via netdev and in the next
release send patches for DRM, media, etc?

-- 
Kees Cook
