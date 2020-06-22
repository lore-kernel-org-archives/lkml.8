Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B91B20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgFVTI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:08:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:50632 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbgFVTIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:08:25 -0400
IronPort-SDR: xm/dDpSQ4jjvxwnC/ibstqvloBb15rMKKfnUI3c8ywpjgmzZPOeXNbwcxwblDcp5O+pX/PERDX
 sq0CI6ZGhgBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="124129273"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="124129273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 12:08:23 -0700
IronPort-SDR: D4tDwJ6OrhmvzbnTg5yXfZUT+qgRdGv12cMiWzocidPlVSdhPFuvgBM93CSWE7oAk9vtP3uszW
 ZleLq1P3vI/g==
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="353555293"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 12:08:17 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id DD065637E;
        Mon, 22 Jun 2020 12:08:14 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:08:14 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] cpu/speculation: Add prototype for cpu_show_srbds
Message-ID: <20200622190814.GA13232@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200617141410.93338-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617141410.93338-1-linux@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ack
Reviewed-by: mark gross <mgross@linux.intel.com>

--mark


On Wed, Jun 17, 2020 at 07:14:10AM -0700, Guenter Roeck wrote:
> 0-day is not happy that there is no prototype for cpu_show_srbds().
> 
> drivers/base/cpu.c:565:16: error:
> 		no previous prototype for 'cpu_show_srbds'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 7e5b3c267d25 ("x86/speculation: Add Special Register Buffer Data Sampling (SRBDS) mitigation")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  include/linux/cpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 52692587f7fe..8aa84c052fdf 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -64,6 +64,7 @@ extern ssize_t cpu_show_tsx_async_abort(struct device *dev,
>  					char *buf);
>  extern ssize_t cpu_show_itlb_multihit(struct device *dev,
>  				      struct device_attribute *attr, char *buf);
> +extern ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *buf);
>  
>  extern __printf(4, 5)
>  struct device *cpu_device_create(struct device *parent, void *drvdata,
> -- 
> 2.17.1
> 
