Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6744FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DB824955
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXheKxFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEHOEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:04:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588946676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ZJXTQJvptAV9cLZgw4Ng81VkyhSWVuCrfvyn+V+OyE=;
        b=bXheKxFkavUxxz3Sacsx5moPTcgdcvlLqGTffRanl0A+dcx9xfjFxpEDFBMQuudC/0qLAg
        +W2zqscjtZK9uCF3ZbGNp/eTXPlZQy8ALjuWjBcW36u0uRjOrH2+TEAYhiL/ukR8Ivgw4p
        2N2OHjZgMWWbSzeoTP76N5Uq17JODHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-oPMRAtl2NHqgHOWnUpQb_w-1; Fri, 08 May 2020 10:04:32 -0400
X-MC-Unique: oPMRAtl2NHqgHOWnUpQb_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D53780058A;
        Fri,  8 May 2020 14:04:27 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D6FC70933;
        Fri,  8 May 2020 14:04:18 +0000 (UTC)
Date:   Fri, 8 May 2020 10:04:15 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, cai@lca.pw,
        dyoung@redhat.com, bhe@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, gpiccoli@canonical.com, pmladek@suse.com,
        tiwai@suse.de, schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <20200508140415.GC367616@optiplex-lnx>
References: <20200508021438.4373-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508021438.4373-1-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
> 
...
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 04a5885cec1b..19e1541c82c7 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -601,7 +601,8 @@ extern enum system_states {
>  #define TAINT_LIVEPATCH			15
>  #define TAINT_AUX			16
>  #define TAINT_RANDSTRUCT		17
> -#define TAINT_FLAGS_COUNT		18
> +#define TAINT_FIRMWARE_CRASH		18
> +#define TAINT_FLAGS_COUNT		19
>  

As others have already mentioned (and I guess it was your idea too)
it would be nicer to split the changes into a set.

We also will need to update Documentation/admin-guide/tainted-kernels.rst
to reflect the inclusion of this new flag.

-- Rafael

